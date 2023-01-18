RMenu.Add(
    "personnal",
    "vehicule",
    RageUI.CreateSubMenu(RMenu:Get("personnal", "main"), "Véhicule", "Actions disponibles")
)
local pos = {
    {name = "Poste de police Central", pos = {x = 409.93, y = -985.60, z = 28.26}},
    {name = "Hopital Central", pos = {x = 363.05, y = -591.44, z = 28.68}},
    {name = "Gouvernement", pos = {x = -542.13, y = -209.36, z = 36.65}},
    {name = "Banque Centrale", pos = {x = 238.11, y = 196.64, z = 105.13}},
    {name = "Supprimer", pos = false}
}
local Ind = 1
local IndW = 1
local IndD = 1
local IndL = 1
local slideNameToBlip = {
    ["Superette"] = 52,
    ["ATM"] = 434,
    ["Station service"] = 361,
    ["Vêtements"] = 73,
    ["Barbier"] = 71,
    ["Armes"] = 313,
    ["Tatouages"] = 75
}
local windowsData = {}
local windowsDataLabel = {"Avant gauche", "Avant droite", "Arrière gauche", "Arrière droite"}
local doorDataLabel = {"Avant gauche", "Avant droite", "Arrière gauche", "Arrière droite", "Capot", "Coffre"}
local limiteDataLabel = {
    "Aucun",
    "30 km/h",
    "40 km/h",
    "50 km/h",
    "70 km/h",
    "80 km/h",
    "90 km/h",
    "110 km/h",
    "130 km/h",
    "150 km/h"
}

Citizen.CreateThread(
    function()
        local xPos = {}
        for i = 1, #pos, 1 do
            xPos[i] = pos[i].name
        end

        for k, v in pairs(slideNameToBlip) do
            table.insert(xPos, k)
            pos[#pos + 1] = {name = k, pos = v}
        end

        if #windowsData == 0 then
            for i = 0, 3 do
                windowsData[i] = true
            end
        end

        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("personnal", "vehicule")) then
                local veh = GetVehiclePedIsIn(PlayerPedId())
                if veh == 0 then
                    RageUI.GoBack()
                end

                RageUI.DrawContent(
                    {header = true, glare = true},
                    function()
                        RageUI.List(
                            "GPS Rapide",
                            xPos,
                            Ind,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                if Active then
                                    Ind = Index
                                end

                                if Selected then
                                    local plyPos = GetEntityCoords()
                                    local target = pos[Ind].pos
                                    if not target then
                                        ClearGpsPlayerWaypoint()
                                        ShowAboveRadarMessage("~r~Marqueur supprimé.")
                                        return
                                    end
                                    if type(target) ~= "table" then
                                        local blip = GetFirstBlipInfoId(target)
                                        if blip == 0 or isSearching then
                                            return
                                        end

                                        Citizen.CreateThread(
                                            function()
                                                local nextBlip = blip
                                                isSearching = true
                                                while nextBlip ~= 0 do
                                                    Citizen.Wait(50)
                                                    if
                                                        GetDistanceBetweenCoords(plyPos, GetBlipCoords(nextBlip), true) <
                                                            GetDistanceBetweenCoords(plyPos, GetBlipCoords(blip), true)
                                                     then
                                                        blip = nextBlip
                                                    end
                                                    nextBlip = GetNextBlipInfoId(target)
                                                end

                                                isSearching = false
                                                SetNewWaypoint(GetBlipCoords(blip))
                                                ShowAboveRadarMessage(
                                                    "Vous avez placé un marqueur sur ~g~" ..
                                                        xPos[Ind] ..
                                                            "~w~ à ~g~" ..
                                                                math.floor(
                                                                    GetDistanceBetweenCoords(
                                                                        LocalPlayer().Pos,
                                                                        GetBlipCoords(blip),
                                                                        true
                                                                    )
                                                                ) ..
                                                                    "m"
                                                )
                                            end
                                        )
                                    else
                                        SetNewWaypoint(target.x, target.y, target.z)
                                        ShowAboveRadarMessage(
                                            "Vous avez placé un marqueur sur ~g~" ..
                                                xPos[Ind] ..
                                                    "~w~ à ~g~" ..
                                                        math.floor(
                                                            GetDistanceBetweenCoords(
                                                                LocalPlayer().Pos,
                                                                target.x,
                                                                target.y,
                                                                target.z,
                                                                true
                                                            )
                                                        ) ..
                                                            "m"
                                        )
                                    end
                                end
                            end
                        )

                        RageUI.List(
                            "Fenêtre",
                            windowsDataLabel,
                            IndW,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                IndW = Index
                                if Selected then
                                    local i = Index - 1
                                    local boolOpen = windowsData[i]
                                    if boolOpen then
                                        RollDownWindow(veh, i)
                                    else
                                        RollUpWindow(veh, i)
                                    end
                                    ShowAboveRadarMessage(
                                        "Fenêtre ~b~" ..
                                            windowsDataLabel[Index] ..
                                                "~w~ " .. (boolOpen and "baissée" or "relevée") .. "."
                                    )
                                    windowsData[i] = not boolOpen
                                end
                            end
                        )

                        RageUI.List(
                            "Portes",
                            doorDataLabel,
                            IndD,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                IndD = Index
                                if Selected then
                                    local i = Index - 1
                                    local boolOpen = GetVehicleDoorAngleRatio(veh, i) > .0
                                    if not boolOpen or boolOpen == 0 then
                                        SetVehicleDoorOpen(veh, i)
                                    else
                                        SetVehicleDoorShut(veh, i)
                                    end
                                    ShowAboveRadarMessage(
                                        "Porte ~b~" ..
                                            doorDataLabel[Index] ..
                                                "~w~ " .. (not boolOpen and "fermée" or "ouverte") .. "."
                                    )
                                end
                            end
                        )

                        RageUI.List(
                            "Limitateur",
                            limiteDataLabel,
                            IndL,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                IndL = Index
                                if Selected then
                                    if limiteDataLabel[IndL] == "Aucun" then
                                        Citizen.InvokeNative(0xBAA045B4E42F3C06, veh, 20000.0)
                                    else
                                        local speed = stringsplit(limiteDataLabel[IndL], " ")
                                        speed = tonumber(speed[1])
                                        if not speed then
                                            Citizen.InvokeNative(0xBAA045B4E42F3C06, veh, -1)
                                            SetVehicleEngineTorqueMultiplier(veh, 1.0)
                                            return
                                        end

                                        Citizen.InvokeNative(0xBAA045B4E42F3C06, veh, speed / 3.6)
                                        SetVehicleEnginePowerMultiplier(veh, math.max(0.0, math.min(1.0, speed / 100)))
                                    end
                                end
                            end
                        )

                        RageUI.Checkbox(
                            "Moteur",
                            nil,
                            GetIsVehicleEngineRunning(veh),
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    SetVehicleEngineOn(veh, not GetIsVehicleEngineRunning(veh), false, true)
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end
        end
    end
)
function stringsplit(inputstr, sep)
    if not inputstr then
        return
    end
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
