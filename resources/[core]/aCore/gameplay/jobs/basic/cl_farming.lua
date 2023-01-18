local CurrentZone
local currentData
local works = 0
local CurrentAction
local isWorking = false
local wannaSTOP = false
local function farmStart()
    --print("1")
    startwork(CurrentZone)
end
local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()

    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end
local function StopCurrentWork(bool)
    isWorking = false
    works = 0
    CurrentData = nil
    wannaSTOP = not wannaSTOP

    --print("works to false")

    showMessageInformation("~r~Vous avez arrêté votre action", 4000)
    -- Sauvegarde de la limite de farm
    TriggerServerEvent("core:SaveLimitFarm",Player.FarmLimit)
    local ped = PlayerPedId()
    if ped then
        ClearPedTasks(ped)
    end
    -- Reset de la zone
    Hint:RemoveAll()
    KeySettings:Clear("controller", "E", CurrentAction)
    KeySettings:Clear("keyboard", "E", CurrentAction)

    KeySettings:ClearAll("E")
    -- Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
    -- KeySettings:Add("keyboard","E",startwork,CurrentAction)
    -- KeySettings:Add("controller","E",startwork,CurrentAction)
end
local function StopCurrentWork2(bool)
    --print("works to falseX")
    if isWorking then
        isWorking = false
        works = 0
        CurrentData = nil
        wannaSTOP = not wannaSTOP
        showMessageInformation("~r~Vous avez arrêté votre action", 4000)
        -- Sauvegarde de la limite de farm
        TriggerServerEvent("core:SaveLimitFarm",Player.FarmLimit)
        local ped = PlayerPedId()
        if ped then
            ClearPedTasks(ped)
        end
        -- Reset de la zone
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", "CurrentAction")
        KeySettings:Clear("controller", "E", "CurrentAction")
    end
end

Citizen.CreateThread(
    function()
        Wait(6000)
        while true do
            Wait(20 * 60000)
            if inServiceS then
                ShowNotification("Voici votre salaire : ~b~" .. Job:GetSalary() .. "$")
                TriggerServerEvent("money:Add", Job:GetSalary())
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(60000)
            if collectgarbage("count") > 13000 then
                collectgarbage()
            end
        end
    end
)
local function Setup()
    for _k, v in pairs(PublicFarm) do
        for k, v in pairs(v) do
            if v.blip ~= "none" then
                local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
                SetBlipSprite(blip, 1)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 0.6)
                SetBlipColour(blip, v.blipcolor)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.blipname)
                EndTextCommandSetBlipName(blip)
            end
            --     --(dump(v))
            Zone:Add(
                v.Pos,
                function()
                    CurrentData = PublicFarm[_k][k]
                    wannaSTOP = false
                    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
                    KeySettings:Add("keyboard", "E", farmStart, k)
                    KeySettings:Add("controller", "E", farmStart, k)
                    CurrentZone = Type
                    CurrentAction = k
                end,
                function()
                    Hint:RemoveAll()
                    KeySettings:Clear("keyboard", "E", k)
                    KeySettings:Clear("controller", "E", k)

                    KeySettings:Clear("keyboard", "E", "CurrentAction")
                    CurrentZone = nil
                    CurrentData = nil
                    CurrentAction = nil
                    isWorking = false
                    StopCurrentWork2()
                end,
                k,
                v.workSize or 1.5
            )
        end
    end
end

