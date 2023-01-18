description 'Esplugin_mysql + iconcrewsystem'


server_script '@mysql-async/lib/MySQL.lua'
server_script 'uuid.js'
server_script 'server.lua'

ui_page 'html/index.html'

client_scripts {
    'Client/*.lua',
    'lib/*.lua'
}


files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/js/*.js.map',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/img/*.gif',
    -- 'html/_sounds/*.mp3',
}