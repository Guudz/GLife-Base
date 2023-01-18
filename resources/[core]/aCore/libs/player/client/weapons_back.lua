local weapons = {
	'WEAPON_KNIFE',
	'WEAPON_PISTOL',
	--`WEAPON_COMBATPISTOL`,
	'WEAPON_APPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_REVOLVER',
	'WEAPON_SNSPISTOL',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL',
	'WEAPON_MICROSMG',
	'WEAPON_SMG',
	'WEAPON_ASSAULTSMG',
	'WEAPON_MINISMG',
}

local holstered = true
local canFire = true
local currWeapon = `WEAPON_UNARMED`

Citizen.CreateThread(function()
	currWeapon = GetSelectedPedWeapon(LocalPlayer().Ped)
	while true do
		Citizen.Wait(0)
		if DoesEntityExist( LocalPlayer().Ped ) and not IsEntityDead( LocalPlayer().Ped ) and not IsPedInAnyVehicle(PlayerPedId(-1), true) then
			if currWeapon ~= GetSelectedPedWeapon(LocalPlayer().Ped) then
				pos = GetEntityCoords(LocalPlayer().Ped, true)
				rot = GetEntityHeading(LocalPlayer().Ped)

				local newWeap = GetSelectedPedWeapon(LocalPlayer().Ped)
				SetCurrentPedWeapon(LocalPlayer().Ped, currWeapon, true)
				loadAnimDict( "reaction@intimidation@1h" )

				if CheckWeapon(newWeap) then
					if holstered then
						canFire = false
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "intro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1000)
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						currWeapon = newWeap
						Citizen.Wait(2000)
						ClearPedTasks(LocalPlayer().Ped)
						holstered = false
						canFire = true
					elseif newWeap ~= currWeapon and CheckWeapon(currWeapon) then
						canFire = false
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "outro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1600)
						SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey('WEAPON_UNARMED'), true)
						--ClearPedTasks(LocalPlayer().Ped)
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "intro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1000)
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						currWeapon = newWeap
						Citizen.Wait(2000)
						ClearPedTasks(LocalPlayer().Ped)
						holstered = false
						canFire = true
					else
						SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey('WEAPON_UNARMED'), true)
						--ClearPedTasks(LocalPlayer().Ped)
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "intro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1000)
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						currWeapon = newWeap
						Citizen.Wait(2000)
						ClearPedTasks(LocalPlayer().Ped)
						holstered = false
						canFire = true
					end
				else
					if not holstered and CheckWeapon(currWeapon) then
						canFire = false
						TaskPlayAnimAdvanced(LocalPlayer().Ped, "reaction@intimidation@1h", "outro", GetEntityCoords(LocalPlayer().Ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0, 0, 0)
						Citizen.Wait(1600)
						SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey('WEAPON_UNARMED'), true)
						ClearPedTasks(LocalPlayer().Ped)
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						holstered = true
						canFire = true
						currWeapon = newWeap
					else
						SetCurrentPedWeapon(LocalPlayer().Ped, newWeap, true)
						holstered = false
						canFire = true
						currWeapon = newWeap
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not canFire then
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(LocalPlayer().Ped, true)
		end
	end
end)

function CheckWeapon(newWeap)
	for i = 1, #weapons do
		if weapons[i] == newWeap then
			return true
		end
	end
	return false
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end