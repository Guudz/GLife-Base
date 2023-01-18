resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"
server_script "@mysql-async/lib/MySQL.lua"

client_script "random.js"
server_script "sv_random.js"

files {
    "statics/data/*.json"
}

server_scripts {
    "utils/vendor/sha1.js",
    "utils/vendor/uuid.js"
}

client_script "autre/rVehicleFailure/client.lua"
client_script "autre/rVehicleFailure/config.lua"
client_script "autre/voiture/cl_car.lua"
client_script "autre/voiture/speedo.lua"
client_script "autre/voiture/drift.lua"
client_script "autre/voiture/chopper_cam/heli_client.lua"
client_script "autre/voiture/sirene/client.lua"
client_script "autre/voiture/vehicle_names.lua"
client_script "autre/logs/client.lua"
client_script "utils/cl_3dme.lua"
client_script "utils/ac.lua"
client_script "utils/cl_weaponme.lua"
client_script "utils/ShowID.lua"
client_script "utils/cl_recul.lua"
client_script "utils/pause.lua"
client_script "utils/cl_utils.lua"
client_script "utils/cl_status.lua"
server_script "autre/voiture/chopper_cam/heli_server.lua"
server_script "autre/voiture/sirene/server.lua"
server_script "autre/rVehicleFailure/server.lua"
server_script "autre/rVehicleFailure/config.lua"
server_script "autre/logs/function.lua"
server_script "autre/logs/logs.lua"
server_script "utils/sv_3dme.lua"
server_script "utils/sv_fuel.lua"


--- Statics data
client_script {
    "statics/assets/Animations.lua",
    "gameplay/illegal/xp/client.lua",
    "statics/assets/coffres.lua",
    "statics/assets/Items.lua",
    "statics/assets/peds.lua",
    "statics/assets/PublicsFarming.lua",
    "statics/assets/tenue_police.lua"
}
server_scripts {
    "statics/assets/Items.lua",
    "statics/assets/Jobs.lua"
}

client_scripts {
    "utils/vendor/rageui/rageui/RageUI.lua",
    "utils/vendor/rageui/rageui/Menu.lua",
    "utils/vendor/rageui/rageui/MenuController.lua",
    "utils/vendor/rageui/components/Rectangle.lua",
    "utils/vendor/rageui/components/Sprite.lua",
    "utils/vendor/rageui/components/Text.lua",
    "utils/vendor/rageui/components/Visual.lua",
    "utils/vendor/rageui/components/Audio.lua",
    "utils/vendor/rageui/components/Scaleform.lua",
    "utils/vendor/rageui/components/Screen.lua",
    "utils/vendor/rageui/rageui/elements/ItemsBadge.lua",
    "utils/vendor/rageui/rageui/elements/ItemsColour.lua",
    "utils/vendor/rageui/rageui/elements/PanelColour.lua",
    "utils/vendor/rageui/rageui/items/UIButton.lua",
    "utils/vendor/rageui/rageui/items/UICheckBox.lua",
    "utils/vendor/rageui/rageui/items/UIList.lua",
    "utils/vendor/rageui/rageui/items/UIProgress.lua",
    "utils/vendor/rageui/rageui/items/UISlider.lua",
    "utils/vendor/rageui/rageui/items/UISliderHeritage.lua",
    "utils/vendor/rageui/rageui/panels/UIColourPanel.lua",
    "utils/vendor/rageui/rageui/panels/UIGridPanel.lua",
    "utils/vendor/rageui/rageui/panels/UIGridPanelHorizontal.lua",
    "utils/vendor/rageui/rageui/panels/UIGridPanelVertical.lua",
    "utils/vendor/rageui/rageui/panels/UIPercentagePanel.lua",
    "utils/vendor/rageui/rageui/windows/UIHeritage.lua",
    "utils/vendor/natives-libraries/entity/client/basic.lua",
    "utils/vendor/natives-libraries/entity/client/ped.lua",
    "utils/vendor/natives-libraries/entity/client/animations.lua",
    "utils/vendor/natives-libraries/entity/client/freemode.lua",
    "utils/vendor/natives-libraries/entity/client.lua",
    "utils/vendor/natives-libraries/streaming/client.lua",
    "utils/vendor/natives-libraries/scaleform/client.lua",
    "utils/vendor/natives-libraries/screen/Prompt.lua",
    "utils/vendor/natives-libraries/screen/KeyboardInput.lua",
    "utils/vendor/natives-libraries/math/client.lua",
    "utils/vendor/natives-libraries/blips/client.lua",
    "utils/vendor/natives-libraries/zones/client.lua",
    "utils/vendor/natives-libraries/vehicle/client.lua",
    "utils/vendor/natives-libraries/zones/marker.lua",
    "utils/vendor/server-callback/client.lua",
    "utils/vendor/RageIB/client.lua",
    "utils/cl_zoneName.lua",
    "utils/cl_deadLog.lua"
}

