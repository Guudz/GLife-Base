local isWorking = false
local data = {}
local works = 0
local Players = {}
local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

local function ShowNotification(msg)
    RageUI.Popup({message = msg})
end

local worksP = {
    recolte = {
        fct = function()
            if Player.FarmLimit == nil then
                Player.FarmLimit = 0
            end
            if Player.FarmLimit <= 10 then
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
                Wait(35000)
            else
                showMessageInformation("~r~Vous avez atteint la limite de farm", 5500)
            end
        end
    },
    traitement = {
        fct = function()
            found = false
            if type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count <= 0 then
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
                if Player.FarmLimit == nil then
                    Player.FarmLimit = 0
                end

                if (data.noFarm ~= nil) then
                    if (data.noFarm == true) then
                        -- nothing
                    else
                        SetFarmLimit(1)
                    end
                else
                    SetFarmLimit(1)
                end
            else
                ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                StopCurrentWork()
                return
            end
        end
    },
    vente = {
        fct = function()
            found = false
            if type(data.required) ~= "table" then
                if Inventory:GetItemCount(data.required) <= 0 then
                    ShowNotification("~r~Pas assez de " .. Items[data.required].label)
                    StopCurrentWork()
                    return
                else
                    found = true
                end
            else
                for i = 1, #data.required, 1 do
                    if Inventory:GetItemCount(data.required[i].name) - data.required[i].count <= 0 then
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
                        name = "⏳ Revente en cours...",
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

Citizen.CreateThread(
    function()
        while true do
            Wait(3000)
            Player = LocalPlayer()
        end
    end
)
local function animsAction(animObj)
    Citizen.CreateThread(
        function()
            if not playAnim then
                local playerPed = LocalPlayer().Ped
                if DoesEntityExist(playerPed) then
                    -- Ckeck if ped exist
                    dataAnim = animObj

                    -- Play Animation
                    if dataAnim.lib == nil then
                        if dataAnim.scenario ~= nil then
                            TaskStartScenarioInPlace(LocalPlayer().Ped, dataAnim.scenario)
                        end
                    else
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
function ResetFarm()
    works = 0
    Hint:RemoveAll()
    isWorking = false
    data = nil
end

function randomChange(percent) -- returns true a given percentage of calls
    assert(percent >= 0 and percent <= 100) -- sanity check
    return percent >= math.random(1, 100) -- 1 succeeds 1%, 50 succeeds 50%,
end

function Job:StartRecolte(_type)
    -- Permet de stopper l'action en appuyant sur E
    if works == 0 then
        Hint:RemoveAll()
        KeySettings:Clear("keyboard", "E", Job.CurrentAction)
        KeySettings:Clear("controller", 46, Job.CurrentAction)
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ~r~stopper~s~ l'action")
        KeySettings:Add("keyboard", "E", StopCurrentWork, Job.CurrentAction)
        --(Job.CurrentAction)
        isWorking = true
        if isWorking then
            works = 1
            -- indexation du job (si farm orga ou pas)
            if _type == "Jobs" then
                data = Job.Job.work[Job.CurrentAction]
            else
                data = Orga.Job.work[Job.CurrentAction]
            end
            Player = LocalPlayer()
            CurrentAction6 = Job.CurrentAction
            Citizen.CreateThread(
                function()
                    -- check si on a de la place
                    if data ~= nil then
                        if data.giveitem ~= nil then
                            if type(data.giveitem) ~= "table" then
                                if Inventory.CanReceive(data.giveitem, 1) then
                                else
                                    StopCurrentWork()
                                    return
                                end
                            else
                                for hh = 1, #data.giveitem, 1 do
                                    if type(data.giveitem[hh].count) == "table" then
                                        data.giveitem[hh].count =
                                            math.random(data.giveitem[hh].count[1], data.giveitem[hh].count[2])
                                    end
                                    if Inventory.CanReceive(data.giveitem[hh].name, data.giveitem[hh].count) then
                                    else
                                        StopCurrentWork()
                                        return
                                    end
                                end
                            end
                        end
                        -- animation
                        if data.anim ~= nil then
                            animsAction(data.anim)
                        end
                        if LocalPlayer().FarmLimit >= 400 and tostring(data.type) ~= "vente" then
                            return ShowNotification("~r~Vous avez atteint votre limite journalière")
                        end
                        worksP[tostring(data.type)].fct()

                        if isWorking then
                            if data.giveitem ~= nil then
                                if data.giveitemType == nil or data.giveitemType == 0 then
                                    if type(data.giveitem) ~= "table" then
                                        item = {name = data.giveitem}
                                        AddItemtoInv(item)
                                    else
                                        for hh = 1, #data.giveitem, 1 do
                                            if type(data.giveitem[hh].count) == "table" then
                                                data.giveitem[hh].count =
                                                    math.random(data.giveitem[hh].count[1], data.giveitem[hh].count[2])
                                            end
                                            for i = 1, data.giveitem[hh].count, 1 do
                                                item = {name = data.giveitem[hh].name}
                                                AddItemtoInv(item)
                                            end
                                        end
                                    end
                                elseif data.giveitemType == 1 then
                                    local give = nil
                                    repeat
                                        for hh = 1, #data.giveitem, 1 do
                                            if randomChange(data.giveitem[hh].chanceDrop) then
                                                give = data.giveitem[hh]
                                            end
                                        end
                                    until give ~= nil
                                    if type(give.count) == "table" then
                                        math.randomseed(GetGameTimer())
                                        give.count = math.random(give.count[1], give.count[2])
                                    end
                                    for i = 1, give.count, 1 do
                                        item = {name = give.name}
                                        AddItemtoInv(item)
                                    end
                                end
                            end

                            if data.required ~= nil then
                                if type(data.required) ~= "table" then
                                    for k, v in pairs(Inventory.Inventory) do
                                        if k == data.required then
                                            -- supprime un objet aléatoir
                                            for i = 1, #v, 1 do
                                                --TriggerServerEvent("inventory:RemoveItem",v[i].id,data.required)
                                                Inventory:RemoveItemToInv(v[i].id, data.required)
                                                break
                                            end
                                            break
                                        end
                                    end
                                else
                                    for hh = 1, #data.required, 1 do
                                        for k, v in pairs(Inventory.Inventory) do
                                            if k == data.required[hh].name then
                                                for cc = 1, data.required[hh].count, 1 do
                                                    --TriggerServerEvent("inventory:RemoveItem",v[1].id,data.required[hh].name)
                                                    Inventory:RemoveItemToInv(v[1].id, data.required[hh].name)
                                                end
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                            -- Give d'argent
                            if data.price ~= nil then
                                if Job:Get().FreeAccess then
                                    TriggerServerEvent("money:Add", data.price)
                                else
                                    TriggerServerEvent("entreprise:Add", Job:Get().name, data.price)
                                end
                            end
                            showMessageInformation(data.add, 1000)
                            Wait(400)
                            works = 0
                            Job:StartRecolte(_type)
                        end
                        works = 0
                    end
                end
            )
        end
    end
end

function StopCurrentWork(bool)
    isWorking = false
    showMessageInformation("~r~Vous avez arrêté votre action", 4000)
    -- Sauvegarde de la limite de farm
    local Player = LocalPlayer()
    TriggerServerEvent("core:SaveLimitFarm", Player.FarmLimit)
    local ped = LocalPlayer().Ped
    if ped then
        ClearPedTasks(ped)
    end
    -- Reset de la zone
    Hint:RemoveAll()
    ResetFarm()
    if bool == nil then
        Hint:RemoveAll()
        --     Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour interagir")
        KeySettings:Clear("keyboard", "E", Job.CurrentAction)
        KeySettings:Clear("controller", 46, Job.CurrentAction)
    end
end

