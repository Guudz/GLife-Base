local VehShop =
    setmetatable(
    {
        -- veh
        {
            Pos = {x = -44.93, y = -1097.68, z = 25.42, a = 70.53},
            SpawnPos = {x = -19.65, y = -1084.61, z = 26.64, h = 69.95},
            Blips = {
                sprite = 225,
                color = 84,
                name = "Concessionnaire SUD"
            },
            Menus = {
                Sprite = "shopui_title_ie_modgarage",
                Enabled = true
            },
            Marker = {
                type = 1,
                scale = {x = 2.5, y = 2.5, z = 0.2},
                color = {r = 255, g = 255, b = 255, a = 120},
                Up = false,
                Cam = false,
                Rotate = false,
                visible = true
            },
            Vehicles = {
                ["Berline"] = {
                    {name = "Primo", price = 9800},
                    {name = "Fugitive", price = 16500},
                    {name = "schafter2", price = 35000},
                    {name = "stretch", price = 80000},
                    {name = "superd", price = 40000},
                    {name = "cognoscenti", price = 70000},
                    {name = "cog55", price = 59000},
                    {name = "surge", price = 6800},
                    {name = "primo2", price = 25000},
                    {name = "tailgater", price = 15000}
                },
                ["Camionette"] = {
                    {name = "Speedo", price = 28000},
                    {name = "speedo2", price = 45000},
                    {name = "speedo4", price = 30000},
                    {name = "rumpo", price = 35000},
                    {name = "minivan2", price = 18000},
                    {name = "pony", price = 36000},
                    {name = "minivan", price = 25000},
                    {name = "pony2", price = 31000},
                    {name = "burrito", price = 32000},
                    {name = "youga3", price = 45000}
                },
                ["Coupé"] = {
                    {name = "windsor2", price = 85000},
                    {name = "windsor", price = 80000},
                    {name = "zion", price = 31000},
                    {name = "zion2", price = 38000},
                    {name = "sentinel2", price = 38000},
                    {name = "f620", price = 75000},
                    {name = "sentinel", price = 35000},
                    {name = "exemplar", price = 150150}
                },
                ["Grosse cylindrée"] = {
                    {name = "buccaneer2", price = 31525},
                    {name = "voodoo", price = 17806},
                    {name = "sabregt2", price = 40500},
                    {name = "moonbeam2", price = 49420},
                    {name = "faction3", price = 27650},
                    {name = "chino2", price = 27450},
                    {name = "faction2", price = 23687},
                    {name = "moonbeam", price = 41639},
                    {name = "hermes", price = 33020},
                    {name = "nightshade", price = 166000},
                    {name = "ellie", price = 221800},
                    {name = "dominator3", price = 256500},
                    {name = "yosemite2", price = 47500},
                    {name = "manana2", price = 23000}
                },
                ["SUV"] = {
                    {name = "baller", price = 39000},
                    {name = "toros", price = 445000},
                    {name = "rocoto", price = 26000},
                    {name = "xls", price = 50000},
                    {name = "patriot2", price = 135000},
                    {name = "rebla", price = 125000},
                    {name = "baller3", price = 80000},
                    {name = "patriot", price = 49250},
                    {name = "baller2", price = 60000},
                    {name = "baller4", price = 85020}
                },
                ["Sportive"] = {
                    {name = "neon", price = 300500},
                    {name = "ruston", price = 90000},
                    {name = "specter", price = 390000},
                    {name = "specter2", price = 520000},
                    {name = "jester", price = 220000},
                    {name = "sultan", price = 150000},
                    {name = "pariah", price = 195000},
                    {name = "Lynx", price = 156000},
                    {name = "jugular", price = 425000},
                    {name = "komoda", price = 395000},
                    {name = "raiden", price = 221000},
                    {name = "rapidgt", price = 157000},
                    {name = "rapidgt2", price = 157000},
                    {name = "massacro2", price = 140000},
                    {name = "kuruma", price = 114000},
                    {name = "massacro", price = 150000},
                    {name = "jester2", price = 180000},
                    {name = "khamelion", price = 157000},
                    {name = "jester", price = 149000},
                    {name = "revolter", price = 229000},
                    {name = "schafter4", price = 140000},
                    {name = "verlierer2", price = 173000},
                    {name = "schafter3", price = 170000},
                    {name = "carbonizzare", price = 97000},
                    {name = "bestiagts", price = 150000},
                    {name = "sentinel3", price = 85000},
                    {name = "seven70", price = 200000},
                    {name = "schlagen", price = 243000},
                    {name = "alpha", price = 65000},
                    {name = "schwarzer", price = 55000},
                    {name = "italigto", price = 480000},
                    {name = "coquette", price = 133000},
                    {name = "elegy2", price = 110000},
                    {name = "comet2", price = 145000},
                    {name = "comet3", price = 257000},
                    {name = "cogcabrio", price = 150000},
                    {name = "banshee", price = 95000},
                    {name = "fusilade", price = 45000},
                    {name = "furoregt", price = 100000}
                },
                ["Sportive classique"] = {
                    {name = "stingergt", price = 315000},
                    {name = "stromberg", price = 445000},
                    {name = "torero", price = 320000},
                    {name = "stinger", price = 275000},
                    {name = "btype", price = 300000},
                    {name = "btype3", price = 268000},
                    {name = "jb700", price = 572000},
                    {name = "ztype", price = 350000},
                    {name = "coquette", price = 280000},
                    {name = "infernus", price = 665000},
                    {name = "turismo2", price = 800000},
                    {name = "zion", price = 55000},
                    {name = "ardent", price = 615000},
                    {name = "cheetah2", price = 800000},
                    {name = "z190", price = 205000},
                    {name = "viseris", price = 340000}
                },
                ["Motos"] = {
                    {name = "akuma", price = 30000}, 
                    {name = "bati", price = 35000},
                    {name = "bf400", price = 40000},
                    {name = "carbonrs", price = 25000},
                    {name = "defiler", price = 25000},
                    {name = "diablous", price = 31000},
                    {name = "diablous2", price = 35000},
                    {name = "double", price = 29000},
                    {name = "faggio", price = 1500},
                    {name = "faggio2", price = 1000},
                    {name = "faggio3", price = 750},
                    {name = "fcr", price = 25000},
                    {name = "fcr2", price = 25000},
                    {name = "hakuchou", price = 45000},
                    {name = "hakuchou2", price = 50000},
                    {name = "lectro", price = 15000},
                    {name = "stryder", price = 46000}, 
                    {name = "rrocket", price = 44000},
                    {name = "nemesis", price = 15000},
                    {name = "pcj", price = 20000},
                    {name = "ruffian", price = 8500},
                    {name = "thrust", price = 15000},
                    {name = "vader", price = 14000},
                    {name = "vindicator", price = 25000},
                    {name = "vortex", price = 22000},
                    {name = "cliffhanger", price = 28000},
                    {name = "enduro", price = 20000},
                    {name = "esskey", price = 15000},
                    {name = "deathbike", price = 15000},
                    {name = "Gargoyle", price = 30000},
                    {name = "manchez", price = 11000},
                    {name = "manchez2", price = 9000},
                    {name = "sanchez", price = 9500},
                    {name = "sanchez2", price = 10000},
                    {name = "avarus", price = 16000},
                    {name = "bagger", price = 7500},
                    {name = "chimera", price = 18000},
                    {name = "daemon", price = 10000},
                    {name = "daemon2", price = 10500},
                    {name = "hexer", price = 10250},
                    {name = "innovation", price = 9850},
                    {name = "nightblade", price = 30000},
                    {name = "ratbike", price = 6500},
                    {name = "sanctus", price = 25000},
                    {name = "sovereign", price = 15000},
                    {name = "wolfsbane", price = 9500},
                    {name = "zombiea", price = 17000},
                    {name = "zombieb", price = 17000},
                },
                ["Supersportive"] = {
                    {name = "Osiris", price = 980000},
                    {name = "penetrator", price = 800000},
                    {name = "nero2", price = 1110500}, 
                    {name = "reaper", price = 850000}, 
                    {name = "nero", price = 995000},
                    {name = "italigto", price = 1000000},
                    {name = "gp1", price = 785000},
                    {name = "italigtb", price = 905000},
                    {name = "fmj", price = 950000},
                    {name = "turismor", price = 900000},
                    {name = "sultanrs", price = 280000},
                    {name = "tezeract", price = 1300000},
                    {name = "tyrant", price = 1000000},
                    {name = "infernus", price = 315000},
                    {name = "tyrus", price = 905000},
                    {name = "sc1", price = 615000},
                    {name = "tempesta", price = 520000},
                    {name = "taipan", price = 980000},
                    {name = "vacca", price = 450000},
                    {name = "entityxf", price = 615000},
                    {name = "cheetah", price = 830000},
                    {name = "bullet", price = 650000},
                    {name = "cyclone", price = 930000},
                    {name = "adder", price = 880000},
                    {name = "pfister811", price = 860000},
                    {name = "vagner", price = 920000},
                    {name = "voltic", price = 250000},
                    {name = "krieger", price = 1250000},
                    {name = "visione", price = 925000},
                    {name = "zentorno", price = 980000},
                    {name = "autarch", price = 945000},
                    {name = "prototipo", price = 1250000}
                },
                ["Tout-Terrain"] = {
                    {name = "bifta", price = 8000},
                    {name = "blazer4", price = 4500},
                    {name = "freecrawler", price = 85000},
                    {name = "kalahari", price = 3500}
                },
                ["Donation"] = {
                    {name = "rmodbolide", price = 0},
                    {name = "rmodbugatti", price = 0},
                    {name = "rmodcharger69", price = 0},
                    {name = "rmodf40", price = 0},
                    {name = "rmodgtr50", price = 0},
                    {name = "rmodjeep", price = 0},
                    {name = "rmodm5e34", price = 0},
                    {name = "rmodmk7", price = 0},
                    {name = "rmodskyline34", price = 0},
                    {name = "rmodzl1", price = 0},
                    {name = "18performante", price = 0},
                    {name = "rmodf12tdf", price = 0}
                },
                ["Entreprise"] = {
                    {name = "ambulance", price = 2500},
                    {name = "taxi", price = 5000},
                    {name = "sheriff2", price = 2500},
                    {name = "police", price = 2500},
                    {name = "police2", price = 2500},
                    {name = "police3", price = 2500},
                    {name = "police4", price = 2500},
                    {name = "policeb", price = 2500},
                    {name = "policet", price = 2500},
                    {name = "flatbed", price = 95000},
                    {name = "towtruck2", price = 25000},
                    {name = "towtruck", price = 45000},
                    {name = "mule4", price = 150000}
                },
                ["Velos"] = {
                    {name = "bmx", price = 245},
                    {name = "cruiser", price = 560},
                    {name = "fixter", price = 595},
                    {name = "scorcher", price = 700},
                    {name = "tribike", price = 1260},
                    {name = "tribike2", price = 1260},
                    {name = "tribike3", price = 1260}
                }
            }
        }
    },
    VehShop
)

