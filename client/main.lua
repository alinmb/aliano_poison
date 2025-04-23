local ESX = exports['es_extended']:getSharedObject()

-- ========== STATE VARIABLES ========== 
local activeNotification = false 
local itemInUse = false

-- ========== UTILITY FUNCTIONS ========== 
local function ShowNotification(msg) 
    BeginTextCommandThefeedPost("STRING") 
    AddTextComponentSubstringPlayerName(msg) 
    EndTextCommandThefeedPostTicker(false, true) 
end

local function CloseNotification(itemType, auto) 
    if not activeNotification then return end

    local msg
    if auto then
        msg = itemType == 'poison' and Config.Messages.timeout_poison or Config.Messages.timeout_antidote
    else
        msg = itemType == 'poison' and Config.Messages.cancel_poison or Config.Messages.cancel_antidote
    end

    ShowNotification(msg)
    ClearHelp()
    activeNotification = false
    itemInUse = false
end

-- ========== CORE INTERACTIONS ========== 
local function AttemptInteraction(type) 
    local target, distance = ESX.Game.GetClosestPlayer()
    if target ~= -1 and distance < 1.5 then
        local targetPed = GetPlayerPed(target)
        local playerPed = PlayerPedId()
        local targetCoords = GetEntityCoords(targetPed)
        local playerCoords = GetEntityCoords(playerPed)
        local forwardVector = GetEntityForwardVector(playerPed)
        local vectorToTarget = targetCoords - playerCoords
        local dotProduct = forwardVector.x * vectorToTarget.x + forwardVector.y * vectorToTarget.y

        if dotProduct > 0 then 
            TriggerServerEvent('aliano_poison:UseItem', type, GetPlayerServerId(target))
            ClearHelp()
            activeNotification = false
            itemInUse = false
            return
        end
    end
    ShowNotification(Config.Messages.no_player)
end

-- ========== USAGE FUNCTIONS ========== 
function UsePoison()
    if itemInUse then return end
    itemInUse = true
    activeNotification = true

    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(Config.Messages.use_poison)
    EndTextCommandDisplayHelp(0, false, true, -1)

    local start = GetGameTimer()

    while activeNotification do
        Citizen.Wait(0)

        if GetGameTimer() - start > 9000 then
            CloseNotification('poison', true)
        end

        if IsControlJustPressed(0, Config.Keys.use) then
            AttemptInteraction('poison')

        elseif IsControlJustPressed(0, Config.Keys.self) then
            TriggerServerEvent('aliano_poison:UseItem', 'poison', GetPlayerServerId(PlayerId()))
            ShowNotification(Config.Messages.self_poisoned)
            ClearHelp()
            activeNotification = false
            itemInUse = false

        elseif IsControlJustPressed(0, Config.Keys.cancel) then
            CloseNotification('poison')
        end
    end
end

function UseAntidote()
    if itemInUse then return end
    itemInUse = true
    activeNotification = true

    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(Config.Messages.use_antidote)
    EndTextCommandDisplayHelp(0, false, true, -1)

    local start = GetGameTimer()

    while activeNotification do
        Citizen.Wait(0)

        if GetGameTimer() - start > 9000 then
            CloseNotification('antidote', true) 
        end

        if IsControlJustPressed(0, Config.Keys.use) then
            AttemptInteraction('antidote')

        elseif IsControlJustPressed(0, Config.Keys.self) then
            TriggerServerEvent('aliano_poison:UseItem', 'antidote', GetPlayerServerId(PlayerId()))
            ShowNotification(Config.Messages.self_cured)
            ClearHelp()
            activeNotification = false
            itemInUse = false

        elseif IsControlJustPressed(0, Config.Keys.cancel) then
            CloseNotification('antidote')
        end
    end
end

-- ========== EXPORTS ========== 
exports('usePoison', UsePoison)
exports('useAntidote', UseAntidote)
