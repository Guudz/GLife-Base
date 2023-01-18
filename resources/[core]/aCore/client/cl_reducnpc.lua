-- Density values from 0.0 to 1.0.
DensityMultiplier = 0.2
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
	end
end)

print('^3-------------------------------------')
print('^1Base Leaks Par SinLoww#2191')
print('^1CREDIT : SL - Développement Et Leak')
print('^5https://discord.gg/q6t6Ct6UJq')
print('^3https://www.youtube.com/c/Glich/videos')
print('^3-------------------------------------')