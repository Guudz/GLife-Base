
print('^3-------------------------------------')
print('^1Base Leaks Par SinLoww#2191')
print('^1CREDIT : SL - Développement Et Leak')
print('^5https://discord.gg/q6t6Ct6UJq')
print('^3https://www.youtube.com/c/Glich/videos')
print('^3-------------------------------------')

local vehWeapons = {
    0x1D073A89,
    0x83BF0278,
    0x5FC3C11
}

local hasBeenInPoliceVehicle = false

local alreadyHaveWeapon = {}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if (IsPedInAnyPoliceVehicle(PlayerPedId())) then
                if (not hasBeenInPoliceVehicle) then
                    hasBeenInPoliceVehicle = true
                end
            else
                if (hasBeenInPoliceVehicle) then
                    for i, k in pairs(vehWeapons) do
                        if (not alreadyHaveWeapon[i]) then
                            TriggerServerEvent("PoliceVehicleWeaponDeleter:askDropWeapon", k)
                        end
                    end
                    hasBeenInPoliceVehicle = false
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if (not IsPedInAnyVehicle(PlayerPedId())) then
                for i = 1, #vehWeapons do
                    if (HasPedGotWeapon(PlayerPedId(), vehWeapons[i], false) == 1) then
                        alreadyHaveWeapon[i] = true
                    else
                        alreadyHaveWeapon[i] = false
                    end
                end
            end
            Citizen.Wait(5000)
        end
    end
)

RegisterNetEvent("PoliceVehicleWeaponDeleter:drop")
AddEventHandler(
    "PoliceVehicleWeaponDeleter:drop",
    function(wea)
        RemoveWeaponFromPed(PlayerPedId(), wea)
    end
)
