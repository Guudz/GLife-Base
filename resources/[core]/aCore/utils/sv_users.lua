RegisterServerCallback(
    "onlinePlayers:list",
    function(source, callback)
        local players = {}
        for _, playerId in ipairs(GetPlayers()) do
            table.insert(players, {id = playerId, name = GetPlayerName(playerId)})
        end

        callback(players)
    end
)
