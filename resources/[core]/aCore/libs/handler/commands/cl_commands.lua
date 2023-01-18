RegisterNetEvent("core:teleport")
AddEventHandler(
    "core:teleport",
    function(pos)
        pos.x = pos.x + 0.0
        pos.y = pos.y + 0.0
        pos.z = pos.z + 0.0

        RequestCollisionAtCoord(pos.x, pos.y, pos.z)

        while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
            RequestCollisionAtCoord(pos.x, pos.y, pos.z)
            Citizen.Wait(1)
        end

        SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
    end
)

local commands = {
    {
        text = "giveitem",
        fct = function(args)
            if tonumber(args[3]) == nil then
                return ShowNotification("~r~Nombre invalide")
            end
            for i = 1, args[3], 1 do
                item = {name = args[2]}
                TriggerPlayerEvent("inventory:AddItem2", args[1], item)
            end
        end
    },
    {
        text = "setjob",
        fct = function(args)
            TriggerServerEvent("job:UpdateJob2", args[2], args[3], args[1])
            TriggerPlayerEvent("Jobs:SetJob2", args[1], args[2], args[3])
        end
    },
    {
        text = "setorga",
        fct = function(args)
            TriggerServerEvent("job:UpdateJob4", args[2], args[3], args[1])
            TriggerPlayerEvent("Orga:SetJob2", CurrentPlayer.serverId, NomJob, Grade)
        end
    },
    {
        text = "car",
        fct = function(args)
            local ModelName = args[1]

            if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                RequestModel(ModelName)
                while not HasModelLoaded(ModelName) do
                    Citizen.Wait(0)
                end
                local veh =
                    CreateVehicle(
                    GetHashKey(ModelName),
                    GetEntityCoords(PlayerPedId()),
                    GetEntityHeading(PlayerPedId()),
                    true,
                    true
                )
                TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                Wait(50)
            else
                ShowNotification("~r~Erreur ! ~w~Model invalide.")
            end
        end
    },
    {
        text = "tp",
        fct = function(args)
            for i = 1, #args, 1 do
                args[i] = tonumber(args[i])
            end
            print(args[1], args[2], args[3])
            TriggerEvent("core:teleport", {x = args[1], y = args[2], z = args[3]})
        end
    },
    {
        text = "dv",
        fct = function(args)
            if IsPedInAnyVehicle(LocalPlayer().Ped) then
                local vehiclePedIsin = GetVehiclePedIsIn(LocalPlayer().Ped)
                TriggerEvent('persistent-vehicles/forget-vehicle', vehiclePedIsin)

                DeleteEntity(vehiclePedIsin)
            else
                if ClosestVeh() ~= 0 then
                    TriggerEvent('persistent-vehicles/forget-vehicle', ClosestVeh())
                    DeleteEntity(ClosestVeh())
                end
            end
        end
    },
    {
        text = "stopCooperScenario",
        fct = function(args)
            TriggerEvent("stopCooperScenario")
        end
    },
    {
        text = "revive",
        fct = function(args)
            TriggerPlayerEvent("player:Revive", args[1])
        end
    },
    {
        text = "tenue",
        fct = function(args)
            SetEntityCoords(PlayerPedId(), -1193.66, -772.17, 17.32, 119.81)
        end
    },
    {
        text = "pc",
        fct = function(args)
            SetEntityCoords(PlayerPedId(), 228.39, -789.40, 30.67, 64.94)
        end
    },
    {
        text = "heal",
        fct = function(args)
            TriggerPlayerEvent("player:Heal", args[1])
        end
    }
}

Citizen.CreateThread(
    function()
        Wait(1)
        while Job:Get() == nil do
            Wait(1)
        end
        for i = 1, #commands, 1 do
            if PlyGroup == "superadmin" then
                RegisterCommand(
                    commands[i].text,
                    function(_, args)
                        commands[i].fct(args)
                    end
                )
            end
        end
    end
)

RegisterCommand(
    "report",
    function(_, args)
        TriggerServerEvent(
            "aCore:sendToDiscord",
            "https://discord.com/api/webhooks/849956729479364639/1nRqGaTIMe6xYnKJqFQkRji9b3Dn-8rphzi_9zjpHpZet1CH3qEdtfTU3j0L4zrBSPBc",
            table.concat(args, " ")
        )
        TriggerServerEvent('addReportMenuS', table.concat(args, " "))
        TriggerEvent(
            "RageUI:Popup",
            {
                message = "Votre message a bien été envoyé aux ~b~staffs ~w~connectés."
            }
        )
    end
)
