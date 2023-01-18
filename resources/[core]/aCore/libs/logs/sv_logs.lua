RegisterServerEvent("insert:Logs")
AddEventHandler("insert:Logs",function(type,action,detail)
    local k = getPlayerID(source)
    local file = io.open("logs/players/".. string.gsub(k,"steam:","") .. ".txt", "a")
    local time = os.date("%m/%d/%Y %I:%M %p")
    if file then
        file:write("[".. type .."]".."[".. action .."]".." [" .. time .. "] Name: " .. GetPlayerName(source) .. " -> ID: " .. getPlayerID(source) .. " " .. detail .."  \n")
    end
    file:close()
end)

-- get's the player id without having to use bugged essentials
function getPlayerID(source)

    local player = getIdentifiant(GetPlayerIdentifiers(source))
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end