local worksP = {
    recolte = {
        fct = function()
            exports["mythic_progbar"]:Progress(
                {
                    name = "poisson_grrr",
                    duration = 5500,
                    label = "⏳ Récolte en cours...",
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = anim
                },
                function(cancelled)
                    if not cancelled then
                        ClearPedTasks(LocalPlayer().Ped)
                    end
                end
            )
            Wait(5500)
         --   Player.FarmLimit = Player.FarmLimit + 1
          if (data.noFarm ~= nil) then
             if (data.noFarm == true) then
         -- nothing
         else
             SetFarmLimit(1)
                 end
         else
             SetFarmLimit(1)
             end
            --print("ok")
        end
        
    },
    recolte2 = {
        fct = function()
            exports["mythic_progbar"]:Progress(
                {
                    name = "poisson_grrr",
                    duration = 5500,
                    label = "⏳ Pêche en cours...",
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = anim
                },
                function(cancelled)
                    if not cancelled then
                        ClearPedTasks(LocalPlayer().Ped)
                    end
                end
            )
            Wait(5500)
                            --   Player.FarmLimit = Player.FarmLimit + 1
                if (data.noFarm ~= nil) then
                    if (data.noFarm == true) then
                        -- nothing
                    else
                        SetFarmLimit(1)
                    end
                else
                    SetFarmLimit(1)
                end
            --print("ok")
        end
    },
    recolte3 = {
        fct = function()
            exports["mythic_progbar"]:Progress(
                {
                    name = "poisson_grrr",
                    duration = 5500,
                    label = "⏳ Pêche en cours...",
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = anim
                },
                function(cancelled)
                    if not cancelled then
                        ClearPedTasks(LocalPlayer().Ped)
                    end
                end
            )
            Wait(5500)
                                        --   Player.FarmLimit = Player.FarmLimit + 1
                                        if (data.noFarm ~= nil) then
                                            if (data.noFarm == true) then
                                                -- nothing
                                            else
                                                SetFarmLimit(1)
                                            end
                                        else
                                            SetFarmLimit(1)
                                        end
            --print("ok")
        end
    },
    recolte4 = {
        fct = function()
            exports["mythic_progbar"]:Progress(
                {
                    name = "poisson_grrr",
                    duration = 5500,
                    label = "⏳ Pêche en cours...",
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = anim
                },
                function(cancelled)
                    if not cancelled then
                        ClearPedTasks(LocalPlayer().Ped)
                    end
                end
            )
            Wait(5500)
                                        --   Player.FarmLimit = Player.FarmLimit + 1
                                        if (data.noFarm ~= nil) then
                                            if (data.noFarm == true) then
                                                -- nothing
                                            else
                                                SetFarmLimit(1)
                                            end
                                        else
                                            SetFarmLimit(1)
                                        end
            --print("ok")
        end
    },
    recolte5 = {
        fct = function()
            exports["mythic_progbar"]:Progress(
                {
                    name = "poisson_grrr",
                    duration = 5500,
                    label = "⏳ Pêche en cours...",
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = anim
                },
                function(cancelled)
                    if not cancelled then
                        ClearPedTasks(LocalPlayer().Ped)
                    end
                end
            )
            Wait(5500)
            --   Player.FarmLimit = Player.FarmLimit + 1
            if (data.noFarm ~= nil) then
            if (data.noFarm == true) then
                -- nothing
                else
                SetFarmLimit(1)
                end
                else
                SetFarmLimit(1)
                end
            --print("ok")
        end
    },
    recolte6 = {
        fct = function()
            exports["mythic_progbar"]:Progress(
                {
                    name = "poisson_grrr",
                    duration = 5500,
                    label = "⏳ Pêche en cours...",
                    useWhileDead = true,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = anim
                },
                function(cancelled)
                    if not cancelled then
                        ClearPedTasks(LocalPlayer().Ped)
                    end
                end
            )
            Wait(5500)
                                        --   Player.FarmLimit = Player.FarmLimit + 1
                                        if (data.noFarm ~= nil) then
                                            if (data.noFarm == true) then
                                                -- nothing
                                            else
                                                SetFarmLimit(1)
                                            end
                                        else
                                            SetFarmLimit(1)
                                        end
            --print("ok")
        end
    },
    traitement = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                exports["mythic_progbar"]:Progress(
                    {
                        name = "poisson_grrr",
                        duration = 5500,
                        label = "⏳ Traitement en cours...",
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        },
                        animation = anim
                    },
                    function(cancelled)
                        if not cancelled then
                            ClearPedTasks(LocalPlayer().Ped)
                        end
                    end
                )
                Wait(5500)
            end
        end
    },
    vente = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        break
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                exports["mythic_progbar"]:Progress(
                    {
                        name = "poisson_grrr",
                        duration = 5500,
                        label = "⏳ Revente en cours...",
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        },
                        animation = anim
                    },
                    function(cancelled)
                        if not cancelled then
                            ClearPedTasks(LocalPlayer().Ped)
                        end
                    end
                )
                Wait(5500)
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    },
    vente2 = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        break
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                exports["mythic_progbar"]:Progress(
                    {
                        name = "poisson_grrr",
                        duration = 5500,
                        label = "⏳ Revente en cours...",
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        },
                        animation = anim
                    },
                    function(cancelled)
                        if not cancelled then
                            ClearPedTasks(LocalPlayer().Ped)
                        end
                    end
                )
                Wait(5500)
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    },
    vente3 = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        break
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                exports["mythic_progbar"]:Progress(
                    {
                        name = "poisson_grrr",
                        duration = 5500,
                        label = "⏳ Revente en cours...",
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        },
                        animation = anim
                    },
                    function(cancelled)
                        if not cancelled then
                            ClearPedTasks(LocalPlayer().Ped)
                        end
                    end
                )
                Wait(5500)
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    },
    vente4 = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        break
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                exports["mythic_progbar"]:Progress(
                    {
                        name = "poisson_grrr",
                        duration = 5500,
                        label = "⏳ Revente en cours...",
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        },
                        animation = anim
                    },
                    function(cancelled)
                        if not cancelled then
                            ClearPedTasks(LocalPlayer().Ped)
                        end
                    end
                )
                Wait(5500)
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    },
    vente5 = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        break
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                exports["mythic_progbar"]:Progress(
                    {
                        name = "poisson_grrr",
                        duration = 5500,
                        label = "⏳ Revente en cours...",
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        },
                        animation = anim
                    },
                    function(cancelled)
                        if not cancelled then
                            ClearPedTasks(LocalPlayer().Ped)
                        end
                    end
                )
                Wait(5500)
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    },
    vente6 = {
        fct = function()
            found = false
            if _type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
                        ShowNotification("~r~Pas assez de " .. Items[data.required[i].name].label)
                        StopCurrentWork()
                        break
                        return
                    else
                        found = true
                    end
                end
            end
            if found then
                exports["mythic_progbar"]:Progress(
                    {
                        name = "poisson_grrr",
                        duration = 5500,
                        label = "⏳ Revente en cours...",
                        useWhileDead = true,
                        canCancel = false,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        },
                        animation = anim
                    },
                    function(cancelled)
                        if not cancelled then
                            ClearPedTasks(LocalPlayer().Ped)
                        end
                    end
                )
                Wait(5500)
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    }
}

