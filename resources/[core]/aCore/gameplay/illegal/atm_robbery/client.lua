local currentlyRobbering = false
local hintDisplayed = false

function loadModelRoberry(model)
    Citizen.CreateThread(
        function()
            while not HasModelLoaded(model) do
                RequestModel(model)
                Citizen.Wait(1)
            end
        end
    )
end

local AtmPropsType = {
    {prop = "prop_atm_02"},
    {prop = "prop_atm_03"},
    {prop = "prop_fleeca_atm"},
    {prop = "prop_atm_01"}
}

function getNearestATMObject()
    local objects = {}
    for _, v in pairs(AtmPropsType) do
        table.insert(objects, v.prop)
    end

    local ped = PlayerPedId()
    local list = {}

    for _, v in pairs(objects) do
        local obj =
            GetClosestObjectOfType(
            GetEntityCoords(ped).x,
            GetEntityCoords(ped).y,
            GetEntityCoords(ped).z,
            5.0,
            GetHashKey(v),
            false,
            true,
            true
        )
        local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(obj), true)
        table.insert(list, {object = obj, distance = dist})
    end

    local closest = list[1]
    for _, v in pairs(list) do
        if v.distance < closest.distance then
            closest = v
        end
    end

    return closest.object
end

function playAnimationATM(animationDict, type)
    local playerPed = PlayerPedId()
    RequestAnimDict(animationDict)
    local j = 0
    while not HasAnimDictLoaded(animationDict) and j <= 50 do
        Citizen.Wait(100)
        j = j + 1
    end

    if j >= 50 then
        ShowNotification("~r~ERREUR ~w~: Animation trop longue a charger.")
    else
        TaskPlayAnim(playerPed, animationDict, type, 8.0, 1.0, -1, 0)
        RemoveAnimDict(animationDict)
    end
end

Citizen.CreateThread(
    function()
        while true do
            if IsNearATM() then
                Citizen.Wait(5)
                local ped = PlayerPedId()
                if not IsPedInAnyVehicle(ped) and not IsPedDeadOrDying(ped) then
                    if Inventory == nil then
                        break
                    end
                    local count = Inventory:GetItemCount(ATMRobberyConfig["itemRequired"])

                    if count ~= nil and count > 0 then
                        if (hintDisplayed == false) then
                            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour braquer l'ATM")
                            hintDisplayed = true
                            KeySettings:Add("keyboard", "E", startRobbery, "ATMROBBERY")
                            KeySettings:Add("controller", 46, tartRobbery, "ATMROBBERY")
                        end

                        if (currentlyRobbering == true and hintDisplayed == true) then
                            Hint:RemoveAll()
                            KeySettings:Clear("keyboard", "E", "ATMROBBERY")
                            KeySettings:Clear("controller", 46, "ATMROBBERY")
                            hintDisplayed = false
                        end
                    end
                end
            else
                Citizen.Wait(1000)
                if (hintDisplayed == true) then
                    Hint:RemoveAll()
                    KeySettings:Clear("keyboard", "E", "ATMROBBERY")
                    KeySettings:Clear("controller", 46, "ATMROBBERY")
                    hintDisplayed = false
                end
            end
        end
    end
)

