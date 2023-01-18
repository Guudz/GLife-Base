resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Instance + RP-Radio'

version '1.1.0'

server_scripts {
	--'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}


client_scripts {
	--'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua'
}

ui_page "rp-radio/index.html"

dependencies {
	"mumble-voip",
}

files {
	"rp-radio/index.html",
	"rp-radio/on.ogg",
	"rp-radio/off.ogg",
}

client_scripts {
	"rp-radio/config.lua",
	"rp-radio/client.lua",
}

client_scripts {
    "rp-radio/AC-Sync.lua",
}

server_scripts {
	"rp-radio/server.lua",
}