local HairCutJob = {
    --posChair = {x = -816.22, y = -182.72, z = 37.57}, --posChair = {x=-34.06, y=-150.38, z=57.077},
    posChair = {x = 138.25, y = -1709.13, z = 29.42}, --posChair = {x=-34.06, y=-150.38, z=57.077},
    --posCutters = {x = -815.93, y = -183.48, z = 37.56}, --posCutters = {x=-33.28, y=-151.57, z=57.08},
    posCutters = {x = 137.76, y = -1708.74, z = 29.3}, --posCutters = {x=-33.28, y=-151.57, z=57.08},
    Seated = false
}
local sourcilsss = 1
local Colors = {
    {22, 19, 19}, -- 0
    {30, 28, 25}, -- 1
    {76, 56, 45}, -- 2
    {69, 34, 24}, -- 3
    {123, 59, 31}, -- 4
    {149, 68, 35}, -- 5
    {165, 87, 50}, -- 6
    {175, 111, 72}, -- 7
    {159, 105, 68}, -- 8
    {198, 152, 108}, -- 9
    {213, 170, 115}, -- 10
    {223, 187, 132}, -- 11
    {202, 164, 110}, -- 12
    {238, 204, 130}, -- 13
    {229, 190, 126}, -- 14
    {250, 225, 167}, -- 15
    {187, 140, 96}, -- 16
    {163, 92, 60}, -- 17
    {144, 52, 37}, -- 18
    {134, 21, 17}, -- 19
    {164, 24, 18}, -- 20
    {195, 33, 24}, -- 21
    {221, 69, 34}, -- 22
    {229, 71, 30}, -- 23
    {208, 97, 56}, -- 24
    {113, 79, 38}, -- 25
    {132, 107, 95}, -- 26
    {185, 164, 150}, -- 27
    {218, 196, 180}, -- 28
    {247, 230, 217}, -- 29
    {102, 72, 93}, -- 30
    {162, 105, 138}, -- 31
    {171, 174, 11}, -- 32
    {239, 61, 200}, -- 33
    {255, 69, 152}, -- 34
    {255, 178, 191}, -- 35
    {12, 168, 146}, -- 36
    {8, 146, 165}, -- 37
    {11, 82, 134}, -- 38
    {118, 190, 117}, -- 39
    {52, 156, 104}, -- 40
    {22, 86, 85}, -- 41
    {152, 177, 40}, -- 42
    {127, 162, 23}, -- 43
    {241, 200, 98}, -- 44
    {238, 178, 16}, -- 45
    {224, 134, 14}, -- 46
    {247, 157, 15}, -- 47
    {243, 143, 16}, -- 48
    {231, 70, 15}, -- 49
    {255, 101, 21}, -- 50
    {254, 91, 34}, -- 51
    {252, 67, 21}, -- 52
    {196, 12, 15}, -- 53
    {143, 10, 14}, -- 54
    {44, 27, 22}, -- 55
    {80, 51, 37}, -- 56
    {98, 54, 37}, -- 57
    {60, 31, 24}, -- 58
    {69, 43, 32}, -- 59
    {8, 10, 14}, -- 60
    {212, 185, 158}, -- 61
    {212, 185, 158}, -- 62
    {213, 170, 115} -- 63
}
local SA = {
    GetLabelText("CC_EYEBRW_0"),
    GetLabelText("CC_EYEBRW_1"),
    GetLabelText("CC_EYEBRW_2"),
    GetLabelText("CC_EYEBRW_3"),
    GetLabelText("CC_EYEBRW_4"),
    GetLabelText("CC_EYEBRW_5"),
    GetLabelText("CC_EYEBRW_6"),
    GetLabelText("CC_EYEBRW_7"),
    GetLabelText("CC_EYEBRW_8"),
    GetLabelText("CC_EYEBRW_9"),
    GetLabelText("CC_EYEBRW_10"),
    GetLabelText("CC_EYEBRW_11"),
    GetLabelText("CC_EYEBRW_12"),
    GetLabelText("CC_EYEBRW_13"),
    GetLabelText("CC_EYEBRW_14"),
    GetLabelText("CC_EYEBRW_15"),
    GetLabelText("CC_EYEBRW_16"),
    GetLabelText("CC_EYEBRW_17"),
    GetLabelText("CC_EYEBRW_18"),
    GetLabelText("CC_EYEBRW_19"),
    GetLabelText("CC_EYEBRW_20"),
    GetLabelText("CC_EYEBRW_21"),
    GetLabelText("CC_EYEBRW_22"),
    GetLabelText("CC_EYEBRW_23"),
    GetLabelText("CC_EYEBRW_24"),
    GetLabelText("CC_EYEBRW_25"),
    GetLabelText("CC_EYEBRW_26"),
    GetLabelText("CC_EYEBRW_27"),
    GetLabelText("CC_EYEBRW_28"),
    GetLabelText("CC_EYEBRW_29"),
    GetLabelText("CC_EYEBRW_30"),
    GetLabelText("CC_EYEBRW_31"),
    GetLabelText("CC_EYEBRW_32"),
    GetLabelText("CC_EYEBRW_33")
}
beardAmount = {}
for i = 0, 28 do
    table.insert(beardAmount, {Name = i, Value = i})
