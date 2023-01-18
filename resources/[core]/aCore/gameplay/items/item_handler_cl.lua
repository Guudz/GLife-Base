local self = Inventory
local blocNote = true
function ClosestVeh()
    if GetEntityType(vehicleFct.GetVehicleInDirection()) == 2 then
        return vehicleFct.GetVehicleInDirection()
    else
        return getVehInSight()
    end
end

function getVehInSight()
    local ent = getEntInSight()
    if not IsEntityAVehicle(ent) then
        return
    end
    return ent
end

function getEntInSight()
    local ped = LocalPlayer().Ped
    local pos = GetEntityCoords(ped) + vector3(.0, .0, -.4)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0) + vector3(.0, .0, -.4)
    local rayHandle = CastRayPointToPoint(pos, entityWorld, 10, ped, 0)
    local _, _, _, _, ent = GetRaycastResult(rayHandle)
    return ent
end
local defaulClothestvalue = {
    male = {
        [8] = 15,
        [3] = 15,
        [11] = 15,
        [6] = 34,
        [4] = 21
    },
    female = {
        [8] = 15,
        [3] = 15,
        [11] = 15,
        [6] = 35,
        [4] = 14
    }
}
local kevequiped = nil
local kevEquiped = false
function EquipKev()
    local ped = LocalPlayer().Ped
    kevEquiped = not kevEquiped
    if kevEquiped then
        SetPedComponentVariation(ped, 9, Inventory.SelectedItem.data.ind, Inventory.SelectedItem.data.var, 2)
        SetPedArmour(LocalPlayer().Ped, Inventory.SelectedItem.data.status)
        kevequiped = Inventory.SelectedItem
    else
        SetPedArmour(LocalPlayer().Ped, 0)
        SetPedComponentVariation(ped, 9, 1, 5)
    end
end
function ChangeItemData(items)
    for i = 1, #Inventory.Inventory[items.name], 1 do
        if Inventory.Inventory[items.name][i].id == items.id then
            Inventory.Inventory[items.name][i] = items
        end
    end
