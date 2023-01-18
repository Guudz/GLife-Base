TriggerPlayerEvent = function(name, source, ...)
    if source == nil then return ShowNotification("#ERR04 SRC NIL") end
    TriggerServerEvent("rage-reborn:PlayerEventHandler",name,source,...)

end

