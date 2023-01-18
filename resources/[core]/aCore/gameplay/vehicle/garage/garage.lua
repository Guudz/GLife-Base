Garage = setmetatable({}, Garage)
Garage.__index = Garage
Garage.__call = function()
    return "Garage"
end
local currentSelf = {}
local MYVEHJOB = nil
local tempPos = nil
local inG = false
DecorRegister("isJob", 3)
local veh99 = {}
local platesList = {}
function Garage.New(name, pos, properties, blipdata)
    local GarageProperties = {
        name = name,
        pos = pos,
        properties = properties,
        blipdata = blipdata
    }
    return setmetatable(GarageProperties, Garage)
end
local Interiors = {
    [2] = vector3(179.04, -1000.36, -99.65707),
    [3] = vector3(-2041.00, 3172.17, 32.81),
    [6] = vector3(207.16, -999.2, -99.65749),
    [10] = vector3(237.29, -1004.83, -99.66071),
    [64] = vector3(454.85, -772.1, 16.42)
}
local function Open()
    --print("trying to enter")
    if currentSelf and currentSelf.properties ~= nil then
        currentSelf:Refresh()
        RageUI.Refresh()
    end
end
--print("oo")
function Garage:Refresh()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if currentSelf.properties.type == 2 then
        if veh ~= 0 and DecorGetInt(veh, "isJob") then
            return vehicleFct.DeleteVehicle(veh)
        end
        local i = 1
        DecorSetInt(veh, "isJob", 1)
        local t = vehicleFct.GetVehiclesInArea(currentSelf.properties.spawnpos, 5.0)
        if #t > 0 then
            RageUI.Popup({message = "~r~La zone est occupée"})
        else
            vehicleFct.SpawnVehicle(
                self.properties.vehicles[i].name,
                self.properties.spawnpos,
                self.properties.spawnpos.h,
                function(veh)
                    vehicleFct.SetVehicleProperties(veh, currentSelf.properties.vehicles[i].tuning)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    MYVEHJOB = veh
                    DecorSetInt(veh, "isJob", 1)
                    RageUI.Visible(RMenu:Get("garage", self.name), false)

                    local vehicles = GetMyVehicles()

                    table.insert(vehicles.preter, {plate = GetVehicleNumberPlateText(veh), label = "clé société"})
                end
            )
            TriggerServerEvent("Garage:SortirVehicule", currentSelf.properties.vehicles[i].id)
            CloseAllMenus()
        end
    else
        tempPos = GetEntityCoords(PlayerPedId())
        currentSelf.properties.Limit = tonumber(currentSelf.properties.Limit)
        if self.properties.vehicles == nil then
            self.properties.vehicles = {}
        end
        local m = fals

        DoScreenFadeOut(0)
        local rdy = false
        if self.properties.type == 1 then
            for i = 1, #self.properties.vehicles, 1 do
                if self.properties.vehicles[i] ~= nil then
                    if self.properties.vehicles[i].job then
                        table.insert(m, self.properties.vehicles[i])
                    end
                end
                rdy = true
            end
            self.properties.vehicles = m
        else
            self.properties.vehicles = {}
        end
        if self.properties.type == 1 or self.properties.type == 0 then
            TriggerServerCallback(
                "garage:GetVehicle",
                function(data)
                    if data ~= nil then
                        for i = 1, #data, 1 do
                            table.insert(self.properties.vehicles, data[i])
                        end
                    end
                    rdy = true
                end,
                self.name
            )
        end
        if self.properties.type == 3 then
            TriggerServerCallback(
                "garage:GetVehicle2",
                function(data)
                    if data ~= nil then
                        for i = 1, #data, 1 do
                            table.insert(self.properties.vehicles, data[i])
                        end
                    end
                    rdy = true
                end,
                self.name
            )
        end
        while not rdy do
            Wait(0)
        end

        --print(#self.properties.vehicles, " / " ,self.properties.Limit)
        if veh ~= 0 then
            if veh ~= 0 then
                if #self.properties.vehicles + 1 <= self.properties.Limit then
                    if DecorGetInt(veh, "isJob") == 0 then
                        TriggerServerEvent("Garage:StockVehicle", vehicleFct.GetVehicleProperties(veh), self.name)
                    else
                        MYVEHJOB = nil
                    end
                    vehicleFct.DeleteVehicle(veh)
                    Wait(500)
                else
                    DoScreenFadeIn(0)
                    RageUI.Popup({message = "~r~Il n'y a plus de place dans votre garage"})
                    return
                end
            end
        end
        local m = {}
        RageUI.Refresh()

        if self.properties.type == 1 then
            for i = 1, #self.properties.vehicles, 1 do
                if self.properties.vehicles[i] ~= nil then
                    if self.properties.vehicles[i].job then
                        table.insert(m, self.properties.vehicles[i])
                    end
                end
                rdy = true
            end
            self.properties.vehicles = m
        else
            self.properties.vehicles = {}
        end
        if self.properties.type == 1 or self.properties.type == 0 then
            TriggerServerCallback(
                "garage:GetVehicle",
                function(data)
                    if data ~= nil then
                        for i = 1, #data, 1 do
                            table.insert(self.properties.vehicles, data[i])
                        end
                    end
                    rdy = true
                end,
                self.name
            )
        end
        if self.properties.type == 3 then
            TriggerServerCallback(
                "garage:GetVehicle2",
                function(data)
                    if data ~= nil then
                        for i = 1, #data, 1 do
                            table.insert(self.properties.vehicles, data[i])
                        end
                    end
                    rdy = true
                end,
                self.name
            )
        end

        TriggerEvent("localInstance", "grg")

        LoadInterior(GetInteriorAtCoords(Interiors[self.properties.Limit]))

        while not IsInteriorReady(GetInteriorAtCoords(Interiors[self.properties.Limit])) do
            Wait(1)
        end
        SetEntityCoords(PlayerPedId(), Interiors[self.properties.Limit])
        KeySettings:Clear("keyboard", "E", "grg" .. self.name)
        KeySettings:Clear("controller", "E", "grg" .. self.name)
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        for i = 1, 10, 1 do
            Wait(0)
            RageUI.GoBack()
        end
        Hint:RemoveAll()
        Citizen.CreateThread(
            function()
                Wait(40)
                Hint:RemoveAll()
            end
        )

        RageUI.Refresh()
        local waiting = 0

        while tablelength(self.properties.vehicles) == 0 and waiting < 50 do
            Wait(40)
            waiting = waiting + 1
            if currentSelf == nil then
                break
            end
        end
        RenderVehicle()

        KeySettings:Add(
            "keyboard",
            "L",
            function()
                CloseAllMenus()
                Wait(200)
                RageUI.Visible(RMenu:Get("garage", "lists"), true)
            end,
            "MenuGarage"
        )
        DoScreenFadeIn(0)
    end
end

function Garage:Setup()
    RageUI.Refresh()
    Zone:Add(
        self.pos,
        function()
            currentSelf = self
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour rentrer dans le garage")
            KeySettings:Add("keyboard", "E", Open, "grg" .. self.name)
            KeySettings:Add("controller", 46, Open, "grg" .. self.name)
        end,
        function()
            Hint:RemoveAll()
            KeySettings:Clear("keyboard", "E", "grg" .. self.name)
            KeySettings:Clear("controller", "E", "grg" .. self.name)
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.Visible(RMenu:Get("garage", self.name), false)
            RageUI.Visible(RMenu:Get("garage", self.name .. "_manage"), false)
            currentSelf = {}
            for i = 1, 10, 1 do
                Wait(0)
                RageUI.GoBack()
            end
        end,
        k,
        3.5
    )
    RMenu.Add("garage", self.name, RageUI.CreateMenu(nil, "Véhicules", 10, 100))
    RMenu.Add(
        "garage",
        self.name .. "_manage",
        RageUI.CreateSubMenu(RMenu:Get("garage", self.name), nil, "Actions disponibles", 10, 100)
    )
    local blip = AddBlipForCoord(self.pos.x, self.pos.y, self.pos.z)
    if self.blipdata.BlipId == nil then
        self.blipdata.BlipId = 357
    end
    self.pos.z = self.pos.z - 1
    Marker:Add(
        self.pos,
        {
            type = 23,
            scale = {x = 1.5, y = 1.5, z = 0.2},
            color = {r = 255, g = 255, b = 255, a = 120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        }
    )
    SetBlipSprite(blip, self.blipdata.BlipId)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, self.blipdata.Blipcolor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(self.blipdata.Blipname)
    EndTextCommandSetBlipName(blip)
end
RMenu.Add("garage", "lists", RageUI.CreateMenu(nil, "Véhicules", 10, 100))
local function TRefresh()
    if currentSelf ~= nil then
        currentSelf:Refresh()
    end
end
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            local self = currentSelf

            --        if currentSelf ~= nil and currentSelf.name ~= nil then --if currentSelf ~= nil and currentSelf.name ~= nil then
            if RageUI.Visible(RMenu:Get("garage", "lists")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        if self == nil then
                            ShowNotification("~r~Sortez du garage et revenez")
                        else
                            for i = 1, #self.properties.vehicles, 1 do
                                local veh = json.decode(self.properties.vehicles[i].vehicles)
                                RageUI.Button(
                                    self.properties.vehicles[i].label,
                                    nil,
                                    {RightLabel = veh.plate},
                                    true,
                                    function(_, Active, Selected)
                                        if Selected then
                                            local m = veh.model
                                            local found = false
                                            local rdy = false
                                            local p = veh
                                            if self.properties.type == 1 then
                                                for i = 1, #self.properties.vehicles, 1 do
                                                    if self.properties.vehicles[i] ~= nil then
                                                        if self.properties.vehicles[i].job then
                                                            table.insert(m, self.properties.vehicles[i])
                                                        end
                                                    end
                                                    rdy = true
                                                end
                                                self.properties.vehicles = m
                                            else
                                                self.properties.vehicles = {}
                                            end
                                            if self.properties.type == 1 or self.properties.type == 0 then
                                                TriggerServerCallback(
                                                    "garage:GetVehicle",
                                                    function(data)
                                                        if data ~= nil then
                                                            for i = 1, #data, 1 do
                                                                table.insert(self.properties.vehicles, data[i])
                                                            end
                                                        end
                                                        rdy = true
                                                    end,
                                                    self.name
                                                )
                                            end
                                            if self.properties.type == 3 then
                                                TriggerServerCallback(
                                                    "garage:GetVehicle2",
                                                    function(data)
                                                        if data ~= nil then
                                                            for i = 1, #data, 1 do
                                                                table.insert(self.properties.vehicles, data[i])
                                                            end
                                                        end
                                                        rdy = true
                                                    end,
                                                    self.name
                                                )
                                            end
                                            while rdy == false do
                                                Wait(1)
                                                print("wait")
                                            end

                                            SetEntityCoords(PlayerPedId(), tempPos)
                                            ShowNotification(
                                                "~w~Le véhicule est en train de sortir. ~r~Veuillez patienter"
                                            )
                                            Wait(1000)

                                            vehicleFct.SpawnVehicle(m, tempPos, 0, function(veh)
                                                    vehicleFct.SetVehicleProperties(veh, p)
                                                    ClearPedTasksImmediately(PlayerPedId())
                                                    SetVehicleOnGroundProperly(veh)
                                                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                                    SetVehicleNumberPlateText(veh, p.plate)
                                                    TriggerEvent('persistent-vehicles/register-vehicle', veh)


                                                    local vehicleHashKey = p.model .. "|" .. p.plate
                                                    TriggerServerEvent("Garage:RemoveVehicule", currentSelf.name, vehicleHashKey)
                
                                                    TriggerEvent("exitInstance")
                                                end
                                            )
                                            inG = false
                                            KeySettings:Clear("keyboard", "L", "MenuGarage")
                                            for i = 1, #veh99 do
                                                if type(veh99[i]) ~= "vector3" then
                                                    vehicleFct.DeleteVehicle(veh99[i].model)
                                                end
                                            end
                                            veh99 = {}
                                            CloseAllMenus()
                                        end
                                    end
                                )
                            end
                        end
                    end
                )
            end
            -- end
        end
    end
)

function Garage:Selfservice()
    for i = 1, #self.properties.vehicles, 1 do
        if self.properties.vehicles[i] ~= nil then
            RageUI.Button(
                self.properties.vehicles[i].label,
                nil,
                {},
                true,
                function(_, Active, Selected)
                    if Selected then
                        local t = vehicleFct.GetVehiclesInArea(self.properties.spawnpos, 5.0)
                        if #t > 0 then
                            RageUI.Popup({message = "~r~La zone est occupée"})
                        else
                            if self.properties.vehicles[i].job then
                                if MYVEHJOB == nil then
                                    vehicleFct.SpawnVehicle(
                                        self.properties.vehicles[i].name,
                                        self.properties.spawnpos,
                                        self.properties.spawnpos.h,
                                        function(veh)
                                            vehicleFct.SetVehicleProperties(
                                                veh,
                                                currentSelf.properties.vehicles[i].tuning
                                            )
                                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                            MYVEHJOB = veh
                                            DecorSetInt(veh, "isJob", 1)

                                            RageUI.Visible(RMenu:Get("garage", self.name), false)

                                            local vehicles = GetMyVehicles()

                                            table.insert(
                                                vehicles.preter,
                                                {plate = GetVehicleNumberPlateText(veh), label = "clé société"}
                                            )
                                        end
                                    )
                                else
                                    ShowNotification("~r~Vous avez déjà sorti un véhicule")
                                end
                            else
                                local veh = json.decode(self.properties.vehicles[i].vehicles)

                                local t = vehicleFct.GetVehiclesInArea(self.properties.spawnpos, 5.0)
                                if #t > 0 then
                                    RageUI.Popup({message = "La zone est ~r~occupée"})
                                else
                                    vehicleFct.SpawnVehicle(
                                        veh.model,
                                        self.properties.spawnpos,
                                        self.properties.spawnpos.h,
                                        function(vehicle)
                                            vehicleFct.SetVehicleProperties(vehicle, veh)
                                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                            RageUI.Visible(RMenu:Get("garage", self.name .. "_manage"), false)
                                        end
                                    )
                                    TriggerServerEvent("Garage:SortirVehicule", self.properties.vehicles[i].id)

                                    RageUI.GoBack()
                                    Wait(200)
                                    self:Refresh()
                                end
                            end
                        end
                    end
                end
            )
        end
    end
end
local posInGarage = {
    [2] = {
        {
            Pos = {x = 175.70, y = -1004.01, z = -100.000},
            Heading = 173.03
        },
        {
            Pos = {x = 172.24, y = -1004.17, z = -100.000},
            Heading = 173.03
        }
    },
    [3] = {
        {
            Pos = {x = -2009.82, y = 3216.45, z = 32.80},
            Heading = 149.16
        },
        {
            Pos = {x = -1989.85, y = 3205.12, z = 32.81},
            Heading = 149.16
        },
        {
            Pos = {x = -1975.50, y = 3196.55, z = 32.81},
            Heading = 149.16
        }
    },
    [6] = {
        {
            Pos = {x = 193.06, y = -995.95, z = -100.000},
            Heading = 225.0
        },
        {
            Pos = {x = 192.61, y = -1000.16, z = -100.000},
            Heading = 225.0
        },
        {
            Pos = {x = 192.06, y = -1003.64, z = -100.000},
            Heading = 225.0
        },
        {
            Pos = {x = 205.85, y = -1002.17, z = -100.000},
            Heading = 105.0
        },
        {
            Pos = {x = 201.98, y = -996.98, z = -100.000},
            Heading = 175.0
        },
        {
            Pos = {x = 198.33, y = -996.42, z = -100.000},
            Heading = 175.0
        }
    },
    [10] = {
        {
            Pos = {x = 224.500, y = -998.695, z = -100.000},
            Heading = 225.0
        },
        {
            Pos = {x = 224.500, y = -994.630, z = -100.000},
            Heading = 225.0
        },
        {
            Pos = {x = 224.500, y = -990.255, z = -100.000},
            Heading = 225.0
        },
        {
            Pos = {x = 224.500, y = -986.628, z = -100.000},
            Heading = 225.0
        },
        {
            Pos = {x = 224.500, y = -982.496, z = -100.000},
            Heading = 225.0
        },
        {
            Pos = {x = 232.500, y = -982.496, z = -100.000},
            Heading = 135.0
        },
        {
            Pos = {x = 232.500, y = -986.628, z = -100.000},
            Heading = 135.0
        },
        {
            Pos = {x = 232.500, y = -990.255, z = -100.000},
            Heading = 135.0
        },
        {
            Pos = {x = 232.500, y = -994.630, z = -100.000},
            Heading = 135.0
        },
        {
            Pos = {x = 232.500, y = -998.695, z = -100.000},
            Heading = 135.0
        }
    },
    [64] = {
        {
            Pos = {x = 439.21, y = -763.17, z = 17.12},
            Heading = 214.6
        },
        {
            Pos = {x = 436.53, y = -765.00, z = 16.42},
            Heading = 214.13
        },
        {
            Pos = {x = 434.05, y = -766.88, z = 17.1},
            Heading = 212.98
        },
        {
            Pos = {x = 431.18, y = -768.89, z = 16.42},
            Heading = 214.38
        },
        {
            Pos = {x = 428.39, y = -770.58, z = 17.1},
            Heading = 214.02
        },
        {
            Pos = {x = 425.6, y = -772.34, z = 17.19},
            Heading = 212.2
        },
        {
            Pos = {x = 434.41, y = -785.51, z = 17.19},
            Heading = 34.94
        },
        {
            Pos = {x = 437.32, y = -783.5, z = 17.19},
            Heading = 33.86
        },
        {
            Pos = {x = 440.01, y = -782.04, z = 16.42},
            Heading = 35.93
        },
        {
            Pos = {x = 442.84, y = -780.14, z = 17.12},
            Heading = 34.77
        },
        {
            Pos = {x = 445.59, y = -778.21, z = 17.1},
            Heading = 35.48
        },
        {
            Pos = {x = 447.95, y = -776.51, z = 17.1},
            Heading = 34.64
        },
        {
            Pos = {x = 452.27, y = -754.5, z = 17.1},
            Heading = 213.25
        },
        {
            Pos = {x = 455, y = -752.71, z = 17.1},
            Heading = 214.84
        },
        {
            Pos = {x = 457.73, y = -750.73, z = 17.1},
            Heading = 214.44
        },
        {
            Pos = {x = 460.48, y = -748.94, z = 17.09},
            Heading = 214.46
        },
        {
            Pos = {x = 463.2, y = -747.1, z = 17.12},
            Heading = 215.25
        },
        {
            Pos = {x = 465.89, y = -745.19, z = 17.12},
            Heading = 213.87
        },
        {
            Pos = {x = 468.58, y = -743.48, z = 17.12},
            Heading = 214.36
        },
        {
            Pos = {x = 471.41, y = -741.82, z = 17.11},
            Heading = 213.97
        },
        {
            Pos = {x = 473.96, y = -740.06, z = 17.11},
            Heading = 214.83
        },
        {
            Pos = {x = 476.77, y = -738.18, z = 17.11},
            Heading = 213.95
        },
        {
            Pos = {x = 479.38, y = -736.42, z = 17.11},
            Heading = 214.01
        },
        {
            Pos = {x = 488.45, y = -749.29, z = 17.12},
            Heading = 32.78
        },
        {
            Pos = {x = 485.76, y = -751.24, z = 17.12},
            Heading = 33.56
        },
        {
            Pos = {x = 483.08, y = -752.79, z = 17.1},
            Heading = 33.72
        },
        {
            Pos = {x = 480.46, y = -754.79, z = 17.1},
            Heading = 34.67
        },
        {
            Pos = {x = 477.72, y = -756.61, z = 17.1},
            Heading = 35.41
        },
        {
            Pos = {x = 475.08, y = -758.3, z = 17.19},
            Heading = 33.72
        },
        {
            Pos = {x = 472.23, y = -760.14, z = 17.19},
            Heading = 33.95
        },
        {
            Pos = {x = 469.61, y = -761.99, z = 17.11},
            Heading = 35.21
        },
        {
            Pos = {x = 476.28, y = -765.94, z = 14.68},
            Heading = 214.18
        },
        {
            Pos = {x = 478.92, y = -764.11, z = 14.68},
            Heading = 214.21
        },
        {
            Pos = {x = 481.59, y = -762.24, z = 14.68},
            Heading = 214.33
        },
        {
            Pos = {x = 484.49, y = -760.77, z = 14.83},
            Heading = 214.89
        },
        {
            Pos = {x = 487.21, y = -759.04, z = 14.83},
            Heading = 215.27
        },
        {
            Pos = {x = 489.98, y = -757.14, z = 14.83},
            Heading = 214.12
        },
        {
            Pos = {x = 492.7, y = -755.34, z = 14.83},
            Heading = 213.97
        },
        {
            Pos = {x = 495.45, y = -753.6, z = 14.83},
            Heading = 212.86
        },
        {
            Pos = {x = 497.68, y = -751.42, z = 14.68},
            Heading = 214.02
        },
        {
            Pos = {x = 500.3, y = -749.71, z = 14.68},
            Heading = 214.66
        },
        {
            Pos = {x = 503.91, y = -766.42, z = 14.68},
            Heading = 213.14
        },
        {
            Pos = {x = 499.24, y = -765.48, z = 14.68},
            Heading = 33.14
        },
        {
            Pos = {x = 496.63, y = -767.17, z = 14.69},
            Heading = 32.74
        },
        {
            Pos = {x = 493.84, y = -769.1, z = 14.69},
            Heading = 33.09
        },
        {
            Pos = {x = 491.14, y = -770.8, z = 14.69},
            Heading = 31.86
        },
        {
            Pos = {x = 488.44, y = -772.61, z = 14.66},
            Heading = 33.93
        },
        {
            Pos = {x = 485.97, y = -774.48, z = 14.66},
            Heading = 33.08
        },
        {
            Pos = {x = 483.2, y = -776.43, z = 14.66},
            Heading = 33.63
        },
        {
            Pos = {x = 480.06, y = -780.18, z = 14.76},
            Heading = 122.3
        },
        {
            Pos = {x = 481.75, y = -782.98, z = 14.76},
            Heading = 123.39
        },
        {
            Pos = {x = 486.6, y = -781.4, z = 14.76},
            Heading = 215.1
        },
        {
            Pos = {x = 489.49, y = -779.61, z = 14.76},
            Heading = 213.29
        },
        {
            Pos = {x = 491.98, y = -777.86, z = 14.76},
            Heading = 214.68
        },
        {
            Pos = {x = 494.67, y = -775.99, z = 14.76},
            Heading = 213.94
        },
        {
            Pos = {x = 497.41, y = -774.17, z = 14.76},
            Heading = 213.13
        },
        {
            Pos = {x = 500.24, y = -772.3, z = 14.69},
            Heading = 215.27
        },
        {
            Pos = {x = 502.81, y = -770.59, z = 14.66},
            Heading = 213.3
        },
        {
            Pos = {x = 515.56, y = -777.59, z = 14.66},
            Heading = 34.92
        },
        {
            Pos = {x = 512.71, y = -779.27, z = 14.66},
            Heading = 34.15
        },
        {
            Pos = {x = 510.1, y = -781.09, z = 14.66},
            Heading = 34.57
        },
        {
            Pos = {x = 507.49, y = -782.75, z = 14.66},
            Heading = 34.49
        },
        {
            Pos = {x = 504.69, y = -784.73, z = 14.66},
            Heading = 34.04
        },
        {
            Pos = {x = 502.04, y = -786.51, z = 14.66},
            Heading = 33.69
        },
        {
            Pos = {x = 499.38, y = -788.33, z = 14.66},
            Heading = 33.96
        },
        {
            Pos = {x = 496.77, y = -790.08, z = 14.66},
            Heading = 32.89
        },
        {
            Pos = {x = 493.89, y = -791.79, z = 14.66},
            Heading = 33.73
        },
        {
            Pos = {x = 491.35, y = -793.67, z = 14.66},
            Heading = 34.23
        },
        {
            Pos = {x = 488.43, y = -795.57, z = 14.66},
            Heading = 34.54
        },
        {
            Pos = {x = 483.76, y = -796.81, z = 14.66},
            Heading = 356.91
        },
        {
            Pos = {x = 480.54, y = -796.69, z = 14.76},
            Heading = 358
        },
        {
            Pos = {x = 477.24, y = -796.48, z = 14.76},
            Heading = 356.03
        },
        {
            Pos = {x = 474.01, y = -796.4, z = 14.76},
            Heading = 358.56
        },
        {
            Pos = {x = 470.96, y = -796.42, z = 14.76},
            Heading = 356.76
        },
        {
            Pos = {x = 467.57, y = -796.15, z = 14.76},
            Heading = 355.57
        },
        {
            Pos = {x = 464.32, y = -796.1, z = 14.76},
            Heading = 356.76
        },
        {
            Pos = {x = 460.02, y = -776.85, z = 14.76},
            Heading = 214.03
        },
        {
            Pos = {x = 457.57, y = -778.63, z = 14.76},
            Heading = 214.13
        },
        {
            Pos = {x = 454.73, y = -780.54, z = 14.76},
            Heading = 212.09
        },
        {
            Pos = {x = 452.11, y = -782.36, z = 14.76},
            Heading = 213.55
        },
        {
            Pos = {x = 449.52, y = -783.96, z = 14.76},
            Heading = 213.39
        },
        {
            Pos = {x = 446.74, y = -785.82, z = 14.76},
            Heading = 213.14
        },
        {
            Pos = {x = 443.88, y = -787.72, z = 14.76},
            Heading = 212.04
        },
        {
            Pos = {x = 441.26, y = -789.49, z = 14.66},
            Heading = 212.38
        },
        {
            Pos = {x = 438.48, y = -791.41, z = 14.66},
            Heading = 214.66
        },
        {
            Pos = {x = 435.86, y = -792.99, z = 14.66},
            Heading = 213.51
        },
        {
            Pos = {x = 433.11, y = -794.95, z = 14.66},
            Heading = 214.25
        },
        {
            Pos = {x = 430.55, y = -796.58, z = 14.66},
            Heading = 215.65
        },
        {
            Pos = {x = 444.34, y = -819.63, z = 14.69},
            Heading = 352.77
        },
        {
            Pos = {x = 440.92, y = -819.06, z = 14.69},
            Heading = 353.83
        },
        {
            Pos = {x = 437.83, y = -818.53, z = 14.66},
            Heading = 352.93
        },
        {
            Pos = {x = 434.56, y = -818.06, z = 14.66},
            Heading = 351.63
        },
        {
            Pos = {x = 431.32, y = -817.72, z = 14.66},
            Heading = 353.6
        }
    }
}

function RenderVehicle()
    local self = currentSelf
    inG = true
    if self.properties == nil then
        self.properties = {}
    end
    if self.properties.vehicles == nil then
        self.properties.vehicles = {}
    end
    for i = 1, #self.properties.vehicles, 1 do
        local veh = json.decode(currentSelf.properties.vehicles[i].vehicles)
        local v555 = veh
        currentSelf.properties.Limit = tonumber(currentSelf.properties.Limit)
        if posInGarage[currentSelf.properties.Limit][i] == nil then
            ShowNotification("ERREUR 01 GARAGE #" ..currentSelf.properties.Limit)
            SetEntityCoords(PlayerPedId(), tempPos)
            return
        end

        posInGarage[currentSelf.properties.Limit][i].Pos.z = posInGarage[currentSelf.properties.Limit][i].Pos.z + 0.5
        vehicleFct.SpawnLocalVehicle(
            veh.model,
            posInGarage[currentSelf.properties.Limit][i].Pos,
            posInGarage[currentSelf.properties.Limit][i].Heading,
            function(_veh_veh)
                FreezeEntityPosition(_veh_veh, true)
                SetEntityAsMissionEntity(_veh_veh, true, true)
                table.insert(
                    veh99,
                    {model = _veh_veh, scaleform = GetDisplayNameFromVehicleModel(GetEntityModel(_veh_veh))}
                )
                vehicleFct.SetVehicleProperties(_veh_veh, v555)
                TriggerEvent('persistent-vehicles/register-vehicle', _veh_veh)
                SetVehicleOnGroundProperly(_veh_veh)
                table.insert(platesList, GetVehicleNumberPlateText(_veh_veh))
            end
        )
        Wait(55)
    end
    inGarage = true
end
function createScaleform(name, data)
    if not name or string.len(name) <= 0 then
        return
    end
    local scaleform = RequestScaleformMovie(name)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    SetScaleformParams(scaleform, data)
    return scaleform
end
local scale = .9
local size = {(10 * 0.8) * scale, (6 * 0.8) * scale, 1 * scale}

Citizen.CreateThread(
    function()
        while true do
            Wait(0)
            if #veh99 > 0 and inG then
                for i = 1, #veh99, 1 do
                    local veh = veh99[i].model
                    local vehPos = GetEntityCoords(veh)
                    local plyPos = GetEntityCoords(PlayerPedId())
                    if GetDistanceBetweenCoords(plyPos, vehPos, true) < 2.0 then
                        local Z = GetEntityHeight(veh, vehPos.x, vehPos.y, vehPos.z, true, false)
                        DrawScaleformMovie_3dNonAdditive(
                            CreateVehicleStatsScaleform(veh99[i].scaleform),
                            vehPos.x,
                            vehPos.y,
                            vehPos.z + 2.4 + Z,
                            GetGameplayCamRot(0),
                            0.0,
                            1.0,
                            0.0,
                            size[1],
                            size[2],
                            size[3],
                            0
                        )
                    end
                end
                local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
                if veh ~= 0 then
                    local p = vehicleFct.GetVehicleProperties(veh)
                    local m = p.model

                    local self = currentSelf
                    if currentSelf ~= nil then
                        local found = false
                        local rdy = false
                        if self.properties.type == 1 then
                            for i = 1, #self.properties.vehicles, 1 do
                                if self.properties.vehicles[i] ~= nil then
                                    if self.properties.vehicles[i].job then
                                        table.insert(m, self.properties.vehicles[i])
                                    end
                                end
                                rdy = true
                            end
                            self.properties.vehicles = m
                        else
                            self.properties.vehicles = {}
                        end
                        if self.properties.type == 1 or self.properties.type == 0 then
                            TriggerServerCallback(
                                "garage:GetVehicle",
                                function(data)
                                    if data ~= nil then
                                        for i = 1, #data, 1 do
                                            table.insert(self.properties.vehicles, data[i])
                                        end
                                    end
                                    rdy = true
                                end,
                                self.name
                            )
                        end
                        if self.properties.type == 3 then
                            TriggerServerCallback(
                                "garage:GetVehicle2",
                                function(data)
                                    if data ~= nil then
                                        for i = 1, #data, 1 do
                                            table.insert(self.properties.vehicles, data[i])
                                        end
                                    end
                                    rdy = true
                                end,
                                self.name
                            )
                        end
                        while rdy == false do
                            Wait(1)
                            print("wait")
                        end

                        SetEntityCoords(PlayerPedId(), tempPos)
                        ShowNotification("~w~Le véhicule est en train de sortir. ~r~Veuillez patienter")
                        Wait(1000)
                        vehicleFct.SpawnVehicle(
                            m,
                            tempPos,
                            0,
                            function(veh)
                                if veh ~= 0 then
                                    vehicleFct.SetVehicleProperties(veh, p)
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleOnGroundProperly(veh)
                                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                    Wait(100)
                                    local vehicleHashKey = p.model .. "|" .. p.plate
                                    TriggerEvent('persistent-vehicles/register-vehicle', veh)
                                    
                                    TriggerServerEvent("Garage:RemoveVehicule", currentSelf.name, vehicleHashKey)

                                    TriggerEvent("exitInstance")
                                end
                            end
                        )
                    else
                        ShowNotification("Erreur inconnue")
                        SetEntityCoords(PlayerPedId(), tempPos)
                    end
                    inG = false
                    KeySettings:Clear("keyboard", "L", "MenuGarage")
                    for i = 1, #veh99 do
                        if type(veh99[i]) ~= "vector3" then
                            vehicleFct.DeleteVehicle(veh99[i].model)
                        end
                    end
                    veh99 = {}
                end
            end
        end
    end
)

function GetVehicleNameFromModel(urkh)
    local zhzpBSx = GetDisplayNameFromVehicleModel(urkh)
    local rHSjalVy = GetLabelText(zhzpBSx)
    if rHSjalVy ~= "NULL" then
        return rHSjalVy
    end
    if zhzpBSx ~= "CARNOTFOUND" then
        return zhzpBSx
    end
    return urkh
end
function CreateVehicleStatsScaleform(model)
    local u = GetHashKey(model)
    local K = GetVehicleNameFromModel(u)

    local i1 = vehCoffres[string.lower(K)] or 0
    local zz1QI = GetVehicleModelMaxSpeed(u) * 1.25
    local kFTAh = GetVehicleModelAcceleration(u) * 200
    local LBf = GetVehicleModelMaxBraking(u) * 100
    local dijn4Ph = GetVehicleModelMaxTraction(u) * 25
    return createScaleform(
        "mp_car_stats_01",
        {
            {
                name = "SET_VEHICLE_INFOR_AND_STATS",
                param = {
                    K,
                    "~g~" .. i1 .. "kg / " .. GetVehicleModelMaxNumberOfPassengers(model) .. " sièges",
                    "MPCarHUD",
                    "Annis",
                    "Vitesse max",
                    "Accélération",
                    "Frein",
                    "Suspension",
                    zz1QI,
                    kFTAh,
                    LBf,
                    dijn4Ph
                }
            }
        }
    )
end

function DisplayNewGarage()
    local self = currentSelf
    RageUI.Button(
        "Rentrer dans le garage",
        nil,
        {},
        true,
        function(_, Active, Selected)
            if Selected then
                if currentSelf.properties.type == 0 then
                    DoScreenFadeOut(0)
                    local ped = PlayerPedId()
                    local veh = GetVehiclePedIsUsing(ped)
                    if veh ~= 0 then
                        if veh ~= 0 then
                            if #self.properties.vehicles + 1 <= self.properties.Limit then
                                if DecorGetInt(veh, "isJob") == 0 then
                                    TriggerServerEvent(
                                        "Garage:StockVehicle",
                                        vehicleFct.GetVehicleProperties(veh),
                                        self.name
                                    )
                                else
                                    MYVEHJOB = nil
                                end
                                vehicleFct.DeleteVehicle(veh)
                            else
                                RageUI.Popup({message = "~r~Il n'y a plus de place dans votre garage"})
                                return
                            end
                        end
                    end
                    tempPos = GetEntityCoords(PlayerPedId())
                    TriggerEvent("localInstance", "grg")
                    LoadInterior(GetInteriorAtCoords(Interiors[currentSelf.properties.Limit]))
                    while not IsInteriorReady(GetInteriorAtCoords(Interiors[currentSelf.properties.Limit])) do
                        Wait(1)
                    end

                    SetEntityCoords(PlayerPedId(), Interiors[currentSelf.properties.Limit])

                    KeySettings:Clear("keyboard", "E", "grg" .. self.name)
                    KeySettings:Clear("controller", "E", "grg" .. self.name)
                    RageUI.GoBack()
                    RageUI.GoBack()
                    RageUI.GoBack()
                    RageUI.GoBack()
                    RageUI.GoBack()
                    RageUI.Visible(RMenu:Get("garage", self.name), false)
                    for i = 1, 10, 1 do
                        Wait(0)
                        RageUI.GoBack()
                    end
                    CloseAllMenus()
                    Hint:RemoveAll()
                    Citizen.CreateThread(
                        function()
                            Wait(40)
                            Hint:RemoveAll()
                        end
                    )
                    RenderVehicle()
                    DoScreenFadeIn(0)
                end
            end
        end
    )
end

Citizen.CreateThread(
    function()
        for k, v in pairs(Interiors) do
            local x, y, z = table.unpack(v)
            local coords = {x = x, y = y, z = z}
            local coords2 = coords
            coords2.z = coords2.z - 0.2
            Marker:Add(
                coords,
                {
                    type = 23,
                    scale = {x = 1.5, y = 1.5, z = 0.2},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            )
            local t = Random(11111)
            Zone:Add(
                coords,
                function()
                    if tempPos == nil then
                        tempPos = vector3(PublicGarage[1].Pos.x, PublicGarage[1].Pos.y, PublicGarage[1].Pos.z)
                    end
                    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour sortir du garage")
                    KeySettings:Add(
                        "keyboard",
                        "E",
                        function()
                            SetEntityCoords(PlayerPedId(), tempPos)
                            Hint:RemoveAll()
                            Hint:RemoveAll()

                            KeySettings:Clear("keyboard", "E", "sortirgg_" .. t)
                            for i = 1, #veh99 do
                                if type(veh99[i]) ~= "vector3" then
                                    vehicleFct.DeleteVehicle(veh99[i].model)
                                end
                            end
                            currentSelf = nil
                            inG = false
                            KeySettings:Clear("keyboard", "L", "MenuGarage")
                            veh99 = {}
                            TriggerEvent("exitInstance")

                            KeySettings:Clear("keyboard", "L", "MenuGarage")
                        end,
                        "sortirgg_" .. t
                    )
                    --print("o")
                end,
                function()
                    Hint:RemoveAll()
                    KeySettings:Clear("keyboard", "E", "sortirgg_" .. t)

                    Hint:Set("Appuyez sur ~INPUT_CELLPHONE_CAMERA_FOCUS_LOCK~ pour ouvrir le menu garage")
                end,
                k,
                3.5
            )
        end
    end
)

function RealGarage()
    self = currentSelf
    if self.properties.vehicles[1] == nil then
        RageUI.Button(
            "Vide",
            nil,
            {},
            true,
            function(_, Active, Selected)
            end
        )
    end
    for i = 1, #self.properties.vehicles, 1 do
        -- local veh = json.decode(self.properties.vehicles[i].vehicles)

        RageUI.Button(
            self.properties.vehicles[i].label,
            nil,
            {},
            true,
            function(_, Active, Selected)
                if Selected then
                    self.CurrentIndex = i
                    RageUI.Refresh()
                end
            end,
            RMenu:Get("garage", self.name .. "_manage")
        )
    end
end
function Garage:RealGarage()
    if self.properties.vehicles[1] == nil then
        RageUI.Button(
            "Vide",
            nil,
            {},
            true,
            function(_, Active, Selected)
            end
        )
    end
    for i = 1, #self.properties.vehicles, 1 do
        local veh = json.decode(self.properties.vehicles[i].vehicles)

        RageUI.Button(
            self.properties.vehicles[i].label,
            nil,
            {},
            true,
            function(_, Active, Selected)
                if Selected then
                    self.CurrentIndex = i
                    RageUI.Refresh()
                end
            end,
            RMenu:Get("garage", self.name .. "_manage")
        )
    end
end

function Garage:PutInVeh()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    if veh ~= 0 then
        if #self.properties.vehicles + 1 <= self.properties.Limit then
            if DecorGetInt(veh, "isJob") == 0 then
                TriggerServerEvent("Garage:StockVehicle", vehicleFct.GetVehicleProperties(veh), self.name)
            else
                MYVEHJOB = nil
            end
            local testProps = vehicleFct.GetVehicleProperties(veh)

            print('putting away vehicle!', testProps.plate)
            vehicleFct.DeleteVehicle(veh)
        else
            RageUI.Popup({message = "~r~Il n'y a plus de place dans votre garage"})
        end
    end
end
---- Garage
PublicGarage = {
    {
        Pos = {x = 1498.45, y = 3747.46, z = 32.85},
        Properties = {
            type = 0,
            spawnpos = {x = 1498.45, y = 3747.46, z = 33.85, h = 334.16},
           Limit = 6
        },
        Blipdata = {
            Pos = {x = 1498.45, y = 3747.46, z = 33.85},
            Blipcolor = 84,
            Blipname = "Garage 6 Place"
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
        Name = "garage_1"
    },
    {
        Pos = {x = 182.18, y = 6625.57, z = 30.68, h = 196.93},
        Properties = {
            type = 0,
            spawnpos = {x = 182.18, y = 6625.57, z = 31.68, h = 196.93},
           Limit = 6
        },
        Blipdata = {
            Pos = {x = 182.18, y = 6625.57, z = 31.68, h = 196.93},
            Blipcolor = 84,
            Blipname = "Garage 6 Place"
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
        Name = "garage_2"
    },
    {
        Pos = {x = 230.4, y = -794.27, z = 30.6, h = 162.05},
        Properties = {
            type = 0,
            spawnpos = {x = 230.4, y = -794.27, z = 29.6, h = 162.05},
            Limit = 6
        },
        Blipdata = {
            Pos = {x = 230.4, y = -794.27, z = 29.6, h = 162.05},
            Blipcolor = 84,
            Blipname = "Garage 6 Place"
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
        Name = "garage_3"
    },
    {
        Pos = {x = -1176.15, y = -734.06, z = 19.31, h = 235.05},
        Properties = {
            type = 0,
            spawnpos = {x = -1176.15, y = -734.06, z = 19.31, h = 235.05},
           Limit = 6
        },
        Blipdata = {
            Pos = {x = -1176.15, y = -734.06, z = 19.31, h = 235.05},
            Blipcolor = 84,
            Blipname = "Garage 6 Place"
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
        Name = "garage_4"
    },
    {
        Pos = {x = -334.30, y = -1071.24, z = 23.02, h = 167.48},
        Properties = {
            type = 0,
            spawnpos = {x = -334.30, y = -1071.24, z = 23.02, h = 167.48},
           Limit = 10
        },
        Blipdata = {
            Pos = {x = -334.30, y = -1071.24, z = 23.02, h = 167.48},
            Blipcolor = 5,
            Blipname = "Garage 10 Place"
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
        Name = "garage_14"
    },
    {
        Pos = {x = -65.55, y = 81.40, z = 71.55, h = 69.00},
        Properties = {
            type = 0,
            spawnpos = {x = -65.55, y = 81.40, z = 71.55, h = 69.00},
           Limit = 10
        },
        Blipdata = {
            Pos = {x = -65.55, y = 81.40, z = 71.55, h = 69.00},
            Blipcolor = 5,
            Blipname = "Garage 10 Place"
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
        Name = "garage_15"
    },

    {
        Pos = {x = 1302.25, y = 4218.06, z = 33.90, h = 73.62},
        Properties = {
            type = 2,
            spawnpos = {x = 1295.77, y = 4203.91, z = 29.76, h = 154.30},
           Limit = 6,
            vehicles = {
                {
                    name = "tug",
                    label = "tug",
                    tuning = {
                        modXenon = false,
                        modLivery = 0,
                        color1 = 27,
                        color2 = 27
                    }
                }
            }
        },
        Blipdata = {
            Pos = {x = 1302.25, y = 4218.06, z = 33.90, h = 73.62},
            BlipId = 255,
            Blipcolor = 47,
            BlipScale = 0.8,
            Blipname = "Bateau de location"
        },
        
        Marker = {
            type = 1,
            scale = {x = 1.0, y = 1.0, z = 0.2},
            color = {r = 255, g = 0, b = 0, a = 120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = false
        },
        Name = "garage_7"
    },

     {
         Pos = {x=-1644.69,y=-3143.68,z=13.92,h=326.79},
         Properties = {
             type = 3,
             spawnpos ={x=-2041.00,y=3172.17,z=32.8,h=59.47},
            Limit = 10
         },
         Blipdata = {
             Pos = {x=-1644.69,y=-3143.68,z=13.92,h=59.47},
             Blipcolor  =84,
             BlipId = 359,
             Blipname = "Garage avion"
         },
         Marker = {
             type = 1,
             scale = {x=5.5,y=5.5,z=0.2},
             color = {r=255,g=255,b=255,a=120},
             Up = false,
             Cam = false,
             Rotate = false,
             visible = true
         },
         Name = "garage_7"
     },
     {
        Pos = {x=2128.71,y=4806.65,z=41.23,h=326.79},
        Properties = {
            type = 0,
            spawnpos ={x=2128.71,y=4806.65,z=40.23,h=59.47},
           Limit = 3
        },
        Blipdata = {
            Pos = {x=2128.71,y=4806.65,z=40.23,h=114.91},
            Blipcolor  =84,
            BlipId = 359,
            Blipname = "Garage avion"
        },
        Marker = {
            type = 1,
            scale = {x=5.5,y=5.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_75"
    }
    --[[{
        Pos = {x=3856.16,y=4454.6,z=-0.1,h=259.18},
        Properties = {
            type = 0,
            spawnpos ={x=3856.16,y=4454.6,z=-0.1,h=259.18},
           Limit = 6
        },
        Blipdata = {
            Pos = {x=3856.16,y=4454.6,z=-0.1,h=259.18},
            Blipcolor  =84,
            BlipId = 356,
            Blipname = "Garage bateau"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_85"
    },
    {
        Pos = {x=-854.21,y=-1336.57,z=-0.1,h=108.63},
        Properties = {
            type = 0,
            spawnpos = {x=-854.21,y=-1336.57,z=-0.1,h=108.63},
            Limit = 6
        },
        Blipdata = {
            Pos = {x=-854.21,y=-1336.57,z=-0.1,h=108.63},
            Blipcolor  =84,
            BlipId = 356,
            Blipname = "Garage bateau"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_95"
    }]]--
}
Citizen.CreateThread(
    function()
        for _, v in pairs(PublicGarage) do
            Marker:Add(v.Pos, v.Marker)
            local garage = Garage.New(v.Name, v.Pos, v.Properties, v.Blipdata)
            garage:Setup()
        end
    end
)
