Citizen.CreateThread(function()
	while true do
        -- This is the Application ID (Replace this with you own)
		SetDiscordAppId(732026007326031933)

        -- Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('RainLayer City')
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('discord')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('https://discord.gg/rainlayercity')


        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        ]]--
        SetDiscordRichPresenceAction(0, "🔊 DISCORD", "https://discord.gg/rainlayercity")
        SetDiscordRichPresenceAction(1, "🎮 SE CONNECTER", "fivem://connect/91.134.153.226:30120")

        -- It updates every minute just in case.
		Citizen.Wait(60000)
	end
end)