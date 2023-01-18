RegisterServerEvent("player:serviceOn")
RegisterServerEvent("player:serviceOff")
RegisterServerEvent("call:makeCall")
RegisterServerEvent("call:makeCall2")
RegisterServerEvent("service:showOnDuty")
RegisterServerEvent("call:getCall")

local inService = {
    ["ltd"] = {},
    ["police"] = {},
    ["lssd"] = {},
    ["lsms"] = {},
    ["mecano"] = {}
}
local callActive = {
    ["ltd"] = {taken = false},
    ["police"] = {taken = false},
    ["lssd"] = {taken = false},
    ["lsms"] = {taken = false},
    ["mecano"] = {taken = false}
}
local timing = 60000

-- Add the player to the inService table
AddEventHandler(
    "player:serviceOn",
    function(job)
        local source = source
        --job)
        -- ("Prise de service !!")
        if inService[job] == nil then
            inService[job] = {}
        end
        table.insert(inService[job], source)
        --json.encode(inService[job]))
    end
)

-- Remove the player to the inService table
AddEventHandler(
    "player:serviceOff",
    function(job)
        local source = source
        if job == nil then
            for _, v in pairs(inService) do
                removeService(source, _)
            end
        else
            removeService(source, job)
        end
    end
)
AddEventHandler(
    "call:makeCall2",
    function(job, pos, message, author)
        local source = source
        --job)
        --(job,pos,message)
        if callActive[job] == nil then
            callActive[job] = {}
        end
        -- Players can't call simultanously the same service
        if callActive[job].taken then
            --    TriggerClientEvent("target:call:taken", callActive[job].target, 2)
            CancelEvent()
        end
        -- Save the target of the call
        callActive[job].target = source
        callActive[job].taken = true
        -- Send notif to all players in service
        --(json.encode(inService[job]))
        --(inService[job])
        if inService[job] == nil then
            inService[job] = {}
        end
        for _, player in pairs(inService[job]) do
            --player)
            --(player , "send to")
            TriggerClientEvent("call:callIncoming2", player, job, pos, message, author)
        end
        -- Say to the target after 'timing' seconds that nobody will come
        SetTimeout(
            timing,
            function()
                if callActive[job].taken then
                -- TriggerClientEvent("target:call:taken", callActive[job].target, 0)
                end
                callActive[job].taken = false
            end
        )
    end
)

AddEventHandler(
    "service:showOnDuty",
    function(job)
        local source = source
        local playersOnDutyAndName = {}
        if (inService[job] == nil) then
            TriggerClientEvent("service:showOnDutyClient", source, playersOnDutyAndName)
        else
            for _, player in pairs(inService[job]) do
                --player)
                --(player , "send to")
                if (player ~= nil) then
                    table.insert(playersOnDutyAndName, GetPlayerName(source))
                end
            end
            TriggerClientEvent("service:showOnDutyClient", source, job, playersOnDutyAndName)
        end
    end
)

-- Receive call event
AddEventHandler(
    "call:makeCall",
    function(job, pos, message, author)
        local source = source
        --job)
        --(job,pos,message)
        if callActive[job] == nil then
            callActive[job] = {}
        end
        -- Players can't call simultanously the same service
        if callActive[job].taken then
            --  TriggerClientEvent("target:call:taken", callActive[job].target, 2)
            CancelEvent()
        end
        -- Save the target of the call
        callActive[job].target = source
        callActive[job].taken = true
        -- Send notif to all players in service
        --(json.encode(inService[job]))
        --(inService[job])
        if inService[job] == nil then
            inService[job] = {}
        end
        for _, player in pairs(inService[job]) do
            --player)
            --(player , "send to")
            TriggerClientEvent("call:callIncoming", player, job, pos, message, author)
        end
        -- Say to the target after 'timing' seconds that nobody will come
        SetTimeout(
            timing,
            function()
                if callActive[job].taken then
                    TriggerClientEvent("target:call:taken", callActive[job].target, 0)
                end
                callActive[job].taken = false
            end
        )
    end
)

RegisterServerEvent("gcPhone:CallServerNumber")
AddEventHandler(
    "gcPhone:CallServerNumber",
    function(number)
        for _, player in pairs(inService[number]) do
            --TriggerEvent("tonnio:MakeServiceCall", player,number,source)
            --  TriggerClientEvent("call:callIncoming", player, job, pos, message)
        end
    end
)

AddEventHandler(
    "call:getCall2",
    function(job)
        callActive[job].taken = false
        -- Say to other in service people that the call is taken
        for _, player in pairs(inService[job]) do
            if player ~= source then
                TriggerClientEvent("call:taken", player, GetPlayerName(source))
            end
        end
        -- Say to a target that someone come
        if not callActive[job].taken then
        --  TriggerClientEvent("target:call:taken", callActive[job].target, 1)
        end
    end
)

AddEventHandler(
    "call:getCall",
    function(job, y)
        callActive[job].taken = false
        -- Say to other in service people that the call is taken
        for _, player in pairs(inService[job]) do
            if player ~= source then
                TriggerClientEvent("call:taken", player, GetPlayerName(source))
            end
        end
        -- Say to a target that someone come
        if not callActive[job].taken and not y then
            TriggerClientEvent("target:call:taken", callActive[job].target, 1)
        end
    end
)

function removeService(player, job)
    for i, val in pairs(inService[job]) do
        if val == player then
            table.remove(inService[job], i)
            return
        end
    end
end

RegisterServerEvent("core:SetService")
AddEventHandler(
    "core:SetService",
    function(job, bool)
        if inService[job] == nil then
            inService[job] = {}
        end

        if bool then
            table.insert(inService[job], source)
        else
            local source = source
            if job == nil then
                for _, v in pairs(inService) do
                    removeService(v)
                end
            end
            removeService(source, job)
        end

        local player = Player.GetPlayer(source)
        player.service = bool
    end
)

RegisterServerCallback(
    "GetJobServices",
    function(source, callback)
        --(json.encode(inService))
        callback(inService)
    end
)

RegisterServerCallback(
    "service:Count",
    function(source, callback, job)
        if inService[job] ~= nil then
            callback(#inService[job])
        else
            --print("job = nil")
            callback(0)
        end
    end
)
local mmm = {}
RegisterServerEvent("braquage:Add")
AddEventHandler(
    "braquage:Add",
    function(cur)
        mmm[cur] = GetGameTimer()
    end
)
RegisterServerCallback(
    "braquage:Get",
    function(_source, callback, cur)
        if (mmm[cur] == nil) then
            callback(true)
        elseif (mmm[cur] ~= nil and (((GetGameTimer() - mmm[cur]) / 1000) > 3600)) then
            callback(true)
        else
            callback(false)
        end
    end
)

AddEventHandler(
    "playerDropped",
    function(reason)
        for _, v in pairs(inService) do
            removeService(source, _)
        end
        print("Player " .. GetPlayerName(source) .. " dropped (Reason: " .. reason .. ")")

        TriggerEvent(
            "aCore:sendToDiscordFromServer",
            source,
            "https://discord.com/api/webhooks/842992237431881750/JJjrJcdhmrrB1DTb4knVTf2gqjbUz0tVgib6n0R2LDPyGoEkkUtkLvml7nlJJXyaurxQ",
            GetPlayerName(source) .. " se deconnecte (Raison : " .. reason .. ")"
        )
    end
)
