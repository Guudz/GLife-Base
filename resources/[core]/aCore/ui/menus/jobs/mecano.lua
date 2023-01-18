Mecano = {}
local function ClosestVeh()
    if GetEntityType(vehicleFct.GetVehicleInDirection()) == 2 then
        return vehicleFct.GetVehicleInDirection()
    else
        return 0
    end
end
function Mecano.CheckVehicle()
    local veh = ClosestVeh()
    if veh ~= 0 then
        local carosserie = math.floor(GetVehicleBodyHealth(veh) / 10,2)
        local motor =  math.floor(GetVehicleEngineHealth(veh) / 10,2)
        local moyenne = (motor + carosserie) / 2 
        RageUI.Popup({message="État de la carosserie : ~b~"..carosserie.."%\n~s~État du moteur : ~b~"..motor.."%~s~\nL'état globale est de : ~b~"..moyenne.."%"})
    else
        RageUI.Popup({message="~r~Aucun véhicule"})
    end      
end

function Mecano.OpenTrunk()
    local veh = ClosestVeh()
    if veh ~= 0 then
        if GetVehicleDoorAngleRatio(veh,4) > 0.0  then
            Jobs.mecano.Menu.submenus["Actions véhicule"].menus.buttons[2].label = "Fermer le capot"
            SetVehicleDoorShut(veh,4,false)
        else
            Jobs.mecano.Menu.submenus["Actions véhicule"].menus.buttons[2].label = "Ouvrir le capot"
            
            SetVehicleDoorOpen(veh, 4, false, false)
        end
        
    else
        RageUI.Popup({message="~r~Aucun véhicule"})
    end



end
local CurrentlyTowedVehicle = nil
function PutPlateau()
            local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, true)

			local towmodel = GetHashKey('flatbed')
			local isVehicleTow = IsVehicleModel(vehicle, towmodel)

			if isVehicleTow then
				local targetVehicle = GetVehicleInDirection()

				if CurrentlyTowedVehicle == nil then
					if targetVehicle ~= 0 then
						if not IsPedInAnyVehicle(playerPed, true) then
							if vehicle ~= targetVehicle then
								AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
								CurrentlyTowedVehicle = targetVehicle
								ShowNotification("Véhicule ~g~attaché")
							else
								ShowNotification("Vous ne pouvez pas attacher votre propre dépaneuse")
							end
						end
					else
						ESX.ShowNotification("Aucun véhicule attaché")
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle, true, true)

					CurrentlyTowedVehicle = nil
					ShowNotification("Véhicule ~g~détaché")
				end
			else
				ShowNotification("~r~Il vous faut un plateau !")
			end
end

function Mecano.Repair()
    local vehicle = ClosestVeh()
    if vehicle ~= 0 and Inventory:GetItemCount("repairbox") > 0  then
        TaskStartScenarioInPlace(LocalPlayer().Ped, 'PROP_HUMAN_BUM_BIN', 0, true)
        player = LocalPlayer()
        player.isBusy = true
        Citizen.CreateThread(function()
            Citizen.Wait(20000)

            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
            ClearPedTasksImmediately(LocalPlayer().Ped)

            RageUI.Popup({message="Véhicule ~g~réparé"})
            player.isBusy = false
        end)
    elseif vehicle == 0 then
        RageUI.Popup({message="~r~Aucun véhicule"})
    else
        RageUI.Popup({message="~r~Vous n'avez pas de boite a outil"})
    end    
end

function Mecano.CleanVehicule()
    local vehicle = ClosestVeh()
    if vehicle ~= 0 and Inventory:GetItemCount("lavage") > 0  then
        TaskStartScenarioInPlace(LocalPlayer().Ped, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
        player = LocalPlayer()
        player.isBusy = true
        Citizen.CreateThread(function()
            Citizen.Wait(10000)

            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(LocalPlayer().Ped)

            RageUI.Popup({message="Véhicule ~g~nettoyé"})
            player.isBusy = false
        end)
    elseif vehicle == 0 then
        RageUI.Popup({message="~r~Aucun véhicule"})
    else
        RageUI.Popup({message="~r~Vous n'avez pas de kit de lavage"})
    end
end

function Mecano.Fouriere()
    local vehicle = ClosestVeh()
    if vehicle ~= 0 then
        TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
        SetEntityAsMissionEntity(vehicle, false, true)
        DeleteVehicle(vehicle)
    else
        RageUI.Popup({message="~r~Aucun véhicule"})
    end
end

function Mecano.ShowMarker()
    local veh = ClosestVeh()
    if veh ~= 0 and GetEntityType(veh) == 2 then
        if GetVehicleDoorAngleRatio(veh,4) > 0.0 then
            Jobs.mecano.Menu.submenus["Actions véhicule"].menus.buttons[2].label = "Fermer le capot"
        else
            Jobs.mecano.Menu.submenus["Actions véhicule"].menus.buttons[2].label = "Ouvrir le capot"
        end
        local coords = GetEntityCoords(veh)
        local x,y,z = table.unpack(coords)
        DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
    end
end