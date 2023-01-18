local kmh = 3.6
local mph = 2.23693629
local carspeed = 0
local driftmode = true
local speed = kmh
local drift_speed_limit = 80.0
local toggle = 118
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(1, 118) then
			driftmode = not driftmode
			if driftmode then
				TriggerEvent("chatMessage", 'Votre mode drift est', { 255,255,255}, 'Activer')
			else
				TriggerEvent("chatMessage", 'Votre mode drift est', { 255,255,255}, 'Désactiver')
			end
		end
		if driftmode then
			if IsPedInAnyVehicle(GetPed(), false) then
				CarSpeed = GetEntitySpeed(GetCar()) * speed
				if GetPedInVehicleSeat(GetCar(), -1) == GetPed() then
					if CarSpeed <= drift_speed_limit then
						if IsControlPressed(1, 21) then
                            SetVehicleReduceGrip(GetCar(), true)
                            
						else
                            SetVehicleReduceGrip(GetCar(), false)
                            
						end
					end
				end
			end
		end
	end
end)
function GetPed() return PlayerPedId() end
function GetCar() return GetVehiclePedIsIn(PlayerPedId(),false) end
