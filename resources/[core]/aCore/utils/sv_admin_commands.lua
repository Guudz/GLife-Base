TriggerEvent(
  "es:addCommand",
  "report",
  function(source, args, user)
    TriggerClientEvent(
      "RageUI:Popup",
      source,
      {
        message = "(~r~REPORT~w~) Votre message a bien été envoyé"
      }
    )

    steamID = GetPlayerIdentifiers(source)[1]

    local embeds = {
      {
        ["title"] = source .. " | " .. GetPlayerName(source),
        ["type"] = "rich",
        ["color"] = 16711680,
        ["footer"] = {
          ["text"] = table.concat(args, " ")
        }
      }
    }

    PerformHttpRequest(
      "https://discord.com/api/webhooks/842992416025477150/t6Xghk3n_W9qez_lQsvxlLfgANRWysLsYv8NcTUMihDEaWiqSaf1ZFj1n-0jobgl3PQd",
      function(err, text, headers)
      end,
      "POST",
      json.encode({username = "RainLayer City Report", embeds = embeds}),
      {["Content-Type"] = "application/json"}
    )

  end,
  {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}}
)
