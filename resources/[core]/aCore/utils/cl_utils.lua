local relationshipTypes = {
    "PLAYER",
    "SECURITY_GUARD",
    "PRIVATE_SECURITY",
    "FIREMAN",
    "GANG_1",
    "GANG_2",
    "GANG_9",
    "GANG_10",
    "AMBIENT_GANG_LOST",
    "AMBIENT_GANG_MEXICAN",
    "AMBIENT_GANG_FAMILY",
    "AMBIENT_GANG_BALLAS",
    "AMBIENT_GANG_MARABUNTE",
    "AMBIENT_GANG_CULT",
    "AMBIENT_GANG_SALVA",
    "AMBIENT_GANG_WEICHENG",
    "AMBIENT_GANG_HILLBILLY",
    "DEALER",
    "HATES_PLAYER",
    "HEN",
    "NO_RELATIONSHIP",
    "SPECIAL",
    "MISSION2",
    "MISSION3",
    "MISSION4",
    "MISSION5",
    "MISSION6",
    "MISSION7",
    "MISSION8",
    "ARMY",
    "GUARD_DOG",
    "AGGRESSIVE_INVESTIGATE",
    "MEDIC",
    "CAT"
}

local RELATIONSHIP_HATE = 1

Citizen.CreateThread(
    function()
        while true do
            Wait(50)
            SetPlayerWeaponDamageModifier(GetHashKey("weapon_unarmed"), 0.10)
            for _, group in ipairs(relationshipTypes) do
                SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey("PLAYER"), GetHashKey(group))
                SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey(group), GetHashKey("PLAYER"))
            end
        end
    end
)
local mp_pointing = false
local keyPressed = false
Citizen.CreateThread(
    function()
        -- AntiSpawn Larry's
        while true do
            Wait(50)
            pos = {x = 1222.7, y = 2712.9, z = 38.01}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 500.0,
                pos.y - 500.0,
                pos.z - 500.0,
                pos.x + 500.0,
                pos.y + 500.0,
                pos.z + 500.0
            )
        end
    end
)
Citizen.CreateThread(
    function()
        -- AntiSpawn concess sud
        while true do
            Wait(50)
            pos = {x = -44.02, y = -1098.0, z = 26.42}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 100.0,
                pos.y - 100.0,
                pos.z - 100.0,
                pos.x + 100.0,
                pos.y + 100.0,
                pos.z + 100.0
            )
        end
    end
)
Citizen.CreateThread(
    function()
        -- AntiSpawn concess nord
        while true do
            Wait(50)
            pos = {x = 133.89, y = 6604.01, z = 31.84}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 500.0,
                pos.y - 500.0,
                pos.z - 500.0,
                pos.x + 500.0,
                pos.y + 500.0,
                pos.z + 500.0
            )
        end
    end
)
Citizen.CreateThread(
    function()
        -- AntiSpawn station sandy
        while true do
            Wait(50)
            pos = {x = 1986.10, y = 3785.63, z = 34.65}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 500.0,
                pos.y - 500.0,
                pos.z - 500.0,
                pos.x + 500.0,
                pos.y + 500.0,
                pos.z + 500.0
            )
        end
    end
)
Citizen.CreateThread(
    function()
        -- AntiSpawn FlyWheels Garage
        while true do
            Wait(50)
            pos = {x = 1806.64, y = 3392.35, z = 41.44}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 500.0,
                pos.y - 500.0,
                pos.z - 500.0,
                pos.x + 500.0,
                pos.y + 500.0,
                pos.z + 500.0
            )
        end
    end
)
Citizen.CreateThread(
    function()
        -- AntiSpawn LSPD
        while true do
            Wait(50)
            pos = {x = 408.50, y = -988.39, z = 29.26}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 500.0,
                pos.y - 500.0,
                pos.z - 500.0,
                pos.x + 500.0,
                pos.y + 500.0,
                pos.z + 500.0
            )
        end
    end
)
Citizen.CreateThread(
    function()
        -- AntiSpawn LSPD 2
        while true do
            Wait(50)
            pos = {x = 437.58, y = -1022.08, z = 28.64}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 500.0,
                pos.y - 500.0,
                pos.z - 500.0,
                pos.x + 500.0,
                pos.y + 500.0,
                pos.z + 500.0
            )
        end
    end
)
Citizen.CreateThread(
    function()
        -- AntiSpawn Concess NORD (sud)
        while true do
            Wait(50)
            pos = {x = 533.85, y = -179.67, z = 54.37}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 500.0,
                pos.y - 500.0,
                pos.z - 500.0,
                pos.x + 500.0,
                pos.y + 500.0,
                pos.z + 500.0
            )
        end
    end
)
Citizen.CreateThread(
    function()
        -- Club House AOD
        while true do
            Wait(50)
            pos = {x = 1639.45, y = 4836.45, z = 42.02}
            RemoveVehiclesFromGeneratorsInArea(
                pos.x - 500.0,
                pos.y - 500.0,
                pos.z - 500.0,
                pos.x + 500.0,
                pos.y + 500.0,
                pos.z + 500.0
            )
        end
    end
)
local function startPointing()
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end
local pT = false
function pointKey()
    print(pT)
    if IsPedOnFoot(PlayerPedId()) then
        if not pT then
            startPointing()
        else
            stopPointing()
        end
        pT = not pT
    end
