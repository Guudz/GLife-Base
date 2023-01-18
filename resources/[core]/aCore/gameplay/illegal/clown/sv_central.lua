RegisterServerEvent("sv:stopLights")
AddEventHandler(
    "sv:stopLights",
    function()
        TriggerClientEvent("stopLights", -1)
    end
)
