currentApuBraquable = nil

local inBraquage = false

-- HOLD UP STUFF (APU)
local SceneEntities = {}
local firstStageCompleted = false
local animData = {}
local lastReward = false
local robberyStartTime = false
local robberyTime = 1000 * 60 * 4
local alarmID

local function AbortRobbery(apuEntity)
    RemoveAnimDict("mp_am_hold_up")
    SetModelAsNoLongerNeeded("p_till_01_s")
    SetModelAsNoLongerNeeded("p_poly_bag_01_s")
    ReleaseScriptAudioBank("Alarms")

    for k, v in pairs(SceneEntities) do
        DeleteEntity(v)
    end
    SceneEntities = {}

    if alarmID then
        StopSound(alarmID)
        alarmID = false
    end

    ClearPedTasks(apuEntity)
    FreezeEntityPosition(apuEntity, false)

    local NPCPos = GetEntityCoords(apuEntity) - vector3(0.0, 0.0, 1.0)
    TaskGoStraightToCoord(apuEntity, NPCPos.x, NPCPos.y, NPCPos.z, 1.0, -1, GetEntityHeading(apuEntity) or 0.0, 0.1)

    while not IsEntityAtCoord(apuEntity, NPCPos.x, NPCPos.y, NPCPos.z, 0.5, 0.5, 0.5, 0, 1, 0) do
        Citizen.Wait(100)
    end

    FreezeEntityPosition(apuEntity, true)
    ClearPedTasks(apuEntity)

    firstStageCompleted = false
    lastReward = false
    startRobbery = false
    animData = {}
end
function TaskSynchronizedTasks(ped, animData, clearTasks)
    for _, v in pairs(animData) do
        if not HasAnimDictLoaded(v.anim[1]) then
            RequestAnimDict(v.anim[1])
            while not HasAnimDictLoaded(v.anim[1]) do
                Citizen.Wait(0)
            end
        end
    end

    local _, sequence = OpenSequenceTask(0)
    for _, v in pairs(animData) do
        TaskPlayAnim(0, v.anim[1], v.anim[2], 2.0, -2.0, math.floor(v.time or -1), v.flag or 48, 0, 0, 0, 0)
    end

    CloseSequenceTask(sequence)
    if clearTasks then
        ClearPedTasks(ped)
    end
    TaskPerformSequence(ped, sequence)
    ClearSequenceTask(sequence)

    for _, v in pairs(animData) do
        RemoveAnimDict(v.anim[1])
    end
