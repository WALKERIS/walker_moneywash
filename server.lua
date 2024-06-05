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

RegisterNetEvent('walker_sendmailtoplayer')
AddEventHandler('walker_sendmailtoplayer', function(kiekis)
    -- phoneNumber: string, the phone number to get the email address from
-- returns: string, the email address of the player
local senderNumber = exports["lb-phone"]:GetEquippedPhoneNumber(source)
local emailas = exports["lb-phone"]:GetEmailAddress(senderNumber)

-- data: table
-- data.to: string, the email address to send the mail to, or "all" to send to all players
-- data.sender: string, the email address of the sender
-- data.subject: string, the subject of the email
-- data.message: string, the message of the email
-- data.attachments: table, the attachments of the email (optional)
-- data.actions: table, buttons to add to the email (optional)
-- returns: boolean (true if mail was sent, false if mail was not sent) and string (the id of the mail or the error message)
local success, id = exports["lb-phone"]:SendMail({
    to = emailas,
    sender = "walkeris@vierhcas.com",
    subject = "WALKERIS VIERHCAS IR TAU PASAKE PINIGU PLOVIMO LOKACIJA",
    message = "SI LOKACIJA GALIOS TIK VIENA KARTA",
    attachments = {
        "https://cdn.discordapp.com/avatars/691243271825129473/a_ba2367d1273ae62b6225ed2649e37119.gif?size=1024",
    },
    actions = {
        {
            label = "Pazymeti vieta",
            data = {
                event = "walker_waypoint",
                isServer = false,
            }
        }
    }
})
end)


