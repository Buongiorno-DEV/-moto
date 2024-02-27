ESX = exports["es_extended"]:getSharedObject()

local motospawnata = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsControlJustReleased(0, 23) then
                DeleteVehicle(vehicle)
                motospawnata = false
            end
        end
    end
end)

function SpawnMoto()
    if not motospawnata then
        RequestModel(config.Modello)
        while not HasModelLoaded(config.Modello) do
            Wait(500)
        end

        local playerPed = PlayerPedId()
        local coordinate = GetEntityCoords(playerPed)
        local vehicle = CreateVehicle(config.Modello, coordinate, GetEntityHeading(playerPed), true, false)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        motospawnata = true
    else
        ESX.ShowNotification("Hai già una moto spawnata")
    end
end

RegisterCommand("moto", function()
    local closestPlayerPed = GetPlayerPed(-1)
    local vita = GetEntityHealth(closestPlayerPed)
    if vita <= 0 then
        ESX.ShowNotification("Non puoi spawnare moto da morto!") 
    else
        SpawnMoto()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
    motospawnata = false
end)