local function animsAction(animObj)
    Citizen.CreateThread(
        function()
            if not playAnim then
                local playerPed = PlayerPedId()
                if DoesEntityExist(playerPed) then
                    -- Ckeck if ped exist
                    dataAnim = animObj

                    -- Play Animation
                    RequestAnimDict(dataAnim.lib)
                    while not HasAnimDictLoaded(dataAnim.lib) do
                        Citizen.Wait(0)
                    end
                    if HasAnimDictLoaded(dataAnim.lib) then
                        local flag = 0
                        if dataAnim.loop ~= nil and dataAnim.loop then
                            flag = 1
                        elseif dataAnim.move ~= nil and dataAnim.move then
                            flag = 49
                        end

                        TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                        playAnimation = true
                    end

                    -- Wait end annimation
                    while true do
                        Citizen.Wait(0)
                        if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                            playAnim = false
                            TriggerEvent("ft_animation:ClFinish")
                            break
                        end
                    end
                end -- end ped exist
            end
        end
    )
end
function _type(d)
    return type(d)
end
function startwork(type)
    -- Permet de stopper l'action en appuyant sur E
    if works == 0 then
        Hint:RemoveAll()
        if CurrentData ~= nil then
            KeySettings:Clear("keyboard", "E", CurrentAction)
            KeySettings:Clear("controller", "E", CurrentAction)

            Citizen.CreateThread(
                function()
                    Wait(800)
                    KeySettings:Add("keyboard", "E", StopCurrentWork, "CurrentAction")
                    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ~r~stopper~s~ l'action")
                end
            )
            isWorking = true
            --print("works to true")
            if isWorking and CurrentData ~= nil and not wannaSTOP then
                works = 1
                -- indexation du job (si farm orga ou pas)

                data = CurrentData
                Player = LocalPlayer()
                CurrentAction6 = CurrentAction

                Citizen.CreateThread(
                    function()
                        -- check si on a de la place

                        -- animation
                        if data.anim ~= nil and not wannaSTOP then
                            animsAction(data.anim)
                        end
                        if isWorking and not wannaSTOP then
                            if data.giveitem ~= nil and not Inventory.canReceive(data.giveitem, 1) then
                                StopCurrentWork2()
                                ClearPedTasks(PlayerPedId())
                            end
                            if isWorking and not wannaSTOP then
                                if LocalPlayer().FarmLimit >= 400 and tostring(CurrentAction) ~= "vente" then
                                    StopCurrentWork2()
                                    return ShowNotification("~r~Vous avez atteint votre limite journalière")
                                end
                                if data.required ~= nil then
                                    if _type(data.required) ~= "table" then
                                        deleteRandomItem(data.required)
                                    else
                                        for hh = 1, #data.required, 1 do
                                            for cc = 1, data.required[hh].count, 1 do
                                                deleteRandomItem(data.required[hh].name)
                                            end
                                        end
                                    end
                                end
                                worksP[tostring(CurrentAction)].fct()
                                if data.giveitem ~= nil then
                                    item = {name = data.giveitem}
                                    AddItemtoInv(item)
                                end
                                if data.price ~= nil then
                                    TriggerServerEvent("money:Add", data.price)
                                end
                                showMessageInformation(data.add, 1000)
                                Wait(400)
                                works = 0
                                startwork(type)
                            end
                        end
                        works = 0
                    end
                )
            end
        end
    else
        StopCurrentWork2()
        works = 0
    end
    wannaSTOP = false
end

Citizen.CreateThread(
    function()
        Setup()
    end
)
