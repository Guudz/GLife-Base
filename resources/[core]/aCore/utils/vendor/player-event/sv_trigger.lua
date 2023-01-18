RegisterServerEvent('rage-reborn:PlayerEventHandler')
AddEventHandler("rage-reborn:PlayerEventHandler",function(name,_source,...)
    print(name .. " event triggered to " .. _source)
    TriggerClientEvent(name,_source,...)
end)





MySQL.ready(function ()
    MySQL.Async.execute(
        "UPDATE users SET farm_limit = 0",
        {
        }
    )
end)