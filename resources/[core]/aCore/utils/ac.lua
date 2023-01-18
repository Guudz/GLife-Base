
local bypass = false
Citizen.CreateThread(function()
    while true do
        Wait(10000)
        group = exports["aCore"]:GetGroup()

        if group == "superadmin" then
            bypass = true
        end
    end
end)
AddEventHandler("esx:getSharedObject",function()
    if not bypass then
        -- ban
    end
end)
Citizen.CreateThread(function()
    while true do
        Wait(1)
        --
    end
end)
