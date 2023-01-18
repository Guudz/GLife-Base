

RegisterServerEvent("skin:AddMySkin")
AddEventHandler("skin:AddMySkin", function(p)

    local face = json.encode(p.skin)
    local outfit = json.encode(p.outfit)
    local tattoo = nil
    MySQL.Async.execute(
        'INSERT INTO players_appearance (uuid,face,outfit,tattoo) VALUES(@uuid,@face,@outfit,@tattoo)',
        {
            ['@uuid']   = Player.GetCurrentUuid(source),
            ['@face'] = face,
            ['@outfit'] = outfit,
            ['@tattoo'] = {},

        }
    )

end)
RegisterServerEvent("tatoo:add")
AddEventHandler("tatoo:add", function(data)
    local users = Users[source]
    MySQL.Async.execute(
        'UPDATE players_appearance SET tattoo=@tattoo where uuid=@uid',
        {
             ['@uid']   = users.uuid,
             ['@tattoo'] = json.encode(data),

         }
        )
end)
