Property = {}
local currentProperty = {}
local currentAppart = nil
local weekRent = 1

RMenu.Add("appart", "main", RageUI.CreateMenu(nil, "Actions disponibles", 10, 100))
Exist = false
local PosSS = {}
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
        coords = {x = -1480.84, y = -533.65, z = 70.55}, -- Luxe Del Perro a changer
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
local MYPOS = {}
local function EnterProperty()
    local playerPed = LocalPlayer().Ped
    local propertyX = currentProperty
    local property = CoordsCamList[currentProperty.indexx]
    local x, y, z = table.unpack(GetEntityCoords(playerPed))
    MYPOS = {x = x, y = y, z = z}
    Citizen.CreateThread(
        function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Citizen.Wait(0)
            end

            SetEntityCoords(playerPed, property.entry.x, property.entry.y, property.entry.z)

            DoScreenFadeIn(800)

            DrawSub(propertyX.name, 5000)

            w = propertyX["capacity"]
        end
    )
end
local function ExitProperty()
    outside = MYPOS
    if currentProperty ~= nil then
        if (CoordsCamList[currentProperty.indexx] ~= nil) then
            Zone:Remove(CoordsCamList[currentProperty.indexx].coffre)
        end
    end
    Zone:RemoveFromName("coffre_appart")
    Citizen.CreateThread(
        function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Citizen.Wait(0)
            end
            if outside == nil then
                outside = {x = 212.19, y = -934.99, z = 24.28}
            end
            SetEntityCoords(playerPed, outside.x, outside.y, outside.z)

            DoScreenFadeIn(800)
        end
    )
end

local function Exit22()
    TriggerEvent("instance:leave")
    ExitProperty()
    KeySettings:Clear("keyboard", "E", "Appart_")
    KeySettings:Clear("controller", 46, "Appart_")
    Hint:RemoveAll()
end
local function Enter2(pos)
    PosSS = pos
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour sortir")
    KeySettings:Add("keyboard", "E", Exit22, "Appart_")
    KeySettings:Add("controller", 46, Exit22, "Appart_")
end

local function Exit2()
    KeySettings:Clear("keyboard", "E", "Appart_")
    KeySettings:Clear("controller", 46, "Appart_")
    Hint:RemoveAll()
end
local function Format()
    for i = 1, #Property, 1 do
        if (type(Property[i].pos) == "string") then
            Property[i].Pos = json.decode(Property[i].pos)
        else
            Property[i].Pos = Property[i].pos
        end
        Property[i].capacity = string.gsub(Property[i].capacity, "KG", "")
        Property[i].capacity = tonumber(Property[i].capacity)
        Property[i].time = tostring(Property[i].time)
        if (type(Property[i].coowner) == "string") then
            Property[i].coowner = Property[i].coowner == nil and {} or json.decode(Property[i].coowner)
        else
            Property[i].coowner = Property[i].coowner == nil and {} or Property[i].coowner
        end
    end
    SetupApparts()
end
function FormatApprt(cc)
    Property = cc
    return Format()
end
local function Exit()
    currentAppart = nil
    KeySettings:Clear("keyboard", "E", "Appart")
    KeySettings:Clear("controller", 46, "Appart")
    Hint:RemoveAll()
end
local function Open()
    currentProperty = Property[currentAppart]
    RMenu:Get("appart", "main"):SetTitle(currentProperty.name)
    RageUI.Visible(RMenu:Get("appart", "main"), true)
    Exit()
end
local function Enter(z)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec la propriété")
    KeySettings:Add("keyboard", "E", Open, "Appart")
    KeySettings:Add("controller", 46, Open, "Appart")
    currentAppart = z
end

local _Marker = {
    type = 25,
    scale = {x = 1.5, y = 1.5, z = 0.2},
    color = {r = 255, g = 255, b = 255, a = 120},
    Up = false,
    Cam = false,
    Rotate = false,
    visible = true
}