function VehShop:CreateShops()
    for i = 1, #self, 1 do
        Wait(540)
        v = self[i]
        Zone:Add(v.Pos, self.EnterZone, self.ExitZone, i, 2.5)
        RMenu.Add(
            "VehShop",
            i,
            RageUI.CreateMenu(nil, "Catégories disponibles", 10, 20, v.Menus.Sprite, v.Menus.Sprite)
        )
        Marker:Add(v.Pos, v.Marker)

        for k, v in pairs(v.Vehicles) do
            RMenu.Add("VehShop_sub", k, RageUI.CreateSubMenu(RMenu:Get("VehShop", i), nil, k))
        end
        RMenu.Add("VehShop_sub", "list", RageUI.CreateSubMenu(RMenu:Get("VehShop", i), nil, "Actions disponibles"))
        RMenu.Add(
            "VehShop_sub",
            "playerList",
            RageUI.CreateSubMenu(RMenu:Get("VehShop_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "VehShop_sub",
            "joblist",
            RageUI.CreateSubMenu(RMenu:Get("VehShop_sub", "list"), nil, "Listes des joueurs")
        )
    end
end

local CurrentZone = nil

function VehShop.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", VehShop.Open, "VehShop")
    KeySettings:Add("controller", 46, VehShop.Open, "VehShop")
    CurrentZone = zone
end

function VehShop.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "VehShop")
        KeySettings:Clear("controller", 46, "VehShop")
        Marker:Visible(VehShop[CurrentZone].Pos, true)
        VehShop.Close()
        CurrentZone = nil
    end
end

function VehShop.Open()
    RageUI.Visible(RMenu:Get("VehShop", CurrentZone), true)
    Marker:Visible(VehShop[CurrentZone].Pos, false)
end

function VehShop.Close()
    if RageUI.Visible(RMenu:Get("VehShop", CurrentZone)) then
        RageUI.Visible(RMenu:Get("VehShop", CurrentZone), false)
    end
end

local currentHeader = true
local currentveh = 0
local function DrawVehicle(vehicleName)
    local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
    if veh ~= nil then
        DeleteEntity(veh)
    end
    vehicleFct.SpawnLocalVehicle(
        vehicleName,
        VehShop[CurrentZone].Pos,
        VehShop[CurrentZone].Pos.h,
        function(veh)
            SetPedIntoVehicle(LocalPlayer().Ped, veh, -1)
            FreezeEntityPosition(veh, true)
            SetVehicleDoorsLocked(veh, 4)
            currentveh = veh
        end
    )
--       SetEntityVisible(LocalPlayer().Ped, false)
    t = vehicleFct.GetVehiclesInArea(VehShop[CurrentZone].Pos, 8.0)

    for i = 1, #t, 1 do
        DeleteEntity(t[i])
    end
    RMenu:Get("VehShop", CurrentZone).Closed = function()
        SetEntityVisible(LocalPlayer().Ped, true)
        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
        if veh ~= nil then
            DeleteEntity(veh)
        end
        t = vehicleFct.GetVehiclesInArea(VehShop[CurrentZone].Pos, 8.0)
        Marker:Visible(VehShop[CurrentZone].Pos, true)
        for i = 1, #t, 1 do
            DeleteEntity(t[i])
        end
    end
end
local CurrentVehicle = nil
local menu = nil
local currentInd = {}
local amountVeh = nil
Citizen.CreateThread(
    function()
        Wait(100)
        VehShop:CreateShops()
        while true do
            Wait(1)
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("VehShop", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            for k, v in pairs(VehShop[CurrentZone].Vehicles) do
                                RageUI.Button(
                                    k,
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            CurrentVehicle = v[1].name
                                            if IsModelValid(v[1].name) then
                                                DrawVehicle(v[1].name)
                                            end
                                        end
                                    end,
                                    RMenu:Get("VehShop_sub", k)
                                )
                            end
                        end,
                        function()
                        end
                    )
                else
                    if RageUI.Visible(RMenu:Get("VehShop_sub", "playerList")) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                for k, v in pairs(GetActivePlayers()) do
                                    local i = v
                                    RageUI.Button(
                                        GetPlayerName(i),
                                        nil,
                                        {},
                                        true,
                                        function(_, Active, Selected)
                                            if Selected then
                                                TriggerServerCallback(
                                                    "getBankingAccountsPly3",
                                                    function(result)
                                                        amount = result[1].amount
                                                        local iban = result[1].iban
                                                        if amount - amountVeh >= 0 then
                                                            TriggerServerEvent("bankingRemoveFromAccount2","concess",amountVeh)
                                                            print("am")
                                                            local veh =
                                                                vehicleFct.GetVehicleProperties(
                                                                GetVehiclePedIsIn(LocalPlayer().Ped)
                                                            )
                                                            --(veh.model)
                                                            TriggerServerEvent(
                                                                "newTransaction",
                                                                "concess",
                                                                "gouvernement",
                                                                amountVeh,
                                                                "Achat véhicule concess " .. veh.label
                                                            )
                                                            TriggerServerEvent(
                                                                "bankingSendMoney",
                                                                "gouvernement",
                                                                amountVeh,
                                                                iban
                                                            )

                                                            veh.plate = vehicleFct.GetUniquePlate()

                                                            TriggerServerCallback("vehicleshop:BuyVehicle", function(bool)
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    if bool then
                                                                        vehicleFct.SpawnVehicle(veh.model, VehShop[CurrentZone].SpawnPos, VehShop[CurrentZone].SpawnPos.h, function(_veh)
                                                                                SetPedIntoVehicle(LocalPlayer().Ped, _veh, -1)
                                                                                --FreezeEntityPosition(veh,true)
                                                                                --SetVehicleDoorsLocked(veh,4)
                                                                                vehicleFct.SetVehicleProperties(_veh, veh)
		                                                                        TriggerEvent('persistent-vehicles/register-vehicle', _veh)
                                                                                currentveh = veh
                                                                            end
                                                                        )
                                                                    end

                                                                    items = {
                                                                        name = "key",
                                                                        data = {plate = veh.plate},
                                                                        label = veh.plate
                                                                    }
                                                                    AddItemtoInv(items)
                                                                    CloseAllMenus()
                                                                end, currentInd.price, GetPlayerServerId(i), veh)
                                                        else
                                                            RageUI.Popup(
                                                                {
                                                                    message = "Les fonds de la société ne sont pas suffisants pour l'achat de ce véhicule"
                                                                }
                                                            )
                                                        end
                                                    end,
                                                    "concess"
                                                )
                                            end
                                        end
                                    )
                                end
                            end,
                            function()
                            end
                        )
                    end
                    if RageUI.Visible(RMenu:Get("VehShop_sub", "joblist")) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                for k, v in pairs(Jobs) do
                                    RageUI.Button(
                                        v.label,
                                        nil,
                                        {},
                                        true,
                                        function(_, Active, Selected)
                                            if Selected then
                                                TriggerServerCallback(
                                                    "getBankingAccountsPly3",
                                                    function(result)
                                                        amount = result[1].amount
                                                        if amount - amountVeh >= 0 then
                                                            local veh =
                                                                vehicleFct.GetVehicleProperties(
                                                                GetVehiclePedIsIn(LocalPlayer().Ped)
                                                            )
                                                            TriggerServerEvent(
                                                                "bankingRemoveFromAccount2",
                                                                "concess",
                                                                amountVeh
                                                            )

                                                            veh.plate = vehicleFct.GetUniquePlate()

                                                            TriggerServerCallback(
                                                                "vehicleshop:BuyVehicleForCompany",
                                                                function(bool)
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))

                                                                    TriggerServerEvent(
                                                                        "newTransaction",
                                                                        "concess",
                                                                        "gouvernement",
                                                                        amountVeh,
                                                                        "Achat véhicule concess " .. veh.label
                                                                    )
                                                                    TriggerServerEvent(
                                                                        "bankingSendMoney",
                                                                        "gouvernement",
                                                                        amountVeh,
                                                                        "concess"
                                                                    )

                                                                    if bool then
                                                                        vehicleFct.SpawnVehicle(
                                                                            veh.model,
                                                                            VehShop[CurrentZone].SpawnPos,
                                                                            VehShop[CurrentZone].SpawnPos.h,
                                                                            function(_veh)
                                                                                SetPedIntoVehicle(
                                                                                    LocalPlayer().Ped,
                                                                                    _veh,
                                                                                    -1
                                                                                )
                                                                                --FreezeEntityPosition(veh,true)
                                                                                --SetVehicleDoorsLocked(veh,4)
                                                                                vehicleFct.SetVehicleProperties(_veh, veh)
                                                                                TriggerEvent('persistent-vehicles/register-vehicle', _veh)
                                                                                currentveh = veh
                                                                            end
                                                                        )
                                                                    end

                                                                    items = {
                                                                        name = "key",
                                                                        data = {plate = veh.plate},
                                                                        label = veh.plate
                                                                    }
                                                                    AddItemtoInv(items)
                                                                    -- SetEntityVisible(PlayerPedId(),true)
                                                                    CloseAllMenus()
                                                                end,
                                                                currentInd.price,
                                                                k,
                                                                veh
                                                            )
                                                        else
                                                            RageUI.Popup(
                                                                {
                                                                    message = "Les fonds de la société ne sont pas suffisants pour l'achat de ce véhicule"
                                                                }
                                                            )
                                                        end
                                                    end,
                                                    "concess"
                                                )
                                            end
                                        end
                                    )
                                end
                            end,
                            function()
                            end
                        )
                    end
                    if RageUI.Visible(RMenu:Get("VehShop_sub", "list")) then
                        RageUI.DrawContent(
                            {header = true, glare = false},
                            function()
                                RageUI.Button(
                                    "Joueurs",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("VehShop_sub", "playerList")
                                )

                                RageUI.Button(
                                    "Métiers",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("VehShop_sub", "joblist")
                                )

                                RageUI.Button(
                                    "Sortir le véhicule",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                        if Selected then
                                            CloseAllMenus()
                                            local veh =
                                                vehicleFct.GetVehicleProperties(GetVehiclePedIsIn(LocalPlayer().Ped))
                                            vehicleFct.SpawnVehicle(
                                                veh.model,
                                                VehShop[CurrentZone].SpawnPos,
                                                VehShop[CurrentZone].SpawnPos.h,
                                                function(_veh)
                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                    SetPedIntoVehicle(LocalPlayer().Ped, _veh, -1)
                                                    --FreezeEntityPosition(veh,true)
                                                    SetVehicleNumberPlateText(_veh, "CONCESS")
                                                    vehicleFct.SetVehicleProperties(_veh, veh)
                                                    --    SetEntityVisible(LocalPlayer().Ped,true)
                                                    currentveh = veh
                                                end
                                            )
                                            CloseAllMenus()
                                        end
                                    end
                                )
                            end,
                            function()
                            end
                        )
                    end
                    for k, v in pairs(VehShop[CurrentZone].Vehicles) do
                        if RageUI.Visible(RMenu:Get("VehShop_sub", k)) then
                            RageUI.DrawContent(
                                {header = true, glare = false},
                                function()
                                    for i = 1, #v, 1 do
                                        p = "~r~MASQUÉ"
                                        if isAnyJob("concess") then
                                            p = v[i].price .. "$"
                                        end
                                        RageUI.Button(
                                            GetLabelText(GetDisplayNameFromVehicleModel(v[i].name)),
                                            nil,
                                            {RightLabel = p},
                                            true,
                                            function(_, Active, Selected)
                                                if isAnyJob("concess") then
                                                    menu = RMenu:Get("VehShop_sub", "list")
                                                else
                                                    menu = nil
                                                end
                                                if Active then
                                                    --         Citizen.CreateThread(function()
                                                    if IsModelValid(v[i].name) and CurrentVehicle ~= v[i].name then
                                                        --("oload")
                                                        RequestModel(v[i].name)

                                                        while not HasModelLoaded(v[i].name) do
                                                            Citizen.Wait(0)
                                                        end
                                                        CurrentVehicle = v[i].name
                                                        DrawVehicle(CurrentVehicle)

                                                        if (type(v[i].name) == "string") then
                                                            SetModelAsNoLongerNeeded(GetHashKey(v[i].name))
                                                        else
                                                            SetModelAsNoLongerNeeded(v[i].name)
                                                        end
                                                    end
                                                --       end)
                                                end

                                                if Selected then
                                                    if isAnyJob("concess") then
                                                        amountVeh = v[i].price
                                                        menu = RMenu:Get("VehShop_sub", "list")
                                                        currentInd = v[i]
                                                    else
                                                        menu = nil
                                                        RageUI.Popup(
                                                            {message = "Merci de contacter un ~b~concessionnaire"}
                                                        )
                                                    end
                                                end
                                            end,
                                            menu
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
        end
    end
)
