--[[ Purpose of this script is to attach fuel level to vehicle and not to player ]]
ConfigFuel = {}

-- Blacklist certain vehicles. Use names or hashes. https://wiki.gtanet.work/index.php?title=Vehicle_Models
ConfigFuel.Blacklist = {}

-- Class multipliers. If you want SUVs to use less fuel, you can change it to anything under 1.0, and vise versa.
ConfigFuel.Classes = {
    [0] = 1.5, -- Compacts
    [1] = 1.8, -- Sedans
    [2] = 2.1, -- SUVs
    [3] = 2.4, -- Coupes
    [4] = 2.7, -- Muscle
    [5] = 2.9, -- Sports Classics
    [6] = 3.0, -- Sports
    [7] = 3.3, -- Super
    [8] = 1.5, -- Motorcycles
    [9] = 2.4, -- Off-road
    [10] = 1.5, -- Industrial
    [11] = 1.5, -- Utility
    [12] = 1.5, -- Vans
    [13] = 0.0, -- Cycles
    [14] = 0.6, -- Boats
    [15] = 0.6, -- Helicopters
    [16] = 0.6, -- Planes
    [17] = 1.5, -- Service
    [18] = 1.5, -- Emergency
    [19] = 1.8, -- Military
    [20] = 1.8, -- Commercial
    [21] = 3.0 -- Trains
}

-- The left part is at percentage RPM, and the right is how much fuel (divided by 10) you want to remove from the tank every second
ConfigFuel.FuelUsage = {
    [1.0] = 0.7,
    [0.9] = 0.5,
    [0.8] = 0.4,
    [0.7] = 0.35,
    [0.6] = 0.3,
    [0.5] = 0.25,
    [0.4] = 0.2,
    [0.3] = 0.15,
    [0.2] = 0.1,
    [0.1] = 0.05,
    [0.0] = 0.0
}

function ManageFuelUsage(vehicle)
    if (vehicle ~= nil) then
        SetFuel(vehicle, GetFuel(vehicle))
        SetFuel(
            vehicle,
            GetVehicleFuelLevel(vehicle) -
                ConfigFuel.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] *
                    (ConfigFuel.Classes[GetVehicleClass(vehicle)] or 1.0) /
                    10
        )
    end
end

function SetFuel(vehicle, fuel)
    if type(fuel) == "number" and fuel >= 0 and fuel <= 100 then
        SetVehicleFuelLevel(vehicle, fuel + 0.0)
        if (vehicle ~= nil) then
            local status, vehicleIdentifier = pcall(getVehicleIdentifier, vehicle)
            if (status == true) then
                TriggerServerCallback(
                    "vehicleFuelSynchro:updateVehicleFuelLevel",
                    function()
                    end,
                    vehicleIdentifier,
                    fuel
                )
            end
        end
    end
end

function GetFuel(vehicle)
    local fuel = nil

    local status, vehicleIdentifier = pcall(getVehicleIdentifier, vehicle)
    if (status == true) then
        TriggerServerCallback(
            "vehicleFuelSynchro:getVehicleFuelLevel",
            function(retFuel)
                fuel = retFuel
            end,
            vehicleIdentifier
        )

        while fuel == nil do
            Wait(50)
        end

        return fuel
    end
end

RegisterNetEvent("essence:hasBuying")
AddEventHandler("essence:hasBuying",
    function(amount)
        local amountToEssence = (amount / 60) * 0.142
        local done = false
        local secondsLeft = amount / 5

        LoadingPrompt("Remplissage du reservoir... (15 secondes)", 4)

        while done == false do
            Wait(0)

            local _essence = 0.142
            if (amountToEssence - 0.0005 > 0) then
                amountToEssence = amountToEssence - 0.0005
                essence = _essence + 0.0005
                _essence = essence
                if (_essence > 0.142) then
                    essence = 0.142
                    done = true
                end
                SetVehicleUndriveable(GetVehiclePedIsUsing(LocalPlayer().Ped), true)
                SetVehicleEngineOn(GetVehiclePedIsUsing(LocalPlayer().Ped), false, false, false)
                local essenceToPercent = (essence / 0.142) * 65

                local status, vehicleIdentifier = pcall(getVehicleIdentifier, GetVehiclePedIsUsing(LocalPlayer().Ped))
                if (status == true) then
                    SetVehicleFuelLevel(GetVehiclePedIsIn(LocalPlayer().Ped), round(essenceToPercent))
                    TriggerServerCallback(
                        "vehicleFuelSynchro:updateVehicleFuelLevel",
                        function()
                        end,
                        vehicleIdentifier,
                        round(essenceToPercent)
                    )

                    SetVehicleFuelLevel(GetVehiclePedIsIn(LocalPlayer().Ped), round(essenceToPercent))
                end
                Citizen.Wait(15000)
            else
                essence = essence + amountToEssence
                local essenceToPercent = (essence / 0.142) * 65
                local status, vehicleIdentifier = pcall(getVehicleIdentifier, GetVehiclePedIsUsing(LocalPlayer().Ped))
                if (status == true) then
                    TriggerServerCallback(
                        "vehicleFuelSynchro:updateVehicleFuelLevel",
                        function()
                        end,
                        vehicleIdentifier,
                        round(essenceToPercent)
                    )
                    SetVehicleFuelLevel(GetVehiclePedIsIn(LocalPlayer().Ped), round(essenceToPercent))
                end
                done = true
            end

            RemoveLoadingPrompt()
        end

        TriggerServerEvent(
            "essence:setToAllPlayerEscense",
            essence,
            GetVehicleNumberPlateText(GetVehiclePedIsUsing(LocalPlayer().Ped)),
            GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(LocalPlayer().Ped)))
        )

        SetVehicleUndriveable(GetVehiclePedIsUsing(LocalPlayer().Ped), false)
        SetVehicleEngineOn(GetVehiclePedIsUsing(LocalPlayer().Ped), true, false, false)
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(3500)
            local ped = LocalPlayer().Ped
            if IsPedInAnyVehicle(ped) then
                local vehicle = GetVehiclePedIsIn(ped)
                if (GetPedInVehicleSeat(vehicle, -1) == LocalPlayer().Ped and IsVehicleEngineOn(vehicle)) then
                    ManageFuelUsage(vehicle)
                end
            end
        end
    end
)

function getVehicleIdentifier(vehicle)
    return GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)
end
