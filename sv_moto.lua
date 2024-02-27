print("Script /moto sviluppato da BuongiornoDEV, entra nel discord se vuoi altri script GRATIS: https://discord.gg/SMGJU4PqGJ")

RegisterCommand("moto", function(source, args, rawCommand)
    local playerId = source
    local playerPed = GetPlayerPed(playerId)
    local coordinate = GetEntityCoords(playerPed)
    TriggerClientEvent("spawnMoto", playerId, coordinate)
end, false)
