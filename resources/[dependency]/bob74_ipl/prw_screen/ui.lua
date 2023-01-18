RegisterNUICallback("exit",function(data, cb)
	SendNUIMessage({
		action = 'hide'
	})
	SetNuiFocus(false, false)
	
end)


RegisterNUICallback("start",function(data, cb)
	local data = data.itemId
	SendNUIMessage({
		action = 'hide'
	})
	SetNuiFocus(false, false)
    newscreen(data)
end)

RegisterCommand("screen", function(src, args, m)
		SendNUIMessage({
			action = 'show'
		})
		SetNuiFocus(true, true)
end)