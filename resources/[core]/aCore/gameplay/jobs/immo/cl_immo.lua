Citizen.CreateThread(
    function()
        Wait(0)
        while Job == nil or Job:Get() == nil do
            Wait(1)
        end
        -- --("ready immo")
        if Job:Get().name == "immo" then
            local PosOfMarker, isMarkerEnabled, WeightOfPos, PosOfInterior, cam, numberOfHouse
            local PosInLabelAppart = 1
            local createdCamera = nil
            local AppartementList = {
                "Petit hangars",
                "Moyen hangars",
                "Grand hangars",
                "Appartement bas de gamme",
                "Appartement moyen gamme",
                "Appartement haut de gamme",
                "Garage",
                "maison franklin",
                "appt balcon",
                "Appt Luxe Arcadia",
                "Appartement Luxe Del Perro",
                "Maison luxe 1",
                "Maison Luxe rouge",
                "Penthouse Rouge",
                "Penthouse Marron",
                "Bunker",
                "Business Modern",
                "Business Bois",
                --"Studio musique",
                --"Studio motel",
                --"maison de disque"
            }
            local CoordsCamList = {
                {
                    coords = {x = 1087.69, y = -3095.56, z = -36.5},
                    r = {x = -200.0, y = -180.0, z = -57.39},
                    entry = {x = 1087.63, y = -3099.42, z = -39.0},
                    coffre = {x = 1091.37, y = -3096.9, z = -39.0}
                },
                {
                    coords = {x = 1048.45, y = -3111.36, z = -36.8},
                    r = {x = -10.0, y = 0.0, z = -74.39},
                    entry = {x = 1048.31, y = -3097.34, z = -39.0},
                    coffre = {x = 1052.97, y = -3095.2, z = -39.0}
                },
                {
                    coords = {x = 993.13, y = -3092.36, z = -33.5},
                    r = {x = -200.0, y = -180.0, z = -57.39},
                    entry = {x = 992.76, y = -3097.81, z = -39.0},
                    coffre = {x = 1003.48, y = -3102.71, z = -39.0}
                },
                {
                    coords = {x = 257.73, y = -995.36, z = -98.0},
                    r = {x = -190.0, y = -180.0, z = -49.43},
                    entry = {x = 266.06, y = -1007.38, z = -101.01},
                    coffre = {x = 259.81, y = -1003.95, z = -99.01}
                },
                {
                    coords = {x = 337.98, y = -993.43, z = -98.0},
                    r = {x = -190.0, y = -180.0, z = -49.43},
                    entry = {x = 346.38, y = -1012.72, z = -99.2},
                    coffre = {x = 351.9, y = -998.6, z = -99.2}
                },
                {
                    coords = {x = -769.52, y = 342.82, z = 213.04},
                    r = {x = -190.0, y = -180.0, z = 49.01},
                    entry = {x = -781.56, y = 322.36, z = 212.0},
                    coffre = {x = -765.52, y = 327.23, z = 211.4}
                },
                {
                    coords = {x = 1097.9, y = -3166.48, z = -35.25},
                    r = {x = -190.0, y = -180.0, z = 220.44},
                    entry = {x = 1121.09, y = -3152.33, z = -37.06},
                    coffre = {x = 1114.85, y = -3161.85, z = -36.87}
                },
                {
                    coords = {x = -9.49, y = -1441.55, z = 32.10},
                    r = {x = -190.0, y = -180.0, z = 160.44},
                    entry = {x = -14.13, y = -1440.57, z = 31.1},
                    coffre = {x = -18.29, y = -1438.79, z = 31.1}
                },
                {
                    coords = {x = -1161.62, y = -1520.68, z = 11.60},
                    r = {x = -190.0, y = -180.0, z = -84.69},
                    entry = {x = -1150.70, y = -1520.713, z = 10.633},
                    coffre = {x = -1145.27, y = -1514.57, z = 10.63}
                },
                {
                    coords = {x = -42.2, y = -570.73, z = 90.65},
                    r = {x = -190.0, y = -180.0, z = -25.63},
                    entry = {x = -17.45, y = -588.46, z = 90.11},
                    coffre = {x = -27.15, y = -588.22, z = 90.12}
                },
                {
                    coords = {x = -1480.84, y = -533.65, z = 70.55}, -- a changer
                    r = {x = -190.0, y = -180.0, z = -80.08},
                    entry = {x = -1451.3, y = -524.04, z = 69.56},
                    coffre = {x = -1457.2, y = -531.05, z = 56.94}
                },
                {
                    coords = {x = -170.52, y = 478.84, z = 138.40}, -- Maison Luxe 1
                    r = {x = -190.0, y = -180.0, z = -140.48},
                    entry = {x = -174.14, y = 497.41, z = 137.67},
                    coffre = {x = -175.19, y = 492.79, z = 130.04}
                },
                {
                    coords = {x = 368.65, y = 404.74, z = 146.68}, -- Maison Luxe rouge
                    r = {x = -190.0, y = -180.0, z = -120.34},
                    entry = {x = 373.69, y = 423.62, z = 145.91},
                    coffre = {x = 378.33, y = 429.58, z = 138.3}
                },
                {
                    coords = {x = -772.65, y = 337.47, z = 198.10},
                    r = {x = -190.0, y = -180.0, z = 15.22},
                    entry = {x = -779.33, y = 339.31, z = 196.69},
                    coffre = {x = -765.05, y = 330.44, z = 196.09}
                },
                {
                    coords = {x = -781.77, y = 342.36, z = 188.75},
                    r = {x = -190.0, y = -180.0, z = 45.1},
                    entry = {x = -781.6, y = 318.36, z = 187.91},
                    coffre = {x = -796.04, y = 326.98, z = 186.41}
                },
                {
                    coords = {x = 895.06, y = -3246.8, z = -95.25}, --bunker
                    r = {x = -190.0, y = -180.0, z = 105.31},
                    entry = {x = 895.85, y = -3245.87, z = -98.25},
                    coffre = {x = 907.93, y = -3203.63, z = -97.19}
                },
                {
                    coords = {x = -142.22, y = -646.72, z = 169.95}, --Business - Modern
                    r = {x = -190.0, y = -180.0, z = -140.43},
                    entry = {x = -141.85, y = -618.03, z = 168.82},
                    coffre = {x = -127.63, y = -634.04, z = 168.82}
                },
                {
                    coords = {x = -63.9, y = -804.87, z = 244.50}, --Business - Bois
                    r = {x = -190.0, y = -180.0, z = 58.89},
                    entry = {x = -76.75, y = -830.32, z = 243.39},
                    coffre = {x = -82.26, y = -809.25, z = 243.39}
                },
                {
                    coords = {x = -899.82, y = -463.47, z = 162.7}, --Studio de musique
                    r = {x = -190.0, y = -180.0, z = 190.89},
                    entry = {x = -906.27, y = -453.9, z = 161.32},
                    coffre = {x = -888.65, y = -439.18, z = 160.22}
                },
                {
                    coords = {x = 150.73, y = -1007.99, z = -98.20}, --Chambre motel
                    r = {x = -190.0, y = -180.0, z = 220.46},
                    entry = {x = 151.52, y = -1007.91, z = -99.00},
                    coffre = {x = 151.90, y = -1001.19, z = -98.99}
                },
                {
                    coords = {x = 726.37, y = 2521.85, z = 75.01}, --Studio maison de disque
                    r = {x = -190.0, y = -180.0, z = 150.62},
                    entry = {x = 724.96, y = 2521.99, z = 73.50},
                    coffre = {x = 716.52, y = 2524.05, z = 72.50}
                }
            }
            function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
                AddTextEntry("FMMC_KEY_TIP1", TextEntry)
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
            local price
            local oldIndex
            local priceAm
            local CurrentIndexS
            local CurrentProperty
            local MYPOS
            local users = {}
            local usersID = {}
            local selectedPri = 0
            local selectedID = 0
            local PosOfGarage = nil
            local selectedName = ""
            local px = true
            local nbrplace = 1
            local CurrentSonnerieSalope = nil
            RMenu.Add("immo", "main", RageUI.CreateMenu("Immobilier ", "Actions disponibles", 10, 100))

            RMenu.Add(
                "immo",
                "put_proprio",
                RageUI.CreateSubMenu(RMenu:Get("immo", "main"), "Immobilier ", "Actions disponibles", 10, 100)
            )
            RMenu:Get("immo", "put_proprio").Closed = function()
                PosOfMarker, isMarkerEnabled, WeightOfPos, PosOfInterior, cam, numberOfHouse = nil
                PosInLabelAppart = 1
                createdCamera = nil
                DestroyCam(createdCamera, 0)
                RenderScriptCams(0, 0, 1, 1, 1)
                createdCamera = 0
                ClearTimecycleModifier("scanline_cam_cheap")
                SetFocusEntity(GetPlayerPed(PlayerId()))
            end
            KeySettings:Add(
                "keyboard",
                "F6",
                function()
                    RageUI.Visible(RMenu:Get("immo", "main"), true)
                end,
                "immo"
            )
            --  RageUI.Visible(RMenu:Get('immo',"put_proprio"),true)
            Citizen.CreateThread(
                function()
                    while true do
                        Wait(1)
                        if RageUI.Visible(RMenu:Get("immo", "main")) then
                            RageUI.DrawContent(
                                {header = true, glare = false},
                                function()
                                    RageUI.Button(
                                        "Créer une propriété",
                                        nil,
                                        {},
                                        true,
                                        function(Hovered, Active, Selected)
                                        end,
                                        RMenu:Get("immo", "put_proprio")
                                    )
                                    RageUI.Button(
                                        "Facture",
                                        nil,
                                        {},
                                        true,
                                        function(Hovered, Active, Selected)
                                            if Selected then
                                                CreateFacture("immo")
                                            end
                                            if Active then
                                                HoverPlayer()
                                            end
                                        end
                                    )
                                end,
                                function()
                                end
                            )
                        end
                        if RageUI.Visible(RMenu:Get("immo", "put_proprio")) then
                            RageUI.DrawContent(
                                {header = true, glare = false},
                                function()
                                    if isMarkerEnabled then
                                        DrawMarker(
                                            25,
                                            PosOfMarker.x,
                                            PosOfMarker.y,
                                            PosOfMarker.z,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            1.0,
                                            1.0,
                                            1.0,
                                            255,
                                            255,
                                            255,
                                            100
                                        )
                                        if PosOfGarage ~= nil then
                                            DrawMarker(
                                                25,
                                                PosOfGarage.x,
                                                PosOfGarage.y,
                                                PosOfGarage.z,
                                                nil,
                                                nil,
                                                nil,
                                                nil,
                                                nil,
                                                nil,
                                                1.0,
                                                1.0,
                                                1.0,
                                                125,
                                                0,
                                                0,
                                                100
                                            )
                                        end
                                    end
                                    RageUI.Button(
                                        "Placer une propriété",
                                        "Place l'entrée de la propriété",
                                        {},
                                        true,
                                        function(Hovered, Active, Selected)
                                            if Active then
                                                coords = LocalPlayer().Pos
                                                if PosOfMarker == nil then
                                                    DrawMarker(
                                                        25,
                                                        coords.x,
                                                        coords.y,
                                                        coords.z - 0.95,
                                                        nil,
                                                        nil,
                                                        nil,
                                                        nil,
                                                        nil,
                                                        nil,
                                                        1.0,
                                                        1.0,
                                                        1.0,
                                                        255,
                                                        255,
                                                        255,
                                                        100
                                                    )
                                                else
                                                    DrawMarker(
                                                        25,
                                                        PosOfMarker.x,
                                                        PosOfMarker.y,
                                                        PosOfMarker.z,
                                                        nil,
                                                        nil,
                                                        nil,
                                                        nil,
                                                        nil,
                                                        nil,
                                                        1.0,
                                                        1.0,
                                                        1.0,
                                                        255,
                                                        255,
                                                        255,
                                                        100
                                                    )
                                                end
                                            end
                                            if Selected then
                                                isMarkerEnabled = true
                                                coords = LocalPlayer().Pos
                                                PosOfMarker = {x = coords.x, y = coords.y, z = coords.z - 0.95}
                                            end
                                        end,
                                        RMenu:Get("immo", "main_second")
                                    )

                                    if isMarkerEnabled then
                                        DrawMarker(
                                            25,
                                            PosOfMarker.x,
                                            PosOfMarker.y,
                                            PosOfMarker.z,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            nil,
                                            1.0,
                                            1.0,
                                            1.0,
                                            255,
                                            255,
                                            255,
                                            100
                                        )

                                        RageUI.Button(
                                            "Capacité du coffre",
                                            nil,
                                            {
                                                RightLabel = WeightOfPos
                                            },
                                            true,
                                            function(Hovered, Active, Selected)
                                                if Selected then
                                                    amount = KeyboardInput("Entrez la capacité du coffre", nil, 5)
                                                    if tonumber(amount) ~= nil then
                                                        WeightOfPos = tonumber(amount) .. "KG"
                                                    end
                                                end
                                            end
                                        )
                                        local streetName --[[ Hash ]], crossingRoad --[[ Hash ]] =
                                            GetStreetNameAtCoord(PosOfMarker.x, PosOfMarker.y, PosOfMarker.z)
                                        realstreetname = GetStreetNameFromHashKey(streetName)
                                        if numberOfHouse == nil then
                                            RageUI.Button(
                                                "Numéro de la propriété",
                                                "Indiquez le numéro de la maison",
                                                {
                                                    RightLabel = nil
                                                },
                                                true,
                                                function(Hovered, Active, Selected)
                                                    if Selected then
                                                        amount =
                                                            KeyboardInput("Entrez le numéro de la propriété", nil, 25)
                                                        if tonumber(amount) ~= nil then
                                                            numberOfHouse = amount
                                                        end
                                                    end
                                                end
                                            )
                                        else
                                            RageUI.Button(
                                                "Numéro",
                                                "Indiquez le numéro de la maison",
                                                {
                                                    RightLabel = realstreetname .. " " .. numberOfHouse
                                                },
                                                true,
                                                function(Hovered, Active, Selected)
                                                    if Selected then
                                                        amount =
                                                            KeyboardInput("Entrez le numéro de la propriété", nil, 3)
                                                        if tonumber(amount) ~= nil then
                                                            numberOfHouse = amount
                                                        end
                                                    end
                                                end
                                            )
                                        end
                                        RageUI.List(
                                            "Intérieur",
                                            AppartementList,
                                            PosInLabelAppart,
                                            nil,
                                            {},
                                            true,
                                            function(Hovered, Active, Selected, Index)
                                                PosInLabelAppart = Index
                                                if Active and oldIndex ~= Index then
                                                    DestroyCam(createdCamera, 0)
                                                    RenderScriptCams(0, 0, 1, 1, 1)
                                                    createdCamera = 0
                                                    ClearTimecycleModifier("scanline_cam_cheap")
                                                    SetFocusEntity(GetPlayerPed(PlayerId()))
                                                    oldIndex = Index
                                                    m = CoordsCamList[Index]
                                                    c = m.coords
                                                    r = m.r

                                                    local int = GetInteriorAtCoords(c.x, c.y, c.z)
                                                    LoadInterior(int)
                                                    while not IsInteriorReady(int) do
                                                        Wait(1)
                                                    end
                                                    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 2)
                                                    SetCamCoord(cam, c.x, c.y, c.z)
                                                    SetCamRot(cam, r.x, r.y, r.z, 1)
                                                    SetFocusArea(c.x, c.y, c.z, c.x, c.y, c.z)
                                                    RenderScriptCams(1, 0, 0, 1, 1)
                                                    createdCamera = cam
                                                elseif not Active then
                                                    DestroyCam(createdCamera, 0)
                                                    RenderScriptCams(0, 0, 1, 1, 1)
                                                    createdCamera = 0
                                                    ClearTimecycleModifier("scanline_cam_cheap")
                                                    SetFocusEntity(GetPlayerPed(PlayerId()))
                                                end
                                            end
                                        )
                                        RageUI.Button(
                                            "Placer un garage",
                                            nil,
                                            {},
                                            true,
                                            function(Hovered, Active, Selected)
                                                if Active then
                                                    coords = LocalPlayer().Pos
                                                    if PosOfGarage == nil then
                                                        DrawMarker(
                                                            25,
                                                            coords.x,
                                                            coords.y,
                                                            coords.z - 0.95,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            1.0,
                                                            1.0,
                                                            1.0,
                                                            120,
                                                            0,
                                                            0,
                                                            100
                                                        )
                                                    else
                                                        DrawMarker(
                                                            25,
                                                            PosOfGarage.x,
                                                            PosOfGarage.y,
                                                            PosOfGarage.z,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            nil,
                                                            1.0,
                                                            1.0,
                                                            1.0,
                                                            120,
                                                            0,
                                                            0,
                                                            100
                                                        )
                                                    end
                                                end
                                                if Selected then
                                                    isMarkerEnabled = true
                                                    coords = LocalPlayer().Pos
                                                    PosOfGarage = {x = coords.x, y = coords.y, z = coords.z - 0.95}
                                                end
                                            end
                                        )
                                        if PosOfGarage ~= nil then
                                            if nbrplace == nil then
                                                nbrplace = 1
                                            end
                                            RageUI.List(
                                                "Nombre de place",
                                                {2, 6, 10},
                                                nbrplace,
                                                nil,
                                                {},
                                                true,
                                                function(Hovered, Active, Selected, Index)
                                                    if Active then
                                                        nbrplace = Index
                                                    end
                                                end
                                            )
                                        end
                                        RageUI.Button(
                                            "Prix",
                                            nil,
                                            {
                                                RightLabel = price
                                            },
                                            true,
                                            function(Hovered, Active, Selected)
                                                if Selected then
                                                    amount = KeyboardInput("Entrez le prix de la propriété", nil, 25)
                                                    if tonumber(amount) ~= nil then
                                                        priceAm = amount
                                                        price = amount .. "$"
                                                    end
                                                end
                                            end
                                        )

                                        if price ~= nil then
                                            RageUI.Button(
                                                "Prix de la location",
                                                "Chaque semaine le client devra payer " ..
                                                    math.floor(priceAm / 50) .. "$",
                                                {
                                                    RightLabel = math.floor(priceAm / 50) .. "$"
                                                },
                                                true,
                                                function(Hovered, Active, Selected)
                                                    if Selected then
                                                    end
                                                end
                                            )

                                            RageUI.Button(
                                                "Enregistrer la propriété",
                                                nil,
                                                {},
                                                true,
                                                function(Hovered, Active, Selected)
                                                    if Selected then
                                                        Citizen.CreateThread(
                                                            function()
                                                                for i = 1, 10, 1 do
                                                                    Wait(1)
                                                                    RageUI.GoBack()
                                                                end
                                                            end
                                                        )
                                                        if numberOfHouse ~= nil then
                                                            --TriggerPlayerEvent("add:Appart",-1,json.encode(appartement))
                                                            if PosOfGarage ~= nil then
                                                                PosOfGarage = json.encode(PosOfGarage)
                                                            end
                                                            local ttp = {2, 6, 10}
                                                            appartement = {
                                                                index = PosInLabelAppart,
                                                                price = priceAm,
                                                                priceloc = math.floor(priceAm / 10),
                                                                max = WeightOfPos,
                                                                name = realstreetname .. " " .. numberOfHouse,
                                                                entry = json.encode(PosOfMarker),
                                                                garage = PosOfGarage,
                                                                maxGrg = ttp[nbrplace]
                                                            }
                                                            TriggerServerEvent("core:NewAppartDuSexe", appartement)
                                                        else
                                                            ShowNotification(
                                                                "~r~Vous avez oubliez le numéro de la maison"
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
                    end
                end
            )
        end
    end
)

RegisterNetEvent("core:SyncApparts")
AddEventHandler(
    "core:SyncApparts",
    function()
    end
)

RegisterNetEvent("core:SyncApparts2")
AddEventHandler(
    "core:SyncApparts2",
    function(r)
    end
)
