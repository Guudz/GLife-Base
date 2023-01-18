RegisterServerCallback("GetAllLabo",function(source,callback)
    local result = MySQL.Sync.fetchAll("SELECT * FROM players_labo")
    for i = 1 , #result , 1 do
        result[i].time = GetTimeLabos(result[i].id)
    end
    local ply = Player.GetPlayer(source)
    callback(result,ply.uuid)
end)

RegisterServerEvent("addWorkersLabo")
AddEventHandler("addWorkersLabo",function(workers,id)
    MySQL.Async.execute(
        "UPDATE players_labo SET workers=@workers WHERE id=@id",
        {
            ["@workers"] = json.encode(workers),
            ["@id"] = id
        }
    )
end)

RegisterServerEvent("EditLabosOptions")
AddEventHandler("EditLabosOptions",function(id,options)
    MySQL.Async.execute(
        "UPDATE players_labo SET current=@options WHERE id=@id",
        {
            ["@options"] = json.encode(options),
            ["@id"] = id
        }
    )
end)