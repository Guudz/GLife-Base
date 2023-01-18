
local doorState = {}


RegisterServerEvent('sc-doors:updateState')
AddEventHandler('sc-doors:updateState', function(doorIndex, state)

	if  type(doorIndex) == 'number' and type(state) == 'boolean' and Config.DoorList[doorIndex] then
		doorState[doorIndex] = state
		TriggerClientEvent('sc-doors:setDoorState', -1, doorIndex, state)
	end
end)
Citizen.CreateThread(function()
	Wait(500)
	exports["aCore"]:RegisterServerCallback('sc-doors:getDoorState', function(source, cb)
		cb(doorState)
	end)
end)