local function j(t)
    return json.decode(t)
end
function isMale()
    return GetEntityModel(LocalPlayer().Ped) == GetHashKey("mp_m_freemode_01")
end
local male_torso = {
}
local tempData = {}
local topToRemoveMale = {
}
local botToRemoveMale = {
}
local chaussureToRemoveMale = {
}
local accessToRemoveMale = {
}
local chapeauToRemoveMale = {
}

topToRemoveFemale = {
}
local botToRemoveFemale = {
}
local chaussureToRemoveFemale = {
}
local accessToRemoveFemale = {
}

local chapeauToRemoveMale = {
}
local braseditInd = 1
local tshirt1 = 1
local tshirt2 = 1
local Clothes = {
    pricePerClothes = 50,
    config_clothes = {
        {x = 72.254, y = -1399.102, z = 28.376},
        {x = -167.52, y = -299.31, z = 38.73},
        {x = 428.694, y = -800.106, z = 28.491},
        {x = -829.413, y = -1073.710, z = 10.328},
        {x = -1447.797, y = -242.461, z = 48.820},
        {x = 11.632, y = 6514.224, z = 30.877},
        {x = 123.646, y = -219.440, z = 53.557},
        {x = 1696.291, y = 4829.312, z = 41.063},
        {x = 618.093, y = 2759.629, z = 41.088},
        {x = 1190.550, y = 2713.441, z = 37.222},
        {x = -1193.429, y = -772.262, z = 16.324},
        {x = -3172.496, y = 1048.133, z = 19.863},
        {x = -1108.441, y = 2708.923, z = 18.107}
    },
    category = {
        {
            label = "Haut",
            component = 11,
            type = 0,
            staticM = j(Config.Haut),
            staticF = j(Config.HautF),
            remM = topToRemoveMale,
            remF = topToRemoveFemale
        },
        {
            label = "Pantalon",
            component = 4,
            type = 0,
            staticM = j(Config.Pant),
            staticF = j(Config.PantF),
            remM = botToRemoveMale,
            remF = botToRemoveFemale
        },
        {
            label = "Chaussures",
            component = 6,
            type = 0,
            staticM = j(Config.Shoes),
            staticF = j(Config.ShoesF),
            remM = chaussureToRemoveMale,
            remF = chaussureToRemoveFemale
        },
        {
            label = "Accessoires",
            component = 7,
            type = 0,
            staticM = j(Config.Accessories),
            staticF = j(Config.AccessoriesF),
            remM = accessToRemoveMale,
            remF = accessToRemoveFemale
        },
        {
            label = "Chapeau",
            component = 0,
            type = 1,
            staticM = j(Config.Hats),
            staticF = j(Config.HatsF),
            remM = chapeauToRemoveMale,
            remF = chapeauToRemoveFemale
        },
        {label = "Lunettes", component = 1, type = 1, staticM = j(Config.Glasses), staticF = j(Config.GlassesF)},
        {
            label = "Oreilles",
            component = 2,
            type = 1,
            staticM = json.decode(Config.Ears),
            staticF = json.decode(Config.EarsF)
        },
        {
            label = "Montres",
            component = 6,
            type = 1,
            staticM = json.decode(Config.Watches),
            staticF = json.decode(Config.Watches)
        },
        {label = "Sac", component = 5, type = 0, staticM = {}, staticF = {}}
    }
}
function Clothes.CreateShops()
    for i = 1, #Clothes.config_clothes, 1 do
        local v = Clothes.config_clothes[i]
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 73)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 17)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Magasin de vêtement")
        EndTextCommandSetBlipName(blip)
        Blips:AddBlip(blip, "Magasin", v.Blips)
        v.Pos = {x = v.x, y = v.y, z = v.z}
        Zone:Add(v.Pos, Clothes.EnterZone, Clothes.ExitZone, i, 2.5)
        RMenu.Add(
            "clothesSHOP",
            i,
            RageUI.CreateMenu(nil, "Objets disponibles", 10, 100, "shopui_title_midfashion", "shopui_title_midfashion")
        )
        RMenu.Add(
            "clothesSHOP",
            "my_clothes_" .. i,
            RageUI.CreateSubMenu(RMenu:Get("clothesSHOP", i), nil, "Inventaire")
        )
        RMenu.Add(
            "clothesSHOP",
            "custom_clothes_" .. i,
            RageUI.CreateSubMenu(RMenu:Get("clothesSHOP", "my_clothes_" .. i), nil, "Modifier un vêtement")
        )
        RMenu.Add(
            "clothesSHOP",
            "clothes_chooser_" .. i,
            RageUI.CreateSubMenu(RMenu:Get("clothesSHOP", i), nil, "Vêtements disponibles")
        )
        RMenu:Get("clothesSHOP", i).Closed = function()
            Clothes.static = {}
            RefreshClothes()
        end
    end

    RMenu.Add(
        "clothesSHOP",
        "topChooser",
        RageUI.CreateMenu(nil, "Variation disponibles", 10, 100, "shopui_title_midfashion", "shopui_title_midfashion")
    )
