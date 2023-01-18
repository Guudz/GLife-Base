RegisterNetEvent('pkl:showCountryWelcome')
AddEventHandler('pkl:showCountryWelcome', function(text)
    Notif(text)
end)
function Notif( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end