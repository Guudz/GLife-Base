spawnedVehicles = {}
jackedVehicles = {}

local relationshipTypes = {
    "GANG_1",
    "GANG_2",
    "GANG_9",
    "GANG_10",
    "AMBIENT_GANG_LOST",
    "AMBIENT_GANG_MEXICAN",
    "AMBIENT_GANG_FAMILY",
    "AMBIENT_GANG_BALLAS",
    "AMBIENT_GANG_MARABUNTE",
    "AMBIENT_GANG_CULT",
    "AMBIENT_GANG_SALVA",
    "AMBIENT_GANG_WEICHENG",
    "AMBIENT_GANG_HILLBILLY",
    "DEALER",
    "CIVMALE",
    "CIVFEMALE",
    "COP",
    "PRIVATE_SECURITY",
    "SECURITY_GUARD",
    "ARMY",
    "MEDIC",
    "FIREMAN",
    "HATES_PLAYER",
    "NO_RELATIONSHIP",
    "SPECIAL",
    "MISSION2",
    "MISSION3",
    "MISSION4",
    "MISSION5",
    "MISSION6",
    "MISSION7",
    "MISSION8"
}

-- Citizen.CreateThread(
--     function()
--         while true do
--             Wait(1)
--             local tryVehicle = GetVehiclePedIsTryingToEnter(LocalPlayer().Ped)

--             if tryVehicle and DoesEntityExist(tryVehicle) then
--                 local veh = tryVehicle
--                 local mdl, netID = GetEntityModel(veh), VehToNet(veh)
--                 --	print(veh,GetVehicleDoorsLockedForPlayer(veh, PlayerId()))

--                 if IsPedJacking(LocalPlayer().Ped) then
                    
--                     math.randomseed(GetGameTimer())
--                     local chanceToTracker = math.random(0, 100)
--                     math.randomseed(GetGameTimer())
--                     local chanceToHate = math.random(0, 100)

--                     local entityIdentifier = GetEntityModel(tryVehicle) .. "|" .. GetVehicleNumberPlateText(tryVehicle)
--                     if (jackedVehicles[entityIdentifier] == nil) then
--                         jackedVehicles[entityIdentifier] = true
--                         if (chanceToTracker >= 90) then
--                             Citizen.Wait(3000)
--                             SetVehicleAlarm(tryVehicle, true)
--                             StartVehicleAlarm(tryVehicle)
--                             callCopsForVehicle(tryVehicle)
--                             Citizen.Wait(1000 * 30)
--                             callCopsForVehicle(tryVehicle)
--                             Citizen.Wait(1000 * 30)
--                             callCopsForVehicle(tryVehicle)
--                             Citizen.Wait(1000 * 60 * 1)
--                             callCopsForVehicle(tryVehicle)
--                             SetVehicleAlarm(tryVehicle, true)
--                             Citizen.Wait(1000 * 30)
--                             callCopsForVehicle(tryVehicle)
--                             StartVehicleAlarm(tryVehicle)
--                             ShowNotification(
--                                 "~r~Alarme voiture~w~\nCette voiture est équipé d'un coupe circuit et d'un tracker GPS"
--                             )
--                             SetVehicleUndriveable(tryVehicle, true)
--                             table.insert( spawnedVehicles, VehToNet(tryVehicle))
--                         end

--                         if (chanceToHate >= 80) then
--                             callCopsForVehicle(tryVehicle)
--                             ShowNotification(
--                                 "~r~Réaction de foule~w~\nVous avez volé un véhicule, les gens ne sont pas contents"
--                             )
--                             Citizen.CreateThread(
--                                 function()
--                                     while true do
--                                         for _, group in ipairs(relationshipTypes) do
--                                             SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey(group)) -- could be removed
--                                             SetRelationshipBetweenGroups(5, GetHashKey(group), GetHashKey("PLAYER"))
--                                         end

--                                         Citizen.Wait(1000 * 60 * 3)
--                                         print("END")
--                                         for _, group in ipairs(relationshipTypes) do
--                                             SetRelationshipBetweenGroups(3, GetHashKey("PLAYER"), GetHashKey(group)) -- could be removed
--                                             SetRelationshipBetweenGroups(3, GetHashKey(group), GetHashKey("PLAYER"))
--                                         end
--                                         break
--                                     end
--                                 end
--                             )