end
local ixixi = 0
local CurrentZone = nil
function Clothes.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard", "E", Clothes.Open, "Shop")
    KeySettings:Add("controller", 46, Clothes.Open, "Shop")
    CurrentZone = zone
end

function Clothes.ExitZone()
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone)) then
            RageUI.Visible(
                RMenu:Get("clothesSHOP", CurrentZone),
                not RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone))
            )
        end
        KeySettings:Clear("keyboard", "E", "Shop")
        CurrentZone = nil

        RefreshClothes()
    end
end

function Clothes.Open()
    RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone), not RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone)))
end
function AmIPed()
    if
        GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") or
            GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01")
     then
        return false
    else
        return true
    end
end

Clothes.CreateShops()
local oldClothes = nil
local oldVar = nil
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            --print(LocalPlayer().FarmLimit )
            if RageUI.Visible(RMenu:Get("clothesSHOP", "topChooser")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local am = {}
                        for i = 1, GetNumberOfPedDrawableVariations(PlayerPedId(), 3), 1 do
                            am[i] = i
                        end
                        RageUI.List(
                            "Bras",
                            am,
                            braseditInd,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                braseditInd = Index

                                if Active then
                                    SetPedComponentVariation(PlayerPedId(), 3, Index, 0, 2)
                                end
                            end
                        )
                        local am = {}
                        for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 8), 1 do
                            am[i] = i
                        end
                        RageUI.List(
                            "T-shirt",
                            am,
                            tshirt1,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                if tshirt1 ~= Index then
                                    tshirt1 = Index
                                    tshirt2 = 0
                                    if Active then
                                        SetPedComponentVariation(PlayerPedId(), 8, tshirt1, tshirt2, 2)
                                    end
                                end
                            end
                        )
                        local am = {}
                        for i = 0, GetNumberOfPedTextureVariations(PlayerPedId(), 8, tshirt1), 1 do
                            am[i] = i
                        end
                        RageUI.List(
                            "T-shirt 2",
                            am,
                            tshirt2,
                            nil,
                            {},
                            true,
                            function(Hovered, Active, Selected, Index)
                                tshirt2 = Index

                                if Active then
                                    SetPedComponentVariation(PlayerPedId(), 8, tshirt1, tshirt2, 2)
                                end
                            end
                        )
                        RageUI.Button(
                            "Acheter",
                            nil,
                            {},
                            true,
                            function(_, _, S)
                                if S then
                                    dataonWait = {
                                        price = Clothes.pricePerClothes,
                                        fct = function()
                                            tempData.data.bras = braseditInd
                                            tempData.data.h = tshirt1
                                            tempData.data.hV = tshirt2
                                            AddItemtoInv(tempData)
                                        end
                                    }
                                    CloseAllMenus()
                                    TriggerEvent("payWith?")
                                end
                            end
                        )
                    end
                )
            end
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("clothesSHOP", "clothes_chooser_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            local label = nil

                            local amount = {}

                            for i = 0, Clothes.amount - 1, 1 do
                                local ttt = {}
                                local f = false
                                if isMale() then
                                    ttt = Clothes.remM
                                else
                                    ttt = Clothes.remF
                                end
                                if ttt ~= nil then
                                    for it = 1, #ttt, 1 do
                                        if ttt[it] - 1 == i then
                                            f = true
                                        end
                                    end
                                end

                                if not f then
                                    --if Clothes.static[tostring(i)] ~= nil then
                                    if Clothes.Indexes[i] == nil then
                                        Clothes.Indexes[i] = 1
                                    end
                                    local u =
                                        Clothes.static[tostring(i)] ~= nil and
                                        Clothes.static[tostring(i)][tostring(Clothes.Indexes[i] - 1)] or
                                        nil
                                    if u ~= nil then
                                        label = GetLabelText(u["GXT"])
                                    else
                                        label = "Vêtements #" .. i
                                    end
                                    if label == nil then
                                        label = "NULL"
                                    end
                                    if label ~= nil then
                                        if label == "NULL" then
                                            label = "Vêtements #" .. i
                                        end
                                        local x = 0
                                        local tt = label
                                        if Clothes.static[tostring(i)] ~= nil then
                                            x = tableCount(Clothes.static[tostring(i)])
                                        else
                                            x = GetNumberOfPedTextureVariations(PlayerPedId(), 5, i)
                                        end
                                        for p = 1, x, 1 do
                                            amount[p] = p
                                        end
                                        RageUI.List(
                                            label,
                                            amount,
                                            Clothes.Indexes[i],
                                            nil,
                                            {},
                                            true,
                                            function(_, Active, Selected, Index)
                                                Clothes.Indexes[i] = Index
                                                if Active then
                                                    if oldClothes ~= i or oldVar ~= Index - 1 then
                                                        if Clothes.type == 0 then
                                                            SetPedComponentVariation(
                                                                PlayerPedId(),
                                                                Clothes.component,
                                                                i,
                                                                Index - 1
                                                            )
                                                            oldClothes = i
                                                            oldVar = Index - 1
                                                            if Clothes.component == 11 then
                                                                SetPedComponentVariation(
                                                                    PlayerPedId(),
                                                                    3,
                                                                    male_torso[i],
                                                                    0
                                                                )
                                                            end
                                                        else
                                                            SetPedPropIndex(
                                                                PlayerPedId(),
                                                                Clothes.component,
                                                                i,
                                                                Index - 1
                                                            )
                                                            oldClothes = i
                                                            oldVar = Index - 1
                                                        end
                                                    end
                                                end
                                                if Selected then
                                                    local uuu = label
                                                    if Clothes.type == 0 then
                                                        if Inventory.canReceive("clothe", 1) then
                                                            if Clothes.component == 11 then
                                                                tempData = {
                                                                    name = "clothe",
                                                                    data = {
                                                                        component = Clothes.component,
                                                                        type = Clothes.type,
                                                                        sex = m,
                                                                        equiped = false,
                                                                        var = i,
                                                                        ind = Index - 1,
                                                                        data = male_torso[i],
                                                                        h = 15,
                                                                        hv = 0
                                                                    },
                                                                    label = tt
                                                                }
                                                            else
                                                                dataonWait = {
                                                                    price = Clothes.pricePerClothes,
                                                                    fct = function()
                                                                        local m = "female"
                                                                        if isMale() then
                                                                            m = "male"
                                                                        end
                                                                        items = {
                                                                            name = "clothe",
                                                                            data = {
                                                                                component = Clothes.component,
                                                                                type = Clothes.type,
                                                                                sex = m,
                                                                                equiped = false,
                                                                                var = i,
                                                                                ind = Index - 1,
                                                                                data = male_torso[i],
                                                                                h = 15,
                                                                                hv = 0
                                                                            },
                                                                            label = uuu
                                                                        }
                                                                        AddItemtoInv(items)
                                                                    end
                                                                }
                                                                CloseAllMenus()
                                                                TriggerEvent("payWith?")
                                                            end
                                                        end
                                                    else
                                                        if Inventory.canReceive("access", 1) then
                                                            dataonWait = {
                                                                price = Clothes.pricePerClothes,
                                                                fct = function()
                                                                    local m = "female"
                                                                    if isMale() then
                                                                        m = "male"
                                                                    end
                                                                    items = {
                                                                        name = "access",
                                                                        data = {
                                                                            component = Clothes.component,
                                                                            type = Clothes.type,
                                                                            sex = m,
                                                                            equiped = false,
                                                                            var = i,
                                                                            ind = Index - 1
                                                                        },
                                                                        label = uuu
                                                                    }
                                                                    AddItemtoInv(items)
                                                                end
                                                            }
                                                            CloseAllMenus()
                                                            TriggerEvent("payWith?")
                                                        end
                                                    end
                                                end
                                            end,
                                            Clothes.component == 11 and RMenu:Get("clothesSHOP", "topChooser") or nil
                                        )
                                    --end
                                    end
                                -- end
                                end
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("clothesSHOP", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            if not AmIPed() then
                                -- RageUI.Button("Modifier un vêtement", nil, {}, true, function(_, _, S)

                                -- end,RMenu:Get('clothesSHOP', "my_clothes_"..CurrentZone))
                                for i = 1, #Clothes.category, 1 do
                                    RageUI.Button(
                                        Clothes.category[i].label,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, S)
                                            if S then
                                                RMenu:Get("clothesSHOP", "clothes_chooser_" .. CurrentZone).Index = 1
                                                Clothes.component = Clothes.category[i].component
                                                Clothes.type = Clothes.category[i].type
                                                Clothes.remM = Clothes.category[i].remM
                                                Clothes.remF = Clothes.category[i].remF

                                                Clothes.listLabel = {}
                                                if Clothes.type == 0 then
                                                    Clothes.amount =
                                                        GetNumberOfPedDrawableVariations(
                                                        LocalPlayer().Ped,
                                                        Clothes.component
                                                    )
                                                else
                                                    Clothes.amount =
                                                        GetNumberOfPedPropDrawableVariations(
                                                        LocalPlayer().Ped,
                                                        Clothes.component
                                                    )
                                                end
                                                if isMale() then
                                                    --print(dump(Clothes.static))
                                                    Clothes.static = Clothes.category[i].staticM
                                                else
                                                    Clothes.static = Clothes.category[i].staticF
                                                end
                                                Clothes.Indexes = {}
                                                for i = 0, 101, 1 do
                                                    Clothes.Indexes[i] = 1
                                                end
                                            end
                                        end,
                                        RMenu:Get("clothesSHOP", "clothes_chooser_" .. CurrentZone)
                                    )
                                end
                            else
                                for i = 1, 12, 1 do
                                    local m = {}
                                    for i = 1, GetNumberOfPedDrawableVariations(PlayerPedId(), i) do
                                        m[i] = i
                                    end
                                    if #m ~= 0 then
                                        RageUI.List(
                                            "Variation " .. i,
                                            m,
                                            GetPedDrawableVariation(PlayerPedId(), i) + 1,
                                            GetLabelText("FACE_APP_H"),
                                            {},
                                            true,
                                            function(Hovered, Active, Selected, Index)
                                                if Active then
                                                    if Index - 1 ~= GetPedDrawableVariation(PlayerPedId(), i) then
                                                        SetPedComponentVariation(PlayerPedId(), i, Index - 1, 0, 0)
                                                    end
                                                end
                                            end
                                        )
                                        local x = {}
                                        for t = 0, GetNumberOfPedTextureVariations(
                                            PlayerPedId(),
                                            i,
                                            GetPedDrawableVariation(PlayerPedId(), i)
                                        ) - 1, 1 do
                                            table.insert(x, t)
                                        end
                                        if tablelength(x) > 1 then
                                            RageUI.List(
                                                "Texture " .. i,
                                                x,
                                                GetPedTextureVariation(PlayerPedId(), i) + 1,
                                                GetLabelText("FACE_APP_H"),
                                                {},
                                                true,
                                                function(Hovered, Active, Selected, Index)
                                                    if Active then
                                                        if Index - 1 ~= GetPedTextureVariation(PlayerPedId(), i) then
                                                            print(GetPedTextureVariation(PlayerPedId(), i))
                                                            SetPedComponentVariation(
                                                                PlayerPedId(),
                                                                i,
                                                                GetPedDrawableVariation(PlayerPedId(), i),
                                                                Index - 1,
                                                                0
                                                            )
                                                        end
                                                    end
                                                end
                                            )
                                        end
                                    end
                                end

                                RageUI.Button(
                                    "Sauvegarder",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, S)
                                        if S then
                                            local Skin = {}
                                            for i = 0, 12, 1 do
                                                Skin[i] = {
                                                    v = GetPedDrawableVariation(PlayerPedId(), i),
                                                    c = GetPedTextureVariation(PlayerPedId(), i)
                                                }
                                            end
                                            TriggerServerEvent("face:Save", Skin)
                                        end
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end

                if RageUI.Visible(RMenu:Get("clothesSHOP", "custom_clothes_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            local am = {}
                            for i = 1, GetNumberOfPedDrawableVariations(LocalPlayer().Ped, 3), 1 do
                                am[i] = i
                            end
                            RageUI.List(
                                "Bras",
                                am,
                                braseditInd,
                                nil,
                                {},
                                true,
                                function(Hovered, Active, Selected, Index)
                                    braseditInd = Index

                                    if Active then
                                        SetPedComponentVariation(LocalPlayer().Ped, 3, Index, 0, 2)
                                    end
                                end
                            )
                            local am = {}
                            for i = 0, GetNumberOfPedDrawableVariations(LocalPlayer().Ped, 8), 1 do
                                am[i] = i
                            end
                            RageUI.List(
                                "T-shirt",
                                am,
                                tshirt1,
                                nil,
                                {},
                                true,
                                function(Hovered, Active, Selected, Index)
                                    if tshirt1 ~= Index then
                                        tshirt1 = Index
                                        tshirt2 = 0
                                        if Active then
                                            SetPedComponentVariation(LocalPlayer().Ped, 8, tshirt1, tshirt2, 2)
                                        end
                                    end
                                end
                            )
                            local am = {}
                            for i = 0, GetNumberOfPedTextureVariations(LocalPlayer().Ped, 8, tshirt1), 1 do
                                am[i] = i
                            end
                            RageUI.List(
                                "T-shirt 2",
                                am,
                                tshirt2,
                                nil,
                                {},
                                true,
                                function(Hovered, Active, Selected, Index)
                                    tshirt2 = Index

                                    if Active then
                                        SetPedComponentVariation(LocalPlayer().Ped, 8, tshirt1, tshirt2, 2)
                                    end
                                end
                            )
                            RageUI.Button(
                                "Sauvegarder",
                                nil,
                                {},
                                true,
                                function(_, _, S)
                                    if S then
                                        Inventory.Inventory["clothe"][ixixi].data.bras = braseditInd - 1
                                        Inventory.Inventory["clothe"][ixixi].data.h = tshirt1 - 1
                                        Inventory.Inventory["clothe"][ixixi].data.hV = tshirt2 - 1
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("clothesSHOP", "my_clothes_" .. CurrentZone)) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            local count = 0
                            if tableCount(Inventory.Inventory) == 0 then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {},
                                    true,
                                    function()
                                    end
                                )
                            else
                                for k, v in pairs(Inventory.Inventory) do
                                    if k == "clothe" then
                                        for i = 1, #v, 1 do
                                            if v[i].label == nil then
                                                v[i].label = ""
                                            end
                                            if v[i].data.component == 11 then
                                                RageUI.Button(
                                                    Items[k].label .. " : " .. v[i].label,
                                                    nil,
                                                    {RightLabel},
                                                    true,
                                                    function(_, _, Selected)
                                                        if Selected then
                                                            ixixi = i
                                                            Inventory.SelectedItem = v[i]
                                                            braseditInd = v[i].data.bras or 1
                                                            tshirt1 = v[i].data.h or 1
                                                            tshirt2 = v[i].data.hV or 1
                                                            SetPedComponentVariation(
                                                                LocalPlayer().Ped,
                                                                11,
                                                                v[i].data.var,
                                                                v[i].data.ind
                                                            )
                                                        end
                                                    end,
                                                    RMenu:Get("clothesSHOP", "custom_clothes_" .. CurrentZone)
                                                )
                                                count = count + 1
                                            end
                                        end
                                    end
                                end
                                if count == 0 then
                                    RageUI.Button(
                                        "Vide",
                                        nil,
                                        {},
                                        true,
                                        function()
                                        end
                                    )
                                end
                            end
                        end,
                        function()
                        end
                    )
                end
            end
        end
    end
)

