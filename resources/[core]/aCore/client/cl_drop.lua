print('^3-------------------------------------')
print('^1Base Leaks Par SinLoww#2191')
print('^1CREDIT : SL - Développement Et Leak')
print('^5https://discord.gg/q6t6Ct6UJq')
print('^3https://www.youtube.com/c/Glich/videos')
print('^3-------------------------------------')

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisablePlayerVehicleRewards(PlayerId())
	end
end)

local pedindex = {}

function SetWeaponDrops()
	local handle, ped = FindFirstPed()
	local finished = false

	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished

	EndFindPed(handle)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		SetWeaponDrops()
	end
end)

-----

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
        --SetParkedVehicleDensityMultiplierThisFrame(0.0)
	end
end)

--------
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1)
	  RemoveAllPickupsOfType(0xD93F3079)
	  RemoveAllPickupsOfType(0x31FB95FE)
	  RemoveAllPickupsOfType(0xDF711959)
      RemoveAllPickupsOfType(0xF9AFB48F)
      RemoveAllPickupsOfType(0xA9355DCD)
	  RemoveAllPickupsOfType(0xD93F3079)
	  RemoveAllPickupsOfType(0x0BD7C070)
	  RemoveAllPickupsOfType(0x1A88742D)
	  RemoveAllPickupsOfType(0x0A8163F8)
	  RemoveAllPickupsOfType(0xEA91B807)
	  RemoveAllPickupsOfType(0x86500326)
	  RemoveAllPickupsOfType(0xAC581E2E)
	  RemoveAllPickupsOfType(0x98C74B66)
	  RemoveAllPickupsOfType(0x43AAEAE6)
	  RemoveAllPickupsOfType(0x2451A293)
	  RemoveAllPickupsOfType(0xE5EB8146)
	  RemoveAllPickupsOfType(0xA1D4544E)
	  RemoveAllPickupsOfType(0x0A8163F8)
	end
end)
