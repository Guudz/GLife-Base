-- Make sure you set this convar:
-- set es_enableCustomData 1

local mReady = false

AddEventHandler('onMySQLReady', function()
    mReady = true
end)

AddEventHandler('es_db:firstRunCheck', function(ip, port)
    -- Not in use
end)

AddEventHandler('es_db:doesUserExist', function(identifier, callback)
    --[[
    MySQL.Async.fetchAll('SELECT * FROM whitelist WHERE identifier = @identifiers', { ["@identifiers"] = identifier }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            if(result[1].character_count ~= result[1].character_limit)then
                callback(false)
            else
                callback(true)
            end
        else
            DropPlayer(source, "Une exception non gérée vient de se produire [es_db:doesUserExist], Merci de contacter un développeur rapidement.")
        end
    end)
    ]]

    MySQL.Async.fetchAll('SELECT * FROM users WHERE `identifier`=@identifier;', { identifier = identifier }, function(users)
        if users[1] then
            callback(true)
        else
            callback(false)
        end
    end)

end)

AddEventHandler('es_db:retrieveUser', function(identifier, callback)
    local Callback = callback
    MySQL.Async.fetchAll('SELECT * FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
        if users[1] then
            Callback(users[1])
        else
            Callback(false)
        end
    end)
end)


AddEventHandler('es_db:createUser', function(identifier, license, cash, bank, callback)
    TriggerEvent('uuid', function(result)
        local user = { uuid = result, identifier = identifier, money = 0, black_money = 0, license = license, group = "user", permission_level = 0 }
        MySQL.Async.execute('INSERT INTO users (`uuid`, `identifier`, `money`, `black_money`, `group`, `permission_level`, `position`,`is_active`) VALUES (@uuid, @identifier, @money, @black_money, @group, @permission_level,@pos,1);', { uuid = user.uuid, identifier = user.identifier, money = user.money, black_money = user.black_money, permission_level = user.permission_level, group = user.group, license = user.license, pos = json.encode({}) }, function(e)
            callback()
        end)
    end)
end)

AddEventHandler('es_db:retrieveLicensedUser', function(license, callback)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE `identifier`=@identifier;', { identifier = license }, function(users)
        if users[1] then
            callback(users[1])
        else
            callback(false)
        end
    end)
end)

AddEventHandler('es_db:doesLicensedUserExist', function(license, callback)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE `license`=@identifier;', { identifier = license }, function(users)
        if users[1] then
            callback(true)
        else
            callback(false)
        end
    end)
end)

AddEventHandler('es_db:updateUser', function(identifier, new, callback)
    Citizen.CreateThread(function()
        local updateString = ""

        local length = tLength(new)
        local cLength = 1
        for k, v in pairs(new) do
            if cLength < length then
                if (type(v) == "number") then
                    updateString = updateString .. "`" .. k .. "`=" .. v .. ","
                else
                    updateString = updateString .. "`" .. k .. "`='" .. v .. "',"
                end
            else
                if (type(v) == "number") then
                    updateString = updateString .. "`" .. k .. "`=" .. v .. ""
                else
                    updateString = updateString .. "`" .. k .. "`='" .. v .. "'"
                end
            end
            cLength = cLength + 1
        end

        -- MySQL.Async.execute('UPDATE users SET ' .. updateString .. ' WHERE `identifier`=@identifier', { identifier = identifier }, function(done)
        --     if callback then
        --         callback(true)
        --     end
        -- end)
    end)
end)

function tLength(t)
    local l = 0
    for k, v in pairs(t) do
        l = l + 1
    end

    return l
end