local masks = {
    Pos = {x = -1334.74, y = -1277.99, z = 4.69, h = 102.60},
    PedModel = "a_m_m_afriamer_01",
    array = json.decode(Config.MaskName),
    Indexes = {},
    price = 20
}
function masks.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique de vêtement")
    KeySettings:Add("keyboard", "E", masks.Open, "Shop")
    KeySettings:Add("controller", 46, masks.Open, "Shop")
end

function masks.ExitZone()
    Hint:RemoveAll()
    if RageUI.Visible(RMenu:Get("masks", "main")) then
        RageUI.Visible(RMenu:Get("masks", "main"), not RageUI.Visible(RMenu:Get("masks", "main")))
    end
    RefreshClothes()
    KeySettings:Clear("keyboard", "E", "Shop")
    CurrentZone = nil
end

function masks.Open()
    RageUI.Visible(RMenu:Get("masks", "main"), not RageUI.Visible(RMenu:Get("masks", "main")))
    playerPed = LocalPlayer().Ped
    for i = 0, GetNumberOfPedDrawableVariations(playerPed, 1) - 1, 1 do
        masks.Indexes[i] = 1
    end
end
function masks.Create()
    local blip = AddBlipForCoord(masks.Pos.x, masks.Pos.y, masks.Pos.z)
    SetBlipSprite(blip, 362)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 83)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Magasin de masques")
    EndTextCommandSetBlipName(blip)

    Zone:Add(masks.Pos, masks.EnterZone, masks.ExitZone, i, 2.5)
    RMenu.Add(
        "masks",
        "main",
        RageUI.CreateMenu(nil, "Masques disponibles", 10, 100, "shopui_title_movie_masks", "shopui_title_movie_masks")
    )
end

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("masks", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        playerPed = LocalPlayer().Ped
                        for i = 0, GetNumberOfPedDrawableVariations(playerPed, 1) - 1, 1 do
                            amount = {}
                            for c = 1, GetNumberOfPedTextureVariations(playerPed, 1, i), 1 do
                                amount[c] = c
                            end
                            if label ~= "Masque" then
                                RageUI.List(
                                    label,
                                    amount,
                                    masks.Indexes[i],
                                    "",
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        masks.Indexes[i] = Index

                                        if Active then
                                            SetPedComponentVariation(playerPed, 1, i, Index - 1, 2)
                                        end
                                        if Selected then
                                            local ppp = label
                                            if Inventory.canReceive("mask", 1) then
                                                dataonWait = {
                                                    price = masks.price,
                                                    fct = function()
                                                        items = {
                                                            name = "mask",
                                                            data = {
                                                                component = 1,
                                                                equiped = false,
                                                                var = i,
                                                                ind = Index - 1
                                                            },
                                                            label = ppp
                                                        }
                                                        AddItemtoInv(items)
                                                    end
                                                }

                                                CloseAllMenus()
                                                TriggerEvent("payWith?")
                                            end
                                        end
                                    end
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)

masks.Create()
