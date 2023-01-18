Police = {}

local function ClosestVeh()
    if GetEntityType(vehicleFct.GetVehicleInDirection()) == 2 then
        return vehicleFct.GetVehicleInDirection()
    else
        return 0
    end
end
function CloseAllMenus()
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
        end
    )
end
function Police.PlateCheck()
    local veh = ClosestVeh()
    if veh ~= 0 then
        local plate = GetVehicleNumberPlateText(veh)
        RageUI.Popup({message = "La plaque de ce véhicule est : ~r~" .. plate})
    end
end
function Police.Stup()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local player = GetPlayerFromServerId(playerId)
        local pedT = GetPlayerPed(player)

        TriggerServerCallback(
            "aCore_status:isOnStatus",
            function(bool)
                if bool then
                    ShowNotification("Test Canabis : ~g~Positif~s~")
                else
                    ShowNotification("Test Canabis : ~r~Negatif~s~")
                end
            end,
            "weed",
            playerId
        )

        TriggerServerCallback(
            "aCore_status:isOnStatus",
            function(bool)
                if bool then
                    ShowNotification("Test Meth : ~g~Positif~s~")
                else
                    ShowNotification("Test Meth : ~r~Negatif~s~")
                end
            end,
            "meth",
            playerId
        )

        TriggerServerCallback(
            "aCore_status:isOnStatus",
            function(bool)
                if bool then
                    ShowNotification("Test Cocaine : ~g~Positif~s~")
                else
                    ShowNotification("Test Cocaine : ~r~Negatif~s~")
                end
            end,
            "coke",
            playerId
        )
    else
        ShowNotification("~r~Aucun joueur proche")
    end
end
function Police.Powder()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local player = GetPlayerFromServerId(playerId)
        local pedT = GetPlayerPed(player)

        TriggerServerCallback(
            "aCore_status:isOnStatus",
            function(bool)
                if bool then
                    ShowNotification("Test Poudre : ~g~Positif~s~")
                else
                    ShowNotification("Test Poudre : ~r~Negatif~s~")
                end
            end,
            "powder",
            playerId
        )
    else
        ShowNotification("~r~Aucun joueur proche")
    end
end
function Police.Crocheter()
    local veh = ClosestVeh()
    if veh ~= 0 then
        TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_WELDING", 0, true)
        Citizen.Wait(20000)
        ClearPedTasksImmediately(LocalPlayer().Ped)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleDoorsLocked(veh, 1)
        SetVehicleDoorsLockedForPlayer(veh, false)
        SetVehicleDoorsLockedForAllPlayers(veh, false)
        RageUI.Popup({message = "~g~Véhicule déverouillé"})
    end
end

function Police.Immobiliser()
    local veh = ClosestVeh()
    if veh ~= 0 then
        SetVehicleUndriveable(veh, true)
        SetVehicleDoorsLockedForAllPlayers(veh, true)
        RageUI.Popup({message = "~r~Vous avez immobilisé~s~ le véhicule"})
    end
end

function Police.Desimmobiliser()
    local veh = ClosestVeh()
    if veh ~= 0 then
        SetVehicleUndriveable(veh, false)
        SetVehicleDoorsLockedForAllPlayers(veh, false)

        RageUI.Popup({message = "~r~Vous avez désimmobilisé~s~ le véhicule"})
    end
end
local function F(l)
    local i = {}
    for k, v in pairs(l) do
        i[v.uuid] = v
    end
    return i
end
local listIdentity = {}
local braceletList = {}
local plyTracked = {}
local blipsList = {}
RMenu.Add("police", "bracelet", RageUI.CreateMenu("", "Actions disponibles", 10, 200))
function Police.Bracelet()
    listIdentity = {}
    Citizen.CreateThread(
        function()
            CloseAllMenus()
            TriggerServerCallback(
                "core:GetBraceletList",
                function(identity, _braceletList)
                    listIdentity = F(identity)
                    braceletList = _braceletList
                    RageUI.Visible(RMenu:Get("police", "bracelet"), true)
                end
            )
        end
    )
