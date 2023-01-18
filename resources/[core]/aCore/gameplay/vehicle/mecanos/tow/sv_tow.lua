RegisterServerEvent("vehicle:UnTowVehicle")
AddEventHandler(
    "vehicle:UnTowVehicle",
    function(id)
        MySQL.Async.execute(
            "UPDATE players_vehicles SET pound = 0 where id = @id",
            {
                ["@id"] = id
            }
        )
    end
)

MySQL.ready(
    function()
        MySQL.Async.fetchAll(
            "SELECT * FROM players_parking",
            {},
            function(_result)
                for keyVeh, valueVeh in pairs(_result) do
                    if (valueVeh.plate == nil) then
                        vehicleData = json.decode(valueVeh.vehicles)
                        if vehicleData.plate == nil then
                            math.randomseed(GetGameTimer())
                            vehicleData.plate = math.random(10000000, 99999999)

                            MySQL.Async.execute(
                                "UPDATE players_parking SET vehicles = @vehicles where id = @id",
                                {
                                    ["@id"] = valueVeh.id,
                                    ["@vehicles"] = json.encode(vehicleData)
                                },
                                function(inserted)
                                    print("[MIGRATION] ^2 Added plate into vehicle^0")
                                end
                            )
                        end

                        valueVeh.plate = vehicleData.model .. "|" .. vehicleData.plate
                        MySQL.Async.execute(
                            "UPDATE players_parking SET plate = @plate where id = @id",
                            {
                                ["@id"] = valueVeh.id,
                                ["@plate"] = valueVeh.plate
                            },
                            function(inserted)
                                print(
                                    "[MIGRATION] ^2 Adedd plate to vehicle id " ..
                                        vehicleData.plate ..
                                            " set : " .. vehicleData.model .. "|" .. vehicleData.plate .. "^0"
                                )
                            end
                        )
                    end
                end

                MySQL.Async.fetchAll(
                    "SELECT * FROM players_vehicles WHERE pound =0",
                    {},
                    function(result)
                        for i = 1, #result, 1 do
                            print(
                                "[TOW] ^2checking for this plate : " ..
                                    result[i].label .. " " .. result[i].plate .. "^0"
                            )
                            local found = false
                            local foundAt = nil
                            for t = 1, #_result, 1 do
                                local data = json.decode(_result[t].vehicles)
                                if data.plate == result[i].plate then
                                    found = true
                                    foundAt = t
                                end
                            end
                            if not found then
                                MySQL.Async.execute(
                                    "UPDATE players_vehicles SET pound = 1 where id = @id",
                                    {
                                        ["@id"] = result[i].id
                                    }
                                )
                                print("[TOW] ^2" .. result[i].label .. " " .. result[i].plate .. " mis en fourrière^0")
                            end
                        end
                    end
                )

                MySQL.Async.fetchAll(
                    "SELECT * FROM players_vehicles WHERE pound = 1",
                    {},
                    function(result)
                        for i = 1, #result, 1 do
                            while _result == nil do
                                Wait(1)
                            end

                            for c = 1, #_result, 1 do
                                data = json.decode(_result[c].vehicles)
                                if result[i].plate == data.plate then
                                    local vehicleId = _result[c].id
                                    local vehicleLabel = data.label
                                    local vehiclePlate = data.plate
                                    MySQL.Async.execute(
                                        "DELETE FROM players_parking where id = @id",
                                        {
                                            ["@id"] = vehicleId
                                        },
                                        function(localResults)
                                            print(
                                                vehicleLabel ..
                                                    " " .. vehiclePlate .. " était en garage et en fourrière"
                                            )
                                        end
                                    )
                                end
                            end
                        end
                    end
                )
            end
        )
    end
)
