-- REWRITE BY Max Golf#0001 --

local myJob = nil
Citizen.CreateThread(
    function()
        -- Update the door list
        exports["aCore"]:TriggerServerCallback(
            "sc-doors:getDoorState",
            function(doorState)
                for index, state in pairs(doorState) do
                    Config.DoorList[index].locked = state
                end
            end
        )
    end
)

function DrawText3DTest(coords, text, size)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent("sc-doors:setDoorState")
AddEventHandler(
    "sc-doors:setDoorState",
    function(index, state)
        Config.DoorList[index].locked = state
    end
)
Citizen.CreateThread(
    function()
        while true do
            Wait(8000)
            TriggerEvent(
                "getmyjobname",
                function(k)
                    myJob = k
                end
            )
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())

            for k, v in ipairs(Config.DoorList) do
                v.isAuthorized = isAuthorized(v)

                if v.doors then
                    for k2, v2 in ipairs(v.doors) do
                        if v2.object and DoesEntityExist(v2.object) then
                            if k2 == 1 then
                                v.distanceToPlayer = #(playerCoords - GetEntityCoords(v2.object))
                            end

                            if v.locked and v2.objHeading and (GetEntityHeading(v2.object)) ~= v2.objHeading then
                                SetEntityHeading(v2.object, v2.objHeading)
                            end
                        else
                            v.distanceToPlayer = nil
                            v2.object = GetClosestObjectOfType(v2.objCoords, 1.0, v2.objHash, false, false, false)
                        end
                    end
                else
                    if v.object and DoesEntityExist(v.object) then
                        v.distanceToPlayer = #(playerCoords - GetEntityCoords(v.object))

                        if v.locked and v.objHeading and (GetEntityHeading(v.object)) ~= v.objHeading then
                            SetEntityHeading(v.object, v.objHeading)
                        end
                    else
                        v.distanceToPlayer = nil
                        v.object = GetClosestObjectOfType(v.objCoords, 1.0, v.objHash, false, false, false)
                    end
                end
            end

            Citizen.Wait(500)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local letSleep = true

            for k, v in ipairs(Config.DoorList) do
                if v.distanceToPlayer and v.distanceToPlayer < 50 then
                    letSleep = false

                    if v.doors then
                        for k2, v2 in ipairs(v.doors) do
                            FreezeEntityPosition(v2.object, v.locked)
                        end
                    else
                        FreezeEntityPosition(v.object, v.locked)
                    end
                end

                if v.distanceToPlayer and v.distanceToPlayer < v.maxDistance then
                    local size, displayText = 1, ("[E] Fermer")

                    if v.size then
                        size = v.size
                    end
                    if v.locked then
                        displayText = ("[E] Ouvrir")
                    end
                    --if v.isAuthorized then displayText = _U('press_button', displayText) end

                    DrawText3DTest(v.textCoords, displayText, wsize)
                    --ESX.Game.Utils.DrawText3D(v.textCoords, displayText, size)

                    if IsControlJustReleased(0, 38) then
                        if v.isAuthorized then
                            v.locked = not v.locked
                            TriggerEvent("dooranim")
                            TriggerServerEvent("sc-doors:updateState", k, v.locked) -- broadcast new state of the door to everyone
                        end
                    end
                end
            end

            if letSleep then
                Citizen.Wait(500)
            end
        end
    end
)

function isAuthorized(door)
    for k, job in pairs(door.authorizedJobs) do
        if job == myJob then
            return true
        end
    end

    return false
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

RegisterNetEvent("dooranim")
AddEventHandler(
    "dooranim",
    function()
        ClearPedSecondaryTask(PlayerPedId())
        loadAnimDict("anim@heists@keycard@")
        TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
        Citizen.Wait(850)
        ClearPedTasks(PlayerPedId())
    end
)