server_scripts {
    "utils/vendor/server-callback/server.lua",
    "utils/vendor/natives-libraries/player/server.lua",
    "utils/vendor/player-event/sv_trigger.lua",
    "libs/helper/functions.lua",
    "libs/helper/uuid.lua",
    "utils/sv_users.lua",
    "utils/sv_admin_commands.lua",
    "rLock/server.lua",
    "utils/sv_discord_webhooks.lua"
}

client_scripts {
	'carte_grise_ui/client.lua'
}


ui_page 'carte_grise_ui/html/index.html'

files {
	'carte_grise_ui/html/index.html',
	'carte_grise_ui/html/main.js',
	'carte_grise_ui/html/main.css',
}

client_script {
    "libs/handler/commands/cl_commands.lua",
    "libs/handler/commands/help.lua",
    "libs/handler/position/client.lua",
    "libs/handler/spawned/client.lua",
    "libs/helper/functions.lua",
    "libs/helper/uuid.lua",
    "libs/handler/call.lua",
    "libs/handler/comas.lua",
    "libs/handler/key.lua",
    "libs/logs/cl_logs.lua",
    "libs/mugroom/selector/class/camera.lua",
    "libs/mugroom/selector/class/ped.lua",
    "libs/mugroom/selector/selector.lua",
    "libs/mugroom/creator/class/camera.lua",
    "libs/mugroom/creator/class/ped.lua",
    "libs/mugroom/creator/class/ia.lua",
    "libs/mugroom/creator/creator.lua",
    "libs/mugroom/client.lua",
    "libs/player/client/handcuff.lua",
    "libs/player/client/job_handler.lua",
    "libs/player/client/money_handler.lua",
    "libs/player/client/player_handler.lua",
    "libs/player/client/weapons_back.lua",
    "libs/fuel/cl_fuel.lua",
    "libs/compass/cm_essentials.lua",
    "libs/compass/streetname_and_compass.lua"
}

server_scripts {
    "libs/handler/commands/sv_commands.lua",
    "libs/handler/position/server.lua",
    "libs/handler/spawned/server.lua",
    "libs/logs/sv_logs.lua",
    "libs/mugroom/server.lua",
    "libs/player/server/inventory.lua",
    "libs/player/server/player_class.lua",
    "libs/player/server/position.lua",
    "libs/player/server/service.lua",
    "libs/player/server/settings.lua",
    "libs/player/server/skin.lua",
    "libs/player/server/status.lua",
    "libs/player/server/stockages.lua",
    "libs/fuel/sv_fuel.lua"
}

files {
    'autre/loading/index.html',
    'autre/loading/music/load.mp3',
    'autre/loading/img/logo.png',
	'autre/loading/img/bg-1.jpg',
    'autre/loading/img/bg-2.jpg',
    'autre/loading/img/bg-3.jpg',
    'autre/loading/img/bg-4.jpg',
    'autre/loading/img/bg-5.jpg',
    'autre/loading/img/bg-6.jpg',
    'autre/loading/img/bg-7.jpg',
    'autre/loading/img/bg-8.jpg',
    'autre/loading/img/bg-9.jpg',
    'autre/loading/img/bg-10.jpg',
    'autre/loading/img/timeout.png',
	'autre/loading/css/bootstrap.css',
    'autre/loading/css/owl.carousel.css',
	'autre/loading/css/style.css',
    'autre/loading/js/jquery.ajaxchimp.js',
	'autre/loading/js/jquery.backstretch.min.js',
    'autre/loading/js/jquery-1.11.0.min.js',
	'autre/loading/js/lj-safety-first.js',
    'autre/loading/js/owl.carousel.min.js',
}

loadscreen 'autre/loading/index.html'

