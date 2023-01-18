Citizen.CreateThread(function()
    while true do
        Wait(0)
        local Player = LocalPlayer()
        if Player.Handcuff then
            Player.isBusy = true
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 114, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 288, true)
            DisableControlAction(0, 289, true)
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 166, true)
            DisableControlAction(0, 167, true)
            DisableControlAction(0, 168, true)
            DisableControlAction(0, 57, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 0, true)
            DisableControlAction(0, 26, true)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Wait(200)
        local Player = LocalPlayer()
        if Player.Handcuff then
            if  not IsEntityPlayingAnim(Player.Ped, "mp_arresting", "idle", 49) then
                TaskPlayAnim(Player.Ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            end

        end
    end
end)
local function ShowNotification(msg)
    RageUI.Popup({message=msg})
end
local HandCuffObj = nil
RegisterNetEvent('player:HandCuff')
AddEventHandler('player:HandCuff', function(m)
    local Player = LocalPlayer()
    Player.Handcuff = m
    if m then
        local playerPed = LocalPlayer().Ped
        DecorSetBool(playerPed,"Handcuffed",true)

        
        ShowNotification('Vous avez été ~r~menotté.')
        SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
        Citizen.CreateThread(function()
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Wait(100)
            end
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            SetEnableHandcuffs(playerPed, true)
            SetPedCanPlayGestureAnims(playerPed, false)

        end)
        local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
        HandCuffObj = CreateObject(GetHashKey("p_cs_cuffs_02_s"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        
        AttachEntityToEntity(HandCuffObj, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), -0.04, 0.06, 0.02, -90.0, -25.0, 80.0, 1, 0, 0, 0, 0, 1)
    else
        DecorSetBool(playerPed,"Handcuffed",false)
        local playerPed = LocalPlayer().Ped
        ShowNotification('Vous avez été ~g~démenotté.')
        Citizen.CreateThread(function()
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
        end)
        DeleteObject(HandCuffObj)
    end
end)