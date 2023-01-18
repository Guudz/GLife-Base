local save = 0
local oldF = 0
function setOldF(o)
    oldF = o
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000) --5M
        if isLoaded then
            TriggerServerEvent('handler:savePosition', EntityGetCoords(LocalPlayer().Ped))
            if oldF ~= LocalPlayer().FarmLimit then
                TriggerServerEvent('save:FarmLimit', LocalPlayer().FarmLimit)
                oldF = LocalPlayer().FarmLimit
            end
            save = save +1 
            if save == 10 then
                RageUI.Popup({
                    message = "~w~Personnage ~g~\nSynchronisation effectuée.",
                })
                save = 0
            end
        end
    end
end)
