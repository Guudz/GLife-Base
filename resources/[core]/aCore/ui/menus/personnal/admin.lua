RMenu.Add(
    "personnal",
    "admin",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "Administration", "Actions disponibles")
)

RMenu.Add(
    "personnal",
    "admin_plylist",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Joueurs connectés")
)
RMenu.Add(
    "personnal",
    "world",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "vehicle",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "report",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin"), "Administration", "Actions disponibles")
)

local joueurs = false
local pblips = false
imWaiting = false
local filterString = nil
local connectedPlayers = {}
local treport = {}
local webhookadmin = "https://discord.com/api/webhooks/842992416025477150/t6Xghk3n_W9qez_lQsvxlLfgANRWysLsYv8NcTUMihDEaWiqSaf1ZFj1n-0jobgl3PQd"

RMenu.Add(
    "personnal",
    "admin_plyaction",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plylist"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_items",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plyaction"), "Administration", "Actions disponibles")
)

RMenu.Add(
    "personnal",
    "admin_banlist",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plyaction"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_warnlist",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "admin_plyaction"), "Administration", "Actions disponibles")
)
RMenu.Add(
    "personnal",
    "admin_reportaction",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "report"), "Administration", "Actions disponibles")
)

RegisterNetEvent("addReportMenu")
AddEventHandler("addReportMenu", function(player, name, message, date)
    if PlyGroup == "superadmin" then
        RageUI.Popup({message = "~r~Un nouveau report vient d'arriver !"})
        table.insert(treport, {etat = "❌", id = player, name = name, msg = message, date = date, who = "Personne"})
    end
end)

RegisterNetEvent("closeReport")
AddEventHandler("closeReport", function(index)
    if PlyGroup == "superadmin" then
        table.remove(treport, index)
    end
end)

RegisterNetEvent("takeReport")
AddEventHandler("takeReport", function(index, id, name, msg, date, who, take)
    if PlyGroup == "superadmin" then
        if take == "true" then ett = "✅" else ett = "❌" who = "Personne" end
        treport[index] = {etat = ett, id = id, name = name, msg = msg, date = date, who = who}
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry("FMMC_KEY_TIP1", TextEntry .. "")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function Text(text)
    SetTextColour(186, 186, 186, 255)
    SetTextFont(0)
    SetTextScale(0.378, 0.378)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 205)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.017, 0.977)
end

local object = UIInstructionalButton.__constructor()
local noclip_speed = 3.0

local function veh(vehicle)
    TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
	SetEntityAsMissionEntity(vehicle, false, true)
	DeleteVehicle(vehicle)
end
local Freeze = false
RegisterNetEvent("admin:Freeze")
AddEventHandler(
    "admin:Freeze",
    function()
        FreezeEntityPosition(LocalPlayer().Ped, not Freeze)
        Freeze = not Freeze
    end
)
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            object:onTick()
            if Freeze then
                drawTxt(0.5, 0.5, .9, "Vous êtes freeze", 4, 1, nil, 180, 255, 0, 0)
            end
        end
    end
)
RegisterNetEvent("admin:tp")
AddEventHandler(
    "admin:tp",
    function(coords)
        print(coords)
        SetEntityCoords(LocalPlayer().Ped, coords)
    end
)
RegisterNetEvent("admin:tp2")
AddEventHandler(
    "admin:tp2",
    function(eddq)
        TriggerPlayerEvent("admin:tp", eddq, GetEntityCoords(PlayerPedId()))
    end
)

RegisterNetEvent("GetPlayersCoords")
AddEventHandler(
    "GetPlayersCoords",
    function(src)
        TriggerPlayerEvent("myCoordsAre", src, GetEntityCoords(PlayerPedId()))
    end
)

local InSpectatorMode = false
local TargetSpectate = nil
local LastPosition = nil
local polarAngleDeg = 0
local azimuthAngleDeg = 90
local radius = -3.5
local cam = nil
local PlayerDate = {}
local ShowInfos = false
local group


local lastModel = nil
function resetNormalCamera()
    InSpectatorMode = false
    TargetSpectate = nil
    local playerPed = PlayerPedId()

    SetCamActive(cam, false)
    RenderScriptCams(false, false, 0, true, true)

    SetEntityCollision(PlayerPedId(), true, true)
    SetEntityVisible(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), LastPosition.x, LastPosition.y, LastPosition.z)
