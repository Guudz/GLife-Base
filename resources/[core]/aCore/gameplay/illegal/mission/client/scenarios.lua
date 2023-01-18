illegalscenario = {
    [1] = function(param)
        local pos = {
            {x = 2653.78, y = 1703.64, z = 24.49},
            {x = 23.16, y = -131.22, z = 55.31, a = 69.33},
            {x = -1013.58, y = 78.32, z = 51.29, a = 210.29},
            {x = -1090.89, y = -479.04, z = 36.49, a = 27.66},
            {x = -1219.19, y = -685.5, z = 25.88, a = 129.79},
            {x = -1249.11, y = -642.54, z = 30.7, a = 130.67},
            {x = -1201.55, y = -694.63, z = 40.34, a = 218.74},
            {x = -1037.15, y = -1668.1, z = 4.47, a = 187.51},
            {x = -967.15, y = -1578.3, z = 5.00, a = 18.85},
            {x = -1174.55, y = -1377.4, z = 4.93, a = 293.43},
            {x = -1274.73, y = -1155.23, z = 6.2, a = 292.62},
            {x = -1618.67, y = -853.5, z = 10.04, a = 317.65},
            {x = -1704.1, y = -903.27, z = 7.79, a = 140.46},
            {x = -2037.86, y = -461.27, z = 11.37, a = 319.49},
            {x = -2998.05, y = 77.73, z = 11.59, a = 148.31},
            {x = -3053.33, y = 602.86, z = 7.19, a = 108.35},
            {x = -3137.68, y = 1090.57, z = 20.55, a = 259.49},
            {x = -1666.22, y = 129.9, z = 62.96, a = 123.06},
            {x = -1685.34, y = 48.72, z = 63.94, a = 341.78},
            {x = -1221.72, y = -195.43, z = 39.08, a = 249.2},
            {x = -1293.29, y = -184.73, z = 46.95, a = 36.79},
            {x = -1304.91, y = -221.89, z = 60.56, a = 125.55},
            {x = -1323.00, y = -382.91, z = 36.54, a = 298.57},
            {x = -1322.8, y = -454.97, z = 33.24, a = 35.67},
            {x = -1688.71, y = -387.45, z = 47.61, a = 319.24},
            {x = -965.17, y = -1481.35, z = 4.93, a = 108.78}
        }
        local ra = Random(#pos)
        if ra == 0 then
            ra = 1
        end
        local spawnPos = pos[ra]
        local ra = Random(#param.cars)
        if ra == 0 then
            ra = 1
        end
        local car = param.cars[ra]
        local v = nil
        local vspawn = false

        repeat
            if IsAnyVehicleNearPoint(spawnPos.x, spawnPos.y, spawnPos.z, 1.5) == false then
                vehicleFct.SpawnVehicle(
                    car,
                    spawnPos,
                    spawnPos.a,
                    function(vehicle)
                        v = vehicle
                        SetEntityAsMissionEntity(vehicle, true, true)
                    end
                )
                local coords = {x = spawnPos.x + Random(75), y = spawnPos.y - Random(75), z = spawnPos.z}
                local streetname = GetStreetNameFromHashKey(GetStreetNameAtCoord(spawnPos.x, spawnPos.y, spawnPos.z))
                ShowAdvancedNotification(
                    "Kevin",
                    "~b~Dialogue",
                    "J'ai reçu une livraison de ~b~" ..
                        GetLabelText(GetDisplayNameFromVehicleModel(car)) .. " ~s~à ~b~" .. streetname .. "\n~s~",
                    "CHAR_LESTER_DEATHWISH",
                    1
                )
                Wait(50)
                ShowNotification("~r~Récupère la je te laisse " .. param.hours .. " heures")

                while v == nil do
                    Citizen.Wait(50)
                end
                currentMission.streetName = streetname
                currentMission.goalCar = GetLabelText(GetDisplayNameFromVehicleModel(car))
                currentMission.plates = GetVehicleNumberPlateText(v)
                currentMission.participant = {GetPlayerServerId(PlayerId())}
                currentMission.id = GetGameTimer()
                ClearGpsPlayerWaypoint()
                SetNewWaypoint(coords.x, coords.y)
                TriggerServerEvent("startIllegalMission", currentMission)

                vspawn = true
                Citizen.CreateThread(
                    function()
                        Wait((currentMission.timeLeft - GetGameTimer()) / 4)

                        TriggerServerEvent(
                            "call:makeCall2",
                            "police",
                            coords,
                            "J'ai eu comme information qu'un véhicule était fortement convoité par là bas",
                            "Informateur"
                        )
                        TriggerServerEvent(
                            "call:makeCall2",
                            "lssd",
                            coords,
                            "J'ai eu comme information qu'un véhicule était fortement convoité par là bas",
                            "Informateur"
                        )
                    end
                )

                TriggerServerEvent(
                    "aCore:sendToDiscord",
                    "https://discord.com/api/webhooks/842991761671585812/oocOKps2gkrgbtMnOM6drIhl9jid5HcGpNocO0E07_bQ1sjHToFGteBsFc0ofhA-qk3R",
                    "Lance un Vol véhicule : " .. GetLabelText(GetDisplayNameFromVehicleModel(car))
                )
            else
                Wait(500)
            end
        until vspawn
    end,
    [2] = function(param)
        local configStart = param.configStart

        local positionStartRandomness = Random(#missionConfig["startPointGoFast"])
        if positionStartRandomness == 0 then
            positionStartRandomness = 1
        end

        local positionDrugRandomness = Random(#configStart["positions"])
        if positionDrugRandomness == 0 then
            positionDrugRandomness = 1
        end

        local positionStart = missionConfig["startPointGoFast"][positionStartRandomness]
        local positionDrugs = configStart["positions"][positionStartRandomness]
        local configEnd = missionConfig["receleurGoFastPos"]

        local carRandomness = Random(#param.cars)
        if carRandomness == 0 then
            carRandomness = 1
        end

        local car = param.cars[carRandomness]

        local v = nil
        local vspawn = false

        repeat
            if IsAnyVehicleNearPoint(positionStart.pos.x, positionStart.pos.y, positionStart.pos.z, 1.5) == false then
                vehicleFct.SpawnVehicle(
                    car,
                    positionStart.pos,
                    positionStart.heading,
                    function(vehicle)
                        v = vehicle
                        SetEntityAsMissionEntity(vehicle, true, true)
                        --AddPropIntoTrunk(configStart.propInTrunk, vehicle)
                        SetVehicleMod(vehicle, 11, 5, false)
                        SetVehicleMod(vehicle, 12, 5, false)
                        Citizen.InvokeNative(0xBAA045B4E42F3C06, vehicle, 190 / 3.6)
                        SetVehicleEnginePowerMultiplier(vehicle, 20.0)
                        ModifyVehicleTopSpeed(vehicle, 25.0)
                        SetVehicleMod(vehicle, 13, 5, false)
                        SetVehicleMod(vehicle, 15, 4, false)
                        ToggleVehicleMod(vehicle, 18, 1)
                        ToggleVehicleMod(vehicle, 22, 1)
                    end
                )
                local coordsStart = {
                    x = positionDrugs.pos.x,
                    y = positionDrugs.pos.y,
                    z = positionDrugs.pos.z
                }

                local streetname =
                    GetStreetNameFromHashKey(
                    GetStreetNameAtCoord(positionStart.pos.x, positionStart.pos.y, positionStart.pos.z)
                )
                ShowAdvancedNotification(
                    "Armando",
                    "~b~Dialogue",
                    "Tu vas aller chercher la voiture derriere le Hookies ~b~" ..
                        GetLabelText(GetDisplayNameFromVehicleModel(car)) .. " ~s~à ~b~" .. streetname .. "\n~s~",
                    "CHAR_LESTER_DEATHWISH",
                    1
                )
                Wait(50)
                ShowNotification(
                    "~r~Récupère la. Attention pour cette mission je te laisse " .. param.minutes .. " minutes"
                )

                while v == nil do
                    Citizen.Wait(50)
                end

                local positionEndRandomness = Random(#configEnd)
                if positionEndRandomness == 0 then
                    positionEndRandomness = 1
                end

                local positionEnd = configEnd[positionEndRandomness]

                local coords = {
                    x = positionEnd.pos.x + Random(-100, 100),
                    y = positionEnd.pos.y + Random(-100, 100),
                    z = positionEnd.pos.z
                }

                currentMission.streetName = streetname
                currentMission.goalCar = GetLabelText(GetDisplayNameFromVehicleModel(car))
                currentMission.plates = GetVehicleNumberPlateText(v)
                currentMission.participant = {GetPlayerServerId(PlayerId())}
                currentMission.id = GetGameTimer()
                currentMission.pedName = positionEnd.name
                currentMission.positionDrug = vector3(positionDrugs.pos.x, positionDrugs.pos.y, positionDrugs.pos.z)
                currentMission.positionEnd = vector3(positionEnd.pos.x, positionEnd.pos.y, positionEnd.pos.z)
                currentMission.blip = AddBlipForCoord(positionStart.pos.x, positionStart.pos.y, positionStart.pos.z)

                local entityZoneName =
                    GetNameOfZone(
                    GetEntityCoords(PlayerPedId()).x,
                    GetEntityCoords(PlayerPedId()).y,
                    GetEntityCoords(PlayerPedId()).z
                )

                TriggerServerEvent(
                    "aCore:sendToDiscord",
                    "https://discord.com/api/webhooks/842991761671585812/oocOKps2gkrgbtMnOM6drIhl9jid5HcGpNocO0E07_bQ1sjHToFGteBsFc0ofhA-qk3R",
                    "[" ..
                        entityZoneName ..
                            "] Lance un GoFast à " ..
                                GetZoneLabelTextFromZoneCode(entityZoneName) ..
                                    " voiture : " ..
                                        GetLabelText(GetDisplayNameFromVehicleModel(car)) ..
                                            "(" ..
                                                GetVehicleNumberPlateText(v) .. ")" .. " récupération à " .. streetname
                )

                SetBlipRoute(currentMission.blip, true)
                TriggerServerEvent("startIllegalMission", currentMission)

                vspawn = true
                Citizen.CreateThread(
                    function()
                        Wait((currentMission.timeLeft - GetGameTimer()) / 10)

                        TriggerServerEvent(
                            "call:makeCall2",
                            "police",
                            coordsStart,
                            "TEMOIN\nUn type met de la drogue dans une " ..
                                currentMission.goalCar .. " immatriculé : " .. currentMission.plates,
                            currentMission.pedName
                        )
                        TriggerServerEvent(
                            "call:makeCall2",
                            "lssd",
                            coordsStart,
                            "TEMOIN\nUn type met de la drogue dans une " ..
                                currentMission.goalCar .. " immatriculé : " .. currentMission.plates,
                            currentMission.pedName
                        )
                    end
                )

                Citizen.CreateThread(
                    function()
                        Wait((currentMission.timeLeft - GetGameTimer()) / 6)
                        local timerLocal = GetGameTimer()
                        local coordsPlayer = GetEntityCoords(PlayerPedId())
                        local coordsApprox =
                            vector3(
                            coordsPlayer.x + Random(300, 600) * 1.0,
                            coordsPlayer.y + Random(300, 600) * 1.0,
                            coordsPlayer.z
                        )

                        TriggerServerEvent(
                            "call:makeCall2",
                            "police",
                            coordsApprox,
                            "Voiture rapide aperçue : " ..
                                currentMission.goalCar ..
                                    " immatriculé : " .. currentMission.plates .. ". regardez vos cartes",
                            "Collègue LSPD"
                        )
                        TriggerServerEvent(
                            "call:makeCall2",
                            "lssd",
                            coordsApprox,
                            "Voiture rapide aperçue : " ..
                                currentMission.goalCar ..
                                    " immatriculé : " .. currentMission.plates .. ". regardez vos cartes",
                            "Collègue LSSD"
                        )
                        while (GetGameTimer() - timerLocal < 100000) do
                            Citizen.Wait(0)
                        end
                    end
                )

                local hasBeenToldForDrug = false
                local hasBeenLoadedWithDrug = false
                local dealderCarSpawned = false

                -- Input invites
                Citizen.CreateThread(
                    function()
                        while true do
                            if (IsPedInAnyVehicle(PlayerPedId(), true)) then
                                local pedDealer = nil
                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                if
                                    (GetVehicleNumberPlateText(vehicle) == currentMission.plates and
                                        hasBeenToldForDrug == false)
                                 then
                                    local streetname =
                                        GetStreetNameFromHashKey(
                                        GetStreetNameAtCoord(
                                            currentMission.positionDrug.x,
                                            currentMission.positionDrug.y,
                                            currentMission.positionDrug.z
                                        )
                                    )

                                    ShowAdvancedNotification(
                                        positionEnd.name,
                                        "~b~Dialogue",
                                        "Tu vas aller mettre la drogue dans la voiture a ~b~" ..
                                            " ~s~à ~b~" .. streetname .. "\n~s~",
                                        "CHAR_LESTER_DEATHWISH",
                                        1
                                    )
                                    if currentMission.blip ~= nil then
                                        RemoveBlip(currentMission.blip)
                                        currentMission.blip = nil
                                    end
                                    hasBeenToldForDrug = true
                                    currentMission.blip =
                                        AddBlipForCoord(
                                        currentMission.positionDrug.x,
                                        currentMission.positionDrug.y,
                                        currentMission.positionDrug.z
                                    )
                                    SetBlipRoute(currentMission.blip, true)
                                    SetBlipRouteColour(currentMission.blip, 5)
                                    TriggerServerEvent("editIllegalMission", currentMission)
                                end

                                local playerCoords = GetEntityCoords(PlayerPedId(), 0)
                                local distance =
                                    GetDistanceBetweenCoords(
                                    currentMission.positionDrug.x,
                                    currentMission.positionDrug.y,
                                    currentMission.positionDrug.z,
                                    playerCoords.x,
                                    playerCoords.y,
                                    playerCoords.z,
                                    false
                                )

                                if
                                    (GetVehicleNumberPlateText(vehicle) == currentMission.plates and
                                        hasBeenToldForDrug == true and
                                        hasBeenLoadedWithDrug == false and
                                        distance < 10.0)
                                 then
                                    ShowAdvancedNotification(
                                        positionEnd.name,
                                        "~b~Dialogue",
                                        "Ok super attend un peu désormais, on va te charger la voiture et on te dira où livrer",
                                        "CHAR_LESTER_DEATHWISH",
                                        1
                                    )
                                    hasBeenLoadedWithDrug = true
                                    LoadingPrompt("Chargement de la cargaison", 4)
                                    SetVehicleUndriveable(vehicle, true)
                                    FreezeEntityPosition(vehicle, true)
                                    Citizen.Wait(1000)
                                    SetVehicleDoorOpen(vehicle, 5, false, false)
                                    Citizen.Wait(30000)
                                    SetVehicleDoorShut(vehicle, 5, false, false)
                                    SetVehicleUndriveable(vehicle, false)
                                    FreezeEntityPosition(vehicle, false)
                                    RemoveLoadingPrompt()

                                    local streetname =
                                        GetStreetNameFromHashKey(
                                        GetStreetNameAtCoord(
                                            currentMission.positionEnd.x,
                                            currentMission.positionEnd.y,
                                            currentMission.positionEnd.z
                                        )
                                    )

                                    ShowAdvancedNotification(
                                        positionEnd.name,
                                        "~b~Dialogue",
                                        "La livraison aura lieu à ~b~" .. " ~s~à ~b~" .. streetname .. "\n~s~",
                                        "CHAR_LESTER_DEATHWISH",
                                        1
                                    )
                                    if currentMission.blip ~= nil then
                                        RemoveBlip(currentMission.blip)
                                        currentMission.blip = nil
                                    end

                                    currentMission.blip =
                                        AddBlipForCoord(
                                        currentMission.positionEnd.x,
                                        currentMission.positionEnd.y,
                                        currentMission.positionEnd.z
                                    )
                                    SetBlipRoute(currentMission.blip, true)
                                    SetBlipRouteColour(currentMission.blip, 2)
                                    TriggerServerEvent("editIllegalMission", currentMission)
                                end

                                Citizen.Wait(500)
                            else
                                Citizen.Wait(5000)
                            end
                        end
                    end
                )
            else
                positionStartRandomness = Random(#configStart["positions"])
                if positionStartRandomness == 0 then
                    positionStartRandomness = 1
                end

                positionStart = missionConfig["startPointGoFast"][positionStartRandomness]
                Wait(500)
            end
        until vspawn
    end
}

function AddPropIntoTrunk(model, vehicle)
    local modelHash = GetHashKey(model)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(vehicle)
    local forward = GetEntityForwardVector(vehicle)
    local x, y, z = table.unpack(coords - forward * 1.0)

    Citizen.CreateThread(
        function()
            if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
                RequestModel(modelHash)

                while not HasModelLoaded(modelHash) do
                    Citizen.Wait(1)
                end
            end
            local obj = CreateObject(modelHash, coords.x, coords.y, coords.z - 0.3, true, false, true)
            SetModelAsNoLongerNeeded(modelHash)
            SetEntityHeading(obj, GetEntityHeading(vehicle))

            AttachEntityToEntity(
                obj,
                vehicle,
                GetEntityBoneIndexByName(playerPed, "misc_a"),
                0.0,
                -0.72,
                0.3,
                0.0,
                0.0,
                0.0,
                true,
                true,
                false,
                true,
                0,
                true
            )
        end
    )
end