end
Citizen.CreateThread(
    function()
        while true do
            Wait(30000)
            if kevEquiped then
                if (kevequiped ~= nil and kevequiped.id ~= nil) then
                    if (kevequiped.id.data == nil) then
                        kevequiped.id.data = {}
                    end

                    kevequiped.id.data.status = GetPedArmour(LocalPlayer().Ped)
                    ChangeItemData(kevequiped)
                end
            --TriggerServerEvent("inventory:editData",Inventory.SelectedItem.id,Inventory.SelectedItem.data)
            end
        end
    end
)
function EquipTenue()
    Citizen.CreateThread(
        function()
            -- body

            local item = Inventory.SelectedItem
            local data = item.data
            local ped = LocalPlayer().Ped
            if data.equiped then
                local male = isMale()
                if not male then
                    SetPedComponentVariation(ped, 8, 15, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 11, 15, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 3, 15, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 4, 14, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 6, 35, 0, 2)

                    Wait(700)
                    SetPedComponentVariation(ped, 8, 15, 0, 2)
                    SetPedComponentVariation(ped, 10, 0, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 7, 0, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 5, 0, 0)
                    Wait(700)
                    ClearPedProp(ped, 1)
                    Wait(700)
                    ClearPedProp(ped, 0)
                    SetPedComponentVariation(ped, 1, 0, 0)
                else
                    SetPedComponentVariation(ped, 6, 34, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 4, 21, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 11, 15, 0, 2)
                    Wait(700)
                    SetPedComponentVariation(ped, 3, 15, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 8, 15, 0, 2)
                    SetPedComponentVariation(ped, 10, 0, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 7, 0, 0)
                    Wait(700)
                    SetPedComponentVariation(ped, 5, 0, 0)
                    Wait(700)
                    ClearPedProp(ped, 1)
                    Wait(700)
                    ClearPedProp(ped, 0)
                    SetPedComponentVariation(ped, 1, 0, 0)
                end
            else
                SetPedComponentVariation(ped, 3, data.torso, data.torsocolor)
                Wait(700)
                SetPedComponentVariation(ped, 4, data.pant, data.pantcolor)
                Wait(700)
                SetPedComponentVariation(ped, 6, data.chaus, data.chausscolor)
                Wait(700)
                SetPedComponentVariation(ped, 11, data.tops, data.topcolor)
                Wait(700)
                SetPedComponentVariation(ped, 3, data.torso, data.torsocolor)
                Wait(700)
                SetPedComponentVariation(ped, 7, data.access, data.accesscolor)
                Wait(700)
                SetPedComponentVariation(ped, 8, data.unders, data.underscolor)
                Wait(700)
                SetPedComponentVariation(ped, 10, data.decals, data.decalscolor)
                Wait(700)
                if data.chain ~= nil then
                    SetPedComponentVariation(ped, 7, data.chain, data.chaincolor)
                end
                Wait(700)
                if data.bags ~= nil then
                    SetPedComponentVariation(ped, 5, data.bags, data.bagscolor)
                end
                Wait(700)
                if data.glasses ~= nil then
                    SetPedPropIndex(ped, 1, data.glasses, data.glassescolor)
                end
                Wait(700)
                if data.hat ~= nil then
                    SetPedPropIndex(ped, 0, data.hat, data.hatcolor)
                end
                if data.mask_1 ~= nil then
                    SetPedComponentVariation(ped, 1, data.mask, data.maskcolor)
                end
            end

            item.data.equiped = not item.data.equiped
        end
    )
    local anim = {}
    if isMale() then
        anim = {
            animDict = "clothingshirt",
            anim = "try_shirt_positive_d",
            flags = 1
        }
    else
        anim = {
            animDict = "mp_clothing@female@shirt",
            anim = "try_shirt_neutral_a",
            flags = 1
        }
    end
    exports["mythic_progbar"]:Progress(
        {
            name = "unique_tenue",
            duration = 10000,
            label = "Vous vous changez",
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
    Wait(10000)
end
visor = false
local sac = nil
function EquipClothes()
    local item = Inventory.SelectedItem
    local male = isMale()

    if male then
        if item.data.component == 5 then
            sac = item.data.var
        end
        if item.data.component == 0 then
            visor = false
        end
        if item.data.type == 0 then
            if item.data.equiped and item.data.sex == "male" then
                if item.data.component == 11 then
                end
            else
            end
            item.data.equiped = not item.data.equiped
        else
            if item.data.equiped and item.data.sex == "male" then
                ClearPedProp(LocalPlayer().Ped, item.data.component)
            else
                SetPedPropIndex(LocalPlayer().Ped, item.data.component, item.data.var, item.data.ind)
            end
            item.data.equiped = not item.data.equiped
        end
    else
        if item.data.type == 0 then
            if item.data.equiped and item.data.sex == "female" then
            else
            end
            item.data.equiped = not item.data.equiped
        else
            if item.data.equiped and item.data.sex == "female" then
                ClearPedProp(LocalPlayer().Ped, item.data.component)
            else
                SetPedPropIndex(LocalPlayer().Ped, item.data.component, item.data.var, item.data.ind, 2)
            end
            item.data.equiped = not item.data.equiped
        end
    end

    for i = 1, #Inventory.Inventory[Inventory.SelectedItem.name] do
        local p = Inventory.Inventory[Inventory.SelectedItem.name][i]
        if p.data.component == Inventory.SelectedItem.data.commponent then
            if p.id ~= Inventory.SelectedItem.id then
                p.data.equiped = false
            end
        end
    end

    if item.data.type == 0 then
        RefreshClothes()
    end
end
local decorObject = nil
function EquipMasks()
    local item = Inventory.SelectedItem
    if item.data.equiped then
        playerPed = LocalPlayer().Ped
        local dict = "missfbi4"
        local myPed = LocalPlayer().Ped
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        local animation = ""
        local flags = 0
        animation = "takeoff_mask"
        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
        Citizen.Wait(1000)
        SetEntityCollision(LocalPlayer().Ped, true, true)
        playerPed = LocalPlayer().Ped
        Citizen.Wait(200)
        ClearPedTasks(playerPed)
        SetPedComponentVariation(LocalPlayer().Ped, item.data.component, 0, 0)
    else
        playerPed = LocalPlayer().Ped
        local dict = "missfbi4"
        local myPed = LocalPlayer().Ped
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end

        local animation = ""
        local flags = 0 -- only play the animation on the upper body
        animation = "takeoff_mask"
        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
        Citizen.Wait(1000)
        SetEntityCollision(LocalPlayer().Ped, true, true)
        playerPed = LocalPlayer().Ped
        Citizen.Wait(200)
        ClearPedTasks(playerPed)
        SetPedComponentVariation(LocalPlayer().Ped, item.data.component, item.data.var, item.data.ind)
    end
    item.data.equiped = not item.data.equiped
end
function EquipRadio()
    exports["ls_radio"]:SetRadio(true)
    ShowNotification("~g~Radio activé !")
end

MyBattery = 0
MyNumber = 0
Citizen.CreateThread(
    function()
        while true do
            Wait(100)
            if MyBattery > 0 and MyNumber ~= 0 then
                Wait(60000)
                MyBattery = MyBattery - 1

                TriggerEvent("gcphone:UpdateBattery", MyBattery)
                for i = 1, #Inventory.Inventory["tel"] do
                    if Inventory.Inventory["tel"][i].data.num == MyNumber then
                        Inventory.Inventory["tel"][i].data.battery = MyBattery
                        --TriggerServerEvent("inventory:editData",Inventory.Inventory["tel"][i].id,Inventory.Inventory["tel"][i].data)
                        break
                    end
                end
            elseif MyBattery < 0 and myPhoneNumber ~= 0 then
                MyBattery = 0
                TriggerEvent("gcphone:UpdateBattery", 0)
            end
        end
    end
)
ItemsFunction = {
    herse = function()
        useHerse()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    roulant = function()
        useChaise()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    armoire = function()
        useArmoire()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    fauteuil = function()
        useFauteuil()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    commode = function()
        useCommode()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    tablefbi = function()
        useTablefbi()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    cone = function()
        useCone()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    barrier = function()
        useBarrier()
    end,
    usbkey = function()
        local bool, m = isNearComputer()
        if bool then
            Wait(100)
            AddHackButton()
        end
    end,
    tel = function()
        local item = self.SelectedItem
        TriggerServerEvent("core:SetNumber", item.data.num)
        MyNumber = item.data.num
        MyBattery = item.data.battery
        TriggerEvent("gcphone:UpdateBattery", MyBattery)
        TriggerEvent("gcPhone:myPhoneNumber", MyNumber)
        Wait(300)
        TriggerServerEvent("gcPhone:allUpdate")
        RageUI.Popup({message = "Téléphone activé : ~g~" .. MyNumber})
    end,
    battery = function()
        if MyNumber == nil or MyNumber == 0 then
            RageUI.Popup({message = "~w~Vous n'avez pas de ~r~téléphone actif"})
        else
            self:RemoveItem()
            MyBattery = MyBattery + 50
            if MyBattery > 100 then
                MyBattery = MyBattery - (MyBattery - 100)
            end
            for i = 1, #Inventory.Inventory["tel"] do
                if Inventory.Inventory["tel"][i].data.num == MyNumber then
                    Inventory.Inventory["tel"][i].data.battery = MyBattery
                    --TriggerServerEvent("inventory:editData",Inventory.Inventory["tel"][i].id,Inventory.Inventory["tel"][i].data)
                    break
                end
            end
            TriggerEvent("gcphone:UpdateBattery", MyBattery)
        end
    end,
    blocnote = function()
        local item = self.SelectedItem
        local data = item.data
        data = json.decode(data)
        if type(data) ~= "table" then
            data = json.decode(data)
        end
        text = KeyboardInput("~b~Combien ?", data.text, 255)
        if tostring(text) ~= nil then
            data.text = text
            TriggerServerEvent("ChangeItemData", item.id, data, item)
        end
    end,
    crochetage = function()
        LockPickVehicle()
    end,
    weed_pot = function()
        self:RemoveItem()
        exports["weed"]:createProps()
    end,
    ciseaux = function()
        CutChev()
    end,
    mask = EquipMasks,
    kevlar = EquipKev,
    clothe = EquipClothes,
    radio = EquipRadio,
    tenue = EquipTenue,
    menottes = Police.HandcuffPly,
    pinces = Police.CutMenottes,
    access = EquipClothes,
    bank_card = function()
        UseBankCard()
    end,
    bouteille_vin = drinkAlcool,
    sac = OpenSac,
    coke1 = eatCoke,
    meth = eatMeth,
    meth1 = eatMeth,
    lsd = eatLSD,
    hero = eatHero,
    mdma = eatMdma,
    repairbox2 = function()
        TriggerServerCallback(
            "service:Count",
            function(nb)
                if nb == 0 then
                    local vehicle = ClosestVeh()
                    Inventory:DeleteItem()
                    if vehicle ~= 0 then
                        TaskStartScenarioInPlace(LocalPlayer().Ped, "PROP_HUMAN_BUM_BIN", 0, true)
                        player = LocalPlayer()
                        player.isBusy = true
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(20000)

                                SetVehicleFixed(vehicle)
                                SetVehicleDeformationFixed(vehicle)
                                SetVehicleUndriveable(vehicle, false)
                                SetVehicleEngineOn(vehicle, true, true)
                                ClearPedTasksImmediately(LocalPlayer().Ped)

                                RageUI.Popup({message = "Véhicule ~g~réparé"})
                                player.isBusy = false
                            end
                        )
                    else
                        RageUI.Popup({message = "~r~Aucun véhicule"})
                    end
                else
                    ShowNotification("~r~Vous ne pouvez pas faire ceci\n~y~(mécano(s) en service)")
                end
            end,
            "mecano"
        )
    end,
    Ticket = function()
        numb = tonumber(KeyboardInput("Choisir un chiffre",nil,3))
        f = false
        if numb == nil then return end
        if numb > 0 and numb < 100 and not f then
            TriggerServerEvent("insertLotery",numb)
            self:RemoveItem()
            ShowNotification("~g~Vous avez joué le numéro " .. numb)
        else
            ShowNotification("~r~Veuillez entrer un chiffre entre 0 et " .. 100)
        end
    end,
    perche = function()
        local objectData = {
            prop = "prop_v_bmike_01",
            anim = {"missfra1", "mcs2_crew_idle_m_boom"},
            flag = 50,
            bone = 28422,
            pos = {-0.08, 0.0, 0.0, 0.0, 0.0, 0.0}
        }
        -- if objectData and objectData.anim and (not IsEntityPlayingAnim(ped, objectData.anim[1], objectData.anim[2], 3) or (not lastAnimationUpdate or lastAnimationUpdate <= GetGameTimer())) then
        --   forceAnim(objectData.anim, objectData.flag, { clearTasks = true })
        --   lastAnimationUpdate = GetGameTimer() + 10000
        -- end
        ppppp(objectData)
    end,
    micro = function()
        objectData = {
            prop = "p_ing_microphonel_01",
            anim = {"missheistdocksprep1hold_cellphone", "hold_cellphone"},
            flag = 50,
            bone = 60309,
            pos = {0.055, 0.05, 0.0, 240.0, 0.0, 0.0}
        }
        ppppp(objectData)
    end,
    bigcam = function()
        objectData = {
            prop = "prop_v_cam_01",
            anim = {"missfinale_c2mcs_1", "fin_c2_mcs_1_camman"},
            flag = 50,
            bone = 28422,
            pos = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0}
        }
        ppppp(objectData)
    end,
    parapluie = function()
        objectData = {
            prop = "p_amb_brolly_01",
            anim = {"amb@code_human_wander_drinking@male@base", "base"},
            flag = 49,
            bone = 57005,
            pos = {.125, .05, .0, -90.0, 0.0, 0.0}
        }
        ppppp(objectData)
    end,
    megaphone = function()
        objectData = {
            prop = "prop_megaphone_01",
            anim = {"weapons@first_person@aim_idle@generic@submachine_gun@shared@core", "settle_med"},
            flag = 49,
            bone = 36029,
            pos = {-.125, .0, -.03, -10.0, 30.0, 0.0}
        }
        ppppp(objectData)
        megaphone = not megaphone
        exports["mumble-voip"]:megaPhone()
    end,
    --cannepeche = function()
    --TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_STAND_FISHING", 0, true)
    --end,
    shield = function()
        createShield()
    end,
    cana = eatCana,
    darknet = function()
        if self.SelectedItem.data == nil or self.SelectedItem.data.username == nil then
            generateRandomUsername()
        else
            OpenDarkNet(self.SelectedItem)
        end
    end,
    gants = toggleGloves,
    medikit = function()
        SetEntityHealth(LocalPlayer().Ped, 200)
        self:RemoveItem()
    end,
    mec = function()
        SetEntityHealth(LocalPlayer().Ped, GetEntityHealth(LocalPlayer().Ped) + 50.0)
        self:RemoveItem()
    end,
    moteur = RepairMotor,
    fikit = RepairCaro,
    roue = RepairRoue,
    lavage = function()
        local vehicle = ClosestVeh()
        if vehicle ~= 0 then
            TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
            player = LocalPlayer()
            player.isBusy = true
            Citizen.CreateThread(
                function()
                    Citizen.Wait(10000)

                    SetVehicleDirtLevel(vehicle, 0)
                    ClearPedTasksImmediately(LocalPlayer().Ped)

                    RageUI.Popup({message = "Véhicule ~g~nettoyé"})
                    player.isBusy = false
                end
            )
            self:RemoveItem()
        else
            RageUI.Popup({message = "~r~Aucun véhicule"})
        end
    end
}
function ppppp(objectData)
    local ped = LocalPlayer().Ped
    if decorObject == nil then
        decorObject = CreateObject(GetHashKey(objectData.prop), plyPos, true, true, true)
        SetPedKeepTask(ped, true)
        doAnim(objectData.anim, nil, objectData.flag)
        local a, b, c, d, e, f = table.unpack(objectData.pos)
        AttachEntityToEntity(
            decorObject,
            ped,
            GetPedBoneIndex(ped, objectData.bone),
            a or 0.0,
            b or 0.0,
            c or 0.0,
            d or 0.0,
            e or 0.0,
            f or 0.0,
            0,
            0,
            0,
            1,
            0,
            1
        )
    else
        DeleteEntity(decorObject)
        decorObject = nil
        ClearPedTasks(ped)
    end