end
RegisterCommand(
    "+poiting",
    function()
        pointKey()
    end,
    false
)
RegisterCommand(
    "-poiting",
    function()
        pointKey()
    end,
    false
)
RegisterCommand(
    "poiting",
    function()
        pointKey()
    end,
    false
)
RegisterKeyMapping("poiting", "Montrer du doigt", "keyboard", "b")
local once = true
local oldval = false
local oldvalped = false
local ishandcuff = false

Citizen.CreateThread(
    function()
        while true do
            Wait(0)

            if once then
                once = false
            end
            if ishandcuff == false then
                if not keyPressed then
                    if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                        Wait(200)
                        if not IsControlPressed(0, 29) then
                            keyPressed = true
                            -- startPointing()
                            mp_pointing = true
                        else
                            keyPressed = true
                            while IsControlPressed(0, 29) do
                                Wait(50)
                            end
                        end
                    elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                        keyPressed = true
                        mp_pointing = false
                    --stopPointing()
                    end
                end

                if keyPressed then
                    if not IsControlPressed(0, 29) then
                        keyPressed = false
                    end
                end
                if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
                    stopPointing()
                end
                if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                    if not IsPedOnFoot(PlayerPedId()) then
                        stopPointing()
                    else
                        local ped = PlayerPedId()
                        local camPitch = GetGameplayCamRelativePitch()
                        if camPitch < -70.0 then
                            camPitch = -70.0
                        elseif camPitch > 42.0 then
                            camPitch = 42.0
                        end
                        camPitch = (camPitch + 70.0) / 112.0

                        local camHeading = GetGameplayCamRelativeHeading()
                        local cosCamHeading = Cos(camHeading)
                        local sinCamHeading = Sin(camHeading)
                        if camHeading < -180.0 then
                            camHeading = -180.0
                        elseif camHeading > 180.0 then
                            camHeading = 180.0
                        end
                        camHeading = (camHeading + 180.0) / 360.0

                        local blocked = 0
                        local nn = 0

                        local coords =
                            GetOffsetFromEntityInWorldCoords(
                            ped,
                            (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)),
                            (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)),
                            0.6
                        )
                        local ray =
                            Cast_3dRayPointToPoint(
                            coords.x,
                            coords.y,
                            coords.z - 0.2,
                            coords.x,
                            coords.y,
                            coords.z + 0.2,
                            0.4,
                            95,
                            ped,
                            7
                        )
                        nn, blocked, coords, coords = GetRaycastResult(ray)

                        Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                        Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                        Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                        Citizen.InvokeNative(
                            0xB0A6CFD2C69C1088,
                            ped,
                            "isFirstPerson",
                            Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4
                        )
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        local isSniper = false
        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()
            local currentWeaponHash = GetSelectedPedWeapon(ped)

            if currentWeaponHash == 100416529 then
                isSniper = true
            elseif currentWeaponHash == 205991906 then
                isSniper = true
            elseif currentWeaponHash == -952879014 then
                isSniper = true
            elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSNIPER_MK2") then
                isSniper = true
            else
                isSniper = false
            end

            if not isSniper then
                HideHudComponentThisFrame(14)
            end

            if IsPedArmed(ped, 6) then
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            SetCreateRandomCops(false) -- disable random cops walking/driving around.
            SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
            SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
            DisablePlayerVehicleRewards(PlayerId())
            local myCoords = GetEntityCoords(PlayerPedId())
            ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 50.0, 0)
            SetPlayerHealthRechargeMultiplier(PlayerPedId(), 0.0)
            SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
            Citizen.Wait(100)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            if GetPlayerWantedLevel(PlayerId()) ~= 0 then
                SetPlayerWantedLevel(PlayerId(), 0, false)
                SetPlayerWantedLevelNow(PlayerId(), false)
                SetPoliceIgnorePlayer(PlayerId(), true)
                SetDispatchCopsForPlayer(PlayerId(), false)
                SetDitchPoliceModels()
            end

            local playerPed = PlayerPedId()
            local playerLocalisation = GetEntityCoords(playerPed)
            ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
        end
    end
)

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