end
local anyThread = false
local function DoGiveMoneyAnim(apuEntity)
    RequestAndWaitModel("bkr_prop_money_wrapped_01")

    local localEntity, netScene = NetworkGetEntityIsLocal(apuEntity)
    local b =
        CreateObjectNoOffset(
        GetHashKey("bkr_prop_money_wrapped_01"),
        GetEntityCoords(apuEntity),
        not localEntity,
        not localEntity,
        0
    )

    if localEntity then
        netScene = CreateSynchronizedScene(animData.pos, .0, .0, animData.a, 2, 1, 0, 1065353216, 0, 1065353216)
        TaskSynchronizedScene(
            apuEntity,
            netScene,
            "mp_am_hold_up",
            "purchase_chocbar_shopkeeper",
            1.5,
            -1.5,
            0,
            0,
            1148846080,
            0
        )
        PlaySynchronizedEntityAnim(
            apuEntity,
            netScene,
            "mp_am_hold_up",
            "purchase_chocbar_shopkeeper",
            8.0,
            -1.5,
            157,
            16,
            1148846080,
            0
        )
        PlaySynchronizedEntityAnim(b, netScene, "purchase_chocbar", "mp_am_hold_up", 1000.0, 8.0, 1, 1148846080)
    else
        netScene = NetworkCreateSynchronisedScene(animData.pos, .0, .0, animData.a, 2, 1, 0, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(
            apuEntity,
            netScene,
            "mp_am_hold_up",
            "purchase_chocbar_shopkeeper",
            8.0,
            -1.5,
            157,
            16,
            1148846080,
            0
        )
        NetworkAddEntityToSynchronisedScene(b, netScene, "mp_am_hold_up", "purchase_chocbar", 4.0, -4.0, 137)
        NetworkStartSynchronisedScene(netScene)
    end

    SetModelAsNoLongerNeeded(GetHashKey("bkr_prop_money_wrapped_01"))

    Citizen.Wait(0)
    PlayAmbientSpeechWithVoice(
        apuEntity,
        "APOLOGY_NO_TROUBLE",
        "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01",
        "SPEECH_PARAMS_FORCE",
        1
    )

    local scene = localEntity and netScene or NetworkConvertSynchronisedSceneToSynchronizedScene(netScene)
    while GetSynchronizedScenePhase(scene) <= 0.9 and not IsEntityDead(apuEntity) and anyThread do
        Citizen.Wait(0)
    end

    local pPos, rot = GetEntityCoords(b), GetEntityRotation(b, 2)
    DeleteEntity(b)

    if anyThread and not IsEntityDead(apuEntity) then
    end

    TaskSynchronizedTasks(
        apuEntity,
        {
            {anim = {"mp_am_hold_up", "handsup_enter"}, flag = 0},
            {anim = {"mp_am_hold_up", "handsup_base"}, flag = 1}
        }
    )
end

local function CreateRobberyThread(apuEntity)
    if anyThread then
        return
    end

    anyThread = true
    Citizen.CreateThread(
        function()
            while true do
                Citizen.Wait(0)
                local Player = LocalPlayer()
                local ped, plyPos, interiorID =
                    PlayerPedId(),
                    GetEntityCoords(PlayerPedId()),
                    GetInteriorAtCoords(GetEntityCoords(PlayerPedId()))

                if
                    interiorID == 0 or GetDistanceBetweenCoords(plyPos, GetEntityCoords(apuEntity)) > 7.5 or
                        robberyStartTime + robberyTime <= GetGameTimer()
                 then
                    local endTime = robberyStartTime + robberyTime < GetGameTimer()
                    drawCenterText(
                        endTime and "Vous avez complètement vidé le magasin fuyez!" or "Vous avez dégagé du magasin.",
                        3000
                    )
                    inBraquage = false
                    break
                end

                if firstStageCompleted and inBraquage ~= false then
                    -- do some stuff
                    if (not lastReward or lastReward + 10000 < GetGameTimer()) and IsPedArmed(ped, 7) then
                        TaskSynchronizedTasks(apuEntity, {{anim = {"mp_am_hold_up", "handsup_exit"}, flag = 0}})
                        math.randomseed(GetGameTimer())
                        local t = math.random(15, 60)
                        ShowNotification("~g~+" .. t .. "$")
                        TriggerServerEvent("money:Add", t)
                        TriggerPlayerEvent("XNL_NET:AddPlayerXP", GetPlayerServerId(PlayerId()), t)

                        lastReward = GetGameTimer()
                        Citizen.Wait(600)
                        DoGiveMoneyAnim(apuEntity)
                    end
                end
            end

            anyThread = false
            AbortRobbery(apuEntity)
        end
    )
end

function RequestAndWaitModel(modelName)
    if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
        RequestModel(modelName)
        while not HasModelLoaded(modelName) do
            Citizen.Wait(100)
        end
    end
end

function RequestAndWaitDict(dictName)
    if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
        RequestAnimDict(dictName)
        while not HasAnimDictLoaded(dictName) do
            Citizen.Wait(100)
        end
    end
end
function drawCenterText(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

-- TODO APU NE SE REMET PAS TOUT LE TEMPS BIEN
local function startRobberyFunc(apuEntity)
    RequestAndWaitDict("mp_am_hold_up")
    RequestAndWaitModel("p_till_01_s")
    RequestScriptAudioBank("Alarms")
    RequestAndWaitModel("p_poly_bag_01_s")
    TaskClearLookAt(apuEntity)
    math.randomseed(GetGameTimer())
    local chanceToDie = math.random(0, 100)
    local localEntity, netScene = NetworkGetEntityIsLocal(apuEntity)
    local apuPosition, closestOBJ = GetEntityCoords(apuEntity)

    local entityZoneName =
        GetNameOfZone(
        GetEntityCoords(PlayerPedId()).x,
        GetEntityCoords(PlayerPedId()).y,
        GetEntityCoords(PlayerPedId()).z
    )
    TriggerServerEvent(
        "aCore:sendToDiscord",
        "https://discord.com/api/webhooks/842991761671585812/oocOKps2gkrgbtMnOM6drIhl9jid5HcGpNocO0E07_bQ1sjHToFGteBsFc0ofhA-qk3R",
        "[" .. entityZoneName .. "] Lance un braquage de superette à : " .. GetZoneLabelTextFromZoneCode(entityZoneName)
    )

    alarmID = GetSoundId()
    PlaySoundFromCoord(alarmID, "Burglar_Bell", apuPosition, "Generic_Alarms", 0, 0, 0)

    robberyStartTime = GetGameTimer()

    closestOBJ =
        GetClosestObjectOfType(apuPosition.x, apuPosition.y, apuPosition.z, 2.0, GetHashKey("prop_till_01"), 0, 0, 0)

    if not closestOBJ or not DoesEntityExist(closestOBJ) or IsEntityDead(closestOBJ) then
        return AbortRobbery(apuEntity, shop)
    end

    for k, v in pairs({"prop_till_01", "prop_till_02"}) do
        CreateModelHide(apuPosition, 2.0, GetHashKey(v), 1)
    end

    local tillPos, tillHeading = GetEntityCoords(closestOBJ), GetEntityHeading(closestOBJ)
    tillPos = tillPos - vector3(0.0, 0.0, 0.125)

    animData = {pos = tillPos, a = tillHeading - 180.0}

    local till = CreateObject(GetHashKey("p_till_01_s"), tillPos, not localEntity, not localEntity, true)
    SetEntityHeading(till, tillHeading)
    FreezeEntityPosition(till, true)

    local pickup = CreateObject(GetHashKey("p_poly_bag_01_s"), tillPos, not localEntity, not localEntity, true)
    SetEntityRotation(pickup, 5.0, .0, tillHeading, 2, 1)
    SetEntityVisible(pickup, false, false)

    if localEntity then
        netScene = CreateSynchronizedScene(animData.pos, .0, .0, animData.a, 2)
        TaskSynchronizedScene(
            apuEntity,
            netScene,
            "mp_am_hold_up",
            "holdup_victim_20s",
            4.0,
            -1.5,
            157,
            16,
            1148846080,
            0
        )
        SetEntityCollision(pickup, true, 0)
        SetEntityDynamic(pickup, true)
        PlaySynchronizedEntityAnim(
            pickup,
            netScene,
            "holdup_victim_20s_bag",
            "mp_am_hold_up",
            1000.0,
            8.0,
            137,
            1148846080
        )
        PlaySynchronizedEntityAnim(
            till,
            netScene,
            "holdup_victim_20s_till",
            "mp_am_hold_up",
            1000.0,
            8.0,
            137,
            1148846080
        )
    else
        netScene =
            NetworkCreateSynchronisedScene(animData.pos, .0, .0, animData.a, 2, true, 0, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(
            apuEntity,
            netScene,
            "mp_am_hold_up",
            "holdup_victim_20s",
            4.0,
            -1.5,
            157,
            16,
            1148846080,
            0
        )
        SetEntityCollision(pickup, true, 0)
        SetEntityDynamic(pickup, true)
        NetworkAddEntityToSynchronisedScene(pickup, netScene, "mp_am_hold_up", "holdup_victim_20s_bag", 4.0, -4.0, 137)
        NetworkAddEntityToSynchronisedScene(till, netScene, "mp_am_hold_up", "holdup_victim_20s_till", 4.0, -4.0, 137)
        NetworkStartSynchronisedScene(netScene)
    end

    PlayAmbientSpeechWithVoice(
        apuEntity,
        "APOLOGY_NO_TROUBLE",
        "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01",
        "SPEECH_PARAMS_FORCE",
        1
    )

    CreateRobberyThread(apuEntity)

    local scene = not localEntity and NetworkConvertSynchronisedSceneToSynchronizedScene(netScene) or netScene

    while GetSynchronizedScenePhase(scene) <= 0.478 and not IsEntityDead(apuEntity) and anyThread do
        Citizen.Wait(0)
    end

    if IsEntityDead(apuEntity) then
        AbortRobbery(apuEntity)
        return
    end

    StopCurrentPlayingAmbientSpeech(apuEntity)
    PlayAmbientSpeechWithVoice(
        apuEntity,
        "SHOP_HURRYING",
        "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01",
        "SPEECH_PARAMS_FORCE",
        1
    )

    SetEntityVisible(pickup, true, 0)
    ActivatePhysics(pickup)

    while GetSynchronizedScenePhase(scene) <= .9 and not IsEntityDead(apuEntity) and anyThread do
        Citizen.Wait(0)
    end

    for k, v in pairs({"prop_till_01", "prop_till_02"}) do
        RemoveModelHide(apuPosition, 4.0, GetHashKey(v), true)
    end

    SetEntityAsNoLongerNeeded(till)
    DeleteEntity(till)

    if IsEntityDead(apuEntity) then
        AbortRobbery(apuEntity)
        return
    end

    if
        not IsEntityDead(apuEntity) and IsEntityAtEntity(PlayerPedId(), apuEntity, 8.0, 8.0, 4.0, 0, 1, 0) and anyThread and
            GetSynchronizedScenePhase(scene) > 0.9
     then
        local pPos, rot = GetEntityCoords(pickup), GetEntityRotation(pickup, 2)
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

        DeleteEntity(pickup)
        ShowNotification("~g~Vous pouvez récupérer le butin.", 2000)

        if not localEntity then
            NetworkStopSynchronisedScene(netScene)
        end
    end

    TaskSynchronizedTasks(
        apuEntity,
        {
            {anim = {"mp_am_hold_up", "handsup_enter"}, flag = 0},
            {anim = {"mp_am_hold_up", "handsup_base"}, flag = 1}
        }
    )

    ShowNotification("~r~Criez et continuez de menacer Apu~w~\npour récupérer plus de cash.")
    firstStageCompleted = true
    math.randomseed(GetGameTimer())
    t = math.random(150, 280)

    ShowNotification("~g~+" .. t .. "$")
    TriggerServerEvent("money:Add", t)
    TriggerPlayerEvent("XNL_NET:AddPlayerXP", GetPlayerServerId(PlayerId()), t)
    lastReward = GetGameTimer() - 5000

    if (chanceToDie >= 80) then
        Wait(10000)
        inBraquage = false
        ShowNotification("~r~Apu a trop la pression ! Il pete un cable.\n~w~ Fuyez !!!")
        SetPedShootRate(apuEntity, 50)
        GiveWeaponToPed(apuEntity, GetHashKey("weapon_snspistol"), 30, true, true)
        SetPedAsEnemy(apuEntity, true)
        TaskAimGunAtEntity(apuEntity, PlayerPedId(), -1, true)

        Citizen.CreateThread(
            function()
                drawCenterText("APU pete un cable !!! Il va te mettre une balle si tu continues", 5000)
                Citizen.Wait(5000)
                return
            end
        )

        Wait(5000)

        TaskCombatPed(apuEntity, PlayerPedId(), 0, 16)
        SetPedCombatAttributes(apuEntity, 46, true)
        SetPedFleeAttributes(apuEntity, 0, 0)
        SetPedAsEnemy(apuEntity, true)
        SetPedMaxHealth(apuEntity, 900)
        SetPedAlertness(apuEntity, 3)
        SetPedCombatRange(apuEntity, 0)
        SetPedCombatMovement(apuEntity, 3)

        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = x, y = y, z = z},
            "\n[VOISIN SUPERETTE]\n ~r~J'ai entendu des coups de feux dans la superette~s~"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = x, y = y, z = z},
            "\n[VOISIN SUPERETTE]\n ~r~J'ai entendu des coups de feux dans la superette~s~"
        )
    end

    --AbortRobbery(apuEntity)