end
function toggleObject(_, n)
    if not n then
        return
    end
    local Player = LocalPlayer()
    GM.itemHandler[n] = nil
    hasObject = not hasObject and n or false
    if decorObject and DoesEntityExist(decorObject) then
        SetEntityAsMissionEntity(decorObject, 1, 1)
        DeleteEntity(decorObject)
    end

    local ped, plyPos, objectInfo = Player.Ped, Player.Pos, treeDecorObjets[n]
    if hasObject and objectInfo then
        ClearAreaOfObjects(plyPos, 3.0)

        decorObject = CreateObject(GetHashKey(objectInfo.prop), plyPos, true, 0, 0)
        SetPedKeepTask(ped, true)
        doAnim(objectInfo.anim, nil, objectInfo.flag)
        local a, b, c, d, e, f = table.unpack(objectInfo.pos)
        AttachEntityToEntity(
            decorObject,
            ped,
            GetPedBoneIndex(ped, objectInfo.bone),
            a or 0.0,
            b or 0.0,
            c or 0.0,
            d or 0.0,
            e or 0.0,
            f or 0.0,
            0,
            0,
            0,
            1,
            0,
            1
        )

        GM.itemHandler[n] = decorObject

        if objectInfo.onStart then
            objectInfo.onStart(objectInfo, Player, ped)
        end
    else
        ClearPedTasks(ped)
        if objectInfo.onExit then
            objectInfo.onExit(objectInfo, Player, ped)
        end
    end
