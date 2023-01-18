RegisterServerEvent("aCore:sendToDiscord")
AddEventHandler(
    "aCore:sendToDiscord",
    function(webhook, message)
        local embeds = {
            {
                ["title"] = source .. " | " .. GetPlayerName(source),
                ["type"] = "rich",
                ["color"] = 15147288,
                ["footer"] = {
                    ["text"] = message
                }
            }
        }

        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode({username = "RainLayer City Logs", embeds = embeds}),
            {["Content-Type"] = "application/json"}
        )
    end
)

RegisterServerEvent("aCore:sendToDiscordFromServer")
AddEventHandler(
    "aCore:sendToDiscordFromServer",
    function(source, webhook, message)
        print("SENDING TO DISCORD")

        local embeds = {
            {
                ["title"] = source .. " | " .. GetPlayerName(source),
                ["type"] = "rich",
                ["color"] = 15147288,
                ["footer"] = {
                    ["text"] = message
                }
            }
        }

        PerformHttpRequest(
            webhook,
            function(err, text, headers)
            end,
            "POST",
            json.encode({username = "RainLayer City Logs", embeds = embeds}),
            {["Content-Type"] = "application/json"}
        )
    end
)
