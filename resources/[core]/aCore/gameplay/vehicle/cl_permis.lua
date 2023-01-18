local CurrentZone = nil
local _blip = nil
local currentVehicle = nil
local Permis_config = {
    ["start"] = {x = 221.49, y = 370.27, z = 105.27, a = 72.21}, -- pos ped
    ["end"] = {x = 235.24, y = -1509.56, z = 28.65},
    price = 200
}

local function StopVehicule(reason)
    DeleteEntity(currentVehicle)
    currentVehicle = nil
    ClearAllBlipRoutes()
    RemoveBlip(_blip)
    SetEntityCoordsNoOffset(LocalPlayer().Ped, 219.95, 371.27, 106.29, false, false, false, true)
    ShowNotification("~r~Vous avez échoué\n Raison : " .. reason)
end

local function StopVehicule2()
    DeleteEntity(currentVehicle)
    currentVehicle = nil
    ClearAllBlipRoutes()
    RemoveBlip(_blip)
    SetEntityCoordsNoOffset(LocalPlayer().Ped, 219.95, 371.27, 106.29, false, false, false, true)
    ShowNotification("~g~Vous avez réussi votre test")

    items = {name = "permis-conduire", data = {points = 12, uid = "LS-" .. Random(99999999), identity = GetIdentity()}}
    AddItemtoInv(items)
end

local function startTest()
    dataonWait = {
        detail = "Permis de conduire ",
        price = Permis_config.price,
        fct = function()
            coords = {x = 213.78, y = 390.19, z = 106.85, a = 173.14}
            vehicleFct.SpawnVehicle(
                "blista2",
                coords,
                235.32,
                function(vehicle)
                    currentVehicle = vehicle
                    SetPedIntoVehicle(LocalPlayer().Ped, vehicle, -1)
                    SetVehicleDoorsLocked(vehicle, 4)
                    SetVehicleNumberPlateText(vehicle, "PERMIS")
                end
            )
            ShowNotification("Conduisez jusqu'au point.")
            Wait(5)
            _blip = AddBlipForCoord(235.24, -1509.56, 28.65)
            SetBlipSprite(_blip, 1)
            SetBlipDisplay(_blip, 4)
            SetBlipScale(_blip, 0.6)
            SetBlipColour(_blip, 81)
            SetBlipAsShortRange(_blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Destination")
            EndTextCommandSetBlipName(_blip)
            SetBlipRouteColour(_blip, 81)
            SetBlipRoute(_blip, true)
            KeySettings:Clear("keyboard", "E", "permis")
            KeySettings:Clear("controller", 46, "permis")
            Hint:RemoveAll()
        end
    }

    TriggerEvent("payWith?")
end
function ShowNotification(msg)
    RageUI.Popup({message = msg})
end
local function Enter(z)
    if z == "start" then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour commencer le test ~r~(200$)")
        KeySettings:Add("keyboard", "E", startTest, "permis")
        KeySettings:Add("controller", 46, startTest, "permis")
        CurrentZone = z
    else
        if currentVehicle ~= nil then
            StopVehicule2()
        end
    end
end

local function Exit(z)
    KeySettings:Clear("keyboard", "E", "permis")
    KeySettings:Clear("controller", 46, "permis")
    Hint:RemoveAll()
end
local function Create()
    local Pos = Permis_config["start"]
    local blip = AddBlipForCoord(Pos.x, Pos.y, Pos.z)
    SetBlipSprite(blip, 269)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 84)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Auto-école")
    EndTextCommandSetBlipName(blip)
    Zone:Add(Pos, Enter, Exit, "start", 2.5)
    Ped:Add("David", "a_m_y_bevhills_01", Pos, nil)

    Zone:Add(Permis_config["end"], Enter, Exit, "end", 2.5)
end

Citizen.CreateThread(
    function()
        Wait(30000)
        local pos = {x = -2357.33, y = 3250.93, z = 106.05}

        Zone:Add(
            pos,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour reset votre position")
                KeySettings:Add(
                    "keyboard",
                    "E",
                    function()
                        SetEntityCoords(LocalPlayer().Ped, 0.0, 0.0, 0.0)
                    end,
                    "spawn"
                )
                KeySettings:Add("controller", 46, startTest, "spawn")
            end,
            function()
                KeySettings:Clear("keyboard", "E", "spawn")
                KeySettings:Clear("controller", 46, "spawn")
                Hint:RemoveAll()
            end,
            "posReset",
            10.5
        )
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(1000)
            if currentVehicle ~= nil then
                if GetVehicleBodyHealth(currentVehicle) ~= 1000 then
                    StopVehicule("~r~Vous avez endommagé le véhicule")
                end
                if GetEntitySpeed(currentVehicle) * 3.6 > 100 then
                    StopVehicule("~r~Excès de vitesse (" .. GetEntitySpeed(currentVehicle) * 3.6 .. "km/h)")
                end
            end
        end
    end
)
Create()