end
function EquipWeapon()
    local name = weapon_name[Inventory.SelectedItem.name]
    if HasPedGotWeapon(LocalPlayer().Ped, GetHashKey(name), false) then
        RemoveWeaponFromPed(playerPed, GetHashKey(name))
    else
        local playerPed = LocalPlayer().Ped
        SetPedAmmo(LocalPlayer().Ped, GetHashKey(name), 0)
        GiveWeaponToPed(playerPed, GetHashKey(name), 0, false, true)
        local data = Inventory.SelectedItem.data
        if data ~= nil and data.tint ~= nil then
            SetPedWeaponTintIndex(playerPed, GetHashKey(name), data.tint)
        end
        if data ~= nil and data.access ~= nil then
            for i = 1, #data.access, 1 do
                GiveWeaponComponentToPed(LocalPlayer().Ped, GetHashKey(name), GetHashKey(data.access[i]))
            end
        end

        cp = nil

        for k, v in pairs(weapon_name) do
            if v == name then
                cp = k
            end
        end
        for k, v in pairs(Inventory.Inventory) do
            if k == weapon_munition[cp] then
                SetPedAmmo(LocalPlayer().Ped, GetHashKey(name), #v)
                Inventory.CurrentAmmo = #v
                break
            else
                Inventory.CurrentAmmo = 0
            end
        end
        Inventory.CurrentWeapon.Name = GetHashKey(name)
        Inventory.CurrentWeapon.Label = name
        Inventory.CurrentMunition = weapon_munition[cp]
        Inventory.IsArmed = true
    end
end
DecorRegister("powder", 2)

Citizen.CreateThread(
    function()
        while true do
            Wait(5)
            playerPed = LocalPlayer().Ped
            --print(DecorGetBool(playerPed,"powder"))
            if IsPedShooting(playerPed) then
                DecorSetBool(playerPed, "powder", true)
                TriggerServerEvent("aCore_status:addOn", "powder")

                if Inventory.Inventory[Inventory.CurrentMunition] ~= nil then
                    item = Inventory.Inventory[Inventory.CurrentMunition][1].id
                    Inventory.CurrentAmmo = Inventory.CurrentAmmo - 1
                    Inventory:RemoveItemToInv(
                        Inventory.Inventory[Inventory.CurrentMunition][1].id,
                        Inventory.Inventory[Inventory.CurrentMunition][1].name
                    )
                ----TriggerServerEvent("inventory:RemoveItem",Inventory.Inventory[Inventory.CurrentMunition][1].id,Inventory.Inventory[Inventory.CurrentMunition][1].name)
                end
            end
        end
    end
)

function DeleteChaise()
    local playerPed = LocalPlayer().Ped
    local coords = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_chair_04a"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de la ~b~chaise")
        end
    end
end

function DeleteArmoire()
    local playerPed = LocalPlayer().Ped
    local coords = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_rub_cabinet01"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de l'~b~Armoire")
        end
    end
end

function DeleteFauteuil()
    local playerPed = LocalPlayer().Ped
    local coords = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_chair_02"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin du ~b~Fauteuil")
        end
    end
end

function DeleteHerse()
    local playerPed = LocalPlayer().Ped
    local coords = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("p_ld_stinger_s"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin d'une herse")
        end
    end
end

function DeleteCommode()
    local playerPed = LocalPlayer().Ped
    local coords = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_fbibombfile"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de la commode")
        end
    end
end

function DeleteTablefbi()
    local playerPed = LocalPlayer().Ped
    local coords = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_fbi3_coffee_table"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de la table")
        end
    end
end

function DeleteCone()
    ExecuteCommand("r")
end

function DeleteBarrier()
    local playerPed = LocalPlayer().Ped
    local coords = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity = nil
    local object = GetClosestObjectOfType(coords, 3.0, GetHashKey("prop_barrier_work05"), false, false, false)

    if DoesEntityExist(object) then
        local objCoords = GetEntityCoords(object)
        local distance = GetDistanceBetweenCoords(coords, objCoords, true)

        if closestDistance == -1 or closestDistance > distance then
            DeleteEntity(object)
        else
            ShowNotification("~r~Vous êtes trop loin de la barriere")
        end
    end
end

local gloves = {}
local gloveModel = GetHashKey("prop_boxing_glove_01")
function toggleGloves()
    for k, v in pairs(gloves) do
        DeleteEntity(v)
    end
    if tableCount(gloves) > 0 then
        gloves = {}
        return
    end

    if not HasModelLoaded(gloveModel) then
        RequestModel(gloveModel)
        while not HasModelLoaded(gloveModel) do
            Citizen.Wait(100)
        end
    end

    local Player = LocalPlayer()
    local ped, plyPos = Player.Ped, Player.Pos

    local firstGlove = CreateObject(gloveModel, plyPos, 1, 0, 0)
    local secondGlove = CreateObject(gloveModel, plyPos, 1, 0, 0)
    table.insert(gloves, firstGlove)
    table.insert(gloves, secondGlove)

    for k, v in pairs(gloves) do
        SetEntityAsMissionEntity(v, 1, 1)
        --	SetEntityCollision(v, 1, 0)
    end

    AttachEntityToEntity(
        firstGlove,
        ped,
        GetPedBoneIndex(ped, 6286),
        vector3(-0.1, 0.01, -0.01),
        vector3(90.0, 0.0, 90.0),
        0,
        0,
        0,
        0,
        0,
        1
    )
    AttachEntityToEntity(
        secondGlove,
        ped,
        GetPedBoneIndex(ped, 36029),
        vector3(-0.1, 0.02, 0.02),
        vector3(-90.0, 0.0, -90.0),
        0,
        0,
        0,
        0,
        0,
        1
    )
    ShowAboveRadarMessage("Vous avez équipé ~g~vos gants~w~.")
end
SpawnObject = function(model, coords, cb)
    local model = (type(model) == "number" and model or GetHashKey(model))

    Citizen.CreateThread(
        function()
            RequestModel(model)

            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end

            local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)

            if cb ~= nil then
                cb(obj)
            end
        end
    )
end
function useHerse()
    local playerPed = LocalPlayer().Ped
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "p_ld_stinger_s",
        objectCoords,
        function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useCommode()
    self:RemoveItem()
    local playerPed = LocalPlayer().Ped
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_fbibombfile",
        objectCoords,
        function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useTablefbi()
    self:RemoveItem()
    local playerPed = LocalPlayer().Ped
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_fbi3_coffee_table",
        objectCoords,
        function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useArmoire()
    self:RemoveItem()
    local playerPed = LocalPlayer().Ped
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_rub_cabinet01",
        objectCoords,
        function(obj)
            FreezeEntityPosition(obj, GetEntityHeading(playerPed))
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useFauteuil()
    self:RemoveItem()
    local playerPed = LocalPlayer().Ped
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_chair_02",
        objectCoords,
        function(obj)
            FreezeEntityPosition(obj, GetEntityHeading(playerPed))
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end

function useChaise()
    self:RemoveItem()
    SpawnObject(
        "prop_wheelchair_01",
        GetEntityCoords(LocalPlayer().Ped),
        function(obj)
            PlaceObjectOnGroundProperly(obj)
        end
    )
end
function useCone()
    TriggerEvent("inrp_propsystem:attachProp", "prop_roadcone02a", 28422, 0.6, -0.15, -0.1, 315.0, 288.0, 0.0)
end
function useBarrier()
    local playerPed = LocalPlayer().Ped
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    SpawnObject(
        "prop_barrier_work05",
        objectCoords,
        function(obj)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
        end
    )
end
-- Enter / Exit entity zone events
Citizen.CreateThread(
    function()
        local trackedEntities = {
            "p_ld_stinger_s"
        }

        while true do
            Citizen.Wait(0)

            local playerPed = LocalPlayer().Ped
            local coords = LocalPlayer().Pos
            local LastEntity = nil

            local closestDistance = -1
            local closestEntity = nil

            if GetVehiclePedIsUsing(playerPed) ~= 0 then
                for i = 1, #trackedEntities, 1 do
                    local object =
                        GetClosestObjectOfType(coords, 15.0, GetHashKey(trackedEntities[i]), false, false, false)

                    if DoesEntityExist(object) then
                        local objCoords = GetEntityCoords(object)
                        local distance = GetDistanceBetweenCoords(GetEntityCoords(playerPed), objCoords, true)

                        if distance <= 3.0 then
                            local vehicle = GetVehiclePedIsIn(playerPed)
                            for i = 0, 7, 1 do
                                SetVehicleTyreBurst(vehicle, i, true, 1000)
                            end
                        end
                    end
                end
            end
        end
    end
)

