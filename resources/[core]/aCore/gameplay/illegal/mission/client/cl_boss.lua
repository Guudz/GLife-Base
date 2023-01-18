local currentZone = nil
local function Build()
    for i = 1, #missionConfig.boss, 1 do
        local v = missionConfig.boss[i]
        Ped:Add(v.name, v.model, v.pos, nil)
        RMenu.Add("illegal", "boss_" .. i, RageUI.CreateMenu("Missions", "Actions disponibles", nil, nil, nil, nil, 240, 147, 43, 1.0))
        Zone:Add(
            v.pos,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                currentZone = i
                KeySettings:Add(
                    "keyboard",
                    "E",
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "boss_" .. i), true)
                    end,
                    "illegal_" .. i
                )
                KeySettings:Add(
                    "controller",
                    46,
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "boss_" .. i), true)
                    end,
                    "illegal_" .. i
                )
            end,
            function()
                CloseAllMenus()
                currentZone = nil
                KeySettings:Clear("keyboard", "E", "illegal_" .. i)
                KeySettings:Clear("controller", 46, "illegal_" .. i)
                Hint:RemoveAll()
            end,
            i,
            1.5
        )
    end
    RMenu.Add("illegal", "recel", RageUI.CreateMenu("Receleur", "Actions disponibles", nil, nil, nil, nil, 240, 147, 43, 1.0))
    for i = 1, #missionConfig.receleurPos, 1 do
        Ped:Add("Malcom", "s_m_y_dealer_01", missionConfig.receleurPos[i], nil)
        Zone:Add(
            missionConfig.receleurPos[i],
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                KeySettings:Add(
                    "keyboard",
                    "E",
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "recel"), true)
                    end,
                    "recel"
                )
                KeySettings:Add(
                    "controller",
                    46,
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "recel"), true)
                    end,
                    "recel"
                )
            end,
            function()
                CloseAllMenus()
                KeySettings:Clear("keyboard", "E", "recel")
                KeySettings:Clear("controller", 46, "recel")
                Hint:RemoveAll()
            end,
            i,
            1.5
        )
    end
    RMenu.Add("illegal", "gofast", RageUI.CreateMenu("Reception GoFast", "Actions disponibles", nil, nil, nil, nil, 240, 147, 43, 1.0))
    for i = 1, #missionConfig.receleurGoFastPos, 1 do
        Ped:Add(
            missionConfig.receleurGoFastPos[i].name,
            missionConfig.receleurGoFastPos[i].model,
            missionConfig.receleurGoFastPos[i].pos,
            nil
        )
        Zone:Add(
            missionConfig.receleurGoFastPos[i].pos,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                KeySettings:Add(
                    "keyboard",
                    "E",
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "gofast"), true)
                    end,
                    "gofast"
                )
                KeySettings:Add(
                    "controller",
                    46,
                    function()
                        RageUI.Visible(RMenu:Get("illegal", "gofast"), true)
                    end,
                    "gofast"
                )
            end,
            function()
                CloseAllMenus()
                KeySettings:Clear("keyboard", "E", "gofast")
                KeySettings:Clear("controller", 46, "gofast")
                Hint:RemoveAll()
            end,
            i,
            1.5
        )
    end
end