function SetupApparts()
    for i = 1, #Property, 1 do
        local own = false
        while PlyUuid == nil do
            Wait(1)
            print("waiting")
        end
        if PlyUuid == Property[i].owner then
            own = true
        end
        if not own then
            if Property[i].coowner ~= nil then
                for _i = 1, #Property[i].coowner, 1 do
                    if PlyUuid == Property[i].coowner[_i] then
                        own = true
                        break
                    end
                end
            end
        end
        if Property[i].garagePos ~= nil and own then
            if (type(Property[i].garagePos) == "string") then
                Property[i].garagePos = json.decode(Property[i].garagePos)
            else
                Property[i].garagePos = Property[i].garagePos
            end
            Properties = {
                type = 3,
                spawnpos = Property[i].garagePos,
                Limit = Property[i].garageMax
            }
            Blipdata = {
                Pos = Property[i].garagePos,
                Blipcolor = 2,
                Blipname = "Garage " .. Property[i].name,
                size = 0.6
            }

            local garage = Garage.New(Property[i].name, Property[i].garagePos, Properties, Blipdata)
            garage:Setup()
            __Marker = {
                type = 25,
                scale = {x = 1.5, y = 1.5, z = 0.2},
                color = {r = 125, g = 0, b = 0, a = 120},
                Up = false,
                Cam = false,
                Rotate = false,
                visible = true
            }
            Property[i].garagePos.z = Property[i].garagePos.z + 1.0
            Marker:Add(Property[i].garagePos, __Marker)
        end
        while Job == nil or Job:Get() == nil do
            Wait(1)
        end

        if own or Job:Get().name == "immo" then
            local coulour = 2
            local size = 0.6
            local name = "Propriété"
            if Job:Get().name == "immo" and not own then
                coulour = 55
                name = nil
                size = 0.45
                if Property[i].owner ~= nil then
                    coulour = 84
                end
            end
            local blip = AddBlipForCoord(Property[i].Pos.x, Property[i].Pos.y, Property[i].Pos.z)
            SetBlipSprite(blip, 411)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, size)
            SetBlipColour(blip, coulour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(name)
            EndTextCommandSetBlipName(blip)
        end

        Zone:Add(Property[i].Pos, Enter, Exit, i, 1.3)
        Marker:Add(Property[i].Pos, _Marker)
    end
end

function StartEverything()
    for i = 1, #CoordsCamList, 1 do
        local property = CoordsCamList[i]
        property.entry.z = property.entry.z - 0.9
        Zone:Add(property.entry, Enter2, Exit2, property.entry, 1.3)
        -- Marker:Add(property.entry,_Marker)
    end
    TriggerServerCallback(
        "appart:requestData",
        function(apparts)
            Property = apparts
            Format()
        end
    )
end
RegisterNetEvent("appart:RequestApparts")
AddEventHandler(
    "appart:RequestApparts",
    function(_users)
        for i = 1, #Property, 1 do
            Zone:Remove(Property[i].Pos)
            --    Marker:Remove(Property[i].Pos)
        end
        Wait(500)
        TriggerServerCallback(
            "appart:requestData",
            function(apparts)
                Property = apparts
                Format()
            end
        )
    end
)

RegisterNetEvent("instance:Exist")
AddEventHandler(
    "instance:Exist",
    function(_users)
        --print(_users)
        Exist = _users
    end
)
RegisterNetEvent("instance:onCreate")
AddEventHandler(
    "instance:onCreate",
    function(instance)
        if instance.type == "property" then
            TriggerEvent("instance:enter", instance)
        end
    end
)

function EnterAppart()
    return EnterProperty()
end
function ExitAppart()
    return ExitProperty()
end

exports("EnterAppart", EnterAppart)
exports("ExitAppart", ExitAppart)

function DrawSub(msg, time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(time, 1)
end
RegisterNetEvent("core:UpdateCoOwner")
AddEventHandler(
    "core:UpdateCoOwner",
    function(id, uuid)
        for i = 1, #Property, 1 do
            if Property[i].id == id then
                Property[i].coowner = uuid
                local own = false
                if Property[i].coowner ~= nil then
                    for _i = 1, #Property[i].coowner, 1 do
                        if PlyUuid == Property[i].coowner[_i] then
                            own = true
                            break
                        end
                    end
                end
                if own then
                    local coulour = 2
                    local size = 0.6
                    local name = "Propriété"
                    local blip = AddBlipForCoord(Property[i].Pos.x, Property[i].Pos.y, Property[i].Pos.z)
                    SetBlipSprite(blip, 411)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, size)
                    SetBlipColour(blip, coulour)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(name)
                    EndTextCommandSetBlipName(blip)

                    if (type(Property[i].garagePos) == "string") then
                        Property[i].garagePos = json.decode(Property[i].garagePos)
                    else
                        Property[i].garagePos = Property[i].garagePos
                    end

                    Properties = {
                        type = 0,
                        spawnpos = Property[i].garagePos,
                        Limit = Property[i].garageMax
                    }
                    Blipdata = {
                        Pos = Property[i].garagePos,
                        Blipcolor = 2,
                        Blipname = "Garage " .. Property[i].name,
                        size = 0.6
                    }

                    local garage = Garage.New(Property[i].name, Property[i].garagePos, Properties, Blipdata)
                    garage:Setup()
                    __Marker = {
                        type = 25,
                        scale = {x = 1.5, y = 1.5, z = 0.2},
                        color = {r = 125, g = 0, b = 0, a = 120},
                        Up = false,
                        Cam = false,
                        Rotate = false,
                        visible = true
                    }
                    Property[i].garagePos.z = Property[i].garagePos.z + 1.0
                    Marker:Add(Property[i].garagePos, __Marker)
                end

                break
            end
        end
    end
)
RegisterNetEvent("core:UpdateOwner")
AddEventHandler(
    "core:UpdateOwner",
    function(id, uuid)
        for i = 1, #Property, 1 do
            if Property[i].id == id then
                Property[i].owner = uuid
                local own = false
                if PlyUuid == Property[i].owner then
                    own = true
                end
                if own then
                    local coulour = 2
                    local size = 0.6
                    local name = "Propriété"
                    if Property[i].Pos == nil then
                        return ShowNotification("~g~Vous avez été ajouté en copropriétaire\nIl faut déco reco pour y avoir accès")
                    end
                    local blip = AddBlipForCoord(Property[i].Pos.x, Property[i].Pos.y, Property[i].Pos.z)
                    SetBlipSprite(blip, 411)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, size)
                    SetBlipColour(blip, coulour)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(name)
                    EndTextCommandSetBlipName(blip)

                    if (type(Property[i].garagePos) == "string") then
                        Property[i].garagePos = json.decode(Property[i].garagePos)
                    else
                        Property[i].garagePos = Property[i].garagePos
                    end

                    Properties = {
                        type = 0,
                        spawnpos = Property[i].garagePos,
                        Limit = Property[i].garageMax
                    }
                    Blipdata = {
                        Pos = Property[i].garagePos,
                        Blipcolor = 2,
                        Blipname = "Garage " .. Property[i].name,
                        size = 0.6
                    }

                    local garage = Garage.New(Property[i].name, Property[i].garagePos, Properties, Blipdata)
                    garage:Setup()
                    __Marker = {
                        type = 25,
                        scale = {x = 1.5, y = 1.5, z = 0.2},
                        color = {r = 125, g = 0, b = 0, a = 120},
                        Up = false,
                        Cam = false,
                        Rotate = false,
                        visible = true
                    }
                    Property[i].garagePos.z = Property[i].garagePos.z + 1.0
                    Marker:Add(Property[i].garagePos, __Marker)
                end
                break
            end
        end
    end
)
RegisterNetEvent("core:updateloc2")
AddEventHandler(
    "core:updateloc2",
    function(id, time)
        --print(id,uuid,time)
        for i = 1, #Property, 1 do
            if Property[i].id == id then
                Property[i].time = time
                break
            end
        end
    end
)
RegisterNetEvent("core:updateloc")
AddEventHandler(
    "core:updateloc",
    function(id, uuid, time)
        --print(id,uuid,time)
        for i = 1, #Property, 1 do
            if Property[i].id == id then
                Property[i].owner = uuid
                Property[i].time = time
                break
            end
        end
    end
)
RegisterNetEvent("add:Appart")
AddEventHandler(
    "add:Appart",
    function(__table)
        local _table = __table

        if type(_table) == "string" then
            _table = json.decode(_table)
        end

        if type(_table.pos) == "string" then
            _table.pos = json.decode(_table.pos)
        end
        local coulour = 2
        local size = 0.6
        local name = "Propriété"
        if Job:Get().name == "immo" and not own then
            coulour = 55
            name = nil
            size = 0.45
            if _table.owner ~= nil then
                coulour = 84
            end
        end
        if Job:Get().name == "immo" then
            local blip = AddBlipForCoord(_table.pos.x, _table.pos.y, _table.pos.z)
            SetBlipSprite(blip, 411)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, size)
            SetBlipColour(blip, coulour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(name)
            EndTextCommandSetBlipName(blip)
        end
        _table.entry = _table.pos
        _table.entry.z = _table.entry.z
        table.insert(
            Property,
            {
                id = _table.id,
                indexx = _table.indexx,
                name = _table.name,
                owner = nil,
                price = _table.price,
                capacity = _table.capacity,
                pos = _table.pos
            }
        )

        Zone:Add(_table.entry, Enter, Exit, #Property, 1.3)
        --    Marker:Add(_table.entry,_Marker)
    end
)

function DeletePropr()
    for i = 1, #Property, 1 do
        if Property[i].id == currentProperty.id then
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            TriggerServerEvent("appart:remove", Property[i].id)
            Marker:Remove(Property[i].Pos)
            Zone:Remove(Property[i].Pos)
            table.remove(Property, i)
            break
        end
    end
end
function NoOwnerAppart()
    RageUI.Button(
        "Visiter",
        nil,
        {},
        true,
        function(_, _, Selected)
            if Selected then
                RageUI.GoBack()
                RageUI.GoBack()
                RageUI.GoBack()
                RageUI.GoBack()
                MYPOS = currentProperty.Pos

                TriggerServerEvent("instance:checkifexist", currentProperty.name)
                while Exist == false do
                    Wait(1)
                end

                print(Exist)

                if Exist == nil then
                    TriggerEvent(
                        "instance:create",
                        "property",
                        {property = currentProperty.name, owner = currentProperty.name}
                    )
                else
                    TriggerEvent(
                        "instance:enter",
                        {host = Exist, property = currentProperty.name, owner = currentProperty.name, type = "property"}
                    )
                end
                Exist = false
            end
        end
    )
    RageUI.Button(
        "Propriétaire",
        nil,
        {RightLabel = "Aucun"},
        true,
        function(_, _, Selected)
        end
    )
    if Job:Get().name == "immo" then
        RageUI.CenterButton(
            "~b~↓↓ ~s~Action immobilier ~b~↓↓",
            nil,
            {},
            true,
            function(_, _, _)
            end
        )
        RageUI.Button(
            "Capacité du coffre",
            nil,
            {RightLabel = currentProperty.capacity .. "KG"},
            true,
            function(_, _, Selected)
                if Selected then
                    local nb = KeyboardInput("~b~Nouveau")
                end
            end
        )
        pr = currentProperty.price .. "$"
        if Job:Get().name ~= "immo" then
            pr = "~r~MASQUÉ"
        end

        pr2 = currentProperty.price / 50 .. "$"
        if Job:Get().name ~= "immo" then
            pr2 = "~r~MASQUÉ"
        end
        RageUI.Button(
            "Prix de la propriété",
            nil,
            {RightLabel = pr},
            true,
            function(_, Ac, Selected)
                if Ac then
                    HoverPlayer()
                end
                if Selected then
                    ply = GetPlayerServerIdInDirection(20.0)

                    if ply == 0 then
                        TriggerServerCallback(
                            "core:GetMysource",
                            function(_src)
                                ply = _src
                            end
                        )
                    end
                    dataonWait = {
                        item = items,
                        price = currentProperty.price,
                        fct = function()
                            local pedId = ply
                            if pedId then
                                TriggerServerEvent("appart:updateown", pedId, currentProperty.id)
                            end
                        end
                    }
                    TriggerEvent("payWith?")
                end
            end
        )

        RageUI.Button(
            "Nombre de semaines",
            nil,
            {RightLabel = weekRent},
            true,
            function(_, _, Selected)
                if Selected then
                    weekRent = KeyboardInput("~b~Définir semaines")
                end
            end
        )

        RageUI.Button(
            "Prix de la location (" .. weekRent .. " semaine(s))",
            nil,
            {RightLabel = pr2},
            true,
            function(_, Ac, Selected)
                if Ac then
                    HoverPlayer()
                end
                if Selected then
                    local pedId = GetPlayerServerIdInDirection(20.0)

                    if pedId then
                        dataonWait = {
                            item = items,
                            price = currentProperty.price * weekRent / 50,
                            fct = function()
                                local pedId = GetPlayerServerIdInDirection(20.0)
                                if pedId then
                                    TriggerServerEvent("appart:updateownLoc", pedId, currentProperty.id, weekRent)
                                else
                                    ShowNotification("~r~Aucun joueur a proximité~w~")
                                end
                            end
                        }
                        TriggerEvent("payWith?")
                    else
                        ShowNotification("~r~Aucun joueur a proximité~w~")
                    end
                end
            end
        )

        RageUI.Button(
            "~r~Supprimer la propriété",
            nil,
            {RightLabel = nil},
            true,
            function(_, _, Selected)
                if Selected then
                    DeletePropr()
                end
            end
        )
    else
        RageUI.Button(
            "Contacter un agent immobilier",
            nil,
            {RightLabel = ""},
            true,
            function(_, _, Selected)
                if Selected then
                    ShowNotification("~g~Vous avez appellé un agent immobilier")
                    MakeCall("immo")
                end
            end
        )
    end
end
function MakeCall(job, msg)
    local plyPos = GetEntityCoords(LocalPlayer().Ped, true)
    TriggerServerEvent("call:makeCall", job, {x = plyPos.x, y = plyPos.y, z = plyPos.z}, msg)
end
function addStorage()
    local Storage = Storage.New(currentProperty.name .. "_storage", currentProperty.capacity)
    Storage:LinkToPos(CoordsCamList[currentProperty.indexx].coffre, "coffre_appart")
end

function OwnAppart()
    RageUI.Button(
        "Rentrer",
        nil,
        {},
        true,
        function(_, _, Selected)
            if Selected then
                RageUI.GoBack()
                RageUI.GoBack()
                RageUI.GoBack()
                RageUI.GoBack()
                MYPOS = currentProperty.Pos

                TriggerServerEvent("instance:checkifexist", currentProperty.name)
                while Exist == false do
                    Wait(1)
                end
                if Exist == nil then
                    TriggerEvent(
                        "instance:create",
                        "property",
                        {property = currentProperty.name, owner = currentProperty.name}
                    )
                else
                    TriggerEvent(
                        "instance:enter",
                        {host = Exist, property = currentProperty.name, owner = currentProperty.name, type = "property"}
                    )
                end
                Exist = false
                addStorage()
            end
        end
    )
    RageUI.Button(
        "Propriétaire",
        nil,
        {RightLabel = "Vous"},
        true,
        function(_, _, Selected)
        end
    )
    if currentProperty.time == nil or currentProperty.time == "nil" then
        currentProperty.time = "Propriétaire"
    end

    RageUI.Button(
        "Fin du bail",
        nil,
        {RightLabel = currentProperty.time ~= nil and currentProperty.time or "Propriétaire"},
        true,
        function(_, _, Selected)
        end
    )

    RageUI.Button(
        "Ajouter un copropriétaire",
        nil,
        {},
        true,
        function(_, Ac, Selected)
            if Ac then
                HoverPlayer()
            end

            if Selected then
                local pedId = GetPlayerServerIdInDirection(10.0)
                if pedId then
                    TriggerServerEvent("core:AddCoOwner", pedId, currentProperty.id, currentProperty.coowner)
                else
                    ShowNotification("Aucun joueur proche")
                end
            end
        end
    )

    RageUI.Button(
        "Retirer un copropriétaire",
        nil,
        {},
        true,
        function(_, Ac, Selected)
            if Ac then
                HoverPlayer()
            end

            if Selected then
                local pedId = GetPlayerServerIdInDirection(10.0)
                if pedId then
                    TriggerServerEvent("core:RemoveCoOwner", pedId, currentProperty.id, currentProperty.coowner)
                else
                    ShowNotification("Aucun joueur proche")
                end
            end
        end
    )

    RageUI.Button(
        "Changer de serrure",
        nil,
        {},
        true,
        function(_, Ac, Selected)
            if Selected then
                TriggerServerEvent("core:RemoveAll", pedId, currentProperty.id, currentProperty.coowner)
                ShowNotification("~r~Serrure changer avec succès !")
            end
        end
    )
end

function isCoOwn(PlyUuid)
    local found = false
    if currentProperty.coowner ~= nil then
        for i = 1, #currentProperty.coowner, 1 do
            if currentProperty.coowner[i] == PlyUuid then
                found = true
                break
            end
        end
    end
    return found
end

function CoOwnAppart()
    RageUI.Button(
        "Rentrer",
        nil,
        {},
        true,
        function(_, _, Selected)
            if Selected then
                RageUI.GoBack()
                RageUI.GoBack()
                RageUI.GoBack()
                RageUI.GoBack()
                MYPOS = currentProperty.Pos

                TriggerServerEvent("instance:checkifexist", currentProperty.name)
                while Exist == false do
                    Wait(1)
                end
                if Exist == nil then
                    TriggerEvent(
                        "instance:create",
                        "property",
                        {property = currentProperty.name, owner = currentProperty.name}
                    )
                else
                    TriggerEvent(
                        "instance:enter",
                        {host = Exist, property = currentProperty.name, owner = currentProperty.name, type = "property"}
                    )
                end
                Exist = false
                addStorage()
            end
        end
    )
    RageUI.Button(
        "Propriétaire",
        nil,
        {RightLabel = "Masqué"},
        true,
        function(_, _, Selected)
        end
    )
    if currentProperty.time == nil or currentProperty.time == "nil" then
        currentProperty.time = "Propriétaire"
    end
    RageUI.Button(
        "Fin du bail",
        nil,
        {RightLabel = currentProperty.time ~= nil and currentProperty.time or "Propriétaire"},
        true,
        function(_, _, Selected)
        end
    )
end

function Idontownappart()
    RageUI.Button(
        "Sonner",
        nil,
        {},
        true,
        function(_, _, Selected)
            if Selected then
                RageUI.GoBack()
                RageUI.GoBack()
                RageUI.GoBack()
                RageUI.GoBack()
                TriggerServerCallback(
                    "core:GetSourceFromUUID",
                    function(src)
                        local _src = GetPlayerServerId(PlayerId())
                        --print(_src)
                        --print(src)
                        if src == nil then
                            return ShowNotification("~r~Personne ne peut vous ouvrir ! ")
                        end
                        TriggerPlayerEvent(
                            "RageUI:Popup",
                            src,
                            {message = "Quelqu'un sonne à la porte\n~g~E ~s~pour accepter\n~r~Y ~s~ pour refuser"}
                        )
                        TriggerPlayerEvent("newAppartRequest", src, _src)
                    end,
                    currentProperty.owner
                )
            end
        end
    )
end
RegisterNetEvent("newAppartRequest")
AddEventHandler(
    "newAppartRequest",
    function(srcc)
        local v = false
        KeySettings:Add(
            "keyboard",
            "E",
            function()
                TriggerPlayerEvent("RageUI:Popup", srcc, {message = "Entrée ~g~acceptée"})
                ShowNotification("Entrée ~g~acceptée")
                TriggerPlayerEvent("accept:Appart", srcc)
                v = true
            end,
            "Appart_Key"
        )
        KeySettings:Add(
            "keyboard",
            "Y",
            function()
                TriggerPlayerEvent("RageUI:Popup", srcc, {message = "Entrée ~r~refusée"})
                ShowNotification("Entrée ~r~refusée")
                v = true
            end,
            "Appart_Key"
        )

        Wait(8000)
        if not v then
            ShowNotification("Entrée ~r~refusée")
            TriggerPlayerEvent("RageUI:Popup", srcc, {message = "Entrée ~r~refusée"})
        end
        KeySettings:Clear("keyboard", "E", "Appart_Key")
        KeySettings:Clear("keyboard", "Y", "Appart_Key")
    end
)
RegisterNetEvent("accept:Appart")
AddEventHandler(
    "accept:Appart",
    function()
        MYPOS = currentProperty.Pos
        --print(dump(currentProperty))
        TriggerServerEvent("instance:checkifexist", currentProperty.name)
        while Exist == false do
            Wait(1)
            --print("checking")
        end
        if Exist == nil then
            TriggerEvent("instance:create", "property", {property = currentProperty.name, owner = currentProperty.name})
        else
            TriggerEvent(
                "instance:enter",
                {host = Exist, property = currentProperty.name, owner = currentProperty.name, type = "property"}
            )
        end
        Exist = false
        addStorage()
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            --  print("ab")
            if RageUI.Visible(RMenu:Get("appart", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        if currentProperty.owner == nil then
                            NoOwnerAppart()
                        else
                            if PlyUuid == currentProperty.owner then
                                OwnAppart()
                            else
                                if isCoOwn(PlyUuid) then
                                    CoOwnAppart()
                                else
                                    Idontownappart()
                                end
                            end

                            if Job:Get().name == "immo" then
                                RageUI.CenterButton(
                                    "~b~↓↓ ~s~Action immobilier ~b~↓↓",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                                RageUI.Button(
                                    "Capacité du coffre",
                                    nil,
                                    {RightLabel = currentProperty.capacity .. "KG"},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            local nb = KeyboardInput("~b~Nouveau")
                                        end
                                    end
                                )

                                RageUI.Button(
                                    "Prix de la propriété",
                                    nil,
                                    {RightLabel = currentProperty.price .. "$"},
                                    true,
                                    function(_, Ac, Selected)
                                        if Ac then
                                            HoverPlayer()
                                        end
                                        if Selected then
                                            local pedId = GetPlayerServerIdInDirection(10.0)
                                            if pedId then
                                                TriggerServerEvent("appart:updateown", pedId, currentProperty.id)
                                            end
                                        end
                                    end
                                )

                                RageUI.Button(
                                    "Nombre de semaines",
                                    nil,
                                    {RightLabel = weekRent},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            weekRent = KeyboardInput("~b~Définir semaines")
                                        end
                                    end
                                )

                                RageUI.Button(
                                    "Prix de la location (" .. weekRent .. " semaine(s))",
                                    nil,
                                    {RightLabel = (currentProperty.price * weekRent) / 50 .. "$"},
                                    true,
                                    function(_, Ac, Selected)
                                        if Ac then
                                            HoverPlayer()
                                        end
                                        if Selected then
                                            local pedId = GetPlayerServerIdInDirection(20.0)

                                            if pedId then
                                                dataonWait = {
                                                    item = items,
                                                    price = currentProperty.price * weekRent / 50,
                                                    fct = function()
                                                        local pedId = GetPlayerServerIdInDirection(20.0)
                                                        if pedId then
                                                            TriggerServerEvent(
                                                                "appart:updateownLoc",
                                                                pedId,
                                                                currentProperty.id,
                                                                weekRent
                                                            )
                                                        else
                                                            ShowNotification("~r~Aucun joueur a proximité~w~")
                                                        end
                                                    end
                                                }
                                                TriggerEvent("payWith?")
                                            else
                                                ShowNotification("~r~Aucun joueur a proximité~w~")
                                            end
                                        end
                                    end
                                )

                                RageUI.Button(
                                    "~r~Supprimer la propriété",
                                    nil,
                                    {RightLabel = nil},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            DeletePropr()
                                        end
                                    end
                                )
                            end
                        end

                        if Job:Get().name == "immo" then
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)

local permaLock = {
    {objName = "v_ilev_rc_door2", x = 1005.292, y = -2998.266, z = -47.49689, h = 89},
    {objName = "v_ilev_fa_frontdoor", x = -14.86892, y = -1441.182, z = 31.19323, h = 180},
    {objName = "v_ilev_epsstoredoor", x = 241.3621, y = 361.047, z = 105.8883, h = 160},
    {objName = "v_ilev_mm_doorm_l", x = -816.716, y = 179.098, z = 72.82738, h = 291},
    {objName = "v_ilev_mm_doorm_r", x = -816.1068, y = 177.5109, z = 72.82738, h = 291},
    {objName = "prop_bh1_48_backdoor_r", x = -794.1853, y = 182.568, z = 73.04045, h = 111},
    {objName = "prop_bh1_48_backdoor_l", x = -793.3943, y = 180.5075, z = 73.04045, h = 111},
    {objName = "prop_bh1_48_backdoor_r", x = -794.5051, y = 178.0124, z = 73.04045, h = 21},
    {objName = "prop_bh1_48_backdoor_l", x = -796.5657, y = 177.2214, z = 73.04045, h = 21},
    {objName = "v_ilev_trevtraildr", x = 1972.769, y = 3815.366, z = 33.66326, h = 29},
    {objName = "v_ilev_trev_doorfront", x = -1149.709, y = -1521.088, z = 10.78267, h = 35},
    --{ objName = "v_ilev_lostdoor", x = 981.1506, y = -103.2552, z = 74.9935, h = 42 },     --LOSTMC
    {objName = "v_ilev_mm_door", x = -806.287, y = 185.785, z = 72.48, h = 201},
    {objName = "v_ilev_gc_door04", x = 16.13, y = -1114.61, z = 29.95, h = 160, c = "BC"},
    {objName = "v_ilev_gc_door03", x = 18.57, y = -1115.5, z = 29.95, h = 340, c = "BC"},
    {objName = "v_ilev_gtdoor", x = 463.4782, y = -1003.538, z = 25.00599, c = "BC"},
    {objName = "v_ilev_bk_door", x = 266.3624, y = 217.5697, z = 110.4, h = 339, c = "BC"},
    {objName = "v_ilev_bk_door", x = 256.6172, y = 206.1522, z = 110.4, h = 250, c = "BC"},
    {objName = "v_ilev_lester_doorfront", x = 1273.82, y = -1720.7, z = 54.92, h = 24.85},
    {objName = "v_ilev_fh_frontdoor", x = 7.52, y = 539.53, z = 176.18, h = 150.0},
    {objName = "v_ilev_trev_doorfront", x = -1149.71, y = -1521.09, z = 10.78, h = 35.0},
    {objName = "v_ilev_janitor_frontdoor", x = -107.54, y = -9.02, z = 70.67, h = 70.22},
    {objName = 1282049587, x = 3602.0, y = -3717.88, z = 29.84, h = -34.61},
    {objName = -421709054, x = 3599.87, y = 3719.38, z = 29.84, h = -35.34}
}

function doCloseDoors()
    for k, v in pairs(permaLock) do
        local closeDoor = GetClosestObjectOfType(v.x, v.y, v.z, 3.0, GetHashKey(v.objName), false, false, false)
        --if DoesEntityExist(closeDoor) then print(GetEntityHeading(closeDoor)) end
        if closeDoor and DoesEntityExist(closeDoor) and v.h and math.floor(GetEntityHeading(closeDoor)) == v.h then
            FreezeEntityPosition(closeDoor, true)
        end
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1500 * 1)
            doCloseDoors()
        end
    end
)

local lastCall = 0
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(20)
            local ped = LocalPlayer().Ped
            if IsPedShooting(ped) and GetInteriorFromEntity(ped) == 0 and GetSelectedPedWeapon(ped) and GetGameTimer() > lastCall and IsPedArmed(ped, 4) then
                local hasSuppressor, weaponUsed = IsPedCurrentWeaponSilenced(ped), GetSelectedPedWeapon(ped)

                if weaponUsed then
                    local handle2, target2 = FindFirstPed()
                    local success2
                    repeat
                        success2, target2 = FindNextPed(handle2)
                        if
                            target2 and DoesEntityExist(target2) and not IsPedAPlayer(target2) and
                                not IsPedDeadOrDying(target2) and
                                not IsPedShooting(target2) and
                                IsPedHuman(target2) and
                                GetGameTimer() > lastCall
                         then
                            local targetPos = GetEntityCoords(target2)
                            local dist = GetDistanceBetweenCoords(plyPos, targetPos, true)
                            if dist < (hasSuppressor and 4 or 120) then
                                if Job:Get().name ~= "police" and "lssd" then
                                    TriggerServerEvent(
                                        "call:makeCall2",
                                        "police",
                                        {x = targetPos.x, y = targetPos.y, z = targetPos.z},
                                        "Tirs d'arme à feu !"
                                    )
                                    TriggerServerEvent(
                                        "call:makeCall2",
                                        "lssd",
                                        {x = targetPos.x, y = targetPos.y, z = targetPos.z},
                                        "Tirs d'arme à feu !"
                                    )
                                end
                                lastCall = GetGameTimer() + 1000 * 120
                            end
                        end
                    until not success2
                    EndFindPed(handle2)
                end
            end
        end
    end
)
