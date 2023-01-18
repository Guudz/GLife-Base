Ambulance = {}


function Ambulance.Revive()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

        RequestAnimDict(lib)
        while (not HasAnimDictLoaded(lib)) do Citizen.Wait(0) end
        TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, 0, 0, 0.0, false, false, false)
        local playerPed = PlayerPedId()
        Wait(5000)
        TriggerPlayerEvent("player:Revive",playerId)
    else
        ShowNotification("~r~Aucun joueur proche")
    end
end

function Ambulance.Heal(m)
    TaskStartScenarioInPlace(LocalPlayer().Ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        Wait(5000)
        TriggerPlayerEvent("player:Heal",playerId,m)
        ClearPedTasksImmediately(LocalPlayer().Ped)
    else
        ShowNotification("~r~Aucun joueur proche")
    end
end

function Ambulance.PutCertificat()
    local playerId = GetPlayerServerIdInDirection(5.0)
    if (playerId ~= false) then
        items = {name = "lsms_licences", data = {serial = txtt}}
        AddItemtoInv(items)
        ShowNotification("~w~Vous avez créer cértficat médical" .. txtt)
    else
        RageUI.Popup({message = "~r~Aucun joueur proche"})
    end
end
RegisterNetEvent('player:Heal')
AddEventHandler('player:Heal',function(m)
    local PlayerPed = LocalPlayer().Ped

    if m ~= nil then
        SetEntityHealth(PlayerPed,GetEntityHealth(PlayerPed)+m)
    else
        SetEntityHealth(PlayerPed,GetEntityMaxHealth(PlayerPed))
    end
end)