end
InTracking = false
function Police.ActivateTrack()
    if inServiceS then
        local c = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId()))
        if c == 17 or c == 18 then
            if InTracking then
                ShowNotification("Vous avez ~r~désactiver~s~ le tracking")
            else
                ShowNotification("Vous avez ~g~activer~s~ le tracking")
            end
            InTracking = not InTracking
            TriggerServerEvent("trackingToggle", InTracking)
        else
            ShowNotification("~r~Ce n'est pas un véhicule adapté")
        end
    else
        ShowNotification("~r~Tu dois être en service")
    end
end
local carBlips = {}
RegisterNetEvent("trackingRefresh")
AddEventHandler(
    "trackingRefresh",
    function(t)
        if inServiceS then
            if Job:Get().name == "police" or "lssd" then
                for i = 1, #carBlips, 1 do
                    RemoveBlip(carBlips[i])
                end
                for k, v in pairs(t) do
                    if v then
                        local ped = GetPlayerPed(GetPlayerFromServerId(k))
                        blipPed = AddBlipForEntity(GetVehiclePedIsIn(ped))
                        SetBlipAsFriendly(blipPed, true)
                        SetBlipColour(blipPed, 2)
                        SetBlipCategory(blipPed, 3)
                        SetBlipSprite(blipPed, 523)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString("Voiture #" .. k)
                        EndTextCommandSetBlipName(blipPed)
                        table.insert(carBlips, blipPed)
                    end
                end
            end
        end
    end
)
RegisterNetEvent("deleteBracelet")
AddEventHandler(
    "deleteBracelet",
    function(t)
        for k, v in pairs(plyTracked) do
            if k == t then
                plyTracked[k] = nil
                RemoveBlip(blipsList[k])
                blipsList[k] = nil
                TriggerServerCallback(
                    "core:GetBraceletList",
                    function(identity, _braceletList)
                        listIdentity = F(identity)
                        braceletList = _braceletList
                    end
                )
                break
            end
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("police", "bracelet")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local ply = GetPlayerServerIdInDirection(5.0)
                        HoverPlayer()
                        if ply ~= false then
                            local fo = false
                            for p, t in pairs(braceletList) do
                                if t == ply then
                                    fo = true
                                end
                            end
                            RageUI.Button(
                                fo == false and "Attacher un bracelet éléctronique" or
                                    "Détacher le bracelet éléctronique",
                                nil,
                                {},
                                true,
                                function(_, A, S)
                                    if S and not fo then
                                        if ply == false then
                                            ShowNotification("~r~Aucun joueur proche")
                                        end
                                        TriggerServerEvent("core:RegisterBracelet", ply)

                                        TriggerServerCallback(
                                            "core:GetBraceletList",
                                            function(identity, _braceletList)
                                                listIdentity = F(identity)
                                                braceletList = _braceletList
                                                RageUI.Refresh()
                                            end
                                        )
                                        TriggerPlayerEvent(
                                            "RageUI:Popup",
                                            ply,
                                            {message = "On vous à attaché un bracelet électronique !"}
                                        )
                                    elseif S and fo then
                                        TriggerServerEvent("core:DeleteBracelet", ply)

                                        TriggerPlayerEvent(
                                            "RageUI:Popup",
                                            ply,
                                            {message = "On vous à enlever un bracelet électronique !"}
                                        )
                                    end

                                    if A then
                                        HoverPlayer()
                                    end
                                end
                            )
                        end
                        for p, t in pairs(braceletList) do
                            local found = false
                            for k, v in pairs(plyTracked) do
                                if v == t then
                                    found = true
                                end
                            end
                            RageUI.Checkbox(
                                listIdentity[p].first_name .. " " .. listIdentity[p].last_name,
                                nil,
                                found,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Selected then
                                        if found then
                                            plyTracked[t] = nil
                                            RemoveBlip(blipsList[t])
                                        else
                                            plyTracked[t] = t
                                            local ped = GetPlayerPed(GetPlayerFromServerId(t))
                                            blipPed = AddBlipForEntity(ped)
                                            SetBlipAsFriendly(blipPed, true)
                                            SetBlipColour(blipPed, 2)
                                            SetBlipCategory(blipPed, 3)
                                            SetBlipSprite(blipPed, 480)
                                            BeginTextCommandSetBlipName("STRING")
                                            AddTextComponentString(
                                                "Bracelet" ..
                                                    listIdentity[p].first_name .. " " .. listIdentity[p].last_name
                                            )
                                            EndTextCommandSetBlipName(blipPed)
                                            blipsList[t] = blipPed
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)
DecorRegister("HandsUp", 3)
local handsup = false
local waiting = false
local val = nil
RegisterNetEvent("imhandsup")
AddEventHandler(
    "imhandsup",
    function(handsup_)
        val = handsup_
        waiting = false
    end
)
RegisterNetEvent("areuhandsup")
AddEventHandler(
    "areuhandsup",
    function(id)
        TriggerPlayerEvent("imhandsup", id, handsup)
    end
)
function IsPlyHandsup(id)
    TriggerPlayerEvent("areuhandsup", id, GetPlayerServerId(PlayerId()))
    waiting = true
    while waiting == true do
        Wait(1)
    end

    return val
end
function HandsUP()
    local ped = PlayerPedId()
    --print("yh")
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        RequestAnimDict("random@mugging3")

        while (not HasAnimDictLoaded("random@mugging3")) do
            Citizen.Wait(1)
        end

        if handsup then
            ClearPedSecondaryTask(ped)
            handsup = false
            TriggerServerEvent("core:updateHands", handsup)
            Citizen.Wait(500)
        else
            TaskPlayAnim(ped, "random@mugging3", "handsup_standing_enter", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
            Wait(100)
            TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
            handsup = true
            TriggerServerEvent("core:updateHands", handsup)
            Citizen.Wait(500)
        end
    end
end

RegisterCommand(
    "+handsup",
    function()
        HandsUP()
    end,
    false
)
RegisterCommand(
    "-handsup",
    function()
        HandsUP()
    end,
    false
)
RegisterCommand(
    "handsup",
    function()
        HandsUP()
    end,
    false
)
RegisterKeyMapping("handsup", "Lever les mains", "keyboard", "X")
function IsPlyHandcuff(id)
    local player = GetPlayerFromServerId(id)
    player = GetPlayerPed(player)
    return DecorGetBool(player, "Handcuffed")
end
DecorRegister("Handcuffed", 3)

function Police.HandcuffPly()
    local count = Inventory:GetItemCount("menottes")
    if count > 0 then
        local playerId = GetPlayerServerIdInDirection(5.0)
        if (playerId ~= false) then
            local isHandcuff = IsPlyHandcuff(playerId)
            if not isHandcuff then
                if Inventory.SelectedItem ~= nil then
                    Inventory:RemoveItem()
                else
                    local _v = Inventory.Inventory["menottes"]
                    local i = 1
                    if _v[i] ~= nil then
                        Inventory:RemoveItemToInv(_v[i].id, _v[i].name)
                    --TriggerServerEvent("inventory:RemoveItem",_v[i].id,"menottes")
                    end
                end
                TriggerServerEvent("player:Handcuff", playerId, true)
            else
                RageUI.Popup({message = "~b~Ce joueur est déjà menotté"})
            end
        else
            RageUI.Popup({message = "~r~Aucun joueur proche"})
        end
    else
        RageUI.Popup({message = "Vous n'avez pas de ~r~menottes"})
    end
end
function Police.PhotoIdent()
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()
            Wait(10)
            RageUI.GoBack()

            RageUI.Visible(RMenu:Get("police", "identity"), true)
        end
    )
end
function Police.RetraitPermis()
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()

            RageUI.Visible(RMenu:Get("police", "permis"), true)
        end
    )
