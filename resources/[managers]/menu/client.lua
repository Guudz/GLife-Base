------------------------------------------------------------------
--                          Variables
------------------------------------------------------------------

local showMenu = false
local toggleCoffre = 0
local toggleCapot = 0
local toggleLocked = 0
local playing_emote = false

AddEventHandler(
    "payWith?",
    function(amount)
        showMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                menu = "payment"
            }
        )

        Crosshair(true)
    end
)

RegisterNUICallback(
    "byCard",
    function(data)
        Crosshair(false)
        showMenu = false
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                menu = false
            }
        )
        --print("p")
        TriggerEvent("payByCard")
    end
)
-- 📦
RegisterNUICallback(
    "byLiquide",
    function(data)
        Crosshair(false)
        showMenu = false
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                menu = false
            }
        )
        TriggerEvent("payByCash")
    end
)
------------------------------------------------------------------
--                          Functions
------------------------------------------------------------------

-- Show crosshair (circle) when player targets entities (vehicle, pedestrian…)
function Crosshair(enable)
    SendNUIMessage(
        {
            crosshair = enable
        }
    )
end

-- Toggle focus (Example of Vehcile's menu)
RegisterNUICallback(
    "disablenuifocus",
    function(data)
        showMenu = data.nuifocus
        SetNuiFocus(data.nuifocus, data.nuifocus)
    end
)

-- Toggle car trunk (Example of Vehcile's menu)
RegisterNUICallback(
    "togglecoffre",
    function(data)
        if (toggleCoffre == 0) then
            SetVehicleDoorOpen(data.id, 5, false)
            toggleCoffre = 1
        else
            SetVehicleDoorShut(data.id, 5, false)
            toggleCoffre = 0
        end
    end
)

-- Toggle car hood (Example of Vehcile's menu)
RegisterNUICallback(
    "togglecapot",
    function(data)
        if (toggleCapot == 0) then
            SetVehicleDoorOpen(data.id, 4, false)
            toggleCapot = 1
        else
            SetVehicleDoorShut(data.id, 4, false)
            toggleCapot = 0
        end
    end
)

RegisterNUICallback(
    "carJack",
    function(data)
        exports["aCore"]:CarJack()
    end
)

RegisterNUICallback(
    "repair",
    function(data)
        exports["aCore"]:Repair()
    end
)

RegisterNUICallback(
    "lavage",
    function(data)
        exports["aCore"]:lavage()
    end
)

-- Toggle car lock (Example of Vehcile's menu)
RegisterNUICallback(
    "togglelock",
    function(data)
        exports["aCore"]:OpenCar()
    end
)

-- Example of animation (Ped's menu)
RegisterNUICallback(
    "cheer",
    function(data)
        playerPed = PlayerPedId()
        if (not IsPedInAnyVehicle(playerPed)) then
            if playerPed then
                if playing_emote == false then
                    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CHEERING", 0, true)
                    playing_emote = true
                end
            end
        end
    end
)
function GetEntInFrontOfPlayer(Distance, Ped)
    local Ent = nil
    local CoA = GetEntityCoords(Ped, 1)
    local CoB = GetOffsetFromEntityInWorldCoords(Ped, 0.0, Distance, 0.0)
    local RayHandle = StartShapeTestRay(CoA.x, CoA.y, CoA.z, CoB.x, CoB.y, CoB.z, -1, Ped, 0)
    local A, B, C, D, Ent = GetRaycastResult(RayHandle)
    return Ent
end

-- Camera's coords
function GetCoordsFromCam(distance)
    local rot = GetGameplayCamRot(2)
    local coord = GetGameplayCamCoord()

    local tZ = rot.z * 0.0174532924
    local tX = rot.x * 0.0174532924
    local num = math.abs(math.cos(tX))

    newCoordX = coord.x + (-math.sin(tZ)) * (num + distance)
    newCoordY = coord.y + (math.cos(tZ)) * (num + distance)
    newCoordZ = coord.z + (math.sin(tX) * 8.0)
    return newCoordX, newCoordY, newCoordZ
end

-- Get entity's ID and coords from where player sis targeting
function Target(Distance, Ped)
    local Entity = nil
    local camCoords = GetGameplayCamCoord()
    local farCoordsX, farCoordsY, farCoordsZ = GetCoordsFromCam(Distance)
    local RayHandle =
        StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, farCoordsX, farCoordsY, farCoordsZ, -1, Ped, 0)
    local A, B, C, D, Entity = GetRaycastResult(RayHandle)
    return Entity, farCoordsX, farCoordsY, farCoordsZ
end
------------------------------------------------------------------
--                          Citizen
------------------------------------------------------------------

---------------------Props
SpawnObject = function(model, coords, cb)
    local model = (type(model) == "number" and model or GetHashKey(model))

    Citizen.CreateThread(
        function()
            RequestModel(model)

            while not HasModelLoaded(model) do
                Citizen.Wait(0)
            end

            local obj = CreateObject(model, coords.x, coords.y, coords.z, false, true, false)

            --SetEntityCollision(obj, false, true)
            FreezeEntityPosition(obj, true)
            if cb ~= nil then
                cb(obj)
            end
        end
    )
end
local props = {
    ["water"] = "prop_ld_flow_bottle",
    ["bread"] = "prop_cs_burger_01",
    ["clothe"] = "prop_cs_box_clothes",
    ["tenue"] = "prop_cs_box_clothes",
    ["sac"] = "prop_cs_heist_bag_01",
    ["coke"] = "prop_drug_package_02",
    ["coke1"] = "prop_drug_package_02",
    ["meth"] = "prop_meth_bag_01",
    ["meth1"] = "prop_meth_bag_01",
    ["weed_graines"] = "prop_weed_bottle",
    ["weed_pooch"] = "p_weed_bottle_s",
    ["weed"] = "prop_weed_block_01",
    ["mm9"] = "prop_ld_ammo_pack_01",
    ["acp45"] = "prop_box_ammo01a",
    ["calibre12"] = "prop_ld_ammo_pack_02",
    ["cab"] = "prop_box_ammo04a",
    ["akm"] = "prop_ld_ammo_pack_03",
    ["snip"] = "prop_box_ammo07b",
    ["pistol"] = "w_pi_pistol",
    ["pistolcombat"] = "w_pi_combatpistol",
    ["pistol50"] = "w_pi_pistol50",
    ["revolver"] = "w_pi_pistol50",
    ["pistolvintage"] = "w_pi_vintage_pistol",
    ["snspistol"] = "w_pi_sns_pistol",
    ["pitollourd"] = "w_pi_heavypistol",
    ["stungun"] = "w_pi_stungun",
    ["flaregun"] = "w_pi_flaregun",
    ["microsmg"] = "w_sb_microsmg",
    ["minismg"] = "w_sb_smg",
    ["smg"] = "w_sb_smg",
    ["assaultsmg"] = "w_sb_assaultsmg",
    ["machinepistol"] = "w_sb_smg",
    ["knife1"] = "w_me_knife_01",
    ["knife"] = "w_me_knife_01",
    ["nightstick"] = "w_me_nightstick",
    ["hammer"] = "w_me_hammer",
    ["batte"] = "w_me_bat",
    ["golf"] = "w_me_gclub",
    ["crowbar"] = "w_me_crowbar",
    ["bottle"] = "w_me_bottle",
    ["dagger"] = "w_me_dagger",
    ["hatchet"] = "w_me_hatchet",
    ["gusenberg"] = "w_sb_gusenberg",
    ["ak"] = "w_ar_assaultrifle",
    ["compactrifle"] = "w_ar_advancedrifle",
    ["carrabine"] = "w_ar_carbinerifle",
    ["advancedrifle"] = "w_ar_advancedrifle",
    ["carabinespecial"] = "w_ar_carbinerifle",
    ["bullpuprifle"] = "w_ar_bullpuprifle",
    ["musket"] = "w_ar_musket",
    ["heavysniper"] = "w_sr_heavysniper",
    ["sniperrifle"] = "w_sr_sniperrifle",
    ["pistoldouble"] = "w_sg_pumpshotgun",
    ["shootgun"] = "w_sg_sawnoff",
    ["bullpupshootgun"] = "w_sg_bullpupshotgun",
    ["doubleshootgun"] = "w_sr_sniperrifle",
    ["dollar1"] = "p_banknote_onedollar_s",
    ["dollar5"] = "p_banknote_onedollar_s",
    ["dollar10"] = "p_banknote_onedollar_s",
    ["dollar50"] = "p_banknote_onedollar_s",
    ["dollar100"] = "p_banknote_onedollar_s",
    ["dollar500"] = "p_banknote_onedollar_s",
    ["c4"] = "prop_ld_bomb"
}
local obj = {}
RegisterNetEvent("newProps")
AddEventHandler(
    "newProps",
    function(item, coords)
        local _props = props[item[1].name] == nil and "hei_prop_heist_box" or props[item[1].name]

        SpawnObject(
            _props,
            coords,
            function(_obj)
                obj[item[1].id] = {item = item, coords = coords, obj = _obj}
            end
        )
    end
)

function tableCount(tbl, checkCount)
    if not tbl or type(tbl) ~= "table" then
        return not checkCount and 0
    end
    local n = 0
    for k, v in pairs(tbl) do
        n = n + 1
        if checkCount and n >= checkCount then
            return true
        end
    end
    return not checkCount and n
end
function DrawText3DTest(coords, text, size)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

local current = {}
local Items = {}
local iddd = 0
Citizen.CreateThread(
    function()
        SetNuiFocus(false, false)
        Crosshair(false)
        Items = exports["aCore"]:GetItemsData()
        while true do
            local Ped = PlayerPedId()
            if not IsPedRagdoll(Ped) then
                -- Get informations about what user is targeting
                -- /!\ If not working, check that you have added "target" folder to resources and server.cfg
                local Entity, farCoordsX, farCoordsY, farCoordsZ = Target(6.0, Ped)
                local EntityType = GetEntityType(Entity)
                --    Crosshair(true)
                -- If EntityType is Vehicle
                local found = false
                for k, v in pairs(obj) do
                    if Entity == v.obj then
                        Crosshair(true)
                        found = true
                        iddd = 1
                        current = {k, v}
                        break
                    end
                end

                if found then
                    if iddd == 1 then
                        local t = current[2].coords
                        DrawText3DTest(t, #current[2].item .. "x " .. Items[current[2].item[1].name].label, 1.0)
                        if IsControlJustPressed(0, 46) then
                            SetNuiFocus(true, true)
                            SendNUIMessage(
                                {
                                    menu = "pickup"
                                }
                            )
                            Crosshair(true)
                        end
                    end
                end
                if EntityType == 2 then
                    Crosshair(true)
                    found = true
                    if IsControlJustReleased(1, 38) then -- E is pressed
                        showMenu = true
                        SetNuiFocus(true, true)
                        SendNUIMessage(
                            {
                                menu = "vehicle",
                                idEntity = Entity
                            }
                        )
                    end
                end
                if not found then
                    Crosshair(false)
                    Wait(500)
                end
            end
            Citizen.Wait(1)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if IsControlJustPressed(0, 46) then
                local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                for k, v in pairs(obj) do
                    local dist = GetDistanceBetweenCoords(x, y, z, v.coords.x, v.coords.y, v.coords.z, false)
                    if dist < 1.5 then
                        current = {k, v}
                        SetNuiFocus(true, true)
                        SendNUIMessage(
                            {
                                menu = "pickup"
                            }
                        )
                        Crosshair(true)
                    end
                end
            end
        end
    end
)
local carryingItem = {}
local carrying = false
local carryingProps = nil
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if carrying then
                SetTextComponentFormat("STRING")
                AddTextComponentString("Appuyez sur ~INPUT_DETONATE~ pour déposer l'objet")
                DisplayHelpTextFromStringLabel(0, 0, 0, -1)
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
                DisableControlAction(0, 288, true) -- F1
                DisableControlAction(0, 289, true) -- F2
                DisableControlAction(0, 170, true) -- F3
                DisableControlAction(0, 167, true) -- F6
                DisableControlAction(0, 168, true) -- F7
                DisableControlAction(0, 57, true) -- F10
                DisableControlAction(0, 37, true) -- M
                DisableControlAction(0, 0, true) -- v
                DisableControlAction(0, 26, true) -- c

                DisableControlAction(0, 47, true) -- c
                DisableControlAction(0, 82, true) -- c

                if IsDisabledControlJustPressed(0, 47) then
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    local forward = GetEntityForwardVector(ped)
                    local x, y, z = table.unpack(coords + forward)
                    local coords = {
                        x = x,
                        y = y,
                        z = z - 1.0
                    }
                    exports["aCore"]:TriggerPlayerEvent("newProps", -1, carryingItem, coords)
                    carrying = false
                    DeleteEntity(carryingProps)
                    carryingItem = {}
                    ClearPedTasks(ped)
                end
            end
        end
    end
)

RegisterNUICallback(
    "take",
    function(data)
        if not GetPlayerServerIdInDirection(3.0) then
            -- items = {name=Shops[CurrentZone].Items[i].name,data=Shops[CurrentZone].Items[i].data}
            Crosshair(false)
            showMenu = false
            SetNuiFocus(false, false)
            SendNUIMessage(
                {
                    menu = false
                }
            )
            if
                DoesEntityExist(obj[current[1]].obj) and
                    exports["aCore"]:canReceive(current[2].item[1].name, #current[2].item)
             then
                randPickupAnim()
                for i = 1, #current[2].item, 1 do
                    exports["aCore"]:AddItemtoInv(current[2].item[i])
                end
                exports["aCore"]:TriggerPlayerEvent("deletePickup", -1, current[1])
            elseif not exports["aCore"]:canReceive(current[2].item[1].name, #current[2].item) then
            -- exports["aCore"]:ShowNotification("~r~Vous n'avez pas assez de place !")
            end
        else
            exports["aCore"]:ShowNotification("~w~Un joueur est trop proche de vous ~r~(anti-glitch)")
        end
    end
)
local max = 4.5
function GetPlayerServerIdInDirection(range)
    local max = range or max
    local ped, closestPlayer = PlayerPedId()
    local playerPos, playerForward = GetEntityCoords(ped), GetEntityForwardVector(ped)
    playerPos = playerPos + (addVector or playerForward * 0.5)

    for _, v in pairs(GetActivePlayers()) do
        local otherPed = GetPlayerPed(v)
        local otherPedPos = otherPed ~= ped and IsEntityVisible(otherPed) and GetEntityCoords(otherPed)
        if otherPed ~= PlayerPedId() then
            if
                otherPedPos and GetDistanceBetweenCoords(otherPedPos, playerPos) <= (d or max) and
                    (not closestPlayer or GetDistanceBetweenCoords(otherPedPos, playerPos))
             then
                closestPlayer = v
            end
        end
    end
    --  print(GetPlayerPed(closestPlayer),PlayerPedId())
    return closestPlayer ~= nil and GetPlayerServerId(closestPlayer) or false
end

RegisterNUICallback(
    "pickup",
    function(data)
        if not GetPlayerServerIdInDirection(3.0) then
            Crosshair(false)
            showMenu = false
            SetNuiFocus(false, false)
            SendNUIMessage(
                {
                    menu = false
                }
            )
            randPickupAnim()
            Wait(750)
            holdAnim()
            item = current[2].item
            local player = PlayerPedId()
            carryingItem = item
            local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
            local _props = props[item.name] == nil and "hei_prop_heist_box" or props[item.name]
            local model = (type(_props) == "number" and _props or GetHashKey(_props))
            obX = CreateObject(model, GetEntityCoords(PlayerPedId()), true, true, true)
            AttachEntityToEntity(
                obX,
                player,
                GetPedBoneIndex(player, 60309),
                0.025,
                0.08,
                0.255,
                -145.0,
                290.0,
                0.0,
                true,
                true,
                false,
                true,
                1,
                true
            )
            exports["aCore"]:TriggerPlayerEvent("deletePickup", -1, current[1])
            carrying = true
            carryingProps = obX
        else
            exports["aCore"]:ShowNotification("~w~Un joueur est trop proche de vous. ~r~(anti-glitch)")
        end
    end
)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

function randPickupAnim()
    local randAnim = math.random(7)
    loadAnimDict("pickup_object")
    TaskPlayAnim(PlayerPedId(), "pickup_object", "pickup_low", 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
end

function holdAnim()
    loadAnimDict("anim@heists@box_carry@")
    TaskPlayAnim((PlayerPedId()), "anim@heists@box_carry@", "idle", 4.0, 1.0, -1, 49, 0, 0, 0, 0)
end
RegisterNetEvent("deletePickup")
AddEventHandler(
    "deletePickup",
    function(id)
        if obj[id] ~= nil then
            DeleteEntity(obj[id].obj)
            obj[id] = nil
        end
    end
)
Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        if IsPedSittingInAnyVehicle(plyPed) then
            local plyVehicle = GetVehiclePedIsIn(plyPed, false)
            CarSpeed = GetEntitySpeed(plyVehicle) * 3.6 
            if CarSpeed <= 40.0 then 
                if IsControlJustReleased(0, 157) then 
                    SetPedIntoVehicle(plyPed, plyVehicle, -1)
                    Citizen.Wait(10)
                end
                if IsControlJustReleased(0, 158) then 
                    SetPedIntoVehicle(plyPed, plyVehicle, 0)
                    Citizen.Wait(10)
                end
                if IsControlJustReleased(0, 160) then 
                    SetPedIntoVehicle(plyPed, plyVehicle, 1)
                    Citizen.Wait(10)
                end
                if IsControlJustReleased(0, 164) then 
                    SetPedIntoVehicle(plyPed, plyVehicle, 2)
                    Citizen.Wait(10)
                end
            end
        end
        Citizen.Wait(10) -- Fix Crash Client
    end
end)
