RegisterServerCallback("getSettings",function(source, callback)
    local _source = source
    local identifiers = GetIdentifiers(_source).steam
    print('identf : '..identifiers)
    MySQL.Async.fetchAll(
        "SELECT colors,demarche,binds FROM users WHERE identifier = @identifiers",
        {
            ["@identifiers"] = identifiers
        },
        function(result)
            callback(result)
        end
    )
end)

local armeBuyed = {}

RegisterServerCallback(
    "getArmeblanched",
    function(source, callback)
        local player = Player.GetPlayer(source)
        callback(armeBuyed[player.uuid] == nil)
    end
)
RegisterServerEvent("ArmeBlanche")
AddEventHandler(
    "ArmeBlanche",
    function()
        local player = Player.GetPlayer(source)

        table.insert(armeBuyed, player.uuid)
    end
)

RegisterServerEvent("saveMyDemarche")
AddEventHandler("saveMyDemarche",function(i)
    local _source = source
    local identifers = GetIdentifiers(_source).steam

    MySQL.Async.fetchAll(
        "UPDATE users SET demarche = @demarche WHERE identifier = @identifiers",
        {
            ["@identifiers"] = identifers,
            ["@demarche"] = i
        }
    )
end)
RegisterServerEvent("BuyNewWeapon")
AddEventHandler(
    "BuyNewWeapon",
    function(data, label)
        local player = Player.GetPlayer(source)

        MySQL.Async.execute(
            "INSERT INTO players_weapon (serial,weapon_name,user) VALUES(@serial,@weapon_name,@user)",
            {
                ["@serial"] = data.serial,
                ["@weapon_name"] = label,
                ["@user"] = json.encode({name = player.firstname, surname = player.surname})
            }
        )
    end
)
RegisterServerEvent("saveMyColor")
AddEventHandler("saveMyColor",function(color)
    local _source = source
    local identifers = GetIdentifiers(_source).steam

    MySQL.Async.fetchAll(
        "UPDATE users SET colors = @color WHERE identifier = @identifiers",
        {
            ["@identifiers"] = identifers,
            ["@color"] = json.encode(color)
        }
    )
end)
RegisterServerEvent("saveMyBind")
AddEventHandler("saveMyBind",function(bind)
        local _source = source
        local identifers = GetIdentifiers(_source).steam

        MySQL.Async.fetchAll(
            "UPDATE users SET binds = @binds WHERE identifier = @identifiers",
            {
                ["@identifiers"] = identifers,
                ["@binds"] = json.encode(bind)
            }
        )
    end
)

AddEventHandler(
    "playerConnecting",
    function(name, setKickReason, deferrals)
        local _source = source

        local steam64 = GetPlayerIdentifiers(_source)[1]

        local steam_name = GetPlayerName(_source)
        local rockstar = nil
        local ipv4 = nil
        deferrals.defer()

        deferrals.update(string.format("Bonjour %s, Bienvenue sur RainLayer City", name))

        Wait(1200)
        for _, foundID in ipairs(GetPlayerIdentifiers(_source)) do
            if string.match(foundID, "license:") then
                rockstar = string.sub(foundID, 9)
            elseif string.match(foundID, "ip:") then
                ipv4 = string.sub(foundID, 4)
            elseif string.match(foundID, "steam:") then
                steam64 = foundID
            end
        end
        local listed = MySQL.Sync.fetchAll("SELECT * FROM whitelist WHERE identifier=@name", {["@name"] = steam64})
        local name = GetPlayerName(_source) or "Nom inconnu"
        --print("Connexion : " .. name)
        if listed ~= nil and listed[1] ~= nil then
            if listed[1].permanent_ban then
                local now = os.time()
                if now > listed[1].ban_expire_at then
                    deferrals.update("Vous avez été débanni faites attention dés à présent !")
                    MySQL.Async.execute(
                        "UPDATE whitelist SET permanent_ban=0, ban_expire_at = 0, reason = 0 where identifier=@identifier",
                        {
                            ["@identifier"] = steam64,
                            ["@ban_expire_at"] = timestamp,
                            ["@reason"] = reason
                        }
                    )
                    Wait(2000)
                    deferrals.done()
                    TriggerEvent(
                        "aCore:sendToDiscordFromServer",
                        _source,
                        "https://discord.com/api/webhooks/842992237431881750/JJjrJcdhmrrB1DTb4knVTf2gqjbUz0tVgib6n0R2LDPyGoEkkUtkLvml7nlJJXyaurxQ",
                        "Se connecte sur RainLayer City"
                    )
                else
                    deferrals.done(
                        "Vous êtes banni jusqu'au " ..
                            os.date("%d/%m/%Y %X", listed[1].ban_expire_at) .. "\nRaison : " .. listed[1].reason
                    )
                    TriggerEvent(
                        "aCore:sendToDiscordFromServer",
                        _source,
                        "https://discord.com/api/webhooks/842992237431881750/JJjrJcdhmrrB1DTb4knVTf2gqjbUz0tVgib6n0R2LDPyGoEkkUtkLvml7nlJJXyaurxQ",
                        "Se connecte mais banni"
                    )
                end
            else
                TriggerEvent(
                    "aCore:sendToDiscordFromServer",
                    _source,
                    "https://discord.com/api/webhooks/842992237431881750/JJjrJcdhmrrB1DTb4knVTf2gqjbUz0tVgib6n0R2LDPyGoEkkUtkLvml7nlJJXyaurxQ",
                    "Se connecte sur RainLayer City"
                )
                deferrals.done()
            end
        else
            MySQL.Async.execute(
                "INSERT INTO whitelist(identifier) VALUES(@steam64)",
                {
                    ["@steam64"] = steam64,
                }
            )

            deferrals.update("Bon jeux sur RainLayer City !")

            Wait(800)
            deferrals.done()
        end
    end
)