RegisterNetEvent("setVehicleDoors")
AddEventHandler(
    "setVehicleDoors",
    function(veh, doors)
        SetVehicleDoorsLocked(veh, doors)
    end
)
function drawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            HideHudComponentThisFrame(141)
            HideHudComponentThisFrame(14)
            HideHudComponentThisFrame(14)
            HideHudComponentThisFrame(2)
            if not ishandcuff then
            -- if IsControlPressed(1, 323) and IsPedOnFoot(PlayerPedId())  then
            -- 	local ped = PlayerPedId()

            -- 	if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then

            -- 		RequestAnimDict( "random@mugging3" )

            -- 		while ( not HasAnimDictLoaded( "random@mugging3" ) ) do
            -- 			Citizen.Wait( 1 )
            -- 		end

            -- 		if handsup then
            -- 			ClearPedSecondaryTask(ped)
            -- 			handsup = false
            -- 			TriggerServerEvent("core:updateHands",handsup)
            -- 			Citizen.Wait(500)
            -- 		else
            -- 			TaskPlayAnim(ped, "random@mugging3", "handsup_standing_enter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
            -- 			Wait(100)
            -- 			TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
            -- 			handsup = true
            -- 			TriggerServerEvent("core:updateHands", handsup)
            -- 			Citizen.Wait(500)
            -- 		end
            -- 	end
            -- end
            end
        end
    end
)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function DisableActions(ped)
    DisableControlAction(1, 140, true)
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    DisableControlAction(1, 37, true)
    DisablePlayerFiring(ped, true)
end

RegisterNetEvent("core:HandCuff")
AddEventHandler(
    "core:HandCuff",
    function(m)
        ishandcuff = m
    end
)
local blessed = false
RegisterNetEvent("changeBlessed")
AddEventHandler(
    "changeBlessed",
    function(bool, time)
        blessed = true
        SetTimeout(
            time,
            function()
                blessed = false
            end
        )
    end
)
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if blessed then
                DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
                DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
                DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
                DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
                DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
                DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
                DisableControlAction(0, 257, true) -- INPUT_ATTACK2
                DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
                DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
                DisableControlAction(0, 24, true) -- INPUT_ATTACK
                DisableControlAction(0, 25, true) -- INPUT_AIM
                DisableControlAction(0, 21, true) -- SHIFT
                DisableControlAction(0, 22, true) -- SPACE
                DisableControlAction(0, 37, true) -- M
            end
        end
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        Citizen.CreateThread(
            function()
                local player = PlayerId()
                local playerPed = PlayerPedId()

                NetworkSetFriendlyFireOption(true)
                SetCanAttackFriendly(playerPed, true, true)
            end
        )
    end
)

--Citizen.CreateThread(function()
--    RequestAnimDict('facials@gen_male@variations@normal')
--    RequestAnimDict('mp_facial')
--
--   while true do
--        Citizen.Wait(300)
--        local myId = PlayerId()
--
--        for _,player in ipairs(GetActivePlayers()) do
--            local boolTalking = NetworkIsPlayerTalking(player)
--
--            if player ~= myId then
--                if boolTalking and not talkingPlayers[player] then
--                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
--                    talkingPlayers[player] = true
--                elseif not boolTalking and talkingPlayers[player] then
--                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
--                    talkingPlayers[player] = nil
--                end
--            end
--        end
--   end
--end)
