local baseChannels = {
    ["Général"] = {},
    ["Drogues"] = {},
    ["Armes"] = {}
}

local channels = {}

for k,v in pairs(baseChannels) do
    channels[k] = v
end

local users = {}
RegisterServerEvent("darknet:ActiveMy")
AddEventHandler("darknet:ActiveMy",function(id)
    users[id] = source
end)


AddEventHandler("playerDropped",function()
    for k ,v in pairs(users) do
        if v == source then
            users[k] = nil
        end
    end
end)
RegisterServerCallback("getDarknetInfos", function(source, callback,username)

    MySQL.Async.fetchAll(
        "SELECT * FROM darknet_messages where dest=@username",
        {
            ["@username"] = string.lower(username)
        },
        function(result)

            for i = 1 , #result , 1 do
                result[i].date = os.date("%Y-%m-%d %H:%M:%S", result[i].date)
            end
            callback(result,channels)
        end
    )
end)


RegisterServerEvent("darknet:RegisterChannel")
AddEventHandler("darknet:RegisterChannel",function(name)
    channels[name] = {}

    TriggerClientEvent("darknet:RequestSync",-1,channels)
end)




RegisterServerEvent("darknet:WipeMsg")
AddEventHandler("darknet:WipeMsg",function(username)
    MySQL.Async.execute(
        "DELETE from darknet_messages where dest=@username",
        {
            ["@username"] = username
        }
    )

end)

local channels_src = {}

RegisterServerEvent("darknet:join")
AddEventHandler("darknet:join",function(id)
    local _s = source
    if channels_src[id] == nil then channels_src[id] = {} end

    table.insert(channels_src[id],_s)
    TriggerClientEvent("requestSyncDarknet",_s,channels[id])
end) 

RegisterServerEvent("darknet:left")
AddEventHandler("darknet:left",function(id)
    local _s = source
    for i= 1 , #channels_src[id] , 1  do
        if channels_src[id][i] == _s then
            channels_src[id][i] = nil
        end
    end
end) 

RegisterServerEvent("darknet:AddMessageChan")
AddEventHandler("darknet:AddMessageChan",function(t)
    print(json.encode(t))
    t.date = os.date("%Y-%m-%d %H:%M:%S", os.time())
    table.insert(channels[t.channel],t)

    for i = 1 , #channels_src[t.channel] ,1 do
        TriggerClientEvent("requestSyncDarknet",channels_src[t.channel][i],channels[t.channel])
    end
end)



RegisterServerEvent("darknet:DeleteMessage")
AddEventHandler("darknet:DeleteMessage",function(id)
    MySQL.Async.execute(
        "DELETE from darknet_messages where id=@id",
        {
            ["@id"] = id
        }
    )
end)


RegisterServerEvent("darknet:SendMessage")
AddEventHandler("darknet:SendMessage",function(t)
    MySQL.Async.execute(
        "INSERT INTO darknet_messages (src,dest,content,date) VALUES(@src,@dst,@content,@date)",
        {
            ["@src"] = string.lower(t.src),
            ["@dst"] = string.lower(t.dst),
            ["@content"] = t.msg,
            ["@date"] = os.time()
        }
    )


    if users[t.dst] ~= nil then
        TriggerClientEvent("RageUI:Popup",users[t.dst],{message="~r~DarkNet\n~s~Nouveau message !"})
    end
end)