client_script {
    "ui/menus/handler.lua",
    "ui/menus/cl_fuel.lua",
    "ui/menus/coffre.lua",
    "ui/menus/stockage.lua",
    "ui/menus/personnal/main.lua",
    "ui/menus/personnal/inventory.lua",
    "ui/menus/personnal/animations.lua",
    "ui/menus/personnal/admin.lua",
    "ui/menus/personnal/other.lua",
    "ui/menus/personnal/boss.lua",
    "ui/menus/personnal/vehicule.lua",
    "ui/menus/personnal/wallet.lua",
    "ui/menus/personnal/fouille.lua",
    "ui/menus/mugroom/selector.lua",
    "ui/menus/mugroom/creator/main.lua",
    "ui/menus/mugroom/creator/categories/appearance.lua",
    "ui/menus/mugroom/creator/categories/clothes.lua",
    "ui/menus/mugroom/creator/categories/faceFeature.lua",
    "ui/menus/mugroom/creator/categories/heritage.lua",
    "ui/menus/mugroom/creator/categories/roleplayContent.lua",
    "ui/menus/jobs/ambulance.lua",
    "ui/menus/jobs/mecano.lua",
    "ui/menus/jobs/menuHandlerJob.lua",
    "ui/menus/jobs/police.lua",
    "ui/menus/jobs/tow_menu.lua",
    "ui/menus/crafting/main.lua",
    "ui/menus/computer/main.lua",
    "ui/menus/computer/cameras.lua",
    "ui/menus/computer/casier.lua",
    "ui/menus/computer/mail.lua"
}

client_script {
    "utils/cl_blips.lua",
    "utils/cl_requin.lua",
    "utils/cl_requin2.lua",
    "utils/blips_vagos.lua",
    "utils/cl_carjack.lua",
    "utils/cl_sit.lua",
    "utils/test/cl_test.lua",
    "utils/vendor/player-event/cl_trigger.lua"
}

client_script {
    "gameplay/illegal/drugs/cl_drugbuyer.lua",
    "gameplay/illegal/atm_robbery/client.lua",
    "gameplay/illegal/atm_robbery/config.lua",
    "gameplay/illegal/fleeca/client.lua",
    "gameplay/illegal/fleeca/utk.lua",
    "gameplay/illegal/mission/config.lua",
    "gameplay/illegal/mission/client/*.lua",
    "gameplay/illegal/drugs/npc_sell.lua",
    "gameplay/illegal/clown/cl_central.lua",
    "gameplay/illegal/braquages/cl_shop.lua",
    "gameplay/illegal/labo/client/*.lua",

    "gameplay/illegal/darknet/cl_main.lua",

    "gameplay/items/item_handler_cl.lua",
    "gameplay/jobs/facture.lua",
    "gameplay/jobs/banking/job/client.lua",
    "gameplay/jobs/ammunation/job.lua",
    "gameplay/jobs/basic/*.lua",
    "gameplay/jobs/concess/*.lua",
    "gameplay/jobs/haircut/client.lua",
    "gameplay/jobs/tatoo/client.lua",
    "gameplay/jobs/ponsoboy/client.lua",
    "gameplay/jobs/immo/cl_immo.lua",
    "gameplay/jobs/labo_placer/cl_labo.lua",
    "gameplay/jobs/jobLister/jobLister.lua",
    "gameplay/shops/clothes/*.lua",
    "gameplay/shops/shop/*.lua",
    "gameplay/shops/vehicle/cl_vehshop.lua",
    "gameplay/shops/vehicle/cl_vehshop_nord.lua",
    "gameplay/shops/vehicle/cl_motoshop.lua",
    "gameplay/vehicle/*.lua",
    "gameplay/vehicle/garage/garage.lua",
    "gameplay/vehicle/lock/*.lua",
    "gameplay/vehicle/mecanos/*.lua",
    "gameplay/vehicle/mecanos/tow/cl_tow.lua",
    "gameplay/world/cl_appart.lua",
    "gameplay/world/cl_computer.lua",
    "gameplay/world/cl_anticarjack.lua",
    "gameplay/gym/gym_cfg.lua",
    "gameplay/gym/gym_cl.lua",

    "gameplay/shops/lotery/config.lua",
    "gameplay/shops/lotery/cl_main.lua"
}