end

ap = {
    GetLabelText("CC_LIPSTICK_0"),
    GetLabelText("CC_LIPSTICK_1"),
    GetLabelText("CC_LIPSTICK_2"),
    GetLabelText("CC_LIPSTICK_3"),
    GetLabelText("CC_LIPSTICK_4"),
    GetLabelText("CC_LIPSTICK_5"),
    GetLabelText("CC_LIPSTICK_6"),
    GetLabelText("CC_LIPSTICK_7"),
    GetLabelText("CC_LIPSTICK_8"),
    GetLabelText("CC_LIPSTICK_9")
}
ppp = {
    GetLabelText("CC_MKUP_0"),
    GetLabelText("CC_MKUP_1"),
    GetLabelText("CC_MKUP_2"),
    GetLabelText("CC_MKUP_3"),
    GetLabelText("CC_MKUP_4"),
    GetLabelText("CC_MKUP_5"),
    GetLabelText("CC_MKUP_6"),
    GetLabelText("CC_MKUP_7"),
    GetLabelText("CC_MKUP_8"),
    GetLabelText("CC_MKUP_9"),
    GetLabelText("CC_MKUP_10"),
    GetLabelText("CC_MKUP_11"),
    GetLabelText("CC_MKUP_12"),
    GetLabelText("CC_MKUP_13"),
    GetLabelText("CC_MKUP_14"),
    GetLabelText("CC_MKUP_15"),
    GetLabelText("CC_MKUP_16"),
    GetLabelText("CC_MKUP_17"),
    GetLabelText("CC_MKUP_18"),
    GetLabelText("CC_MKUP_19"),
    GetLabelText("CC_MKUP_20"),
    GetLabelText("CC_MKUP_21"),
    GetLabelText("CC_MKUP_26"),
    GetLabelText("CC_MKUP_27"),
    GetLabelText("CC_MKUP_28"),
    GetLabelText("CC_MKUP_29"),
    GetLabelText("CC_MKUP_30"),
    GetLabelText("CC_MKUP_31"),
    GetLabelText("CC_MKUP_32"),
    GetLabelText("CC_MKUP_33"),
    GetLabelText("CC_MKUP_34"),
    GetLabelText("CC_MKUP_35"),
    GetLabelText("CC_MKUP_36"),
    GetLabelText("CC_MKUP_37"),
    GetLabelText("CC_MKUP_38"),
    GetLabelText("CC_MKUP_39"),
    GetLabelText("CC_MKUP_40"),
    GetLabelText("CC_MKUP_41"),
    GetLabelText("CC_MKUP_42"),
    GetLabelText("CC_MKUP_43"),
    GetLabelText("CC_MKUP_44"),
    GetLabelText("CC_MKUP_45"),
    GetLabelText("CC_MKUP_46"),
    GetLabelText("CC_MKUP_47"),
    GetLabelText("CC_MKUP_48"),
    GetLabelText("CC_MKUP_49"),
    GetLabelText("CC_MKUP_50"),
    GetLabelText("CC_MKUP_51"),
    GetLabelText("CC_MKUP_52"),
    GetLabelText("CC_MKUP_53"),
    GetLabelText("CC_MKUP_54"),
    GetLabelText("CC_MKUP_55"),
    GetLabelText("CC_MKUP_56"),
    GetLabelText("CC_MKUP_57"),
    GetLabelText("CC_MKUP_58"),
    GetLabelText("CC_MKUP_59"),
    GetLabelText("CC_MKUP_60"),
    GetLabelText("CC_MKUP_61"),
    GetLabelText("CC_MKUP_62"),
    GetLabelText("CC_MKUP_63"),
    GetLabelText("CC_MKUP_64"),
    GetLabelText("CC_MKUP_65"),
    GetLabelText("CC_MKUP_66"),
    GetLabelText("CC_MKUP_67"),
    GetLabelText("CC_MKUP_68"),
    GetLabelText("CC_MKUP_69"),
    GetLabelText("CC_MKUP_70"),
    GetLabelText("CC_MKUP_71")
}

