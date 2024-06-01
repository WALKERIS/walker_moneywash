ESX = exports.es_extended:getSharedObject()

RegisterNetEvent('walker_moneywash_removemoney', function(kiekis)
    local Player = source
    local procentas = kiekis * 0.10
    local visasuma = kiekis - procentas
    local black_money = exports.ox_inventory:Search(Player, 'count','black_money')
    if black_money >= kiekis then
        exports.ox_inventory:RemoveItem(Player, 'black_money', kiekis)
        Citizen.Wait(1000)
        exports.ox_inventory:AddItem(Player, 'money', visasuma)
        TriggerClientEvent('walker_moneywash_romovetarget')
        TriggerClientEvent('ox_lib:notify', Player, {title = 'Sekmingai uzsiplovete pinigus', description = 'Sekmingai uzsiplovete pinigus.', type = 'success'})
    else
        TriggerClientEvent('ox_lib:notify', Player, {title = 'Neuztenka', description = 'Reike tureti daugiau nesvariu pinigu.', type = 'error'})
    end
end)
