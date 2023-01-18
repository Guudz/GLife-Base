ServerCallbacks = {}

RegisterServerEvent('_trigger_server_callback')
AddEventHandler('_trigger_server_callback', function(name, requestId, ...)
    local _source = source
    TriggerServerCallback(name, requestID, _source, function(...)
        TriggerClientEvent('_server_callback', _source, requestId, ...)
    end, ...)
end)

RegisterServerCallback = function(name, cb)
    ServerCallbacks[name] = cb
end

TriggerServerCallback = function(name, requestId, source, cb, ...)
    if ServerCallbacks[name] ~= nil then
        ServerCallbacks[name](source, cb, ...)
    else
    end
end

local screens = {}
local instances = {
    [0] = {1}
}
RegisterServerCallback("screen:GetInfo",function(source,cb,instanceID)
    if instanceID == nil then
        instanceID = 0
    end
    
    screens[instanceID].Ttime = os.time() - screens[instanceID].time
    cb(screens[instanceID])
end)

RegisterServerEvent("screen:start")
AddEventHandler("screen:start",function(instanceID,url)
    local url = instanceID.url
    instanceID = instanceID.host
    if instanceID == nil then
        instanceID = 0
    end
    if screens[instanceID] == nil then screens[instanceID] = {} end
    screens[instanceID]={url=url,time=os.time()} 
    for i = 1 , #instances[instanceID] , 1 do
        TriggerClientEvent("screenStart",instances[instanceID][i],url)
    end


end)

RegisterServerEvent('instance:enter')
AddEventHandler('instance:enter', function(instance)
    if instances[instance] == nil then
        instances[instance] = {}
    end
    table.insert(instances[instance],source)
end)