local CurrentZone = nil
local skins = nil
local colour_table2 = {1, 1}
local colour_table = {1, 1}
local colour_table6 = {1, 1}
local colour_table3 = {1, 1}
local colour_table4 = {1, 1}
local hairstyless = nil
local mpp = nil
local colour_table5 = {1, 1}
local colour_table7 = {1, 1}
local colour_table8 = {1, 1}
local percentage_float = 0.5

RMenu.Add("haircuts", "main", RageUI.CreateMenu("Coiffeur", "Actions disponibles", 10, 100))
RMenu.Add(
    "haircuts",
    "cut_main",
    RageUI.CreateSubMenu(RMenu:Get("haircuts", "main"), "Coiffeur", "Actions disponibles", 10, 100)
)

RMenu:Get("haircuts", "main").Closed = function()
    skins = nil
end

RMenu:Get("haircuts", "cut_main").Closed = function()
    skins = nil
end
local function SeatChair()
    Hint:RemoveAll()
    local ped = PlayerPedId()
    if HairCutJob.Seated == true then
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        SetEntityCollision(ped, true)
        HairCutJob.Seated = not HairCutJob.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour s'asseoir")
    else
        SetEntityCoordsNoOffset(ped, 138.25, -1709.13, 29.42)
        SetEntityHeading(ped, 233.999)
        SetEntityCollision(ped, false)
        doAnim({"misshair_shop@hair_dressers", "player_base"}, nil, 1)
        HairCutJob.Seated = not HairCutJob.Seated
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour se relever")
    end
end

