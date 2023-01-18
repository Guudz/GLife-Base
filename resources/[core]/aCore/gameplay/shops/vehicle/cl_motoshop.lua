local bikershop =
    setmetatable(
    {
        -- veh
        {
            Pos = {x = -879.37, y = -2997.93, z = 12.95, a = 154.39},
            SpawnPos = {x = -879.37, y = -2997.93, z = 12.95, h = 94.96},
            Blips = {
                sprite = 494,
                color = 5,
                name = "Concessionnaire Avion"
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
                ["Avion"] = {
                    {name = "SEASPARROW", price = 10}, 
                    {name = "luxor", price = 10}, 
                    {name = "MAVERICK", price = 10},
                    {name = "HAVOK", price = 10},
                    {name = "VOLATUS", price = 10},
                    {name = "SWIFT", price = 10},
                }
            }
        }
    },
    bikershop
)

function bikershop:CreateShops()
    for i = 1, #self, 1 do
        Wait(540)
        v = self[i]
        Zone:Add(v.Pos, self.EnterZone, self.ExitZone, i, 2.5)
        RMenu.Add(
            "bikershop",
            i,
            RageUI.CreateMenu(nil, "Catégories disponibles", 10, 20, v.Menus.Sprite, v.Menus.Sprite)
        )
        Marker:Add(v.Pos, v.Marker)

        for k, v in pairs(v.Vehicles) do
            RMenu.Add("bikershop_sub", k, RageUI.CreateSubMenu(RMenu:Get("bikershop", i), nil, k))
        end
        RMenu.Add("bikershop_sub", "list", RageUI.CreateSubMenu(RMenu:Get("bikershop", i), nil, "Actions disponibles"))
        RMenu.Add(
            "bikershop_sub",
            "playerList",
            RageUI.CreateSubMenu(RMenu:Get("bikershop_sub", "list"), nil, "Listes des joueurs")
        )
        RMenu.Add(
            "bikershop_sub",
            "joblist",
            RageUI.CreateSubMenu(RMenu:Get("bikershop_sub", "list"), nil, "Listes des joueurs")
        )
    end
end

local CurrentZone = nil

function bikershop.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", bikershop.Open, "bikershop")
    KeySettings:Add("controller", 46, bikershop.Open, "bikershop")
    CurrentZone = zone
end

function bikershop.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "bikershop")
        KeySettings:Clear("controller", 46, "bikershop")
        Marker:Visible(bikershop[CurrentZone].Pos, true)
        bikershop.Close()
        CurrentZone = nil
    end
end

function bikershop.Open()
    RageUI.Visible(RMenu:Get("bikershop", CurrentZone), true)
    Marker:Visible(bikershop[CurrentZone].Pos, false)
end

