local function showMessageInformation(message, duree)
    duree = duree or 500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(message)
    DrawSubtitleTimed(duree, 1)
end

AmmunationCrafts = {}
-- Pistols
AmmunationCrafts["pistols"] = {
    tazer = {
        title = "Pistolet : Tazer ~r~[5.000$]",
        label = "TAZER",
        requiredBullet = "",
        item = "stungun",
        time = 30000,
        required = {
            {name = "metalpiece11", count = 1},
            {name = "plasticpiece3", count = 1},
            {name = "plasticpiece4", count = 1},
            {name = "plasticpiece5", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des pieces necessaires~s~")
            found = false
            local data = AmmunationCrafts["pistols"]["tazer"]
            craftWeapon(data)
        end
    },
    sns = {
        title = "Pistolet : Pétoire ~r~[30.000$]",
        requiredBullet = ".45 ACP",
        label = "PETOIRE",
        item = "snspistol",
        time = 30000,
        required = {
            {name = "metalpiece1", count = 1},
            {name = "metalpiece9", count = 1},
            {name = "woodpiece3", count = 1},
            {name = "woodpiece2", count = 1},
            {name = "plasticpiece4", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des pieces necessaires~s~")
            found = false
            local data = AmmunationCrafts["pistols"]["sns"]
            craftWeapon(data)
        end
    },
    vintage = {
        title = "Pistolet : Vintage",
        requiredBullet = "9mm",
        item = "pistolvintage",
        label = "PISTOLET VINTAGE",
        time = 30000,
        required = {
            {name = "metalpiece1", count = 1},
            {name = "metalpiece7", count = 1},
            {name = "metalpiece9", count = 1},
            {name = "woodpiece2", count = 1},
            {name = "woodpiece3", count = 1},
            {name = "plasticpiece4", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des pieces necessaires~s~")
            found = false
            local data = AmmunationCrafts["pistols"]["vintage"]
            craftWeapon(data)
        end
    },
    pistol = {
        title = "Pistolet : Beretta",
        requiredBullet = "9mm",
        item = "pistol",
        label = "PISTOLET BERETTA",
        time = 30000,
        required = {
            {name = "metalpiece1", count = 1},
            {name = "metalpiece7", count = 1},
            {name = "metalpiece8", count = 1},
            {name = "metalpiece9", count = 1},
            {name = "woodpiece2", count = 1},
            {name = "plasticpiece1", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des pieces necessaires~s~")
            found = false
            local data = AmmunationCrafts["pistols"]["pistol"]
            craftWeapon(data)
        end
    },
    pistol50 = {
        title = "Pistolet : Calibre 50",
        requiredBullet = "9mm",
        item = "pistol50",
        label = "PISTOLET CALIBRE 50",
        time = 30000,
        required = {
            {name = "metalpiece1", count = 1},
            {name = "metalpiece7", count = 1},
            {name = "metalpiece8", count = 1},
            {name = "metalpiece14", count = 1},
            {name = "metalpiece10", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des pieces necessaires~s~")
            found = false
            local data = AmmunationCrafts["pistols"]["pistol50"]
            craftWeapon(data)
        end
    },
}

AmmunationCrafts["hunting"] = {
    musket = {
        title = "Fusil de chasse",
        requiredBullet = "5.56",
        item = "musket",
        label = "MOUSQUET DE CHASSE 223Rem.",
        time = 30000,
        required = {
            {name = "metalpiece2", count = 1},
            {name = "metalpiece13", count = 1},
            {name = "metalpiece12", count = 1},
            {name = "metalpiece10", count = 1},
            {name = "woodpiece1", count = 1},
            {name = "woodpiece2", count = 1},
            {name = "woodpiece3", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des pieces necessaires~s~")
            found = false
            local data = AmmunationCrafts["hunting"]["musket"]
            craftWeapon(data)
        end
    }
}

AmmunationCrafts["shotgun"] = {
    dbshotgun = {
        title = "Double barrell",
        item = "doubleshootgun",
        requiredBullet = "Calibre 12",
        label = "DOUBLE BARRELL",
        time = 30000,
        required = {
            {name = "metalpiece3", count = 1},
            {name = "metalpiece12", count = 1},
            {name = "metalpiece14", count = 1},
            {name = "metalpiece10", count = 1},
            {name = "woodpiece1", count = 1},
            {name = "woodpiece2", count = 1},
            {name = "woodpiece3", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des pieces necessaires~s~")
            found = false
            local data = AmmunationCrafts["shotgun"]["dbshotgun"]
            craftWeapon(data)
        end
    },
    shootgun = {
        title = "Fusil a pompe",
        item = "shootgun",
        requiredBullet = "Calibre 12",
        label = "FUSIL A POMPE",
        time = 30000,
        required = {
            {name = "metalpiece3", count = 1},
            {name = "metalpiece12", count = 1},
            {name = "metalpiece14", count = 1},
            {name = "metalpiece10", count = 1},
            {name = "plasticpiece1", count = 1},
            {name = "plasticpiece2", count = 1},
            {name = "plasticpiece3", count = 1},
            {name = "plasticpiece4", count = 1}
        },
        selected = function()
            ShowNotification("~b~Vérification de la disponibilité des pieces necessaires~s~")
            found = false
            local data = AmmunationCrafts["shotgun"]["shootgun"]
            craftWeapon(data)
        end
    }
}

Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("weaponCraft", "main", RageUI.CreateMenu("Armurier", "Catégories disponibles", 10, 100))
        -- creata acc
        RMenu.Add(
            "weaponCraft",
            "create_weapon",
            RageUI.CreateSubMenu(RMenu:Get("weaponCraft", "main"), "Armurier", "Craft d'arme", 10, 100)
        )
        RMenu.Add(
            "weaponCraft",
            "pistols",
            RageUI.CreateSubMenu(RMenu:Get("weaponCraft", "create_weapon"), "Armurier", "Arme de poing", 10, 100)
        )

        -- Hunting
        RMenu.Add(
            "weaponCraft",
            "hunting",
            RageUI.CreateSubMenu(RMenu:Get("weaponCraft", "create_weapon"), "Armurier", "Arme de chasse", 10, 100)
        )
        RMenu.Add(
            "weaponCraft",
            "shotgun",
            RageUI.CreateSubMenu(RMenu:Get("weaponCraft", "create_weapon"), "Armurier", "Fusils a pompe", 10, 100)
        )
        --RMenu.Add(
            --"weaponCraft",
            --"submachine",
            --RageUI.CreateSubMenu(RMenu:Get("weaponCraft", "create_weapon"), "Armurier", "Mitraillette", 10, 100)
        --)
        RMenu.Add(
            "weaponCraft",
            "assaultrifle",
            RageUI.CreateSubMenu(RMenu:Get("weaponCraft", "create_weapon"), "Armurier", "Fusil d'assault", 10, 100)
        )
        --RMenu.Add(
            --"weaponCraft",
            --"sniperrifle",
            --RageUI.CreateSubMenu(RMenu:Get("weaponCraft", "create_weapon"), "Armurier", "Fusil de précision", 10, 100)
        --)
    end
)

function EnterCraftWeaponZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour assembler des armes")
    KeySettings:Add("keyboard", "E", OpenWeaponMenu, "WEAPON")
    KeySettings:Add("controller", 46, OpenWeaponMenu, "WEAPON")
end

function ExitCraftWeaponZone()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "WEAPON")
    KeySettings:Clear("controller", "E", "WEAPON")
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
end

function OpenWeaponMenu()
    RageUI.Visible(RMenu:Get("weaponCraft", "main"), true)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("weaponCraft", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Crafter une arme",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("weaponCraft", "create_weapon")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("weaponCraft", "create_weapon")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Assembler une arme de poing",
                            nil,
                            {RightLabel = ""},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                end
                            end,
                            RMenu:Get("weaponCraft", "pistols")
                        )
                        RageUI.Button(
                            "Assembler un fusil de chasse",
                            nil,
                            {RightLabel = ""},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                end
                            end,
                            RMenu:Get("weaponCraft", "hunting")
                        )
                        RageUI.Button(
                            "Assembler un fusil à pompe",
                            nil,
                            {RightLabel = ""},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                end
                            end,
                            RMenu:Get("weaponCraft", "shotgun")
                        )
                        --RageUI.Button(
                            --"Assembler une mitraillette",
                           --nil,
                            --{RightLabel = ""},
                            --true,
                            --function(_, _, Selected)
                                --if Selected then
                                    --ShowNotification("~r~Mitraillette~s~\nNon disponible pour le moment")
                                --end
                            --end
                        --)
                        RageUI.Button(
                            "Assembler un fusil d'assaut",
                            nil,
                            {RightLabel = ""},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    ShowNotification("~r~Fusils d'assaut~s~\nNon disponible pour le moment")
                                end
                            end
                        )
                        RageUI.Button(
                            "Assembler un fusil a lunette",
                            nil,
                            {RightLabel = ""},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    ShowNotification("~r~Fusils à lunette~s~\nNon disponible pour le moment")
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("weaponCraft", "pistols")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(AmmunationCrafts["pistols"]) do
                            RageUI.Button(
                                v.title,
                                nil,
                                {RightLabel = "~b~" .. v.requiredBullet .. "~s~"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        if (type(v.selected) == "function") then
                                            v.selected()
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("weaponCraft", "hunting")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(AmmunationCrafts["hunting"]) do
                            RageUI.Button(
                                v.title,
                                nil,
                                {RightLabel = "~b~" .. v.requiredBullet .. "~s~"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        if (type(v.selected) == "function") then
                                            v.selected()
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("weaponCraft", "shotgun")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in pairs(AmmunationCrafts["shotgun"]) do
                            RageUI.Button(
                                v.title,
                                nil,
                                {RightLabel = "~b~" .. v.requiredBullet .. "~s~"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        if (type(v.selected) == "function") then
                                            v.selected()
                                        end
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)

function GenerateAmmunationSerial()
    local serial = "AMMU-"
    math.randomseed(GetGameTimer())
    local num = math.random(11111, 99999)
    return serial .. num .. "-" .. GetGameTimer()
end

function craftWeapon(data)
    local hasOneMissing = false

    for i = 1, #data.required, 1 do
        if Inventory:GetItemCount(data.required[i].name) - data.required[i].count < 0 then
            ShowNotification(
                "~b~" ..
                    Items[data.required[i].name].label ..
                        "~s~ : ~r~" ..
                            Inventory:GetItemCount(data.required[i].name) .. "/" .. data.required[i].count .. "~s~"
            )
            hasOneMissing = true
        else
            ShowNotification(
                "~b~" ..
                    Items[data.required[i].name].label ..
                        "~s~ : ~g~" ..
                            Inventory:GetItemCount(data.required[i].name) .. "/" .. data.required[i].count .. "~s~"
            )
        end
    end

    if GetFarmLimit() <= 5000 then
        if not hasOneMissing then
            SetFarmLimit(1)
            local timeWait = (data.time / 1000) / 60
            --showMessageInformation("~b~Création de l'arme en cours (" .. timeWait .. " minute(s))...", data.time)
            exports["mythic_progbar"]:Progress(
                {
                    name = "ammu_grrr",
                    duration = 30000,
                    label = "Création de l'arme en cours... (30 sec)",
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

            for i = 1, #data.required, 1 do
                Inventory:RemoveItemToInv(
                    Inventory.Inventory[data.required[i].name][1].id,
                    Inventory.Inventory[data.required[i].name][1].name
                )
            end

            local playerPed = PlayerPedId()

            RequestAnimDict("missmechanic")
            local j = 0
            while not HasAnimDictLoaded("missmechanic") and j <= 50 do
                Citizen.Wait(100)
                j = j + 1
            end

            if j >= 50 then
                SendNotification("~r~~h~ERROR ~h~~w~: The animation dictionnary took too long to load.")
            else
                TaskPlayAnim(playerPed, "missmechanic", "work2_base", 8.0, 1.0, -1, 1)
            end
            Wait(data.time / 4)
            RemoveAnimDict("missmechanic")

            RequestAnimDict("weapons@submg@micro_smg")
            local j = 0
            while not HasAnimDictLoaded("weapons@submg@micro_smg") and j <= 50 do
                Citizen.Wait(100)
                j = j + 1
            end

            if j >= 50 then
                SendNotification("~r~~h~ERROR ~h~~w~: The animation dictionnary took too long to load.")
            else
                TaskPlayAnim(playerPed, "weapons@submg@micro_smg", "settle_low", 8.0, 1.0, -1, 1)
            end
            Wait(data.time / 4)

            local j = 0
            while not HasAnimDictLoaded("weapons@submg@micro_smg") and j <= 50 do
                Citizen.Wait(100)
                j = j + 1
            end

            if j >= 50 then
                SendNotification("~r~~h~ERROR ~h~~w~: The animation dictionnary took too long to load.")
            else
                TaskPlayAnim(playerPed, "weapons@submg@micro_smg", "settle_med", 8.0, 1.0, -1, 1)
                RemoveAnimDict("weapons@submg@micro_smg")
            end
            Wait(data.time / 4)

            local j = 0
            while not HasAnimDictLoaded("weapons@submg@micro_smg") and j <= 50 do
                Citizen.Wait(100)
                j = j + 1
            end

            if j >= 50 then
                SendNotification("~r~~h~ERROR ~h~~w~: The animation dictionnary took too long to load.")
            else
                TaskPlayAnim(playerPed, "weapons@submg@micro_smg", "settle_high", 8.0, 1.0, -1, 1)
                RemoveAnimDict("weapons@submg@micro_smg")
            end
            Wait(data.time / 4)
            RemoveAnimDict("weapons@submg@micro_smg")

            ClearPedTasksImmediately(PlayerPedId())

            local idFinal = nil
            local randomTest = uuid.seeder()
            local uuidForItem = uuid.new(randomTest)
            randomTest = uuid.seeder()
            uuidForItem = uuidForItem .. "-AMMU"
            idFinal = uuidForItem
            serial = GenerateAmmunationSerial()
            Inventory:AddItemToInv(data.item, idFinal, {serial = serial}, serial)
            TriggerServerEvent(
                "aCore:sendToDiscord",
                "https://discord.com/api/webhooks/842991761671585812/oocOKps2gkrgbtMnOM6drIhl9jid5HcGpNocO0E07_bQ1sjHToFGteBsFc0ofhA-qk3R",
                "[" ..
                    data.label ..
                        " " ..
                            serial ..
                                "]\n\n" ..
                                    GetPlayerName(PlayerId()) ..
                                        " certifie la confection d'une arme\n\n* Type d'arme : " ..
                                            data.label .. "\n* Numéro de série : " .. serial
            )
        else
            ShowNotification("~r~Action impossible car certaines pièces manquent~s~")
            return
        end
    else
        ShowNotification("~r~Votre quota journalier est dépassé~s~")
    end
end
