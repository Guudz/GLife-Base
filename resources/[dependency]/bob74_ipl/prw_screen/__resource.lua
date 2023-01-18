resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
client_script "prw_screen/config.lua"

client_script 'prw_screen/cl_main.lua'
server_script 'prw_screen/sv_main.lua'
client_script 'prw_screen/ui.lua'

ui_page 'prw_screen/html/index.html'

files {
	'prw_screen/html/index.html',
	'prw_screen/html/main.js',
	'prw_screen/html/main.css',
	'prw_screen/html/iphone.png'
}