local shieldActive = false
local shieldEntity = nil
local hadPistol = false

-- ANIM
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = "prop_ballistic_shield"
local pistol = GetHashKey("WEAPON_PISTOL")

function createShield()
    if shieldActive then
        DisableShield()
    else
        EnableShield()
    end
end

function EnableShield()
    shieldActive = true
    local ped = LocalPlayer().Ped
    local pedPos = GetEntityCoords(ped, false)

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(100)
    end

    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(
        shieldEntity,
        ped,
        GetEntityBoneIndexByName(ped, "IK_L_Hand"),
        0.0,
        -0.05,
        -0.10,
        -30.0,
        180.0,
        40.0,
        0,
        0,
        1,
        0,
        0,
        1
    )
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))

    SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = LocalPlayer().Ped
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))

    if not hadPistol then
        RemoveWeaponFromPed(ped, pistol)
    end
    SetEnableHandcuffs(ped, false)
    hadPistol = false
    shieldActive = false
end

Citizen.CreateThread(
    function()
        while true do
            if shieldActive then
                local ped = LocalPlayer().Ped
                if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                    RequestAnimDict(animDict)
                    while not HasAnimDictLoaded(animDict) do
                        Citizen.Wait(100)
                    end

                    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
                end
            end
            Citizen.Wait(500)
        end
    end
)

attachPropList = {
    {
        ["model"] = "prop_roadcone02a",
        ["name"] = "cone",
        ["bone"] = 28422,
        ["x"] = 0.6,
        ["y"] = -0.15,
        ["z"] = -0.1,
        ["xR"] = 315.0,
        ["yR"] = 288.0,
        ["zR"] = 0.0,
        ["anim"] = "pick"
    }, -- Done
    {
        ["model"] = "prop_cs_trolley_01",
        ["name"] = "chariot",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.6,
        ["z"] = -0.8,
        ["xR"] = -180.0,
        ["yR"] = -165.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_table_03",
        ["name"] = "table",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.8,
        ["z"] = -0.7,
        ["xR"] = -180.0,
        ["yR"] = -165.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_tool_box_04",
        ["name"] = "repairbox",
        ["bone"] = 28422,
        ["x"] = 0.4,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 315.0,
        ["yR"] = 288.0,
        ["zR"] = 0.0,
        ["anim"] = "pick"
    }, -- Done
    {
        ["model"] = "xm_prop_smug_crate_s_medical",
        ["name"] = "MedBox",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "xm_prop_x17_bag_med_01a",
        ["name"] = "MedBag",
        ["bone"] = 28422,
        ["x"] = 0.4,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 315.0,
        ["yR"] = 298.0,
        ["zR"] = 0.0,
        ["anim"] = "pick"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_car_door_04a",
        ["name"] = "porte",
        ["bone"] = 28422,
        ["x"] = -0.5,
        ["y"] = -0.15,
        ["z"] = 0.4,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_front_bars_01a",
        ["name"] = "parebuffle",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.25,
        ["z"] = -0.1,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_bonnet_03a",
        ["name"] = "capot",
        ["bone"] = 28422,
        ["x"] = 0.2,
        ["y"] = 0.2,
        ["z"] = -0.1,
        ["xR"] = -0.0,
        ["yR"] = 0.0,
        ["zR"] = 180.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_front_bumper_02a",
        ["name"] = "parechoc",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = 0.1,
        ["z"] = 0.05,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_car_battery_01",
        ["name"] = "batterie",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.1,
        ["z"] = -0.05,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_wheel_tyre",
        ["name"] = "pneu",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.1,
        ["z"] = -0.05,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_table_03_chr",
        ["name"] = "chaise",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.2,
        ["z"] = -0.6,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_engine_hoist",
        ["name"] = "levage",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.5,
        ["z"] = -1.3,
        ["xR"] = -195.0,
        ["yR"] = -180.0,
        ["zR"] = 180.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "ex_office_swag_guns03",
        ["name"] = "armes",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = 0.0,
        ["z"] = -0.05,
        ["xR"] = 90.0,
        ["yR"] = 180.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_cs_cardbox_01",
        ["name"] = "caisse",
        ["bone"] = 28422,
        ["x"] = 0.01,
        ["y"] = 0.01,
        ["z"] = 0.0,
        ["xR"] = -255.0,
        ["yR"] = -120.0,
        ["zR"] = 40.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "imp_prop_impexp_lappy_01a",
        ["name"] = "portable",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = 0.0,
        ["z"] = -0.15,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "xm_prop_x17_bag_01a",
        ["name"] = "sac",
        ["bone"] = 28422,
        ["x"] = 0.4,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 315.0,
        ["yR"] = 298.0,
        ["zR"] = 0.0,
        ["anim"] = "pick"
    }, -- Done
    {
        ["model"] = "p_ld_soc_ball_01",
        ["name"] = "balle",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = 0.0,
        ["z"] = 0.0,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "p_gcase_s",
        ["name"] = "malearme",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.25,
        ["z"] = -0.1,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_cleaning_trolly",
        ["name"] = "CarroLimpezas",
        ["bone"] = 28422,
        ["x"] = -0.2,
        ["y"] = -0.4,
        ["z"] = -1.2,
        ["xR"] = -188.0,
        ["yR"] = -178.0,
        ["zR"] = 180.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_mp_drug_package",
        ["name"] = "drogue",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.25,
        ["z"] = -0.05,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    },
    {
        ["model"] = "prop_premier_fence_02",
        ["name"] = "patrocinios",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.6,
        ["z"] = -0.2,
        ["xR"] = -180.0,
        ["yR"] = -165.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_premier_fence_01",
        ["name"] = "fence",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.6,
        ["z"] = -0.8,
        ["xR"] = -180.0,
        ["yR"] = -165.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_kino_light_02",
        ["name"] = "luz",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.6,
        ["z"] = -0.8,
        ["xR"] = -180.0,
        ["yR"] = -165.0,
        ["zR"] = 90.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_cash_case_01",
        ["name"] = "malargent",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    }, -- Done
    {
        ["model"] = "prop_cs_dildo_01",
        ["name"] = "dildo",
        ["bone"] = 28422,
        ["x"] = 0.0,
        ["y"] = -0.1,
        ["z"] = -0.1,
        ["xR"] = 0.0,
        ["yR"] = 0.0,
        ["zR"] = 0.0,
        ["anim"] = "hold"
    } -- Done
    --{["model"] = "prop_c4_final_green",				["name"] = "c4", 		["bone"] = 28422, ["x"] = 0.0,	["y"] = -0.1,	["z"] = -0.05,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0 , 	["anim"] = 'hold' } -- Done
    --{["model"] = "prop_fishing_rod_01",				["name"] = "cannepeche", 		["bone"] = 6286, ["x"] = 0.0,	["y"] = -0.1,	["z"] = -0.1,	["xR"] = 0.0,	["yR"] = 0.0, 	["zR"] = 0.0, 	["anim"] = 'hold' } -- Done
}

