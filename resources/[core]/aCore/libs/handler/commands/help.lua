local KeyList = {
    ["F5"] = "Menu personnel",
    ["F3"] = "Téléphone",
    ["F6"] = "Menu métier",
    ["V"] = "Changer de vue",
}

local function chatMessage(msg)
    TriggerEvent("chatMessage", "^3RainLayer City", {0,255,0}, msg)
end


RegisterCommand("help", function()
    local helpText = ""
    for k , v in pairs(KeyList) do
        helpText = helpText .. "\n ^1[^3" ..k.. "^1]^0 " .. v 
    end
    chatMessage(helpText)
end)