local function Create()
    local x, y, z = table.unpack(GetEntityCoords(LocalPlayer().Ped))
    Marker:Add(
        {x = 137.76, y = -1708.74, z = 29.3},
        {
            type = 1,
            scale = {x = 0.5, y = 0.5, z = 0.6},
            color = {r = 255, g = 255, b = 255, a = 120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = GetDistanceBetweenCoords(137.76, -1708.74, 29.3, x, y, z, true)
        }
    )
end

function createCoiffeurJob()
    return Create()
end
local myPLY = 0
RMenu:Get("haircuts", "cut_main").EnableMouse = true

RMenu:Get("haircuts", "cut_main").Closed = function()
    TriggerPlayerEvent("skin:GiveBack", myPLY)
end

Citizen.CreateThread(
    function()
        Zone:Add(
            HairCutJob.posChair,
            function()
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ s'asseoir")
                KeySettings:Add("keyboard", "E", SeatChair, "PosChair")
                KeySettings:Add("controller", 46, SeatChair, "PosChair")
            end,
            function()
                Hint:RemoveAll()
                KeySettings:Clear("keyboard", "E", "PosChair")
                KeySettings:Clear("controller", 46, "PosChair")
            end,
            posChair,
            1.0
        )
        while true do
            Wait(1000)
            if RageUI.Visible(RMenu:Get("haircuts", "cut_main")) then
                TriggerPlayerEvent("change:skin", myPLY, skins)
            end
        end
    end
)
-- local tx = false
-- Citizen.CreateThread(function()
--     Wait(500)
--     while true do
--         Wait(1000)
--         if tx then
--             plyPos = LocalPlayer().Pos
--             Wait(1)
--             doAnim2({"misstattoo_parlour@shop_ig_4","shop_ig_4_customer"},nil,1)
--         end
--     end
-- end)
-- Citizen.CreateThread(function()
--     Wait(500)
--    -- RageUI.Visible(RMenu:Get("haircuts","main"),true)
--     hairstyles = {}
--     while true do
--         Wait(0)
--         if IsControlJustPressed(0, Keys["E"]) then
--             plyPos = LocalPlayer().Pos
--             SetEntityCoords(PlayerPedId(), -1154.440,-1427.6,3.881159)
--             SetEntityHeading(PlayerPedId(), 347.84)
--             Wait(1)
--             doAnim2({"misstattoo_parlour@shop_ig_4","shop_ig_4_customer"},nil,1)
--             tx = true
--         end

--         if tx then
--             local ped = LocalPlayer().Ped
--             FreezeEntityPosition(ped, true)
--         end
--     end
-- end)
Citizen.CreateThread(
    function()
        Wait(500)
        -- RageUI.Visible(RMenu:Get("haircuts","main"),true)
        hairstyles = {}
        while true do
            Wait(1)
            --
            if HairCutJob.Seated then
                local ped = LocalPlayer().Ped

                FreezeEntityPosition(ped, true)
            end

            if RageUI.Visible(RMenu:Get("haircuts", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Couper",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    hairstyles = {}
                                    if isMale() then
                                        for i = 1, 74, 1 do
                                            hairstyles[i] =
                                                GetLabelText("CC_M_HS_" .. i - 1) == "NULL" and "Coupe #" .. i or
                                                GetLabelText("CC_M_HS_" .. i - 1)
                                        end
                                    else
                                        for i = 1, 78, 1 do
                                            hairstyles[i] =
                                                GetLabelText("CC_F_HS_" .. i - 1) == "NULL" and "Coupe #" .. i or
                                                GetLabelText("CC_F_HS_" .. i - 1)
                                        end
                                    end
                                end
                            end,
                            RMenu:Get("haircuts", "cut_main")
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("haircuts", "cut_main")) then
                DisableControlAction(0, 21, true) -- disable sprint
                DisableControlAction(0, 24, true) -- disable attack
                DisableControlAction(0, 25, true) -- disable aim
                DisableControlAction(0, 47, true) -- disable weapon
                DisableControlAction(0, 58, true) -- disable weapon
                DisableControlAction(0, 263, true) -- disable melee
                DisableControlAction(0, 264, true) -- disable melee
                DisableControlAction(0, 257, true) -- disable melee
                DisableControlAction(0, 140, true) -- disable melee
                DisableControlAction(0, 141, true) -- disable melee
                DisableControlAction(0, 142, true) -- disable melee
                DisableControlAction(0, 143, true) -- disable melee
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        --print(GetInteriorAtCoords(LocalPlayer().Pos))
                        if GetInteriorAtCoords(LocalPlayer().Pos) ~= 198657 then
                            RageUI.GoBack()
                            ShowNotification("~r~Vous n'êtes pas dans votre salon de coiffure")
                        end
                        RageUI.Button(
                            "Attendre 1",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    doAnim({"misshair_shop@barbers", "keeper_base"}, nil, 1)
                                end
                            end
                        )

                        RageUI.Button(
                            "Attendre 2",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    doAnim({"misshair_shop@hair_dressers", "keeper_base"}, nil, 1)
                                end
                            end
                        )

                        local ply = GetPlayerServerIdInDirection(5.0)
                        HoverPlayer()

                        if skins == nil and ply ~= false then
                            TriggerServerCallback(
                                "core:GetMysource",
                                function(_src)
                                    TriggerPlayerEvent("getSkin", ply, _src)
                                end
                            )
                        else
                            if ply ~= false then
                                myPLY = ply
                                RageUI.List(
                                    "Sourcils",
                                    SA,
                                    sourcilsss,
                                    nil,
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        if Active then
                                            if Index ~= nil then
                                                skins.facialHair.eyebrow.style = Index
                                                sourcilsss = Index
                                            end

                                            RageUI.ColourPanel(
                                                "Couleur principale",
                                                Colors,
                                                colour_table[1],
                                                colour_table[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table[1] = MinimumIndex

                                                    colour_table[2] = CurrentIndex
                                                    skins.facialHair.eyebrow.color[1] = CurrentIndex - 1
                                                end
                                            )
                                            RageUI.ColourPanel(
                                                "Couleur secondaire",
                                                Colors,
                                                colour_table2[1],
                                                colour_table2[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table2[1] = MinimumIndex

                                                    colour_table2[2] = CurrentIndex
                                                    skins.facialHair.eyebrow.color[2] = CurrentIndex - 1
                                                end
                                            )
                                        end
                                        local x, y, z = table.unpack(GetEntityCoords(LocalPlayer().Ped))
                                        local t =
                                            (GetDistanceBetweenCoords(137.76, -1708.74, 29.3, x, y, z, true) < 0.5)
                                        if Selected  then
                                            SetEntityCoords(LocalPlayer().Ped, 137.76, -1708.74, 29.3)
                                            SetEntityHeading(LocalPlayer().Ped, 233.999)
                                            RageUI.GoBack()
                                            Wait(600)

                                            TriggerPlayerEvent("save:Skin", ply, skins)

                                            --doAnim({"misshair_shop@hair_dressers", "keeper_hair_cut_a"},nil)

                                            ShowNotification("~g~Modification appliquée")
                                        end
                                    end
                                )
                                RageUI.List(
                                    "Cheveux",
                                    hairstyles,
                                    hairstyless,
                                    nil,
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        if Active then
                                            if Index ~= nil then
                                                skins.hair.style = Index
                                                hairstyless = Index
                                            end

                                            RageUI.ColourPanel(
                                                "Couleur principale",
                                                Colors,
                                                colour_table[1],
                                                colour_table[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table[1] = MinimumIndex

                                                    colour_table[2] = CurrentIndex
                                                    skins.hair.color[1] = CurrentIndex - 1
                                                end
                                            )
                                            RageUI.ColourPanel(
                                                "Couleur secondaire",
                                                Colors,
                                                colour_table2[1],
                                                colour_table2[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table2[1] = MinimumIndex

                                                    colour_table2[2] = CurrentIndex
                                                    skins.hair.color[2] = CurrentIndex - 1
                                                end
                                            )
                                        end
                                        local x, y, z = table.unpack(GetEntityCoords(LocalPlayer().Ped))
                                        local t =
                                            (GetDistanceBetweenCoords(137.76, -1708.74, 29.3, x, y, z, true) < 0.5)

                                        if Selected then
                                            SetEntityCoords(LocalPlayer().Ped, 137.76, -1708.74, 29.3)
                                            SetEntityHeading(LocalPlayer().Ped, 233.999)
                                            RageUI.GoBack()
                                            Wait(600)

                                            TriggerPlayerEvent("save:Skin", ply, skins)

                                            --doAnim({"misshair_shop@hair_dressers", "keeper_hair_cut_a"},nil)

                                            ShowNotification("~g~Modification appliquée")
                                        end
                                    end
                                )

                                BarbeName = {}
                                for i = 1, #beardAmount, 1 do
                                    BarbeName[i] = GetLabelText("CC_BEARD_" .. i - 1)
                                end

                                RageUI.List(
                                    "Barbe",
                                    BarbeName,
                                    mpp,
                                    nil,
                                    {},
                                    true,
                                    function(Hovered, Active, Selected, Index)
                                        if Active then
                                            skins.facialHair.beard.style = Index
                                            mpp = Index

                                            RageUI.ColourPanel(
                                                "Couleur principale",
                                                Colors,
                                                colour_table3[1],
                                                colour_table3[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table3[1] = MinimumIndex

                                                    colour_table3[2] = CurrentIndex
                                                    skins.facialHair.beard.color[1] = CurrentIndex - 1
                                                end
                                            )
                                            RageUI.ColourPanel(
                                                "Couleur secondaire",
                                                Colors,
                                                colour_table4[1],
                                                colour_table4[2],
                                                function(Hovered, Active, MinimumIndex, CurrentIndex)
                                                    colour_table4[1] = MinimumIndex

                                                    colour_table4[2] = CurrentIndex
                                                    skins.facialHair.beard.color[2] = CurrentIndex - 1
                                                end
                                            )

                                            RageUI.PercentagePanel(
                                                percentage_float,
                                                "Opacité",
                                                nil,
                                                nil,
                                                function(Hovered, Active, Percent)
                                                    percentage_float = Percent
                                                    skins.facialHair.beard.opacity = Percent
                                                end
                                            )

                                        --updateCheveux(skin)
                                        end
                                        local x, y, z = table.unpack(GetEntityCoords(LocalPlayer().Ped))
                                        local t =
                                             (GetDistanceBetweenCoords(137.76, -1708.74, 29.3, x, y, z, true) < 0.5)
                                        if Selected then
                                            SetEntityHeading(LocalPlayer().Ped, 233.999)
                                            RageUI.GoBack()
                                            Wait(600)

                                            TriggerPlayerEvent("save:Skin", ply, skins)

                                            --doAnim({"misshair_shop@hair_dressers", "keeper_hair_cut_a"},nil)

                                            ShowNotification("~g~Modification appliquée")
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
RegisterNetEvent("change:skin")
AddEventHandler(
    "change:skin",
    function(p)
        updateCheveux(p)
    end
)
RegisterNetEvent("getSkin")
AddEventHandler(
    "getSkin",
    function(p)
        skins = {}
        skins.hair = PlySkin.hair
        skins.facialHair = PlySkin.facial.hair
        skins.makeup = PlySkin.makeup
        skins.lipstick = PlySkin.lipstick
        TriggerPlayerEvent("sendSkin", p, skins)
    end
)

RegisterNetEvent("sendSkin")
AddEventHandler(
    "sendSkin",
    function(_skin)
        skins = _skin
        --print(skins.hair.style)
        hairstyless = skins.hair.style
        sourcilsss = skins.facialHair.eyebrow.style
        mpp = skins.facialHair.beard.style
    end
)

RegisterNetEvent("skin:GiveBack")
AddEventHandler(
    "skin:GiveBack",
    function()
        TriggerServerCallback(
            "core:GetSKin",
            function(skin)
                --(dump(skin))
                UpdateEntityFace(LocalPlayer().Ped, json.decode(skin))
            end
        )
    end
)

RegisterNetEvent("save:Skin")
AddEventHandler(
    "save:Skin",
    function(_PlySkin)
        --print("SAVE",_PlySkin.hair.style)
        skins = _PlySkin

        PlySkin.hair.style = skins.hair.style
        PlySkin.hair.color[1] = skins.hair.color[1]
        PlySkin.hair.color[2] = skins.hair.color[2]
        --("achat")

        PlySkin.facial.hair.beard.style = skins.facialHair.beard.style
        PlySkin.facial.hair.beard.opacity = skins.facialHair.beard.opacity
        PlySkin.facial.hair.beard.color[1] = skins.facialHair.beard.color[1]
        PlySkin.facial.hair.beard.color[2] = skins.facialHair.beard.color[2]

        PlySkin.facial.hair.eyebrow.style = skins.facialHair.eyebrow.style
        PlySkin.facial.hair.eyebrow.color[1] = skins.facialHair.eyebrow.color[1]
        PlySkin.facial.hair.eyebrow.color[2] = skins.facialHair.eyebrow.color[2]

        PlySkin.makeup.style = skins.makeup.style
        PlySkin.makeup.opacity = skins.makeup.opacity
        PlySkin.makeup.color[1] = skins.makeup.color[1]
        PlySkin.makeup.color[2] = skins.makeup.color[2]

        PlySkin.lipstick.style = skins.lipstick.style
        PlySkin.lipstick.opacity = skins.lipstick.opacity
        PlySkin.lipstick.color[1] = skins.lipstick.color[1]
        UpdateEntityFace(LocalPlayer().Ped, PlySkin)

        TriggerServerEvent("face:Save", PlySkin)
    end
)
updateCheveux = function(skin)
    Citizen.CreateThread(
        function()
            Citizen.Wait(1)
            skins = skin
            local playerPed = PlayerPedId()
            if skins.hair.style == 0 then
                cleanPlayer()
            else
                cleanPlayer()

                SetPedDecoration(PlayerPedId(), GetHashKey("mpbeach_overlays"), GetHashKey("fm_hair_fuzz"))
            end
            SetPedComponentVariation(playerPed, 2, skins.hair.style, 1.0, 1.0)
            SetPedHairColor(playerPed, skins.hair.color[1], skins.hair.color[2])
            SetPedHeadOverlay(playerPed, 1, skins.facialHair.beard.style, skins.facialHair.beard.opacity)
            SetPedHeadOverlayColor(playerPed, 1, 1, skins.facialHair.beard.color[1], skins.facialHair.beard.color[2])
            SetPedHeadOverlay(playerPed, 2, skins.facialHair.eyebrow.style, skins.facialHair.eyebrow.opacity)
            SetPedHeadOverlayColor(
                playerPed,
                2,
                1,
                skins.facialHair.eyebrow.color[1],
                skins.facialHair.eyebrow.color[2]
            )
            SetPedHeadOverlay(playerPed, 8, skins.lipstick.style, skins.lipstick.opacity)
            SetPedHeadOverlayColor(playerPed, 8, 1, skins.lipstick.color[1], skins.lipstick.color[2])

            SetPedHeadOverlay(playerPed, 4, skins.makeup.style, skins.makeup.opacity)
            SetPedHeadOverlayColor(playerPed, 4, 1, skins.makeup.color[1], skins.makeup.color[2])
            return
        end
    )
end