end
function polar3DToWorld3D(entityPosition, radius, polarAngleDeg, azimuthAngleDeg)
    -- convert degrees to radians
    local polarAngleRad = polarAngleDeg * math.pi / 180.0
    local azimuthAngleRad = azimuthAngleDeg * math.pi / 180.0

    local pos = {
        x = entityPosition.x + radius * (math.sin(azimuthAngleRad) * math.cos(polarAngleRad)),
        y = entityPosition.y - radius * (math.sin(azimuthAngleRad) * math.sin(polarAngleRad)),
        z = entityPosition.z - radius * math.cos(azimuthAngleRad)
    }

    return pos
end
function spectate(target)
    if not InSpectatorMode then
        LastPosition = GetEntityCoords(PlayerPedId())
    end

    local playerPed = PlayerPedId()

    SetEntityCollision(playerPed, false, false)
    SetEntityVisible(playerPed, false)

    Citizen.CreateThread(
        function()
            if not DoesCamExist(cam) then
                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
            end

            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, true)

            InSpectatorMode = true
            TargetSpectate = target
        end
    )
end
Citizen.CreateThread(
    function()
        local CurrentPlayer = {}
        local ReportPly = {}
        local invisible, sprint, jump, spectatemod, showcoords = false, false, false, false, false
        local labels = {"1H", "2H", "8H", "12H", "1 jour", "3 jours", "7 jours", "14 jours", "Permanent", "Ne pas toucher"}
        local hours = {3600, 7200, 28800, 86400, 259200, 604800, 1210000, 88888888, 88888888}
        local index = 1
        local jobListLabel = {}
        local jobList = {}
        local indexJob = 1
        local indexOrga = 1
        local indexTP = 1
        local bList = {}
        local wList = {}
        for k, v in pairs(Jobs) do
            table.insert(jobListLabel, v.label)
            table.insert(jobList, k)
        end
        while true do
            Wait(1)
            if PlyGroup == "superadmin" then
                if joueurs then
                    for id = 0, 500 do
                        if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1) then
                            ped = GetPlayerPed(id)
                            blip = GetBlipFromEntity(ped)
                            headId =
                                Citizen.InvokeNative(
                                0xBFEFE3321A3F5015,
                                ped,
                                ("[" ..
                                    GetPlayerServerId(id) ..
                                        "] - " .. GetPlayerName(id) .. " - HP :" .. GetEntityHealth(ped)),
                                false,
                                false,
                                "",
                                false
                            )
                        end
                    end
                elseif not joueurs then
                    for id = 0, 500 do
                        if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1) then
                            ped = GetPlayerPed(id)
                            blip = GetBlipFromEntity(ped)
                            headId = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, "", false, false, "", false)
                        end
                    end
                end

                if spectatemod then
                    DisablePlayerFiring(PlayerPedId(), true)
                    if not speconmod then
                        if IsControlJustReleased(0,18) then
                            local targetid = GetPlayerServerIdInDirection(5)
                            targetped = GetPlayerPed(GetPlayerFromServerId(targetid))

                            if targetid ~= nil and targetped ~= PlayerPedId() and targetped ~= nil and IsPedAPlayer(targetped) then
                                object:Delete('Vitesse noclip', 178)
                                object:Delete('Ralentir', 36)
                                object:Delete('Accélérer', 21)
                                object:Delete('Spectate le joueur', 18)
                                object:Add('Arrêter spectate', 252)
                                NetworkSetInSpectatorMode(true, targetped)
                                AttachEntityToEntity(PlayerPedId(), targetped, 31086, 0.0, 0, 1.7, 0, 0, 0, true, true, false, true, 1, false)
                                speconmod = true
                            end
                        elseif IsControlJustReleased(0, 36) then
                            if tonumber(noclip_speed) <= 0 then
                                ShowNotification("~r~Tu ne peut pas ralentir plus que ça")
                            else
                                noclip_speed = noclip_speed - 0.2
                            end
                        elseif IsControlJustReleased(0, 21) then
                            noclip_speed = noclip_speed + 0.2
                        elseif IsControlJustReleased(0, 178) then
                            local speed = KeyboardInput("Vitesse", noclip_speed, 100)
                            if tonumber(speed) ~= nil then
                                noclip_speed = speed
                            end
                        end
                    else
                        if IsControlJustReleased(0, 252) then
                            if IsEntityAttached(PlayerPedId()) then
                                local x,y,z = getPosition()
                                NetworkSetInSpectatorMode(false, targetped)
                                SetEntityNoCollisionEntity(PlayerPedId(), targetped, true)
                                DetachEntity(LocalPlayer().Ped, false, false)
                                SetEntityCoords(PlayerPedId(), x + 0.5, y + 0.5, z + 0.5)
                                object:Delete('Arrêter spectate', 252)
                                object:Add('Vitesse noclip', 178)
                                object:Add('Ralentir', 36)
                                object:Add('Accélérer', 21)
                                object:Add('Spectate le joueur', 18)
                                speconmod = false
                            end
                        end
                    end
                end

                if showcoords then
                    local ped = PlayerPedId()
                    local plyCoords = GetEntityCoords(ped, false)
                    Text(
                        "~r~X~s~: " ..
                            plyCoords.x ..
                                " ~b~Y~s~: " ..
                                    plyCoords.y ..
                                        " ~g~Z~s~: " .. plyCoords.z .. " ~y~Angle~s~: " .. GetEntityHeading(ped)
                    )
                end

                if invisible then
                    SetEntityVisible(PlayerPedId(), false, false)
                end

                if jump then
                    SetSuperJumpThisFrame(PlayerId())
                end
                if RageUI.Visible(RMenu:Get("personnal", "admin")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Liste des joueurs",
                                nil,
                                {
                                    RightLabel = "→→"
                                },
                                true,
                                function(_, _, S)
                                    if S then
                                        TriggerServerCallback(
                                            "onlinePlayers:list",
                                            function(users)
                                                connectedPlayers = users
                                            end
                                        )
                                    end
                                end,
                                RMenu:Get("personnal", "admin_plylist")
                            )
                            RageUI.Button(
                                "Modération",
                                nil,
                                {
                                    RightLabel = "→→"
                                },
                                true,
                                function(_, _, _)
                                end,
                                RMenu:Get("personnal", "world")
                            )
                            if PlyGroup == "superadmin" then
                                RageUI.Button(
                                    "Véhicule",
                                    nil,
                                    {
                                        RightLabel = "→→"
                                    },
                                    true,
                                    function(_, _, _)
                                    end,
                                    RMenu:Get("personnal", "vehicle")
                                )
                            end

                            RageUI.Button("Liste des reports",nil,{RightLabel = "→→"},true,function(_, _, _)end,RMenu:Get("personnal", "report"))

                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_items")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "🔍 Rechercher",
                                nil,
                                {RightLabel = filterString},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        filterString = KeyboardInput("Filtre", nil, 25)
                                    end
                                end
                            )
                            for k, v in pairs(Items) do
                                if
                                    filterString == nil or string.find(v.label, filterString) or
                                        string.find(k, filterString)
                                 then
                                    RageUI.Button(
                                        v.label,
                                        nil,
                                    {RightLabel = "→→"},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                local ItemName = k
                                                local ItemNb = tonumber(KeyboardInput("Nombre d'item", "", 100))
                                                if ItemNb == nil then
                                                    return
                                                end
                                                for i = 1, ItemNb, 1 do
                                                    item = {name = ItemName}
                                                    TriggerPlayerEvent(
                                                        "inventory:AddItem2",
                                                        CurrentPlayer.serverId,
                                                        item
                                                    )
                                                end
                                            end
                                        end
                                    )
                                end
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_banlist")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            for i = 1, #bList, 1 do
                                local v = bList[i]
                                RageUI.Button(
                                    v.reason .. " (" .. v.moderator .. ")",
                                    nil,
                                    {RightLabel = v.date .. " -> " .. v.unbandate},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("personnal", "admin_warnlist")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            for i = 1, #wList, 1 do
                                local v = wList[i]
                                if v.reason == nil then
                                    v.reason = "Inconnue"
                                end
                                RageUI.Button(
                                    v.reason .. " (" .. v.moderator .. ")",
                                    nil,
                                    {RightLabel = v.date},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_reportaction")) then
                    RageUI.DrawContent({header = true, glare = true},function()
                        RageUI.Checkbox("Prendre le ticket",nil,taketicket,{},function(Hovered, Ative, Selected, Checked)
                            if Selected then
                                if not taketicket then
                                    TriggerServerEvent('takeReportS', ReportPly.index, ReportPly.id, ReportPly.name, ReportPly.msg, ReportPly.date, "true")
                                else
                                    TriggerServerEvent('takeReportS', ReportPly.index, ReportPly.id, ReportPly.name, ReportPly.msg, ReportPly.date, "false")
                                end
                                taketicket = not taketicket
                            end
                        end)
                        RageUI.Button("Envoyer un message",nil,{},true,function(_, _, Selected)
                            if Selected then
                                local message = KeyboardInput("Message", "", 100)
                                TriggerServerEvent('sendMessageReport', ReportPly.id, message)
                            end
                        end)
                        RageUI.Button("Revive le joueur",nil,{},true,function(_, _, Selected)
                            if Selected then
                                TriggerPlayerEvent("player:Revive", ReportPly.id)
                                TriggerServerEvent("aCore:sendToDiscord", webhookadmin, GetPlayerName(PlayerId()).." a revive "..ReportPly.name.." pour le ticket n°"..ReportPly.index)
                            end
                        end)
                        RageUI.Button("Heal le joueur",nil,{},true,function(_, _, Selected)
                            if Selected then
                                TriggerPlayerEvent("player:Heal", ReportPly.id)
                                TriggerServerEvent("aCore:sendToDiscord", webhookadmin, GetPlayerName(PlayerId()).." a heal "..ReportPly.name.." pour le ticket n°"..ReportPly.index)
                            end
                        end)
                        if PlyGroup == "superadmin" then
                            RageUI.Button("Give argent",nil,{},true,function(_, _, Selected)
                                if Selected then
                                    local Reason = KeyboardInput("Montant", "", 100)
                                    Reason = tonumber(Reason)
                                    if Reason ~= nil then
                                        ShowNotification("~r~Argent give (" .. ReportPly.name .. ")")
                                        TriggerServerEvent("money:Add2", Reason, ReportPly.id)
                                        TriggerServerEvent("aCore:sendToDiscord", webhookadmin, GetPlayerName(PlayerId()).." a give "..Reason.. "$ à "..ReportPly.name.." pour le ticket n°"..ReportPly.index)
                                    end
                                end
                            end)
                        end
                        RageUI.List("Téléportation",{"Sur le joueur", "Sur vous"},indexTP,nil,{},true,function(_, _, Selected, Index)
                            indexTP = Index
                            if Selected then
                                if Index == 1 then
                                    ShowNotification("~w~Vous vous êtes bien TP sur ~r~(" .. ReportPly.name .. ")")
                                    TriggerPlayerEvent("admin:tp2", ReportPly.id, GetPlayerServerId(PlayerId()))
                                else
                                    ShowNotification("~w~Le joueur ~r~(" .. ReportPly.name .. ") ~w~a bien était TP sur vous.")
                                    
                                    TriggerPlayerEvent("admin:tp", ReportPly.id, LocalPlayer().Pos)
                                end
                            end
                        end)
                        RageUI.Button("Clôturer le report",nil,{},true,function(_, _, Selected)
                            if Selected then
                                local message = KeyboardInput("Etes vous sûr? (oui/non)", "", 3)
                                if message == "oui" then
                                    TriggerServerEvent("closeReportS", ReportPly.index)
                                    taketicket = not taketicket
                                    RageUI.GoBack()
                                    RageUI.Refresh()
                                end
                            end
                        end)
                    end,
                    function()
                    end)
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_plyaction")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Fouiller",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        CloseAllMenus()
                                        Fouiller2(CurrentPlayer.serverId)
                                    end
                                end
                            )
                            RageUI.Button(
                                "Historique bannissement",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerCallback(
                                            "GetHistoBan",
                                            function(ban)
                                                bList = ban
                                            end,
                                            CurrentPlayer.serverId
                                        )
                                    end
                                end,
                                RMenu:Get("personnal", "admin_banlist")
                            )

                            RageUI.Button(
                                "Historique avertissements",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerCallback(
                                            "GetHistoWarn",
                                            function(warns)
                                                wList = warns
                                            end,
                                            CurrentPlayer.serverId
                                        )
                                    end
                                end,
                                RMenu:Get("personnal", "admin_warnlist")
                            )
                            RageUI.Button(
                                "Revive",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerPlayerEvent("player:Revive", CurrentPlayer.serverId)
                                    end
                                end
                            )
                            RageUI.Button(
                                "Heal",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    TriggerPlayerEvent("player:Heal", CurrentPlayer.serverId)
                                end
                            end)
                            if PlyGroup == "superadmin" then
                                RageUI.Button(
                                    "Give argent",
                                    nil,
                                {RightLabel = "→→"},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            local Reason = KeyboardInput("Montant", "", 100)
                                            Reason = tonumber(Reason)
                                            if Reason ~= nil then
                                                ShowNotification("~w~Vous avez bien give des sous a ~r~" .. CurrentPlayer.name .. "")
                                                TriggerServerEvent("money:Add2", Reason, CurrentPlayer.serverId)
                                            end
                                        end
                                    end
                                )
                            end
                            RageUI.Button(
                                "Exclure du serveur",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local Reason = KeyboardInput("Raison", "", 100)
                                        ShowNotification("~w~Le joueur ~r~" .. CurrentPlayer.name .. " ~w~a bien était kick.")
                                        TriggerServerEvent("kickPlayer", CurrentPlayer.serverId, Reason)
                                    end
                                end
                            )
                            RageUI.Button(
                                "Avertir le joueur",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local Reason = KeyboardInput("Raison", "", 100)
                                        ShowNotification("~w~Vous avez bien warn ~r~" .. CurrentPlayer.name .. "")
                                        TriggerServerEvent("warnPlayer", CurrentPlayer.serverId, Reason)
                                    end
                                end
                            )
                            RageUI.List(
                                "Bannir du serveur",
                                labels,
                                index,
                                nil,
                            {},
                                true,
                                function(_, _, Selected, Index)
                                    index = Index
                                    if Selected then
                                        local Reason = KeyboardInput("Raison", "", 100)
                                        TriggerServerEvent("banPlayer", CurrentPlayer.serverId, Reason, hours[index])
                                    end
                                end
                            )

                            RageUI.Button(
                                "Freeze",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ShowNotification("~w~Vous avez freeze :~r~ " .. CurrentPlayer.name .. "")
                                        TriggerPlayerEvent("admin:Freeze", CurrentPlayer.serverId)
                                    end
                                end
                            )

                            RageUI.List(
                                "Téléportation",
                                {"Sur le joueur", "Sur vous"},
                                indexTP,
                                nil,
                            {},
                                true,
                                function(_, _, Selected, Index)
                                    indexTP = Index
                                    if Selected then
                                        if Index == 1 then
                                            ShowNotification("~w~Vous vous êtes bien TP sur ~r~" .. CurrentPlayer.name .. "")
                                            -- ply = GetPlayerFromServerId(CurrentPlayer.serverId)
                                            -- ped = GetPlayerPed(ply)
                                            -- SetEntityCoords(LocalPlayer().Ped,LocalPlayer().Pos)

                                            TriggerPlayerEvent(
                                                "admin:tp2",
                                                CurrentPlayer.serverId,
                                                GetPlayerServerId(PlayerId())
                                            )
                                        else
                                            ShowNotification("~w~Le joueur ~r~" .. CurrentPlayer.name .. " ~w~a bien était TP sur vous.")
                                            TriggerPlayerEvent("admin:tp", CurrentPlayer.serverId, LocalPlayer().Pos)
                                        end
                                    end
                                end
                            )
                            if PlyGroup == "superadmin" then
                            RageUI.Button(
                                "Donner Item",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end,
                                RMenu:Get("personnal", "admin_items")
                            )
                        end
                            RageUI.List(
                                "Changer le métier",
                                jobListLabel,
                                indexJob,
                                nil,
                            {},
                                true,
                                function(_, _, Selected, Index)
                                    indexJob = Index
                                    if Selected then
                                        local NomJob = jobList[indexJob]
                                        local Grade =
                                            KeyboardInput("Grade (MAX : " .. #Jobs[NomJob].grade .. ")", "", 2)
                                        TriggerServerEvent("job:UpdateJob2", NomJob, Grade, CurrentPlayer.serverId)
                                        TriggerPlayerEvent("Jobs:SetJob2", CurrentPlayer.serverId, NomJob, Grade)
                                    end
                                end
                            )

                            RageUI.List(
                                "Changer le second métier",
                                jobListLabel,
                                indexOrga,
                                nil,
                            {},
                                true,
                                function(_, _, Selected, Index)
                                    indexOrga = Index
                                    if Selected then
                                        local NomJob = jobList[indexOrga]
                                        local Grade =
                                        KeyboardInput("Grade (MAX : " .. #Jobs[NomJob].grade .. ")", "", 2)
                                        TriggerServerEvent("orga:UpdateJob2", NomJob, Grade, CurrentPlayer.serverId)
                                        TriggerPlayerEvent("Orga:SetJob2", CurrentPlayer.serverId, NomJob, Grade)
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "world")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Téléporter sur son marqueur",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local playerPed = LocalPlayer().Ped
                                        local WaypointHandle = GetFirstBlipInfoId(8)
                                        if DoesBlipExist(WaypointHandle) then
                                            local coord =
                                                Citizen.InvokeNative(
                                                0xFA7C7F0AADF25D09,
                                                WaypointHandle,
                                                Citizen.ResultAsVector()
                                            )
                                            --SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, coord.z, false, false, false, true)
                                            SetEntityCoordsNoOffset(
                                                playerPed,
                                                coord.x,
                                                coord.y,
                                                -199.9,
                                                false,
                                                false,
                                                false,
                                                true
                                            )
                                        end
                                    end
                                end
                            )
                            RageUI.Button(
                                "TP sur marqueur avec votre véhicule",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local playerPed = LocalPlayer().Ped
                                        local WaypointHandle = GetFirstBlipInfoId(8)
                                        if DoesBlipExist(WaypointHandle) then
                                            Citizen.CreateThread(
                                                function()
                                                    local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
                                                    local foundGround, zCoords, zPos = false, -500.0, 0.0

                                                    while not foundGround do
                                                        zCoords = zCoords + 10.0
                                                        RequestCollisionAtCoord(
                                                            waypointCoords.x,
                                                            waypointCoords.y,
                                                            zCoords
                                                        )
                                                        Citizen.Wait(0)
                                                        foundGround, zPos =
                                                            GetGroundZFor_3dCoord(
                                                            waypointCoords.x,
                                                            waypointCoords.y,
                                                            zCoords
                                                        )

                                                        if not foundGround and zCoords >= 2000.0 then
                                                            foundGround = true
                                                        end
                                                    end

                                                    SetPedCoordsKeepVehicle(
                                                        playerPed,
                                                        waypointCoords.x,
                                                        waypointCoords.y,
                                                        zPos
                                                    )
                                                end
                                            )
                                        end
                                    end
                                end
                            )
                            RageUI.Checkbox(
                                "Nom des joueurs",
                                nil,
                                joueurs,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        joueurs = Checked
                                        if not joueurs then
                                            for id = 0, 500 do
                                                if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1) then
                                                    ped = GetPlayerPed(id)
                                                    blip = GetBlipFromEntity(ped)
                                                    headId =
                                                        Citizen.InvokeNative(
                                                        0xBFEFE3321A3F5015,
                                                        ped,
                                                        (" "),
                                                        false,
                                                        false,
                                                        "",
                                                        false
                                                    )
                                                end
                                            end
                                        end
                                        ShowNotification("~w~Appuyez sur ~r~ECHAP ~w~pour actualiser")
                                    end
                                end
                            )
                            RageUI.Checkbox(
                                "Blip des joueurs",
                                nil,
                                pblips,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        pblips = Checked
                                    end
                                end
                            )
                            RageUI.Checkbox(
                                "Coordonnées",
                                nil,
                                showcoords,
                            {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        showcoords = Checked
                                    end
                                end
                            )
                            RageUI.Checkbox(
                                "Invisible",
                                nil,
                                invisible,
                            {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        invisible = Checked
                                        if not invisible then
                                            SetEntityVisible(PlayerPedId(), true, false)
                                        end
                                    end
                                end
                            )
                            RageUI.Checkbox(
                                "Noclip",
                                nil,
                                isNoclip(),
                            {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        admin_no_clip()
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "vehicle")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            RageUI.Button(
                                "Spawn Véhicule",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local ped = GetPlayerPed(tgt)
                                        local ModelName = KeyboardInput("Véhicule", "", 100)
                                        if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                                            RequestModel(ModelName)
                                            while not HasModelLoaded(ModelName) do
                                                Citizen.Wait(0)
                                            end
                                            local veh =
                                                CreateVehicle(
                                                GetHashKey(ModelName),
                                                LocalPlayer().Pos,
                                                GetEntityHeading(LocalPlayer().Ped),
                                                true,
                                                true
                                            )
                                            TaskWarpPedIntoVehicle(LocalPlayer().Ped, veh, -1)
                                            Wait(50)
                                        else
                                            ShowNotification("~r~Erreur ! ~w~Model invalide.")
                                        end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Réparer véhicule",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local veh = GetVehiclePedIsUsing(LocalPlayer().Ped)
                                        SetVehicleFixed(veh)
                                        SetVehicleDirtLevel(veh, 0.0)
                                    end
                                end
                            )
                            RageUI.Button(
                                "Supprimer véhicule",
                                nil,
                            {RightLabel = "→→"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ExecuteCommand("dv")
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("personnal", "report")) then
                    RageUI.DrawContent({header = true, glare = true},function()
                        for k, v in pairs(treport) do
                            RageUI.Button(v.etat.." "..v.id.." - "..v.name, "~b~Pris en charge par ~w~: ~s~"..v.who.."~n~~b~Date ~w~: ~s~"..v.date.."~n~~b~Motif ~w~: ~s~"..v.msg,{RightLabel = "→"},true,function(_, _, Selected)
                                if Selected then
                                    ReportPly = {index = k, id = v.id, name = v.name, date = v.date, msg = v.msg, who = v.who}
                                end
                            end, RMenu:Get("personnal", "admin_reportaction"))
                        end
                    end,
                    function()
                    end)
                end

                if RageUI.Visible(RMenu:Get("personnal", "admin_plylist")) then
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            local players = {}

                            for _, player in ipairs(connectedPlayers) do
                                table.insert(players, player)
                            end

                            for _, v in pairs(players) do
                                RageUI.Button(
                                    v.id .. " - " .. v.name,
                                    nil,
                                    {
                                        RightLabel = "→"
                                    },
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            CurrentPlayer = {
                                                player = v.id,
                                                serverId = v.id,
                                                name = v.name
                                            }
                                        end
                                    end,
                                    RMenu:Get("personnal", "admin_plyaction")
                                )
                            end
                        end,
                        function()
                        end
                    )
                end
            end
        end
    end
)

TriggerServerCallback(
    "onlinePlayers:list",
    function(users)
        connectedPlayers = users
    end
)

Citizen.CreateThread(
    function()
        while (true) do
            if RageUI.Visible(RMenu:Get("personnal", "admin_plylist")) then
                Citizen.Wait(5000)
                TriggerServerCallback(
                    "onlinePlayers:list",
                    function(users)
                        connectedPlayers = users
                    end
                )
            else
                Citizen.Wait(10000)
            end
        end
    end
)

if playerGroup ~= nil and (playerGroup == "admin" or playerGroup == "superadmin") then
    AddMenuadminMenu(mainMenu)
end

-- FONCTION NOCLIP
local noclip = false

function admin_no_clip()
    noclip = not noclip
    local ped = PlayerPedId()
    if noclip then -- activé
        SetEntityInvincible(ped, true)
        SetEntityVisible(ped, false, false)
        ShowNotification("Noclip ~g~activé")
    else -- désactivé
        SetEntityInvincible(ped, false)
        SetEntityVisible(ped, true, false)
        ShowNotification("Noclip ~r~désactivé")
    end
end

function getPosition()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    return x, y, z
end

function getCamDirection()
    local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()

    local x = -math.sin(heading * math.pi / 180.0)
    local y = math.cos(heading * math.pi / 180.0)
    local z = math.sin(pitch * math.pi / 180.0)

    local len = math.sqrt(x * x + y * y + z * z)
    if len ~= 0 then
        x = x / len
        y = y / len
        z = z / len
    end

    return x, y, z
end

function isNoclip()
    return noclip
end

-- noclip/invisible
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if noclip then
                local ped = PlayerPedId()
                local x, y, z = getPosition()
                local dx, dy, dz = getCamDirection()
                local speed = noclip_speed

                -- reset du velocity
                SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

                -- aller vers le haut
                if IsControlPressed(0, 32) then -- MOVE UP
                    x = x + speed * dx
                    y = y + speed * dy
                    z = z + speed * dz
                end

                -- aller vers le bas
                if IsControlPressed(0, 269) then -- MOVE DOWN
                    x = x - speed * dx
                    y = y - speed * dy
                    z = z - speed * dz
                end

                SetEntityCoordsNoOffset(ped, x, y, z, true, true, true)
            end
        end
    end
)
-- FIN NOCLIP

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(500)
            if pblips then
                for _, id in ipairs(GetActivePlayers()) do
                    if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
                        ped = GetPlayerPed(id)
                        blip = GetBlipFromEntity(ped)
                        vehicule = IsPedInAnyVehicle(ped, true)

                        if not DoesBlipExist(blip) then
                            blip = AddBlipForEntity(ped)
                            SetBlipSprite(blip, 1)
                            ShowHeadingIndicatorOnBlip(blip, true)
                        else
                            veh = GetVehiclePedIsIn(ped, false)
                            blipSprite = GetBlipSprite(blip)
                            if GetEntityHealth(ped) < 1 then
                                if blipSprite ~= 274 then
                                    SetBlipSprite(blip, 274)
                                    ShowHeadingIndicatorOnBlip(blip, false)
                                end
                            elseif veh then
                                --passengers = GetVehicleNumberOfPassengers(veh)
                                --if passengers then
                                --	if not IsVehicleSeatFree(veh, -1) then
                                --		passengers = passengers + 1
                                --	end
                                --	ShowNumberOnBlip(blip, passengers)
                                --else
                                --	HideNumberOnBlip(blip)
                                --end
                                vehClass = GetVehicleClass(veh)
                                vehModel = GetEntityModel(veh)
                                if vehClass == 15 then
                                    if blipSprite ~= 422 then
                                        SetBlipSprite(blip, 422)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehClass == 8 then
                                    if blipSprite ~= 226 then
                                        SetBlipSprite(blip, 226)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehClass == 14 then
                                    if blipSprite ~= 427 then
                                        SetBlipSprite(blip, 427)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehModel == GetHashKey("rhino") then
                                    if blipSprite ~= 421 then
                                        SetBlipSprite(blip, 421)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehModel == GetHashKey("trash") or vehModel == GetHashKey("trash2") then
                                    if blipSprite ~= 318 then
                                        SetBlipSprite(blip, 318)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif
                                    vehModel == GetHashKey("seashark") or vehModel == GetHashKey("seashark2") or
                                        vehModel == GetHashKey("seashark3")
                                 then
                                    if blipSprite ~= 471 then
                                        SetBlipSprite(blip, 471)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif
                                    vehModel == GetHashKey("cargobob") or vehModel == GetHashKey("cargobob2") or
                                        vehModel == GetHashKey("cargobob3") or
                                        vehModel == GetHashKey("cargobob4")
                                 then
                                    if blipSprite ~= 481 then
                                        SetBlipSprite(blip, 481)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif vehModel == GetHashKey("taxi") then
                                    if blipSprite ~= 198 then
                                        SetBlipSprite(blip, 198)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif
                                    vehModel == GetHashKey("fbi") or vehModel == GetHashKey("fbi2") or
                                        vehModel == GetHashKey("police2") or
                                        vehModel == GetHashKey("police3") or
                                        vehModel == GetHashKey("police") or
                                        vehModel == GetHashKey("sheriff2") or
                                        vehModel == GetHashKey("sheriff") or
                                        vehModel == GetHashKey("policeold2") or
                                        vehModel == GetHashKey("policeold1")
                                 then
                                    if blipSprite ~= 56 then
                                        SetBlipSprite(blip, 56)
                                        SetBlipColour(blip, 38)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    end
                                elseif IsPedInAnyVehicle(ped, true) then
                                    local plate = GetVehicleNumberPlateText(veh)
                                    if plate == "RESELLER" then
                                        SetBlipSprite(blip, 225)
                                        SetBlipColour(blip, 52)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    elseif plate == " GOFAST " then
                                        SetBlipSprite(blip, 225)
                                        SetBlipColour(blip, 49)
                                        ShowHeadingIndicatorOnBlip(blip, false)
                                    else
                                        if blipSprite ~= 225 then
                                            SetBlipSprite(blip, 225)
                                            ShowHeadingIndicatorOnBlip(blip, false)
                                        end
                                    end
                                elseif blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    ShowHeadingIndicatorOnBlip(blip, true)
                                end
                            else
                                --HideNumberOnBlip(blip)
                                if blipSprite ~= 1 then
                                    SetBlipSprite(blip, 1)
                                    ShowHeadingIndicatorOnBlip(blip, true)
                                end
                            end

                            SetBlipRotation(blip, math.ceil(GetEntityHeading(veh)))
                            --SetBlipNameToPlayerName(blip, id)
                            SetBlipScale(blip, 0.6)
                            if IsPauseMenuActive() then
                                SetBlipAlpha(blip, 255)
                            else
                                x1, y1 = table.unpack(GetEntityCoords(PlayerPedId(), true))
                                x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                                distance =
                                    (math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1)) +
                                    900

                                if distance < 0 then
                                    distance = 0
                                elseif distance > 255 then
                                    distance = 255
                                end
                                SetBlipAlpha(blip, distance)
                            end
                        end
                    end
                end
            else
                for _, id in ipairs(GetActivePlayers()) do
                    ped = GetPlayerPed(id)
                    blip = GetBlipFromEntity(ped)
                    if DoesBlipExist(blip) then
                        RemoveBlip(blip)
                    end
                end
            end
        end
    end
)
