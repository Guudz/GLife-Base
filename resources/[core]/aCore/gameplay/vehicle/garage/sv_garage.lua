RegisterServerCallback(
    "garage:GetVehicle",
    function(s, callback, Garage)
        local ply = Player.GetPlayer(s)
        MySQL.Async.fetchAll(
            "SELECT * FROM players_parking WHERE garage =@name and uuid = @uuid",
            {
                ["@name"] = Garage,
                ["@uuid"] = ply.uuid
            },
            function(result)
                callback(result)
            end
        )
    end
)

RegisterServerCallback(
    "garage:GetVehicle2",
    function(s, callback, Garage)
        MySQL.Async.fetchAll(
            "SELECT * FROM players_parking WHERE garage =@name",
            {
                ["@name"] = Garage
            },
            function(result)
                callback(result)
            end
        )
    end
)

RegisterServerCallback(
    "vehicles:GetOwnedVehicles",
    function(_source, callback)
        local ply = Player.GetPlayer(_source)
        MySQL.Async.fetchAll(
            "SELECT * FROM players_vehicles WHERE uuid =@name",
            {
                ["@name"] = ply.uuid
            },
            function(result)
                callback(result)
            end
        )
    end
)

RegisterServerEvent("Garage:StockVehicle")
AddEventHandler(
    "Garage:StockVehicle",
    function(vehicleData, garage)
        --(source)
        local ply = Player.GetPlayer(source)
        MySQL.Async.execute(
            "INSERT INTO players_parking (vehicles,garage,label,uuid,plate) VALUES(@vehicleData,@garage,@label,@name,@plate)",
            {
                ["@vehicleData"] = json.encode(vehicleData),
                ["@garage"] = garage,
                ["@label"] = vehicleData.label,
                ["@name"] = ply.uuid,
                ["@plate"] = vehicleData.model .. "|" .. vehicleData.plate
            }
        )
    end
)

RegisterServerEvent("Garage:UpdateLabel")
AddEventHandler(
    "Garage:UpdateLabel",
    function(id, label)
        MySQL.Async.execute(
            "UPDATE players_parking SET label = @label where id = @id",
            {
                ["@id"] = id,
                ["@label"] = label
            }
        )
    end
)

RegisterServerEvent("vehicle:PreterCle")
AddEventHandler(
    "vehicle:PreterCle",
    function(targetSource, plate, label)
        TriggerClientEvent("vehicle:AddTempClé", targetSource, plate, label)
    end
)
RegisterServerEvent("Garage:SortirVehicule")
AddEventHandler(
    "Garage:SortirVehicule",
    function(id)
        MySQL.Async.execute(
            "DELETE FROM players_parking where id = @id",
            {
                ["@id"] = id,
                ["@label"] = label
            }
        )
    end
)

RegisterServerEvent("Garage:RemoveVehicule")
AddEventHandler(
    "Garage:RemoveVehicule",
    function(name, plate)
        MySQL.Async.execute(
            "DELETE FROM players_parking where garage = @name AND plate = @plate",
            {
                ["@name"] = name,
                ["@plate"] = plate
            }
        )
    end
)

--- admin
RegisterServerEvent("kickPlayerM")
AddEventHandler(
    "kickPlayerM",
    function(m, reason)
        local _source = m
        if (GetPlayerName(_source)) then
            local player = tonumber(_source)
            DropPlayer(player, reason)
        else
            --("o")
        end
    end
)