function bikershop.Close()
    if RageUI.Visible(RMenu:Get("bikershop", CurrentZone)) then
        RageUI.Visible(RMenu:Get("bikershop", CurrentZone), false)
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
        bikershop[CurrentZone].Pos,
        bikershop[CurrentZone].Pos.h,
        function(veh)
            SetPedIntoVehicle(LocalPlayer().Ped, veh, -1)
            FreezeEntityPosition(veh, true)
            SetVehicleDoorsLocked(veh, 4)
            currentveh = veh
        end
    )
    --   SetEntityVisible(LocalPlayer().Ped, false)
    t = vehicleFct.GetVehiclesInArea(bikershop[CurrentZone].Pos, 8.0)

    for i = 1, #t, 1 do
        DeleteEntity(t[i])
    end
    RMenu:Get("bikershop", CurrentZone).Closed = function()
        --SetEntityVisible(LocalPlayer().Ped, true)
        local veh = GetVehiclePedIsIn(LocalPlayer().Ped)
        if veh ~= nil then
            DeleteEntity(veh)
        end
        t = vehicleFct.GetVehiclesInArea(bikershop[CurrentZone].Pos, 8.0)
        Marker:Visible(bikershop[CurrentZone].Pos, true)
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
        bikershop:CreateShops()
        while true do
            Wait(1)
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("bikershop", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            for k, v in pairs(bikershop[CurrentZone].Vehicles) do
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
                                    RMenu:Get("bikershop_sub", k)
                                )
                            end
                        end,
                        function()
                        end
                    )
                else
                    if RageUI.Visible(RMenu:Get("bikershop_sub", "playerList")) then
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
                                                            TriggerServerEvent("bankingRemoveFromAccount2","bikershop",amountVeh)

                                                            local veh =
                                                                vehicleFct.GetVehicleProperties(
                                                                GetVehiclePedIsIn(LocalPlayer().Ped)
                                                            )
                                                            --(veh.model)
                                                            TriggerServerEvent(
                                                                "newTransaction",
                                                                "bikershop",
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

                                                            TriggerServerCallback(
                                                                "bikershop:BuyVehicle",
                                                                function(bool)
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))
                                                                    if bool then
                                                                        vehicleFct.SpawnVehicle(
                                                                            veh.model,
                                                                            bikershop[CurrentZone].SpawnPos,
                                                                            bikershop[CurrentZone].SpawnPos.h,
                                                                            function(_veh)
                                                                                SetPedIntoVehicle(
                                                                                    LocalPlayer().Ped,
                                                                                    _veh,
                                                                                    -1
                                                                                )
                                                                                --FreezeEntityPosition(veh,true)
                                                                                --SetVehicleDoorsLocked(veh,4)
                                                                                vehicleFct.SetVehicleProperties(
                                                                                    _veh,
                                                                                    veh
                                                                                )
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
                                                                end,
                                                                currentInd.price,
                                                                GetPlayerServerId(i),
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
                                                    "bikershop"
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
                    if RageUI.Visible(RMenu:Get("bikershop_sub", "joblist")) then
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
                                                                "bikershop",
                                                                amountVeh
                                                            )

                                                            veh.plate = vehicleFct.GetUniquePlate()

                                                            TriggerServerCallback(
                                                                "bikershop:BuyVehicle",
                                                                function(bool)
                                                                    CloseAllMenus()
                                                                    DeleteEntity(GetVehiclePedIsIn(LocalPlayer().Ped))

                                                                    TriggerServerEvent(
                                                                        "newTransaction",
                                                                        "bikershop",
                                                                        "gouvernement",
                                                                        amountVeh,
                                                                        "Achat véhicule concess " .. veh.label
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
                                                                                vehicleFct.SetVehicleProperties(
                                                                                    _veh,
                                                                                    veh
                                                                                )
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
                                                    "bikershop"
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
                    if RageUI.Visible(RMenu:Get("bikershop_sub", "list")) then
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
                                    RMenu:Get("bikershop_sub", "playerList")
                                )

                                RageUI.Button(
                                    "Métiers",
                                    nil,
                                    {},
                                    true,
                                    function(_, Active, Selected)
                                    end,
                                    RMenu:Get("bikershop_sub", "joblist")
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
                                                bikershop[CurrentZone].SpawnPos,
                                                bikershop[CurrentZone].SpawnPos.h,
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
                    for k, v in pairs(bikershop[CurrentZone].Vehicles) do
                        if RageUI.Visible(RMenu:Get("bikershop_sub", k)) then
                            RageUI.DrawContent(
                                {header = true, glare = false},
                                function()
                                    for i = 1, #v, 1 do
                                        p = "~r~MASQUÉ"
                                        if isAnyJob("bikershop") then
                                            p = v[i].price .. "$"
                                        end
                                        RageUI.Button(
                                            GetLabelText(GetDisplayNameFromVehicleModel(v[i].name)),
                                            nil,
                                            {RightLabel = p},
                                            true,
                                            function(_, Active, Selected)
                                                if isAnyJob("bikershop") then
                                                    menu = RMenu:Get("bikershop_sub", "list")
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
                                                    end
                                                --       end)
                                                end

                                                if Selected then
                                                    if isAnyJob("bikershop") then
                                                        amountVeh = v[i].price
                                                        menu = RMenu:Get("bikershop_sub", "list")
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