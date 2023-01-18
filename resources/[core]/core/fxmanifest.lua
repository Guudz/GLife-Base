fx_version 'adamant'
game 'gta5'

this_is_a_map 'yes'


file 'gabz_timecycle_mods_1.xml'
data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_mods_1.xml'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file('CONTENT_UNLOCKING_META_FILE')('data/**/contentunlocks.meta')
data_file('HANDLING_FILE')('data/**/handling.meta')
data_file('VEHICLE_METADATA_FILE')('data/**/vehicles.meta')
data_file('CARCOLS_FILE')('data/**/carcols.meta')
data_file('VEHICLE_VARIATION_FILE')('data/**/carvariations.meta')
data_file('VEHICLE_LAYOUTS_FILE')('data/**/vehiclelayouts.meta')



server_script "config.lua"
server_script "connectqueue.lua"
server_script "shared/sh_queue.lua"
client_script "shared/sh_queue.lua"
server_script 'server/host_lock.lua'
client_script 'client/empty.lua'

client_scripts {
	"src/RMenu.lua",
	"src/menu/RageUI.lua",
	"src/menu/Menu.lua",
	"src/menu/MenuController.lua",
	"src/components/*.lua",
	"src/menu/elements/*.lua",
	"src/menu/items/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/panels/*.lua",
	"src/menu/windows/*.lua",
}

 
client_script 'AC-Sync.lua'

files({
	'data/**/carcols.meta',
	'data/**/carvariations.meta',
	'data/**/contentunlocks.meta',
	'data/**/handling.meta',
	'data/**/vehiclelayouts.meta',
	'data/**/vehicles.meta'
})


files {
	'interiorproxies.meta',
	'downtown.ymt',
	'html/ui.html',
	'html/app.js',
	'html/style.css',
	'img/seatbelt.png'
}

client_script {
	"config.lua",
--	"client/_utils.lua",
--	"client/entityiter.lua",
--	"client/cl_stopdespawn.lua",
    "client/cl_afkkick.lua",
	"client/cl_police.lua",
	"client/cl_vsync.lua",
	"client/cl_minimap.lua",
	"client/cl_shuffle.lua",
	"client/cl_richpresence.lua",
	"client/cl_weapons.lua",
	"client/cl_mapload.lua",
	"client/cl_instance.lua",
	"client/cl_sheriff.lua",
	"client/cl_connecting.lua",
	"client/cl_telep.lua",
	"client/cl_alock.lua",
	"client/cl_galaxy.lua",
	"client/blips.lua",
	"vehicle_names.lua"

}

server_script {
	"config.lua",
--	"server/_utils.lua",
--	"server/sv_stopdespawn.lua",
	"server/sv_vsync.lua",
	"server/sv_afkkick.lua",
	"server/sv_connecting.lua",
	"server/sv_alock.lua",
	"server/sv_instance.lua"
}

client_scripts({
	'speedometer/client/main.lua'
})

ui_page("speedometer/ui/index.html")

files({
	"speedometer/ui/index.html",
	"speedometer/ui/assets/clignotant-droite.svg",
	"speedometer/ui/assets/clignotant-gauche.svg",
	"speedometer/ui/assets/feu-position.svg",
	"speedometer/ui/assets/feu-route.svg",
	"speedometer/ui/assets/fuel.svg",
	"speedometer/ui/fonts/fonts/Roboto-Bold.ttf",
	"speedometer/ui/fonts/fonts/Roboto-Regular.ttf",
	"speedometer/ui/script.js",
	"speedometer/ui/style.css",
	"speedometer/ui/debounce.min.js"
})

client_scripts {
    'CrewSystem/Client/*.lua',
    '@icon_menu/lib/IconMenu.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
    'CrewSystem/Server/*.lua'
    -- "@mysql-async/lib/MySQL.lua"
}

shared_scripts {
    "CrewSystem/Config.lua"
}

files {
	"@speedometer/ui/index.html",
    'CrewSystem/html/css/*.css',
    'CrewSystem/html/*.css',
    'CrewSystem/html/js/*.js',
    'CrewSystem/html/js/*.js.map',
    'CrewSystem/html/img/*.png',
    'CrewSystem/html/img/*.jpg',
    'CrewSystem/html/img/*.gif',
    -- 'html/_sounds/*.mp3',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "waveshield/configs/config_cl.lua",
    "waveshield/configs/config_sv.lua",
    "waveshield/server.lua",
}

client_scripts {
    "waveshield/configs/config_cl.lua",
    "waveshield/aDetections.lua",
    "waveshield/client.lua",
}