end
RMenu.Add("police", "permis", RageUI.CreateMenu("", "Permis disponibles", 10, 200))

RMenu.Add("police", "identity", RageUI.CreateMenu("", "Cartes d'identitées disponibles", 10, 200))

RMenu.Add("concess", "listes", RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "", "Ventes effectuées"))
RMenu.Add("concess", "listes_veh", RageUI.CreateSubMenu(RMenu:Get("concess", "listes"), "", "Informations"))

RMenu.Add("autoshop", "listes", RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "", "Ventes effectuées"))
RMenu.Add("autoshop", "listes_veh", RageUI.CreateSubMenu(RMenu:Get("concess", "listes"), "", "Informations"))

RMenu.Add("bikershop", "listes", RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "", "Ventes effectuées"))
RMenu.Add("bikershop", "listes_veh", RageUI.CreateSubMenu(RMenu:Get("concess", "listes"), "", "Informations"))

local VehiclesList = {}

function Clef()
    local veh = ClosestVeh()
    if veh == 0 then
        return ShowNotification("~r~Aucun véhicule proche")
    end
    local k = GetVehicleNumberPlateText(veh)
    if k ~= nil then
        TriggerServerCallback(
            "core:GetVehicleOwnedX",
            function(b)
                if b then
                    items = {name = "key", data = {plate = k}, label = k}
                    AddItemtoInv(items)
                else
                    ShowNotification("~r~Véhicule inexistant")
                end
            end,
            k
        )
    end
