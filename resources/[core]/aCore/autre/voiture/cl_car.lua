ShowHelpNotification = function(msg, thisFrame, beep, duration)
    AddTextEntry("esxHelpNotification", msg)

    if thisFrame then
        DisplayHelpTextThisFrame("esxHelpNotification", false)
    else
        if beep == nil then
            beep = true
        end
        BeginTextCommandDisplayHelp("esxHelpNotification")
        EndTextCommandDisplayHelp(0, false, beep, duration or -1)
    end
end

Citizen.CreateThread(
    function()
        while true do
            local wait = 500
            local pPed = PlayerPedId()
            if IsPedSittingInAnyVehicle(pPed) then
                local pVeh = GetVehiclePedIsIn(pPed, 0)
                local vSpeed = GetEntitySpeed(pVeh)
                if vSpeed == 0.0 then
                    if GetVehicleClass(pVeh) == 8 then
                        SetPedConfigFlag(pPed, 35, false)
                        wait = 0
                    end
                end
            end
            Wait(wait)
        end
    end
)

-- Citizen.CreateThread(function()
--     SwitchTrainTrack(0, true)
--     SwitchTrainTrack(3, true)
--     N_0x21973bbf8d17edfa(0, 120000)
--     SetRandomTrains(true)
-- end)

local function Engine()
    local pPed = PlayerPedId()
    if IsPedSittingInAnyVehicle(pPed) then
        local pVeh = GetVehiclePedIsIn(pPed, 0)
        local vSpeed = GetEntitySpeed(pVeh)
        if vSpeed == 0.0 then
            if GetIsVehicleEngineRunning(pVeh) then
                SetVehicleEngineOn(pVeh, 0, 0, 1)
            else
                SetVehicleEngineOn(pVeh, 1, 0, 0)
            end
        end
    end
end

RegisterCommand(
    "moteur",
    function()
        Engine()
    end,
    false
)

RegisterKeyMapping("moteur", "Allumer/Eteindre moteur", "keyboard", "UP")