--                             Citizen.Wait(3000)
--                             SetVehicleUndriveable(tryVehicle, false)
--                             SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
--                             SetEntityAsMissionEntity(veh, true, true)
--                             SetVehicleDoorsLocked(veh, 1)
--                             SetVehicleDoorsLockedForPlayer(veh, false)
--                             SetVehicleDoorsLockedForAllPlayers(veh, false)
--                             table.insert( spawnedVehicles, VehToNet(veh))
--                         end
--                     end
--                 end

--                 if not IsEntityAMissionEntity(veh) and not spawnedVehicles[netID] and (IsThisModelACar(mdl) or IsThisModelABike(mdl) or IsThisModelAHeli(mdl) or IsThisModelAPlane(mdl)) and not IsThisModelABicycle(mdl)then
--                     local driver = GetPedInVehicleSeat(veh, -1)
--                     --print(driver,IsPedAPlayer(driver))
--                     if driver ~= 0 and not IsPedAPlayer(driver) then
--                      --   ClearPedTasks(ped)
--                         Citizen.Trace("Task cleared.\n")
--                     elseif driver == 0 then
--                         SetVehicleDoorsLockedForPlayer(veh, PlayerId(), true)
--                         Citizen.Trace("Vehicle locked.\n")
--                     end
--                 end
--             end
--         end
--     end
-- )

function callCopsForVehicle(tryVehicle)
    local x, y, z = table.unpack(GetEntityCoords(tryVehicle))

    local entityZoneName =
        GetNameOfZone(GetEntityCoords(tryVehicle).x, GetEntityCoords(tryVehicle).y, GetEntityCoords(tryVehicle).z)
    local entityZoneCops = GetCopsUnitToCall(entityZoneName)
    for callId, callCops in pairs(entityZoneCops) do
        TriggerServerEvent(
            "call:makeCall2",
            callCops,
            {x = x, y = y, z = z},
            "\n[" ..
                GetVehicleNumberPlateText(tryVehicle) ..
                    " ANTICARJACKING TRACKING ]\n ~r~Véhicule " .. getVehicleType(tryVehicle) .. " a été carjacké~s~"
        )
    end
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            for i = 1, #spawnedVehicles, 1 do
                DeleteEntity(spawnedVehicles[i])
            end
            return
        end
    end
)

function getVehicleType(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    local vehicleClassName = "Inconnue"

    if (vehicleClass == 0) then
        vehicleClassName = "Compact"
    elseif (vehicleClass == 1) then
        vehicleClassName = "Sedans"
    elseif (vehicleClass == 2) then
        vehicleClassName = "SUV"
    elseif (vehicleClass == 3) then
        vehicleClassName = "Coupé"
    elseif (vehicleClass == 4) then
        vehicleClassName = "Muscle Car"
    elseif (vehicleClass == 5) then
        vehicleClassName = "Sport Classic"
    elseif (vehicleClass == 6) then
        vehicleClassName = "Sport"
    elseif (vehicleClass == 7) then
        vehicleClassName = "Super"
    elseif (vehicleClass == 8) then
        vehicleClassName = "Moto"
    elseif (vehicleClass == 9) then
        vehicleClassName = "Off Road"
    elseif (vehicleClass == 10) then
        vehicleClassName = "Industriel"
    elseif (vehicleClass == 11) then
        vehicleClassName = "Utilitaire"
    elseif (vehicleClass == 12) then
        vehicleClassName = "Van"
    elseif (vehicleClass == 13) then
        vehicleClassName = "Vélo"
    elseif (vehicleClass == 14) then
        vehicleClassName = "Bateau"
    elseif (vehicleClass == 15) then
        vehicleClassName = "Helicopter"
    elseif (vehicleClass == 16) then
        vehicleClassName = "Avion"
    elseif (vehicleClass == 17) then
        vehicleClassName = "Bus, camion poubelle"
    elseif (vehicleClass == 18) then
        vehicleClassName = "Véhicule police/EMS"
    elseif (vehicleClass == 19) then
        vehicleClassName = "Véhicule Militaire"
    else
        vehicleClassName = "Classe inconnue"
    end

    return vehicleClassName
end
