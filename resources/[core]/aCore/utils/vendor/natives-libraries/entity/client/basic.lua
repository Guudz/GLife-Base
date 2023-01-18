---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 28/08/2019 22:48
---

---EntityGetCoords
---@param Entity number
---@param callback function
---@return table
function EntityGetCoords(Entity, callback)
    if (Entity ~= nil) then
        Entity = Entity
    else
        Entity = PlayerPedId()
    end
    ---@type table
    local coords = GetEntityCoords(Entity, true)
    ---@type table
    local heading = GetEntityHeading(Entity)
    if callback ~= nil then
        callback(coords.x, coords.y, coords.z, heading)
    end
    return {
        x = coords.x,
        y = coords.y,
        z = coords.z,
        heading = heading
    }
end

function GetDistanceBetween3DCoords(x1, y1, z1, x2, y2, z2)
    if x1 ~= nil and y1 ~= nil and z1 ~= nil and x2 ~= nil and y2 ~= nil and z2 ~= nil then
        return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2 + (z1 - z2) ^ 2)
    end
    return -1
end

---SetCoords
---@param table table
---@return void
---@public
function SetCoords(Entity, table)
    if (Entity ~= nil) then
        Entity = Entity
    else
        Entity = PlayerPedId()
    end
    if table.x ~= nil or table.y ~= nil or table.z ~= nil or table.heading ~= nil then
        SetEntityCoordsNoOffset(PlayerPedId(), table.x, table.y, table.z, false, false, false, true)
        NetworkResurrectLocalPlayer(table.x, table.y, table.z, table.heading, true, true, false)
        SetEntityHeading(PlayerPedId(), table.heading)
        return true
    else
        error("Missing arguments, x or y or z or h")
    end
end

---FreezePlayer
---@param playerId number
---@param freeze boolean
---@return void
function FreezePlayer(playerId, freeze)
    local player = playerId
    SetPlayerControl(player, not freeze, false)
    local ped = GetPlayerPed(player)
    if not freeze then
        -- if not IsEntityVisible(ped) then
        --     SetEntityVisible(ped, true)
        -- end
        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    else
        -- if IsEntityVisible(ped) then
        --     SetEntityVisible(ped, false)
        -- end
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
        if not IsPedFatallyInjured(ped) then
        --      ClearPedTasksImmediately(ped)
        end
    end
end

---GetPlayerInArea
---@param X function
---@param Y number
---@param Z number
---@param Size number
---@return table
---@public
function GetPlayerInArea(X, Y, Z, Size)
    if X or Y or Z ~= nil then
        ---@type table
        local playersInArea = {}
        for _, player in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(player)
            ---@type table
            local targetCoords = GetEntityCoords(GetPlayerPed(player))
            ---@type table
            local distance = GetDistanceBetweenCoords(targetCoords, X, Y, Z, true)
            if distance <= Size then
                table.insert(playersInArea, player)
            end
        end
        return playersInArea
    else
        error("Missing argument : X or Y or Z")
    end
end