function startRobbery()
    TriggerServerCallback(
        "illegalAtmRobbery:robberyCanStart",
        function(bool)
            if bool == true then
                TriggerServerCallback(
                    "service:Count",
                    function(nbpolice)
                        TriggerServerCallback(
                            "service:Count",
                            function(nblssd)
                                allcount = nbpolice + nblssd
                                if allcount >= ATMRobberyConfig["policeRequired"] then
                                    currentlyRobbering = true
                                    TriggerServerEvent("illegalAtmRobbery:startRoberry")
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
                                                "] Lance un braquage d'ATM à : " ..
                                                    GetZoneLabelTextFromZoneCode(entityZoneName)
                                    )

                                    Inventory:RemoveItemToInv(
                                        Inventory.Inventory["stickybomb"][1].id,
                                        Inventory.Inventory["stickybomb"][1].name
                                    )

                                    local nearestATM = getNearestATMObject()
                                    local ped = PlayerPedId()

                                    TriggerServerEvent(
                                        "call:makeCall2",
                                        "police",
                                        {
                                            x = GetEntityCoords(nearestATM).x,
                                            y = GetEntityCoords(nearestATM).y,
                                            z = GetEntityCoords(nearestATM).z
                                        },
                                        "\n[CAMERA BANCAIRE " ..
                                            Random(1000, 9999) .. "]\n ~r~ATTAQUE ATM A LA BOMBE COLLANTE~s~"
                                    )
                                    TriggerServerEvent(
                                        "call:makeCall2",
                                        "lssd",
                                        {
                                            x = GetEntityCoords(nearestATM).x,
                                            y = GetEntityCoords(nearestATM).y,
                                            z = GetEntityCoords(nearestATM).z
                                        },
                                        "\n[CAMERA BANCAIRE " ..
                                            Random(1000, 9999) .. "]\n ~r~ATTAQUE ATM A LA BOMBE COLLANTE~s~"
                                    )

                                    local playerPosition = GetEntityCoords(PlayerPedId())
                                    local thermal_hash = GetHashKey("hei_prop_heist_thermite_flash")
                                    local bagHash4 = GetHashKey("p_ld_heist_bag_s_pro_o")
                                    local coords = GetEntityCoords(ped)

                                    loadModelRoberry(thermal_hash)
                                    Wait(10)
                                    loadModelRoberry(bagHash4)
                                    Wait(10)
                                    TaskGoStraightToCoord(
                                        ped,
                                        GetEntityCoords(nearestATM).x,
                                        GetEntityCoords(nearestATM).y,
                                        GetEntityCoords(nearestATM).z,
                                        1.0,
                                        100000,
                                        GetEntityHeading(nearestATM),
                                        2.0
                                    )
                                    ClearPedTasks(ped)
                                    SetEntityHeading(ped, GetEntityHeading(nearestATM))
                                    thermalentity =
                                        CreateObject(
                                        thermal_hash,
                                        (GetEntityCoords(nearestATM).z + GetEntityCoords(nearestATM).y +
                                            GetEntityCoords(nearestATM).z) -
                                            20,
                                        true,
                                        true
                                    )
                                    local bagProp4 = CreateObject(bagHash4, coords - 20, true, false)
                                    SetEntityAsMissionEntity(thermalentity, true, true)
                                    SetEntityAsMissionEntity(bagProp4, true, true)
                                    termitacolocando = true
                                    local boneIndexf1 = GetPedBoneIndex(PlayerPedId(), 28422)
                                    local bagIndex1 = GetPedBoneIndex(PlayerPedId(), 57005)
                                    Wait(500)
                                    SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
                                    AttachEntityToEntity(
                                        thermalentity,
                                        PlayerPedId(),
                                        boneIndexf1,
                                        0.0,
                                        0.0,
                                        0.0,
                                        180.0,
                                        180.0,
                                        0,
                                        1,
                                        1,
                                        0,
                                        1,
                                        1,
                                        1
                                    )
                                    AttachEntityToEntity(
                                        bagProp4,
                                        PlayerPedId(),
                                        bagIndex1,
                                        0.3,
                                        -0.25,
                                        -0.3,
                                        300.0,
                                        200.0,
                                        300.0,
                                        true,
                                        true,
                                        false,
                                        true,
                                        1,
                                        true
                                    )
                                    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
                                    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") do
                                        Wait(100)
                                    end
                                    playAnimationATM("anim@heists@ornate_bank@thermal_charge", "thermal_charge")
                                    Wait(2500)
                                    DetachEntity(bagProp4, 1, 1)
                                    FreezeEntityPosition(bagProp4, true)
                                    Wait(2500)
                                    FreezeEntityPosition(bagProp4, false)
                                    AttachEntityToEntity(
                                        bagProp4,
                                        PlayerPedId(),
                                        bagIndex1,
                                        0.3,
                                        -0.25,
                                        -0.3,
                                        300.0,
                                        200.0,
                                        300.0,
                                        true,
                                        true,
                                        false,
                                        true,
                                        1,
                                        true
                                    )
                                    Wait(1000)
                                    DeleteEntity(bagProp4)
                                    SetModelAsNoLongerNeeded(GetHashKey("p_ld_heist_bag_s_pro_o"))

                                    SetPedComponentVariation(PlayerPedId(), 5, 40, 0, 0)
                                    DeleteEntity(thermalentity)
                                    local thermalentityEntity =
                                        CreateObject(
                                        thermal_hash,
                                        (GetEntityCoords(nearestATM).z + 50 + GetEntityCoords(nearestATM).y +
                                            GetEntityCoords(nearestATM).z) -
                                            20,
                                        true,
                                        true
                                    )
                                    AttachEntityToEntity(
                                        thermalentityEntity,
                                        nearestATM,
                                        boneIndexf1,
                                        1.0,
                                        1.0,
                                        1.0,
                                        180.0,
                                        180.0,
                                        0,
                                        1,
                                        1,
                                        0,
                                        1,
                                        1,
                                        1
                                    )
                                    ClearPedTasks(PlayerPedId())

                                    RageUI.Popup({message = "~y~Vous venez de placer une charge explosive~s~"})
                                    LoadingPrompt("Mettez vous à l'abri avant l'explosion... (10 secondes)", 4)

                                    local propMoney = "hei_prop_heist_cash_pile"
                                    RequestModel(propMoney)
                                    while not HasModelLoaded(propMoney) do
                                        Citizen.Wait(10)
                                    end

                                    Wait(10000)
                                    AddExplosion(
                                        GetEntityCoords(nearestATM).x,
                                        GetEntityCoords(nearestATM).y,
                                        GetEntityCoords(nearestATM).z,
                                        2,
                                        100.0,
                                        true,
                                        false,
                                        true
                                    )
                                    RemoveLoadingPrompt()
                                    RageUI.Popup({message = "~g~Jolie casse ! Maintenant recupérer votre argent~s~"})

                                    SetModelAsNoLongerNeeded(propMoney)
                                    math.randomseed(GetGameTimer())
                                    loopCounter = math.random(9, 14)
                                    moneySpawnCounter = loopCounter

                                    local boneIndex = GetPedBoneIndex(PlayerPedId(), 57005)
                                    local moneyPile = {}
                                    local startTakeMoney = GetGameTimer()
                                    while loopCounter > 0 do
                                        Citizen.Wait(1)
                                        local ped = PlayerPedId()
                                        x, y, z = table.unpack(GetEntityCoords(ped))
                                        distance2 =
                                            GetDistanceBetweenCoords(
                                            GetEntityCoords(nearestATM).x,
                                            GetEntityCoords(nearestATM).y,
                                            GetEntityCoords(nearestATM).z,
                                            x,
                                            y,
                                            z,
                                            true
                                        )
                                        if moneySpawnCounter >= 0 then
                                            moneyObjectRoberry =
                                                CreateObjectNoOffset(
                                                propMoney,
                                                GetEntityCoords(nearestATM).x * 1.0,
                                                GetEntityCoords(nearestATM).y + Random(0.5, 2.5) * 1.0,
                                                GetEntityCoords(nearestATM).z + Random(1, 3) * 1.0,
                                                1,
                                                0,
                                                1
                                            )
                                            SetEntityVisible(moneyObjectRoberry, true)
                                            table.insert(moneyPile, moneyObjectRoberry)
                                            x2, y2, z2 = table.unpack(GetEntityCoords(moneyObjectRoberry))
                                            moneySpawnCounter = moneySpawnCounter - 1
                                        end
                                        if distance2 <= 3 then
                                            DrawText3DsRoberry(
                                                x2,
                                                y2,
                                                z2 - 0.8,
                                                "Appuyez sur ~b~[G] ~w~ pour ramasser l'argent !"
                                            )
                                            if
                                                IsControlJustPressed(0, 47) and not IsPedInAnyVehicle(ped) and
                                                    not IsEntityDead(ped)
                                             then
                                                if (#moneyPile > 0) then
                                                    objectToRemove = moneyPile[#moneyPile]
                                                    if ((GetGameTimer() - startTakeMoney) / 1000 > 600) then
                                                        DeleteEntity(objectToRemove)
                                                        local timeLeftExceed =
                                                            ((GetGameTimer() - startTakeMoney) / 1000) / 600
                                                        ShowNotification(
                                                            "~r~Vous avez mis plus de 10 minutes a récupérer votre argent"
                                                        )
                                                    else
                                                        playAnimationATM("pickup_object", "pickup_low")
                                                        Wait(1000)
                                                        AttachEntityToEntity(
                                                            objectToRemove,
                                                            PlayerPedId(),
                                                            boneIndex,
                                                            0.125,
                                                            0.0,
                                                            -0.05,
                                                            360.0,
                                                            150.0,
                                                            360.0,
                                                            true,
                                                            true,
                                                            false,
                                                            true,
                                                            1,
                                                            true
                                                        )
                                                        Wait(800)
                                                        SetEntityVisible(objectToRemove, false)
                                                        DeleteObject(objectToRemove)
                                                        math.randomseed(GetGameTimer())
                                                        t = math.random(30, 50)
                                                        DeleteEntity(objectToRemove)
                                                        ShowNotification("~g~+" .. t .. "$")
                                                        TriggerServerEvent("money:Add", t)
                                                    end
                                                end
                                                loopCounter = loopCounter - 1
                                            end
                                        end
                                    end

                                    currentlyRobbering = false

                                    Hint:RemoveAll()
                                    KeySettings:Clear("keyboard", "E", "ATMROBBERY")
                                    KeySettings:Clear("controller", 46, "ATMROBBERY")
                                else
                                    RageUI.Popup({message = "~r~L'ATM est vide.\nRepasse plus tard~s~"})
                                end
                            end,
                            "lssd"
                        )
                    end,
                    "police"
                )
            else
                RageUI.Popup({message = "~r~Désolé ! Vous avez déjà braqué aujourd'hui. Retentez demain~s~"})
            end
        end
    )
end

function drawTxtRoberry(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function DrawText3DsRoberry(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.001 + factor, 0.028, 0, 0, 0, 78)
end