end

function CarteGrise()
    local k = KeyboardInput("Plaques ", nil, 10)
    k = tostring(k)

    if k ~= nil then
        TriggerServerCallback(
            "core:GetVehicleOwned+Infos",
            function(b, v, x)
                if b then
                    _t = json.decode(v.settings)
                    if x == nil then
                        x = v.uuid
                    end
                    items = {name = "carte_grise", data = {plate = k, model = _t.label, identity = x}, label = k}
                    AddItemtoInv(items)
                end
            end,
            k
        )
    end
end
function ListesVentes() -- (concess)
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            TriggerServerCallback(
                "vehicleshop:GetAll",
                function(d, identity)
                    for t = 1, #d, 1 do
                        d[t].identityBuyer = d[t].buyer
                        if d[t].buyer == nil then
                            d[t].identityBuyer = "Contactez un admin (pas de vendeur)"
                        end
                        d[t].identityVendor = "Inconnu"
                        local buyerFound = false
                        for i = 1, #identity, 1 do
                            if identity[i].uuid == d[t].buyer then
                                d[t].identityBuyer = identity[i]
                                buyerFound = true
                            end

                            if identity[i].uuid == d[t].vendor then
                                d[t].identityVendor = identity[i]
                            end
                        end

                        if (buyerFound == false) then
                            d[t].identityBuyer = {}
                            d[t].identityBuyer.first_name = "Société"
                            d[t].identityBuyer.last_name = d[t].buyer
                        end
                    end
                    VehiclesList = d
                end
            )
            RageUI.Visible(RMenu:Get("concess", "listes"), true)
        end
    )
end
local currVEH = {}
function RentrerVeh()
    print(GetInteriorFromEntity(PlayerPedId()))
    if GetInteriorFromEntity(PlayerPedId()) == 7170 then
        DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
    end
end
function RentrerVeh2()
    DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
end
function RentrerVeh3()
    DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