function SpecialProps()
    local i = attachPropList[Items[Inventory.SelectedItem.name].Index]
    TriggerEvent("inrp_propsystem:attachProp", i.model, i.bone, i.x, i.y, i.z, i.xR, i.yR, i.zR)
end

local holdingPackage = false
local dropkey = 246 -- Key to drop/get the props
local closestEntity = 0

RegisterNetEvent("inrp_propsystem:attachProp")
AddEventHandler(
    "inrp_propsystem:attachProp",
    function(attachModelSent, boneNumberSent, x, y, z, xR, yR, zR)
        notifi("~r~Y~w~ pour prendre/lâcher                           ~r~ /r~w~ pour supprimer", true, false, 120)
        closestEntity = 0
        holdingPackage = true
        local attachModel = GetHashKey(attachModelSent)
        SetCurrentPedWeapon(LocalPlayer().Ped, 0xA2719263)
        local bone = GetPedBoneIndex(LocalPlayer().Ped, boneNumberSent)
        RequestModel(attachModel)
        while not HasModelLoaded(attachModel) do
            Citizen.Wait(0)
        end
        closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
        for i = 1, #attachPropList, 1 do
            if (attachPropList[i].model == attachModelSent) and (attachPropList[i].anim == "hold") then
                holdAnim()
            end
        end
        Citizen.Wait(200)
        AttachEntityToEntity(closestEntity, LocalPlayer().Ped, bone, x, y, z, xR, yR, zR, 1, 1, 0, true, 2, 1)
    end
)

function notifi(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, false, 3000)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function randPickupAnim()
    local randAnim = math.random(7)
    loadAnimDict("random@domestic")
    TaskPlayAnim(LocalPlayer().Ped, "random@domestic", "pickup_low", 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
end

function holdAnim()
    loadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim((LocalPlayer().Ped), "anim@heists@box_carry@", "idle", 4.0, 1.0, -1, 49, 0, 0, 0, 0)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)

            if IsPedOnFoot(LocalPlayer().Ped) and not IsPedDeadOrDying(LocalPlayer().Ped) then
                if IsControlJustReleased(0, dropkey) then
                    local playerPed = LocalPlayer().Ped
                    local coords = GetEntityCoords(playerPed)
                    local closestDistance = -1
                    closestEntity = 0
                    for i = 1, #attachPropList, 1 do
                        local object =
                            GetClosestObjectOfType(
                            coords,
                            1.5,
                            GetHashKey(attachPropList[i].model),
                            false,
                            false,
                            false
                        )
                        if DoesEntityExist(object) then
                            local objCoords = GetEntityCoords(object)
                            local distance = GetDistanceBetweenCoords(coords, objCoords, true)
                            if closestDistance == -1 or closestDistance > distance then
                                closestDistance = distance
                                closestEntity = object
                                if not holdingPackage then
                                    local dst =
                                        GetDistanceBetweenCoords(
                                        GetEntityCoords(closestEntity),
                                        GetEntityCoords(LocalPlayer().Ped),
                                        true
                                    )
                                    if dst < 2 then
                                        holdingPackage = true
                                        if attachPropList[i].anim == "pick" then
                                            randPickupAnim()
                                        elseif attachPropList[i].anim == "hold" then
                                            holdAnim()
                                        end
                                        Citizen.Wait(550)
                                        NetworkRequestControlOfEntity(closestEntity)
                                        while not NetworkHasControlOfEntity(closestEntity) do
                                            Wait(0)
                                        end
                                        SetEntityAsMissionEntity(closestEntity, true, true)
                                        while not IsEntityAMissionEntity(closestEntity) do
                                            Wait(0)
                                        end
                                        SetEntityHasGravity(closestEntity, true)
                                        AttachEntityToEntity(
                                            closestEntity,
                                            LocalPlayer().Ped,
                                            GetPedBoneIndex(LocalPlayer().Ped, attachPropList[i].bone),
                                            attachPropList[i].x,
                                            attachPropList[i].y,
                                            attachPropList[i].z,
                                            attachPropList[i].xR,
                                            attachPropList[i].yR,
                                            attachPropList[i].zR,
                                            1,
                                            1,
                                            0,
                                            true,
                                            2,
                                            1
                                        )
                                    end
                                else
                                    holdingPackage = false
                                    if attachPropList[i].anim == "pick" then
                                        randPickupAnim()
                                    end
                                    Citizen.Wait(350)
                                    DetachEntity(closestEntity)
                                    ClearPedTasks(LocalPlayer().Ped)
                                    ClearPedSecondaryTask(LocalPlayer().Ped)
                                end
                            end
                            break
                        end
                    end
                end
            else
                Citizen.Wait(500)
            end
        end
    end
)

function removeAttachedProp()
    if DoesEntityExist(closestEntity) then
        DeleteEntity(closestEntity)
    end
end

function attach(prop)
    TriggerEvent("inrp_propsystem:attachItem", prop)
end

function removeall()
    TriggerEvent("RemoveItems", false)
    ClearPedTasks(LocalPlayer().Ped)
    ClearPedSecondaryTask(LocalPlayer().Ped)
end

RegisterNetEvent("inrp_propsystem:attachItem")
AddEventHandler(
    "inrp_propsystem:attachItem",
    function(item)
        for i = 1, #attachPropList, 1 do
            if (attachPropList[i].model == item) then
                TriggerEvent(
                    "inrp_propsystem:attachProp",
                    attachPropList[i].model,
                    attachPropList[i].bone,
                    attachPropList[i].x,
                    attachPropList[i].y,
                    attachPropList[i].z,
                    attachPropList[i].xR,
                    attachPropList[i].yR,
                    attachPropList[i].zR
                )
            end
        end
    end
)

RegisterNetEvent("RemoveItems")
AddEventHandler(
    "RemoveItems",
    function(sentinfo)
        SetCurrentPedWeapon(LocalPlayer().Ped, GetHashKey("weapon_unarmed"), 1)
        removeAttachedProp()
        holdingPackage = false
    end
)

RegisterCommand(
    "r",
    function()
        removeall()
    end,
    false
)

RegisterCommand(
    "removewheelchair",
    function()
        local wheelchair =
            GetClosestObjectOfType(GetEntityCoords(LocalPlayer().Ped), 10.0, GetHashKey("prop_wheelchair_01"))

        if DoesEntityExist(wheelchair) then
            DeleteEntity(wheelchair)
        end
    end,
    false
)

Citizen.CreateThread(
    function()
        while true do
            local sleep = 500

            local ped = LocalPlayer().Ped
            local pedCoords = GetEntityCoords(ped)

            local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_wheelchair_01"), false)

            if DoesEntityExist(closestObject) then
                sleep = 5

                local wheelChairCoords = GetEntityCoords(closestObject)
                local wheelChairForward = GetEntityForwardVector(closestObject)

                local sitCoords = (wheelChairCoords + wheelChairForward * -0.5)
                local pickupCoords = (wheelChairCoords + wheelChairForward * 0.3)

                if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 1.0 then
                    DrawText3Ds(sitCoords, "[E] S'asseoir", 0.4)

                    if IsControlJustPressed(0, 38) then
                        Sit(closestObject)
                    end
                end

                if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 1.0 then
                    DrawText3Ds(pickupCoords, "[E] Ramasser", 0.4)

                    if IsControlJustPressed(0, 38) then
                        PickUp(closestObject)
                    end
                end
            end

            Citizen.Wait(sleep)
        end
    end
)

