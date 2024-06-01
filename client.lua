ESX = exports.es_extended:getSharedObject()
local panaudotas = true
local blips = {
    {title="Petro Draugas", colour=1, id=615, x = -234.9430, y = 311.5639, z = 92.1662}, --- -234.9430, 311.5639, 92.1662
 }
local dict, anim = 'mp_car_bomb', 'onback_bwd'

Citizen.CreateThread(function()
    RequestModel("s_m_y_xmech_02")
    while not HasModelLoaded("s_m_y_xmech_02") do
      Citizen.Wait(0)
      RequestAnimDict(dict)
  end
    local ped = CreatePed(4, GetHashKey("s_m_y_xmech_02"), -1528.5684, 834.0520, 181.5948 - 1, 136.5393, false, true) --- -1528.5684, 834.0520, 181.5948, 136.5393
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped, "missfbi_s4mop", "guard_idle_b", 8.0, 8.0, 1, 50, 0, false, false, true)
end)

exports.ox_target:addSphereZone({
    coords = vec3(-1528.5684, 834.0520, 181.5948),
    radius = 1,
    name = 'walker_walkermoney_main',
    options = {
        {
            name = 'walker_walkermoney_main',
            icon = 'fa-solid fa-money-bill',
            label = 'Kalbeti su Petru',
            canInteract = function(entity, distance, coords, name, bone)
                return true
            end,
            onSelect = function()
                pradetiplovima()
            end,
        }
    }
})

function pradetiplovima()
lib.progressCircle({
    duration = 3000,
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    allowCuffed = false,
    disable = {
        car = true,
        move = true,
        combat = true,
        sprint = true,
    },
    anim = {
        dict = 'missfbi3_party_d',
        clip = 'stand_talk_loop_a_male1'
    },
})
local input = lib.inputDialog('Kiek Noreti isplauti pinigu?', {'Suma?'})
 
if not input then return end
kiekis = tonumber(input[1])
 --- TriggerServerEvent('walker_moneywash_removemoney', kiekis)
pedasduxas()
SetNewWaypoint(-234.9430 --[[ number ]], 311.5639 --[[ number ]])
end

function pedasduxas()
    local ped2 = CreatePed(4, GetHashKey("s_m_y_xmech_02"), -234.9430, 311.5639, 92.1662 - 1, 261.3563, false, true) --- -234.9430, 311.5639, 92.1662, 261.3563
    FreezeEntityPosition(ped2, true)
    SetEntityInvincible(ped2, true)
    SetBlockingOfNonTemporaryEvents(ped2, true)
    TaskPlayAnim(ped2, "missfbi_s4mop", "guard_idle_b", 8.0, 8.0, 1, 50, 0, false, false, true)
    pridetitargeta()
    lib.notify({
        title = 'Petras pasake jum vieta kur bus jo draugas',
        description = nil,
        type = 'info'
    })
end

function pridetitargeta()
    exports.ox_target:addSphereZone({
        coords = vec3(-234.9430, 311.5639, 92.1662),
        radius = 1,
        options = {
            {
                name = 'walker_walkermoney_ped',
                icon = 'fa-solid fa-money-bill',
                label = 'Kalbeti su Petro draugu',
                canInteract = function(entity, distance, coords, name, bone)
                    return panaudotas
                end,
                onSelect = function()
                    suma()
                end
            }
        }
    })
end
function suma()
lib.progressCircle({
    duration = 3000,
    position = 'bottom',
    useWhileDead = false,
    canCancel = false,
    allowCuffed = false,
    disable = {
        car = true,
        move = true,
        combat = true,
        sprint = true,
    },
    anim = {
        dict = 'missfbi3_party_d',
        clip = 'stand_talk_loop_a_male1'
    },
})
TriggerServerEvent('walker_moneywash_removemoney', kiekis)
FreezeEntityPosition(ped2, false)
SetEntityInvincible(ped2, false)
SetBlockingOfNonTemporaryEvents(ped2, false)
end

function blip()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.8)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
        SetBlipFlashTimer(info.blip --[[ Blip ]], 50000)
        Citizen.Wait(50000)
        RemoveBlip(info.blip)

    end
end

RegisterNetEvent('walker_moneywash_romovetarget', function()
    panaudotas = false
end)