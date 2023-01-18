



RegisterNetEvent('ShowCarteGrise')
AddEventHandler('ShowCarteGrise', function(data)
	if data ~= false then
		SendNUIMessage({
			action = 'showCards',
			data = data
		})
		Wait(5000)
		SendNUIMessage({
			action = 'hide'
		})
	else
		SendNUIMessage({
			action = 'hide'
		})
	end
end)


