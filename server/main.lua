ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('aliano_poison:UseItem')
AddEventHandler('aliano_poison:UseItem', function(type, targetId)
    local src = source
    
    if exports.ox_inventory:GetItem(src, type, nil, true) > 0 then
        exports.ox_inventory:RemoveItem(src, type, 1)
        
        if type == 'poison' then
            TriggerClientEvent('aliano_poison:Poisoned', targetId)
        else
            TriggerClientEvent('aliano_poison:Cured', targetId)
        end
    end
end)