Citizen.CreateThread(
    function()
        Build()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("illegal", "recel")) then
                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()
                        RageUI.Button(
                            "Rendre un véhicule",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local veh = ClosestVeh()
                                    if veh ~= nil then
                                        TriggerServerCallback(
                                            "illegalDoesThisPlateExist",
                                            function(bool, m)
                                                if bool then
                                                    currentMission = m
                                                    TriggerServerEvent("MissionFinished", m)
                                                    DeleteEntity(veh)
                                                    inMission = false

                                                    ShowAdvancedNotification(
                                                        "Malcom",
                                                        "~b~Dialogue",
                                                        "Merci on va faire affaire plus souvent nous deux !",
                                                        "CHAR_LESTER_DEATHWISH_DEATHWISH",
                                                        1
                                                    )
                                                    local f = false
                                                    --print(GetPlayerServerId(PlayerId()))
                                                    for i = 1, #currentMission.participant, 1 do
                                                        if
                                                            currentMission.participant[i] ==
                                                                GetPlayerServerId(PlayerId())
                                                         then
                                                            f = true
                                                            break
                                                        end
                                                    end
                                                    for k, v in pairs(currentMission.rewards) do
                                                        if k == "xp" then
                                                            math.randomseed(GetGameTimer())
                                                            local xp = math.random(v[1], v[2])
                                                            if f then
                                                                for i = 1, #currentMission.participant, 1 do
                                                                    TriggerPlayerEvent(
                                                                        "XNL_NET:AddPlayerXP",
                                                                        currentMission.participant[i],
                                                                        math.floor(xp / #currentMission.participant)
                                                                    )
                                                                end
                                                            else
                                                                TriggerPlayerEvent(
                                                                    "XNL_NET:AddPlayerXP",
                                                                    GetPlayerServerId(PlayerId()),
                                                                    xp
                                                                )

                                                                for i = 1, #currentMission.participant, 1 do
                                                                    TriggerPlayerEvent(
                                                                        "XNL_NET:RemovePlayerXP",
                                                                        currentMission.participant[i],
                                                                        math.floor(xp / #currentMission.participant)
                                                                    )
                                                                end
                                                            end
                                                        end

                                                        if k == "money" then
                                                            math.randomseed(GetGameTimer())
                                                            local r = math.random(v.amount[1], v.amount[2])
                                                            TriggerServerEvent("money:Add", r)
                                                            ShowNotification("Tiens voilà " .. r .. "$")
                                                        end

                                                        if k == "items" then
                                                            for i = 1, #v, 1 do
                                                                AddItemtoInv(v[i])
                                                            end
                                                        end
                                                    end
                                                    TriggerServerEvent("missionEnd", currentMission)
                                                    currentMission = {}
                                                else
                                                    ShowAdvancedNotification(
                                                        "Malcom",
                                                        "~b~Dialogue",
                                                        "Je n'ai pas besoin de ce véhicule.",
                                                        "CHAR_LESTER_DEATHWISH",
                                                        1
                                                    )
                                                end
                                            end,
                                            GetVehicleNumberPlateText(veh)
                                        )
                                    end
                                end

                                if A then
                                    Mecano.ShowMarker()
                                end
                            end
                        )
                        -- -- RageUI.Button("Ramener les objets",nil,{},true,function(_,_,Selected)
                        -- --     if Selected then

                        --     end
                        -- end)
                        -- RageUI.Button("Ramener arme",nil,{},true,function(_,_,Selected)
                        --     if Selected then

                        --     end
                        -- end)
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("illegal", "gofast")) then
                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()
                        RageUI.Button(
                            "Rendre un véhicule",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local veh = ClosestVeh()
                                    if veh ~= nil then
                                        TriggerServerCallback(
                                            "illegalDoesThisPlateExist",
                                            function(bool, m)
                                                if bool then
                                                    currentMission = m
                                                    local playerCoords = GetEntityCoords(PlayerPedId())
                                                    local distanceBetweenPlayerAndGoal =
                                                        GetDistanceBetweenCoords(
                                                        currentMission.positionEnd.x,
                                                        currentMission.positionEnd.y,
                                                        currentMission.positionEnd.z,
                                                        playerCoords.x,
                                                        playerCoords.y,
                                                        playerCoords.z,
                                                        false
                                                    )

                                                    if (distanceBetweenPlayerAndGoal > 25) then
                                                        ShowAdvancedNotification(
                                                            currentMission.pedName,
                                                            "~b~Dialogue",
                                                            "Mec ! C'est pas là que je t'attends",
                                                            "CHAR_LESTER_DEATHWISH",
                                                            1
                                                        )
                                                        return
                                                    else
                                                        print(currentMission.blip)
                                                        if currentMission.blip ~= nil then
                                                            RemoveBlip(currentMission.blip)
                                                            currentMission.blip = nil
                                                        end

                                                        TriggerServerEvent("MissionFinished", m)
                                                        local trackedEntities = {
                                                            "prop_gun_case_02",
                                                            "ba_prop_battle_coke_block_01a",
                                                            "ba_prop_battle_meth_bigbag_01a",
                                                            "bkr_prop_weed_bigbag_03a"
                                                        }

                                                        for i = 1, #trackedEntities, 1 do
                                                            local object =
                                                                GetClosestObjectOfType(
                                                                playerCoords.x,
                                                                playerCoords.y,
                                                                playerCoords.z,
                                                                150.0,
                                                                GetHashKey(trackedEntities[i]),
                                                                false,
                                                                false,
                                                                false
                                                            )

                                                            if DoesEntityExist(object) then
                                                                DeleteEntity(object)
                                                            end
                                                        end
                                                        DeleteEntity(veh)
                                                        inMission = false
                                                        ShowAdvancedNotification(
                                                            currentMission.pedName,
                                                            "~b~Dialogue",
                                                            "Merci on va faire affaire plus souvent nous deux !",
                                                            "CHAR_LESTER_DEATHWISH",
                                                            1
                                                        )

                                                        local f = false
                                                        for i = 1, #currentMission.participant, 1 do
                                                            if
                                                                currentMission.participant[i] ==
                                                                    GetPlayerServerId(PlayerId())
                                                             then
                                                                f = true
                                                                break
                                                            end
                                                        end
                                                        for k, v in pairs(currentMission.rewards) do
                                                            if k == "xp" then
                                                                math.randomseed(GetGameTimer())
                                                                local xp = math.random(v[1], v[2])
                                                                if f then
                                                                    for i = 1, #currentMission.participant, 1 do
                                                                        TriggerPlayerEvent(
                                                                            "XNL_NET:AddPlayerXP",
                                                                            currentMission.participant[i],
                                                                            math.floor(xp / #currentMission.participant)
                                                                        )
                                                                    end
                                                                else
                                                                    TriggerPlayerEvent(
                                                                        "XNL_NET:AddPlayerXP",
                                                                        GetPlayerServerId(PlayerId()),
                                                                        xp
                                                                    )

                                                                    for i = 1, #currentMission.participant, 1 do
                                                                        TriggerPlayerEvent(
                                                                            "XNL_NET:RemovePlayerXP",
                                                                            currentMission.participant[i],
                                                                            math.floor(xp / #currentMission.participant)
                                                                        )
                                                                    end
                                                                end
                                                            end

                                                            if k == "money" then
                                                                math.randomseed(GetGameTimer())
                                                                local r = math.random(v.amount[1], v.amount[2])
                                                                TriggerServerEvent("money:Add", r)
                                                                ShowNotification("Tiens voilà " .. r .. "$")
                                                            end

                                                            if k == "items" then
                                                                for i = 1, #v, 1 do
                                                                    AddItemtoInv(v[i])
                                                                end
                                                            end
                                                        end
                                                        TriggerServerEvent("missionEnd", currentMission)
                                                        currentMission = {}
                                                    end
                                                else
                                                    ShowAdvancedNotification(
                                                        "Malcom",
                                                        "~b~Dialogue",
                                                        "Je n'ai pas besoin de ce véhicule.",
                                                        "CHAR_LESTER_DEATHWISH",
                                                        1
                                                    )
                                                end
                                            end,
                                            GetVehicleNumberPlateText(veh)
                                        )
                                    else
                                        ShowAdvancedNotification(
                                            "Malcom",
                                            "~b~Dialogue",
                                            "Tu te fous de ma gueule ? Y'a aucune voiture",
                                            "CHAR_LESTER_DEATHWISH",
                                            1
                                        )
                                    end
                                end
                            end
                        )
                        -- -- RageUI.Button("Ramener les objets",nil,{},true,function(_,_,Selected)
                        -- --     if Selected then

                        --     end
                        -- end)
                        -- RageUI.Button("Ramener arme",nil,{},true,function(_,_,Selected)
                        --     if Selected then

                        --     end
                        -- end)
                    end
                )
            end
            if currentZone ~= nil then
                if RageUI.Visible(RMenu:Get("illegal", "boss_" .. currentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            for i = 1, #missionConfig.boss[currentZone].missions, 1 do
                                RageUI.Button(
                                    missionConfig.boss[currentZone].missions[i],
                                    nil,
                                    {
                                        RightLabel = "Lvl. " ..
                                            missionConfig.missionLists[missionConfig.boss[currentZone].missions[i]].levelRequired
                                    },
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            StartIllegalMission(
                                                missionConfig.missionLists[missionConfig.boss[currentZone].missions[i]],
                                                missionConfig.boss[currentZone].missions[i]
                                            )
                                        end
                                    end
                                )
                            end
                        end
                    )
                end
            end
        end
    end
)
