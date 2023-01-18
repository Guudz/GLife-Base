local sirene = 1
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local playerped = PlayerPedId()
            if IsPedInAnyVehicle(playerped, false) then
                local veh = GetVehiclePedIsUsing(playerped)
                local NetId = NetworkGetNetworkIdFromEntity(veh)
                if GetPedInVehicleSeat(veh, -1) == playerped then
                    if GetVehicleClass(veh) == 18 then
                        if IsDisabledControlJustReleased(0, 19) then
                            if sirene == 0 then
                                TriggerServerEvent("siren:sync", sirene, NetId)
                                sirene = 1
                            else
                                TriggerServerEvent("siren:sync", sirene, NetId)
                                sirene = 0
                            end
                        end
                    end
                end
            end
        end
    end
)

RegisterNetEvent("siren:ClientSync")
AddEventHandler(
    "siren:ClientSync",
    function(sync, NetId)
        local veh = NetworkGetEntityFromNetworkId(NetId)
        if sync == 0 then
            DisableVehicleImpactExplosionActivation(veh, 0)
        elseif sync == 1 then
            DisableVehicleImpactExplosionActivation(veh, 1)
        end
    end
)
