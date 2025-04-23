local function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

local function ShowNotification(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, true)
end

local function PlayAnimation(dict, anim, duration)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Citizen.Wait(0) end
    
    TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, duration, 33, 0, false, false, false)
    Citizen.Wait(duration)
    RemoveAnimDict(dict)
end

-- Exports
exports('ShowHelpNotification', ShowHelpNotification)
exports('ShowNotification', ShowNotification)
exports('PlayAnimation', PlayAnimation)