end
local filter = nil
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            if RageUI.Visible(RMenu:Get("concess", "listes")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local label2 = search == nil and "Rechercher" or "Recherche actuel : ~b~" .. search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            search = nil
                                        else
                                            search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )
                        local found = false
                        for i = 1, #VehiclesList, 1 do
                            if filter ~= nil then
                                for k, v in pairs(vehicleList) do
                                    if string.match(v, filterSearch.search:lower()) then
                                        found = true
                                    end
                                end
                            else
                                found = true
                            end
                            if found then
                                RageUI.Button(
                                    VehiclesList[i].model .. " - " .. VehiclesList[i].plate,
                                    nil,
                                    {RightLabel = VehiclesList[i].date},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            currVEH = VehiclesList[i]
                                        end
                                    end,
                                    RMenu:Get("concess", "listes_veh")
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("concess", "listes_veh")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        RageUI.Button(
                            "Modèle du véhicule ",
                            nil,
                            {RightLabel = currVEH.model},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        RageUI.Button(
                            "Plaques ",
                            nil,
                            {RightLabel = currVEH.plate},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Prix de vente ",
                            nil,
                            {RightLabel = currVEH.prices .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Date de la vente ",
                            nil,
                            {RightLabel = currVEH.date},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        local bfirstname = currVEH.identityBuyer.first_name or ""
                        local blastname = currVEH.identityBuyer.last_name or currVEH.identityBuyer

                        RageUI.Button(
                            "Acheteur ",
                            nil,
                            {RightLabel = bfirstname .. " " .. blastname},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        local vfirstname = currVEH.identityVendor.first_name or ""
                        local vlastname = currVEH.identityVendor.last_name or currVEH.identityVendor

                        RageUI.Button(
                            "Vendeur ",
                            nil,
                            {RightLabel = vfirstname .. " " .. vlastname},
                            true,
                            function(_, _, Selected)
                            end
                        )
                    end,
                    function()
                    end
                )
            end
        end
    end
)
local zoneRadius = 50.0
local createdSpeedZones = {}
function Police.ChangeZone()
    if createdSpeedZones.id ~= nil then
        RemoveSpeedZone(createdSpeedZones.id)
    end
    local pos = LocalPlayer().Pos
    local val = tonumber(KeyboardInput("KM/H"))
    if val == nil then
        return
    end
    local zone = AddSpeedZoneForCoord(pos, zoneRadius, math.ceil((val or 0) / 3.6) + 0.0)
    createdSpeedZones = {id = zone, pos = pos}

    ShowAboveRadarMessage(
        string.format("La vitesse est limité à ~g~%skm/h~w~ dans la zone.", math.ceil(tonumber(val or 0)))
    )
end

function Police.EditZone()
    if createdSpeedZones.id ~= nil then
        RemoveSpeedZone(createdSpeedZones.id)
    end
    local pos = LocalPlayer().Pos
    local val = tonumber(KeyboardInput("Mètres de rayons", nil, 3))

    if val == nil then
        return
    end
    zoneRadius = val * 1.0001
    local zone = AddSpeedZoneForCoord(pos, zoneRadius, math.ceil((val or 0) / 3.6) + 0.0)
    createdSpeedZones.id = zone

    ShowAboveRadarMessage("La zone est maintenant de ~g~" .. val .. "m de rayons")
end

function Police.RemoveZone()
    if createdSpeedZones.id ~= nil then
        RemoveSpeedZone(createdSpeedZones.id)
        createdSpeedZones = {}

        ShowAboveRadarMessage("~b~La vitesse n'est plus limitée")
    end
end
function Police.PutInVeh()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        TriggerPlayerEvent("police:PutVeh", playerId)
    end
end

function Police.SortirVeh()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        TriggerPlayerEvent("police:PutVeh", playerId)
    end
end

RegisterNetEvent("police:PutVeh")
AddEventHandler(
    "police:PutVeh",
    function()
        local ped = LocalPlayer().Ped
        local vehicle = GetVehiclePedIsIn(LocalPlayer().Ped)
        if vehicle == 0 then
            vehicle = vehicleFct.GetClosestVehicle()
            TaskEnterVehicle(LocalPlayer().Ped, vehicle, 10000, 1)
        else
            TaskLeaveAnyVehicle(LocalPlayer().Ped)
        end
    end
)

function Police.ShowZone()
    if createdSpeedZones.id ~= nil then
        DrawMarker(
            28,
            createdSpeedZones.pos,
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            0.0,
            zoneRadius,
            zoneRadius,
            zoneRadius,
            192,
            255,
            0,
            70,
            0,
            0,
            0,
            0,
            0,
            0,
            0
        )
    end
end
local currCarte = nil
Citizen.CreateThread(
    function()
        Wait(500)

        --TriggerEvent("ShowPicture","https://lh5.ggpht.com/-jHhk2ghmH2Q/T4grf3MRH_I/AAAAAAAACgo/zwHULGGjU5I/jquery-change-image%25255B13%25255D.png?imgmax=800")
        while true do
            Wait(1)
            if takingPic then
                DisplayRadar(false)
                if IsControlJustPressed(0, Keys["E"]) then
                    ShowNotification("~b~Photo prise !")

                    exports["screenshot-basic"]:requestScreenshotUpload(
                        "https://fiveshopm.com/shop/up/ohohohohoho.php",
                        "files",
                        function(data)
                            local resp = json.decode(data)
                            for i = 1, #Inventory.Inventory["identity"], 1 do
                                if Inventory.Inventory["identity"][i].id == currCarte then
                                    Inventory.Inventory["identity"][i].data.identity.face_picutre = resp.url
                                    --TriggerServerEvent("inventory:editData",Inventory.Inventory["identity"][i].id,Inventory.Inventory["identity"][i].data)
                                    TriggerServerEvent(
                                        "identity:editPic",
                                        Inventory.Inventory["identity"][i].data.identity.uuid,
                                        resp.url
                                    )
                                end
                            end
                        end
                    )
                    takingPic = false
                    SetFollowPedCamViewMode(0)
                    DisplayRadar(true)
                end
            end
            if RageUI.Visible(RMenu:Get("police", "identity")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        if Inventory.Inventory["identity"] == nil or #Inventory.Inventory["identity"] == 0 then
                            RageUI.Button(
                                "Vide",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end
                            )
                        end
                        if Inventory.Inventory["identity"] ~= nil then
                            for i = 1, #Inventory.Inventory["identity"], 1 do
                                local v = Inventory.Inventory["identity"][i]
                                local data = v.data.identity
                                if data == nil then
                                    data = {}
                                end
                                if data.first_name == nil then
                                    data.first_name = "Inconnu"
                                    data.last_name = "Inconnu"
                                end
                                RageUI.Button(
                                    "Carte d'identité",
                                    nil,
                                    {RightLabel = data.first_name .. " " .. data.last_name},
                                    true,
                                    function(_, A, Selected)
                                        if A then
                                            if data.face_picutre ~= "N/A" then
                                                TriggerEvent("ShowPicture", data.face_picutre)
                                            else
                                                TriggerEvent("ShowPicture", false)
                                            end
                                        end
                                        if Selected then
                                            RageUI.GoBack()
                                            Citizen.CreateThread(
                                                function()
                                                    currCarte = v.id
                                                    TriggerEvent("ShowPicture", false)
                                                    ShowNotification("Préparez vous à prendre la photo d'identité")
                                                    SetFollowPedCamViewMode(4)
                                                    Wait(250)
                                                    ShowNotification("~b~Appuyez sur E pour prendre la photo")
                                                    takingPic = true
                                                    Wait(50000)
                                                    if takingPic then
                                                        takingPic = false
                                                        SetFollowPedCamViewMode(0)
                                                        ShowNotification("~b~Vous avez pris trop de temps ! ")
                                                    end
                                                end
                                            )
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
            if RageUI.Visible(RMenu:Get("police", "permis")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        if Inventory.Inventory["permis-conduire"] == nil or #Inventory.Inventory["permis-conduire"] == 0 then
                            RageUI.Button(
                                "Vide",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                    end
                                end
                            )
                        end
                        if Inventory.Inventory["permis-conduire"] ~= nil then
                            for i = 1, #Inventory.Inventory["permis-conduire"], 1 do
                                local v = Inventory.Inventory["permis-conduire"][i]
                                local data = v.data
                                RageUI.Button(
                                    "Permis " .. data.uid,
                                    nil,
                                    {RightLabel = data.points .. " points"},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            local am = KeyboardInput("Nombre de points à enlever", nil, 2)
                                            local am = tonumber(am)
                                            if am ~= nil then
                                                data.points = data.points - am
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
        end
    end
)
function Police.CutMenottes()
    local playerId = GetPlayerServerIdInDirection(5.0)
    local item = {name = "menottes", data = {}}
    if (playerId ~= false) then
        local isHandcuff = IsPlyHandcuff(playerId)
        if isHandcuff then
            if Job:Get().name == "police" or "lssd" then
                TriggerServerEvent("player:Handcuff", playerId, false)
                AddItemtoInv(item)
            else
                TriggerServerEvent("player:Handcuff", playerId, false)
            end
        else
            RageUI.Popup({message = "Ce joueur n'est pas menotté"})
        end
    else
        RageUI.Popup({message = "~r~Aucun joueur proche"})
    end
end
function Police.PutPortWeapon()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local txtt = KeyboardInput("Numéro de série", nil, 2)

        items = {name = "weapon_licences", data = {serial = txtt}}
        AddItemtoInv(items)
        ShowNotification("~r~Vous avez créer un permis port d'arme avec le numéro de série ~y~" .. txtt)
    else
        RageUI.Popup({message = "~r~Aucun joueur proche"})
    end
end

function Police.PutPortUber()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local txtt = KeyboardInput("Numéro de licence", nil, 2)

        items = {name = "uber_off", data = {serial = txtt}}
        AddItemtoInv(items)
        ShowNotification("~r~Vous avez créer une licence portant le numéro de série : ~y~" .. txtt)
    else
        RageUI.Popup({message = "~r~Aucun joueur proche"})
    end
end

function Police.PutEntreprise()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local txtt = KeyboardInput("Numéro de licence", nil, 2)

        items = {name = "entreprise_off", data = {serial = txtt}}
        AddItemtoInv(items)
        ShowNotification("~r~Vous avez créer une licence portant le numéro de série : ~y~" .. txtt)
    else
        RageUI.Popup({message = "~r~Aucun joueur proche"})
    end
end
-- function ListesVentesnord() -- (autoshop nord)
--     Citizen.CreateThread(function()
--         RageUI.GoBack()
--         Wait(20)
--         RageUI.GoBack()
--         Wait(20)
--         RageUI.GoBack()
--         Wait(20)
--         RageUI.GoBack()
--         Wait(20)
--         RageUI.GoBack()
--         TriggerServerCallback('autoshop:GetAll',function(d,identity)
--             for t = 1 , #d , 1 do
--                 for i = 1 , #identity, 1 do
--                     if identity[i].uuid == d[t].buyer then
--                         d[t].identityBuyer = identity[i]
--                     end

--                     if identity[i].uuid == d[t].vendor then
--                         d[t].identityVendor = identity[i]
--                     end
--                 end
--             end
--             VehiclesList =  d
--         end)
--         RageUI.Visible(RMenu:Get('autoshop',"listes"),true)
--     end)
-- end

function ListesVentesnord() -- (concess NORD)
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            TriggerServerCallback(
                "autoshop:GetAll",
                function(d, identity)
                    for t = 1, #d, 1 do
                        local buyerFound = false
                        for i = 1, #identity, 1 do
                            if identity[i].uuid == d[t].buyer then
                                d[t].identityBuyer = identity[i]
                                buyerFound = true
                            end

                            if identity[i].uuid == d[t].vendor then
                                d[t].identityVendor = identity[i]
                            end
                        end

                        if (buyerFound == false) then
                            d[t].identityBuyer = {}
                            d[t].identityBuyer.first_name = "Société"
                            d[t].identityBuyer.last_name = d[t].buyer
                        end
                    end
                    VehiclesList = d
                end
            )
            RageUI.Visible(RMenu:Get("autoshop", "listes"), true)
        end
    )
end
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            if RageUI.Visible(RMenu:Get("autoshop", "listes")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local label2 = search == nil and "Rechercher" or "Recherche actuel : ~b~" .. search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            search = nil
                                        else
                                            search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )
                        local found = false
                        for i = 1, #VehiclesList, 1 do
                            if filter ~= nil then
                                for k, v in pairs(vehicleList) do
                                    if string.match(v, filterSearch.search:lower()) then
                                        found = true
                                    end
                                end
                            else
                                found = true
                            end
                            if found then
                                RageUI.Button(
                                    VehiclesList[i].model .. " - " .. VehiclesList[i].plate,
                                    nil,
                                    {RightLabel = VehiclesList[i].date},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            currVEH = VehiclesList[i]
                                        end
                                    end,
                                    RMenu:Get("autoshop", "listes_veh")
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("autoshop", "listes_veh")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        RageUI.Button(
                            "Modèle du véhicule ",
                            nil,
                            {RightLabel = currVEH.model},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        RageUI.Button(
                            "Plaques ",
                            nil,
                            {RightLabel = currVEH.plate},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Prix de vente ",
                            nil,
                            {RightLabel = currVEH.prices .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Date de la vente ",
                            nil,
                            {RightLabel = currVEH.date},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Acheteur ",
                            nil,
                            {RightLabel = currVEH.identityBuyer.first_name .. " " .. currVEH.identityBuyer.last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Vendeur ",
                            nil,
                            {RightLabel = currVEH.identityVendor.first_name .. " " .. currVEH.identityVendor.last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )
                    end,
                    function()
                    end
                )
            end
        end
    end
)

function ListesVentesmoto() -- (Bikershop)
    Citizen.CreateThread(
        function()
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            Wait(20)
            RageUI.GoBack()
            TriggerServerCallback(
                "bikershop:GetAll",
                function(d, identity)
                    for t = 1, #d, 1 do
                        local buyerFound = false

                        for i = 1, #identity, 1 do
                            if identity[i].uuid == d[t].buyer then
                                d[t].identityBuyer = identity[i]
                                buyerFound = true
                            end

                            if identity[i].uuid == d[t].vendor then
                                d[t].identityVendor = identity[i]
                            end
                        end

                        if (buyerFound == false) then
                            d[t].identityBuyer = {}
                            d[t].identityBuyer.first_name = "Société"
                            d[t].identityBuyer.last_name = d[t].buyer
                        end
                    end
                    VehiclesList = d
                end
            )
            RageUI.Visible(RMenu:Get("bikershop", "listes"), true)
        end
    )
end
Citizen.CreateThread(
    function()
        while true do
            Wait(1)

            if RageUI.Visible(RMenu:Get("bikershop", "listes")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        local label2 = search == nil and "Rechercher" or "Recherche actuel : ~b~" .. search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            search = nil
                                        else
                                            search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )
                        local found = false
                        for i = 1, #VehiclesList, 1 do
                            if filter ~= nil then
                                for k, v in pairs(vehicleList) do
                                    if string.match(v, filterSearch.search:lower()) then
                                        found = true
                                    end
                                end
                            else
                                found = true
                            end
                            if found then
                                RageUI.Button(
                                    VehiclesList[i].model .. " - " .. VehiclesList[i].plate,
                                    nil,
                                    {RightLabel = VehiclesList[i].date},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            currVEH = VehiclesList[i]
                                        end
                                    end,
                                    RMenu:Get("bikershop", "listes_veh")
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("bikershop", "listes_veh")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        RageUI.Button(
                            "Modèle du véhicule ",
                            nil,
                            {RightLabel = currVEH.model},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        RageUI.Button(
                            "Plaques ",
                            nil,
                            {RightLabel = currVEH.plate},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Prix de vente ",
                            nil,
                            {RightLabel = currVEH.prices .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Date de la vente ",
                            nil,
                            {RightLabel = currVEH.date},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Acheteur ",
                            nil,
                            {RightLabel = currVEH.identityBuyer.first_name .. " " .. currVEH.identityBuyer.last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Vendeur ",
                            nil,
                            {RightLabel = currVEH.identityVendor.first_name .. " " .. currVEH.identityVendor.last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )
                    end,
                    function()
                    end
                )
            end
        end
    end
)
