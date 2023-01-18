local webhookreport = "https://discord.com/api/webhooks/842992416025477150/t6Xghk3n_W9qez_lQsvxlLfgANRWysLsYv8NcTUMihDEaWiqSaf1ZFj1n-0jobgl3PQd"

RegisterServerEvent("addReportMenuS")
AddEventHandler("addReportMenuS",function(message)
  local date = os.date("%d/%m/%y %X")
  TriggerClientEvent("addReportMenu", -1, source, GetPlayerName(source), message, date)
end)

RegisterServerEvent("sendMessageReport")
AddEventHandler("sendMessageReport",function(id, msg)
  TriggerClientEvent("RageUI:Popup", id,{message = "~r~Staff : ~s~"..msg})
end)

RegisterServerEvent("closeReportS")
AddEventHandler("closeReportS",function(index)
  TriggerClientEvent("RageUI:Popup", source,{message = "~w~le ticket numéro ~r~#"..index.." ~w~a bien était clôturé."})
  TriggerClientEvent("closeReport", -1, index)
  TriggerEvent("aCore:sendToDiscordFromServer", source, webhookreport, GetPlayerName(source).." a clôturé le ticket n°"..index)
end)

RegisterServerEvent("takeReportS")
AddEventHandler("takeReportS",function(index, id, name, msg, date, status)
  local who = GetPlayerName(source)
  TriggerClientEvent("takeReport", -1, index, id, name, msg, date, who, status)
  if status == "true" then pris = " a pris en charge le ticket n°" else pris = " ne prend plus en charge le ticket n°" end
  TriggerEvent("aCore:sendToDiscordFromServer", source, webhookreport, GetPlayerName(source)..pris..index.." de "..name)
end)