server_scripts {
    "gameplay/shops/lotery/config.lua",
    "gameplay/shops/lotery/sv_main.lua",
    "gameplay/illegal/drugs/sv_drugbuyer.lua",
    "gameplay/illegal/labo/server/*.lua",
    "gameplay/illegal/darknet/sv_main.lua",
    "gameplay/illegal/atm_robbery/config.lua",
    "gameplay/illegal/atm_robbery/server.lua",
    "gameplay/illegal/fleeca/server.lua",
    "gameplay/illegal/fleeca/utk.lua",
    "gameplay/illegal/clown/sv_central.lua",
    "gameplay/illegal/mission/config.lua",
    "gameplay/illegal/mission/server/*.lua",
    "gameplay/illegal/status/sv_persistantStatus.lua",
    "gameplay/jobs/banking/banking_class.lua",
    "gameplay/jobs/immo/sv_immo.lua",
    "gameplay/jobs/labo_placer/sv_labo.lua",
    "gameplay/jobs/joblister/sv_jobLister.lua",
    "gameplay/shops/vehicle/sv_vehshop.lua",
    "gameplay/shops/vehicle/sv_vehshop_nord.lua",
    "gameplay/shops/vehicle/sv_motoshop.lua",
    "gameplay/vehicle/garage/sv_garage.lua",
    "gameplay/vehicle/mecanos/tow/sv_tow.lua",
    "gameplay/world/sv_computer.lua"
}


client_scripts {
    "statics/assets/Jobs.lua"
}

client_script "rLock/client.lua"
client_script "rLock/config.lua"
client_script "client/3dme_cl.lua"
client_script "client/cl_reducnpc.lua"
client_script "client/cl_sneax.lua"
client_script "client/cl_boat.lua"
client_script "client/cl_voiture.lua"
client_script "client/cl_carry.lua"
client_script "client/cl_chasse.lua"
client_script "client/pause.lua"
client_script "client/cl_fuel.lua"
client_script "client/cl_utils.lua"
client_script "client/cl_status.lua"
client_script "client/ac.lua"
client_scripts "client/cl_drop.lua"
client_script "client/cl_vehcontrol.lua"
client_script "client/cl_explosion.lua"
client_script "client/clside.lua"
client_script "client/cl_discord.lua"
client_scripts "client/cl_dlarme.lua"

server_script "client/sv_fuel.lua"
server_script "client/sv_sneax.lua"
server_script "client/sv_boat.lua"
server_script "@mysql-async/lib/MySQL.lua"
server_script "client/3dme_sv.lua"
server_script "server/sv_carry.lua"
server_scripts "server/sv_dlarme.lua"
server_scripts "server/sv_vehcontrol.lua"

client_scripts {
	"client/guncontrol/config.lua",
	"client/guncontrol/client.lua"
}
server_scripts {
	"client/guncontrol/config.lua",
	"client/guncontrol/server.lua"
}


-- All Voiture 

files {

	'autre/car/data/**/carcols.meta',
	'autre/car/data/**/carvariations.meta',
	'autre/car/data/**/handling.meta',
	'autre/car/data/**/vehiclelayouts.meta',
	'autre/car/data/**/vehicles.meta',
	'autre/car/data/**/clip_sets.xml',
}

	data_file 'VEHICLE_LAYOUTS_FILE'	'autre/car/data/**/vehiclelayouts.meta'
	data_file 'HANDLING_FILE'			'autre/car/data/**/handling.meta'
	data_file 'VEHICLE_METADATA_FILE'	'autre/car/data/**/vehicles.meta'
	data_file 'CARCOLS_FILE'			'autre/car/data/**/carcols.meta'
	data_file 'VEHICLE_VARIATION_FILE'	'autre/car/data/**/carvariations.meta'
	data_file 'CLIP_SETS_FILE'			'autre/car/data/**/clip_sets.meta'


------------ EXPORTS

export "OnNewPlayerSpawn"
export "OnPlayerSpawn"
export "ShowNotification"
export "TriggerServerCallback"
export "LoadingPrompt"
export "SetCoords"
export "UpdatePlayerPedFreemodeCharacter"
export "GenerateEntityFace"
export "GenerateEntityTattoo"
export "GenerateEntityOutfit"
export "GenerateFreemodeModel"
export "GetItemsData"
export "TriggerPlayerEvent"
server_export "RegisterServerCallback"
export "GetGroup"
export "OpenCar"
