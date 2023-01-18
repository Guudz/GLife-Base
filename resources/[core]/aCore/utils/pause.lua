function SetData()
	players = {}
	for _, player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		table.insert( players, player )
end

	
	local name = GetPlayerName(PlayerId())
	local id = GetPlayerServerId(PlayerId())
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~w~RainLayer ~r~City ~w~| discord.gg/~r~rainlayercity ~w~| ~w~ID : ~r~'..id.. ' ~w~| '..#players.. ' Joueur(s) ~r~Connecté(e)s')
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		SetData()
	end
end)

Citizen.CreateThread(function()
  AddTextEntry('PM_PANE_LEAVE', '~w~Se déconnecter de ~r~RainLayer City') 
end)

Citizen.CreateThread(function()
  AddTextEntry('PM_PANE_QUIT', 'Quitter FiveM 🐌')
end)