end

function StartBraquo(zone)
    if not inBraquage and IsPedArmed(PlayerPedId(), 7) then
        inBraquage = true
        local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        if zone == "police" then
            TriggerServerEvent(
                "call:makeCall2",
                "police",
                {x = x, y = y, z = z},
                "\n[ALARME SILENCIEUSE " .. Random(1000, 9999) .. "]\n ~r~BRAQUAGE DE SUPERETTE~s~"
            )
            startRobberyFunc(currentApuBraquable)
        elseif zone == "lssd" then
            TriggerServerEvent(
                "call:makeCall2",
                "lssd",
                {x = x, y = y, z = z},
                "\n[ALARME SILENCIEUSE " .. Random(1000, 9999) .. "]\n ~r~BRAQUAGE DE SUPERETTE~s~"
            )
            startRobberyFunc(currentApuBraquable)
        elseif zone == "all" then
            TriggerServerEvent(
                "call:makeCall2",
                "police",
                {x = x, y = y, z = z},
                "\n[ALARME SILENCIEUSE " .. Random(1000, 9999) .. "]\n ~r~BRAQUAGE DE SUPERETTE~s~"
            )
            TriggerServerEvent(
                "call:makeCall2",
                "lssd",
                {x = x, y = y, z = z},
                "\n[ALARME SILENCIEUSE " .. Random(1000, 9999) .. "]\n ~r~BRAQUAGE DE SUPERETTE~s~"
            )
            startRobberyFunc(currentApuBraquable)
        end
    end
end