Sit = function(wheelchairObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if
            IsEntityPlayingAnim(
                GetPlayerPed(closestPlayer),
                "missfinale_c2leadinoutfin_c_int",
                "_leadin_loop2_lester",
                3
            )
         then
            ShowNotification("Quelqu'un porte déjà cette chaise")
            return
        end
    end

    LoadAnim("missfinale_c2leadinoutfin_c_int")

    AttachEntityToEntity(
        LocalPlayer().Ped,
        wheelchairObject,
        0,
        0,
        0.0,
        0.4,
        0.0,
        0.0,
        180.0,
        0.0,
        false,
        false,
        false,
        false,
        2,
        true
    )

    local heading = GetEntityHeading(wheelchairObject)

    while IsEntityAttachedToEntity(LocalPlayer().Ped, wheelchairObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(LocalPlayer().Ped) then
            DetachEntity(LocalPlayer().Ped, true, true)
        end

        if not IsEntityPlayingAnim(LocalPlayer().Ped, "missfinale_c2leadinoutfin_c_int", "_leadin_loop2_lester", 3) then
            TaskPlayAnim(
                LocalPlayer().Ped,
                "missfinale_c2leadinoutfin_c_int",
                "_leadin_loop2_lester",
                8.0,
                8.0,
                -1,
                69,
                1,
                false,
                false,
                false
            )
        end

        if IsControlPressed(0, 32) then
            local x, y, z =
                table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * -0.02)
            SetEntityCoords(wheelchairObject, x, y, z)
            PlaceObjectOnGroundProperly(wheelchairObject)
        end

        if IsControlPressed(1, 34) then
            heading = heading + 0.4

            if heading > 360 then
                heading = 0
            end

            SetEntityHeading(wheelchairObject, heading)
        end

        if IsControlPressed(1, 9) then
            heading = heading - 0.4

            if heading < 0 then
                heading = 360
            end

            SetEntityHeading(wheelchairObject, heading)
        end

        if IsControlJustPressed(0, 73) then
            DetachEntity(LocalPlayer().Ped, true, true)

            local x, y, z =
                table.unpack(GetEntityCoords(wheelchairObject) + GetEntityForwardVector(wheelchairObject) * -0.7)

            SetEntityCoords(LocalPlayer().Ped, x, y, z)
        end
    end
end

PickUp = function(wheelchairObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), "anim@heists@box_carry@", "idle", 3) then
            ShowNotification("Quelqu'un porte déjà cette chaise")
            return
        end
    end

    NetworkRequestControlOfEntity(wheelchairObject)

    LoadAnim("anim@heists@box_carry@")

    AttachEntityToEntity(
        wheelchairObject,
        LocalPlayer().Ped,
        GetPedBoneIndex(LocalPlayer().Ped, 28422),
        -0.00,
        -0.3,
        -0.73,
        195.0,
        180.0,
        180.0,
        0.0,
        false,
        false,
        true,
        false,
        2,
        true
    )

    while IsEntityAttachedToEntity(wheelchairObject, LocalPlayer().Ped) do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(LocalPlayer().Ped, "anim@heists@box_carry@", "idle", 3) then
            TaskPlayAnim(LocalPlayer().Ped, "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        if IsPedDeadOrDying(LocalPlayer().Ped) then
            DetachEntity(wheelchairObject, true, true)
        end

        if IsControlJustPressed(0, 73) then
            DetachEntity(wheelchairObject, true, true)
            ClearPedTasksImmediately(LocalPlayer().Ped)
        end
    end
end

DrawText3Ds = function(coords, text, scale)
    local x, y, z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 370

    DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

GetPlayers = function()
    local players = {}

    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(players, i)
    end

    return players
end

GetClosestPlayer = function()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = LocalPlayer().Ped
    local plyCoords = GetEntityCoords(ply, 0)

    for index, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if (target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance =
                Vdist(
                targetCoords["x"],
                targetCoords["y"],
                targetCoords["z"],
                plyCoords["x"],
                plyCoords["y"],
                plyCoords["z"]
            )
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

LoadAnim = function(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)

        Citizen.Wait(1)
    end
end

LoadModel = function(model)
    while not HasModelLoaded(model) do
        RequestModel(model)

        Citizen.Wait(1)
    end
end

ShowNotification = function(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringWebsite(msg)
    DrawNotification(false, true)
end
exports(
    "lavage",
    function()
        if Inventory:GetItemCount("lavage") > 0 then
            local vehicle = ClosestVeh()
            if vehicle ~= 0 then
                TaskStartScenarioInPlace(LocalPlayer().Ped, "WORLD_HUMAN_MAID_CLEAN", 0, true)
                player = LocalPlayer()
                player.isBusy = true
                Citizen.CreateThread(
                    function()
                        Citizen.Wait(10000)

                        SetVehicleDirtLevel(vehicle, 0)
                        ClearPedTasksImmediately(LocalPlayer().Ped)

                        RageUI.Popup({message = "Véhicule ~g~nettoyé"})
                        player.isBusy = false
                    end
                )
                deleteRandomItem("lavage")
            else
                RageUI.Popup({message = "~r~Aucun véhicule"})
            end
        else
            ShowNotification("~w~Vous n'avez pas de ~r~kit de lavage !")
        end
    end
)
exports(
    "CarJack",
    function()
        local veh = ClosestVeh()
        if veh ~= 0 then
            local carosserie = math.floor(GetVehicleBodyHealth(veh) / 10,2)
            local motor =  math.floor(GetVehicleEngineHealth(veh) / 10,2)
            local moyenne = (motor + carosserie) / 2 
            RageUI.Popup({message="État de la carosserie : ~b~"..carosserie.."%\n~s~État du moteur : ~b~"..motor.."%~s~\nL'état globale est de : ~b~"..moyenne.."%"})
        else
            RageUI.Popup({message="~r~Aucun véhicule"})
        end
    end
)

exports(
    "Repair",
    function()
        if Inventory:GetItemCount("repairbox2") > 0 then
            TriggerServerCallback(
                "service:Count",
                function(nb)
                    if nb == 0 then
                        local vehicle = ClosestVeh()
                        deleteRandomItem("repairbox2")
                        if vehicle ~= 0 then
                            TaskStartScenarioInPlace(LocalPlayer().Ped, "PROP_HUMAN_BUM_BIN", 0, true)
                            player = LocalPlayer()
                            player.isBusy = true
                            Citizen.CreateThread(
                                function()
                                    Citizen.Wait(20000)

                                    SetVehicleFixed(vehicle)
                                    SetVehicleDeformationFixed(vehicle)
                                    SetVehicleUndriveable(vehicle, false)
                                    SetVehicleEngineOn(vehicle, true, true)
                                    ClearPedTasksImmediately(LocalPlayer().Ped)

                                    RageUI.Popup({message = "Véhicule ~g~réparé"})
                                    player.isBusy = false
                                end
                            )
                        else
                            RageUI.Popup({message = "~r~Aucun véhicule"})
                        end
                    else
                        ShowNotification( "~r~Vous ne pouvez pas faire ceci\n~y~(mécano(s) en service)")
                    end
                end,
                "mecano"
            )
        else
            ShowNotification("~w~Vous n'avez pas de ~r~kit de réparation !")
        end
    end
)
function LockPickVehicle(pp)
    if pp == nil then
        self:RemoveItem()
    end
    local plyPos = LocalPlayer().Pos
    local veh = ClosestVeh()
    local mdl = GetEntityModel(veh)
    exports["mythic_progbar"]:Progress(
        {
            name = "lockpick",
            duration = 20500,
            label = "Crochetage en cours...",
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = true,
                disableCombat = true
            },
            -- animation = {
            --   animDict = "veh@break_in@0h@p_m_zero@",
            --   anim = "std_locked_ds",
            --   flags = 1
            -- },
            -- animation = {
            --   animDict = "veh@break_in@0h@p_m_one@",
            --   anim = "low_force_entry_ds",
            --   flags = 1
            -- },
            animation = {
                animDict = "missheistfbisetup1leadinoutah_1_mcs_1",
                anim = "leadin_janitor_idle_01",
                flags = 1
            }
        },
        function(cancelled)
            if not cancelled then
                ClearPedTasks(LocalPlayer().Ped)
                SetVehicleAlarm(veh, true)
                SetVehicleAlarmTimeLeft(veh, lockpickTime)
                local c = math.random(1, 2)
                if c ~= 2 then
                    ShowAboveRadarMessage("~r~Vous avez échoué!")
                    PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 0)
                    return
                end
                NetworkRequestControlOfEntity(veh)
                local startTime = GetGameTimer()
                while not NetworkHasControlOfEntity(veh) and startTime + 2000 > GetGameTimer() do
                    Citizen.Wait(0)
                end
                ShowAboveRadarMessage("Vous avez ~g~déverrouillé~w~ le véhicule.")
                SetVehicleDoorsLockedForAllPlayers(veh, false)
                SetVehicleDoorsLocked(veh, 1)

                SetEntityAsMissionEntity(veh, true, true)
                SetVehicleHasBeenOwnedByPlayer(veh, true)
            end
        end
    )
end
local objectHandle
function attachObjectPedHand(stringProp, intWait, boolRelative, rightBone, boolLocal)
    local ped = LocalPlayer().Ped
    if objectHandle and DoesEntityExist(objectHandle) then
        DeleteEntity(objectHandle)
    end

    objectHandle = CreateObject(GetHashKey(stringProp), LocalPlayer().Pos, not boolLocal)
    AttachEntityToEntity(
        objectHandle,
        ped,
        GetPedBoneIndex(ped, rightBone and 60309 or 28422),
        .0,
        .0,
        .0,
        .0,
        .0,
        .0,
        true,
        true,
        false,
        true,
        1,
        not boolRelative
    )

    if intWait then
        Citizen.Wait(intWait)
        if objectHandle and DoesEntityExist(objectHandle) then
            DeleteEntity(objectHandle)
        end
        ClearPedTasks(LocalPlayer().Ped)
    end

    return objectHandle
end
local cutTime = 20000
local scissors
function CutChev()
    local ped = LocalPlayer().Ped
    FreezeEntityPosition(ped, true)
    local player = GetPlayerServerIdInDirection(5.0)
    TriggerServerEvent("aCore:cutHairs", player)
    local victimePed = GetPlayerPed(GetPlayerFromServerId(player))
    print(victimePed)
    if not victimePed or not DoesEntityExist(victimePed) or victimePed == ped then
        ShowAboveRadarMessage("~r~ERREUR.")
        return
    end
    local right, forward, up, pos = GetEntityMatrix(victimePed)
    SetEntityCoords(ped, pos + forward * .45 - right * .1 - up * .9)
    local heading = GetEntityHeading(victimePed)
    anim = {"missfam6ig_8_ponytail", "ig_7_loop_michael"}
    SetEntityHeading(ped, heading + 15.0)
    scissors = attachObjectPedHand("p_cs_scissors_s")
    forceAnim(anim, 1)
    local threadEnd = GetGameTimer() + cutTime
    while threadEnd > GetGameTimer() do
        Citizen.Wait(0)

        if not IsEntityPlayingAnim(ped, anim[1], anim[2], 3) then
            forceAnim(anim, 1)
        end
    end
    ClearPedTasks(ped)
    if scissors and DoesEntityExist(scissors) then
        DeleteEntity(scissors)
    end

    FreezeEntityPosition(ped, false)
    ShowAboveRadarMessage("Vous avez ~r~coupé les cheveux~w~ de votre cible.")
end
function SetPedHairs(ped, hairID, colorID, secondID)
    print("OK ICI")
    SetPedComponentVariation(ped, 2, hairID, 0, 2)
    SetPedHairColor(ped, colorID, secondID)
end
RegisterNetEvent("getCutCheveux")
AddEventHandler(
    "getCutCheveux",
    function()
        TriggerServerCallback(
            "core:GetSKin",
            function(skin)
                --(dump(skin))
                PlySkin = skin
                local skinInfo = json.decode(skin)
                local model = skinInfo.model
                local hash = GetHashKey(model)
                if (model == nil) then
                    ShowNotification("~w~Vous vous faites ~r~raser la tete")
                else
                    RequestModel(hash)
                    while not HasModelLoaded(hash) do
                        Citizen.Wait(500)
                        --print("model loading" , hash)
                    end
                    SetPlayerModel(PlayerId(), hash)
                    Citizen.CreateThread(
                        function()
                            Wait(500)

                            UpdateEntityFace(LocalPlayer().Ped, json.decode(skin))
                            RefreshClothes()
                        end
                    )
                end

                local ped = LocalPlayer().Ped
                FreezeEntityPosition(ped, true)
                local anim = {"missfam6ig_8_ponytail", "ig_7_loop_lazlow"}
                forceAnim(anim, 1)
                local threadEnd = GetGameTimer() + cutTime
                while threadEnd > GetGameTimer() do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(ped, anim[1], anim[2], 3) then
                        forceAnim(anim, 1)
                    end
                end

                if (model ~= nil) then
                    SetPedHairs(ped, 0, 0, 0)

                    skinInfo.hair.style = skins.hair.style
                    skinInfo.hair.color[1] = skins.hair.color[1]
                    skinInfo.hair.color[2] = skins.hair.color[2]
                    UpdateEntityFace(LocalPlayer().Ped, skinInfo)
                    TriggerServerEvent("face:Save", skinInfo)
                end

                ClearPedTasks(ped)
                LocalPlayer().Ragdoll = true
                SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)

                FreezeEntityPosition(ped, false)
                ShowAboveRadarMessage("Vos cheveux ont été ~r~coupés.")
            end
        )
    end
)

function GetBags()
    return sac
end

exports("GetBags", GetBags)
