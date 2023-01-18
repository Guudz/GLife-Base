
local inCoffre = nil
local function OpenCoffre()

    local Player = {}
    Player.Ped = LocalPlayer().Ped
    local veh = GetVehicleInDirection(8.0)
   
    if veh == 0 or DoesEntityExist(veh) == 0 then
        return
    end
    local lock = GetVehicleDoorsLockedForPlayer(veh, Player.Ped)

    --print(lock)
    if not lock and VehToNet(veh) ~= 0 and getVehicleHealth(veh) > 10  then
        
        if IsPedNearTrunk(Player, veh) then
            --("near trunk")
            if GetVehicleDoorLockStatus(veh) == 1 then
                local model = GetEntityModel(veh)

                if IsVehicleDoorDamaged(veh, 5) or GetVehicleDoorAngleRatio(veh, 5) < 0.1 or IsThisModelAPlane(model) then
                    --("veh ok")
                    local result = string.lower(GetDisplayNameFromVehicleModel(model))
                    if vehCoffres[result] == nil then
                        ShowNotification("Le coffre n'est pas enregistré Merci de contacter le staff avec le model du véhicule\n"..result)
                        vehCoffres[result] = 50
                    end
                    currentStorage = Storage.New(model .. "|" .. GetVehicleNumberPlateText(veh), math.floor(vehCoffres[result])) -- storageName is the bdd name
                    while currentStorage == nil do
                        Wait(1)
                    end
                        currentStorage:Visible(true)
                        currentStorage:RefreshDB() -- refresh data with bdd
                        currentStorage:RefreshWeight()
                        SetVehicleDoorOpen(veh, 5)
                        inCoffre = veh
                
                else
                    if currentStorage ~= nil and currentStorage.name ~= nil then
                        currentStorage:Visible(false)
                        currentStorage = {}
                    end
                    inCoffre = nil
                    SetVehicleDoorShut(veh, 5)
                end
            else
                ShowAboveRadarMessage("Le coffre est fermé.")
            end
        else
            ShowAboveRadarMessage("Vous devez regarder le coffre de votre véhicule.")
        end
    end
end
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if inCoffre ~= nil then
            local Ply = SelfPlayer
            local Pos = LocalPlayer().Pos
            local vehPos = GetEntityCoords(inCoffre)
            local x, y, z = table.unpack(vehPos)
            local x1,y1,z1 = table.unpack(Pos)
            if GetDistanceBetween3DCoords(x1,y1,z1, x, y, z) > 5 then
                inCoffre = nil
                currentStorage:Visible(false)
                currentStorage = {}
            end
        end
    end
end)

RegisterCommand('+coffre', function()
    OpenCoffre()
end, false)
RegisterCommand('-coffre', function()
    OpenCoffre()
end, false)
RegisterCommand('coffre', function()
    OpenCoffre()
end, false)
RegisterKeyMapping('coffre', 'Ouvrir coffre véhicule', 'keyboard', 'G')