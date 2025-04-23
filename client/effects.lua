-- ========== STATE VARIABLES ==========
local isPoisoned = false
local lastEventTime = 0

-- ========== UTILITY ==========
local function ShowNotification(msg)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(false, true)
end

local function PlayInjectionAnimation()
    local playerPed = PlayerPedId()
    RequestAnimDict(Config.Animations.injectDict)

    while not HasAnimDictLoaded(Config.Animations.injectDict) do
        Citizen.Wait(0)
    end

    local syringeProp = CreateObject(GetHashKey("prop_syringe_01"), 0, 0, 0, true, true, false)
    local boneIndex = GetPedBoneIndex(playerPed, 18905) 
    AttachEntityToEntity(syringeProp, playerPed, boneIndex, 0.1, 0.02, 0.02, 60.0, 180.0, 0.0, true, true, false, true, 1, true)

    TaskPlayAnim(playerPed, Config.Animations.injectDict, Config.Animations.injectAnim, 8.0, -8.0, Config.Animations.injectDuration, 51, 0, false, false, false)
    Citizen.Wait(Config.Animations.injectDuration)

    DeleteObject(syringeProp)

    ClearPedTasks(playerPed)
    RemoveAnimDict(Config.Animations.injectDict)
end


-- ========== BLACKOUT HANDLING ==========
local function TriggerBlackout()
    if not isPoisoned then return end

    ShowNotification(Config.Messages.blackout_warning)

    Citizen.Wait(3000)
    ShowNotification(Config.Messages.blackout_alert)

    local blackoutDuration = Config.Effects.blackoutDuration
    CreateThread(function()
        local start = GetGameTimer()
        while GetGameTimer() - start < blackoutDuration do
            PlaySoundFrontend(-1, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
            Citizen.Wait(2000) 
        end
    end)

    -- 1
    DoScreenFadeOut(1000)
    Citizen.Wait(800)
    DoScreenFadeIn(1000)
    Citizen.Wait(1000)

    -- 2
    DoScreenFadeOut(1000)
    Citizen.Wait(800)
    DoScreenFadeIn(1000)
    Citizen.Wait(1000)

    -- Blackout final
    DoScreenFadeOut(1200)
    Citizen.Wait(1200)

    -- Ragdoll
    SetPedToRagdoll(PlayerPedId(), blackoutDuration, blackoutDuration, 0, false, false, false)

    Citizen.Wait(blackoutDuration - 1500)
    DoScreenFadeIn(2000)

    lastEventTime = GetGameTimer()
end



-- ========== VISUAL AND MOVEMENT EFFECTS ==========
local function ApplyDrunkWalk()
    RequestAnimSet(Config.Effects.walkStyle)
    while not HasAnimSetLoaded(Config.Effects.walkStyle) do Citizen.Wait(0) end
    SetPedMovementClipset(PlayerPedId(), Config.Effects.walkStyle, 1.0)
end

local function ApplyPoisonEffects()
    Citizen.CreateThread(function()
        ApplyDrunkWalk()
        while isPoisoned do
            SetTimecycleModifier("drug_drive_blend01")
            SetTimecycleModifierStrength(Config.Effects.screenEffectStrength)

            if math.random() < 0.3 then
                ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.5)
            end

            Citizen.Wait(5000)
        end

        ResetPedMovementClipset(PlayerPedId(), 0)
        ClearTimecycleModifier()
        StopGameplayCamShaking(true)
    end)
end

-- ========== DAMAGE OVER TIME ==========
local function HandlePoisonDamage()
    Citizen.CreateThread(function()
        while isPoisoned do
            local playerPed = PlayerPedId()
            local currentHealth = GetEntityHealth(playerPed)
            SetEntityHealth(playerPed, math.max(0, currentHealth - Config.Effects.damageAmount))

            ShowNotification(string.format(Config.Messages.health_loss, Config.Effects.damageAmount))

            if math.random() < Config.Effects.blackoutChance and GetGameTimer() - lastEventTime > Config.Effects.blackoutInterval then
                TriggerBlackout()
            end

            Citizen.Wait(Config.Effects.damageInterval)
        end
    end)
end

-- ========== EVENTS ==========
RegisterNetEvent('aliano_poison:Poisoned')
AddEventHandler('aliano_poison:Poisoned', function()
    isPoisoned = true
    lastEventTime = GetGameTimer() - Config.Effects.blackoutInterval
    PlayInjectionAnimation()
    ApplyPoisonEffects()
    HandlePoisonDamage()
end)

RegisterNetEvent('aliano_poison:Cured')
AddEventHandler('aliano_poison:Cured', function()
    isPoisoned = false
    PlayInjectionAnimation()
    DoScreenFadeIn(500)
    ClearTimecycleModifier()
    ResetPedMovementClipset(PlayerPedId(), 0)
    StopGameplayCamShaking(true)
end)
