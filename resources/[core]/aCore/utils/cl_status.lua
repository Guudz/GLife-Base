faim = 55
soif = 55
inLoading = false
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            Citizen.Wait(15000)
            RemoveCalories(0.15)
            RemoveWater(0.18)
        end
    end
)

function setfaim(calories)
    faim = calories
    --:setfaim", faim)
end
function AddCalories(calories)
    if calories == nil then
        calories = 10
    end
    if faim == 100 then
        return
    end
    if faim + calories <= 100 then
        faim = faim + calories
    else
        faim = 100
    end
    --:setfaim", faim)
end

function RemoveCalories(calories)
    if faim == 0 then
        return
    end
    if faim - calories >= 0 then
        faim = faim - calories
    else
        faim = 0
    end
    if faim <= 10 and faim > 0 then
        ShowNotification("~r~Attention \n~w~Tu sembles avoir faim ...")
    elseif faim == 0 then
        SetEntityHealth(PlayerPedId(), 0)
    end
    --:setfaim", faim)
end

function SetSoif(water)
    soif = water
    --:SetSoif", soif)
end
function AddWater(water)
    if soif == 100 then
        return
    end
    if soif + water <= 100 then
        soif = soif + water
    else
        soif = 100
    end
    --:SetSoif", soif)
end

function RemoveWater(water)
    if soif == 0 then
        return
    end
    if soif - water >= 0 then
        soif = soif - water
    else
        soif = 0
    end
    if soif <= 10 and soif > 0 then
        ShowNotification("~r~Attention \n~w~Tu sembles avoir soif ...")
    elseif soif == 0 then
        SetEntityHealth(PlayerPedId(), 0)
    end
    --:SetSoif", soif)
end

local firstspawn = 0
AddEventHandler(
    "playerSpawned",
    function(spawn)
        if firstspawn == 0 then
            firstspawn = 1
        end
    end
)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent("mosrow:AddCalories")
AddEventHandler(
    "mosrow:AddCalories",
    function(calories)
        AddCalories(calories)
    end
)

RegisterNetEvent("mosrow:AddWater")
AddEventHandler(
    "mosrow:AddWater",
    function(water)
        AddWater(water)
        --	--print(water)
    end
)

RegisterNetEvent("mosrow:Death")
AddEventHandler(
    "mosrow:Death",
    function()
        setfaim(50)
        SetSoif(50)
    end
)

local function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end
local HUD = true
AddEventHandler(
    "displayNourriture",
    function(H)
        HUD = H
    end
)
Citizen.CreateThread(
    function()
        Wait(500)
        while true do
            Citizen.Wait(1)
            ResetScriptGfxAlign()
            --	--print(soif,faim)

            --	drawRct(0.013, 0.770,105/704,0.0425,0,0,0,200)
            if HUD then 
                drawRct(0.01509901, 0.779, 0.1420, 0.015, 42, 167, 75, 100)
                drawRct(0.01509901, 0.779, faim / 704, 0.015, 42, 167, 75, 190)

                drawRct(0.0151, 0.794, 0.1420, 0.015, 26, 170, 199, 100)
                drawRct(0.0151, 0.794, soif / 704, 0.015, 26, 170, 199, 190)
                
                if soif < 1 or faim < 1 then
                    SetEntityHealth(PlayerPedId(), 0)
                    setfaim(50)
                    SetSoif(50)
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            TriggerEvent("updateStatus", soif, faim)
        end
    end
)
-- Ancienne pos status

RegisterNetEvent("status:Spawned")
AddEventHandler(
    "status:Spawned",
    function(faim, soif)
        --print(faim,soif)
        TriggerEvent("updateStatus", soif, faim)
        setfaim(faim)
        SetSoif(soif)
    end
)

local item = nil

RegisterNetEvent("miam:Drink")
AddEventHandler(
    "miam:Drink",
    function(item, Items)
        TriggerServerEvent("removeItem", item.id, item.name)
        items = Items[item.name]
        --DrinkSomething(items)
        if items.soif ~= nil then
            DrinkSomething()
        else
            EatSomething(items)
        end
    end
)

local alreadyOnCoke = false

RegisterNetEvent("drug:Coke")
AddEventHandler(
    "drug:Coke",
    function(item, Items)
        if (alreadyOnCoke == false) then
            ShowNotification(
                "~g~Vous avez consommé de la cocaine ! Vous êtes moins sensible à la douleur pendant 5 minutes~w~"
            )
            ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.4)
            StartScreenEffect("Rampage", 1000 * 60 * 5, true)

            local playerPed = PlayerPedId()
            TriggerServerEvent("aCore_status:addOn", "coke")

            -- StatSetInt(GetHashKey("MP0_STAMINA"), 30, true)
            -- StatSetInt(GetHashKey("MP0_STRENGTH"), 30, true)
            SetRunSprintMultiplierForPlayer(player, 1.2)
            SetSwimMultiplierForPlayer(player, 1.2)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 65)

            alreadyOnCoke = true
            Citizen.Wait(1000 * 60 * 5)
            alreadyOnCoke = false

            StopScreenEffect("Rampage")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 65)
            -- StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            -- StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(player, 1.0)
            SetSwimMultiplierForPlayer(player, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la cocaine ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
)

local alreadyOnMeth = false

RegisterNetEvent("drug:Meth")
AddEventHandler(
    "drug:Meth",
    function(item, Items)
        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.2)
        StartScreenEffect("ChopVision", 1000 * 60 * 3, true)

        if (alreadyOnMeth == false) then
            ShowNotification(
                "~g~Vous avez consommé de la meth ! Vous êtes moins sensible a la douleur pendant 3 minutes~w~"
            )
            local playerPed = PlayerPedId()
            TriggerServerEvent("aCore_status:addOn", "meth")
            -- StatSetInt(GetHashKey("MP0_STAMINA"), 20, true)
            -- StatSetInt(GetHashKey("MP0_STRENGTH"), 20, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.1)
            SetSwimMultiplierForPlayer(playerPed, 1.1)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 45)

            alreadyOnMeth = true
            Citizen.Wait(1000 * 60 * 3)
            alreadyOnMeth = false

            StopScreenEffect("ChopVision")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 45)
            -- StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            -- StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.0)
            SetSwimMultiplierForPlayer(playerPed, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la meth ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
)

local alreadyOnWeed = false

RegisterNetEvent("drug:Weed")
AddEventHandler(
    "drug:Weed",
    function(item, Items)
        local playerPed = PlayerPedId()

        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.2)
        StartScreenEffect("DrugsMichaelAliensFight", 1000 * 60 * 5, true)

        if (alreadyOnWeed == false) then
            TriggerServerEvent("aCore_status:addOn", "weed")

            ShowNotification("~g~Vous avez consommé de la weed !~w~")
            ShowNotification(
                "~g~Vous êtes moins sensible a la douleur pendant 5 minutes mais vous êtes moins rapide~w~"
            )

            -- StatSetInt(GetHashKey("MP0_STAMINA"), 10, true)
            -- StatSetInt(GetHashKey("MP0_STRENGTH"), 10, true)
            SetRunSprintMultiplierForPlayer(playerPed, 0.7)
            SetSwimMultiplierForPlayer(playerPed, 0.7)
            SetPedArmour(playerPed, GetPedArmour(playerPed) + 30)

            alreadyOnWeed = true
            Citizen.Wait(1000 * 60 * 5)
            alreadyOnWeed = false

            StopScreenEffect("DrugsMichaelAliensFight")
            StopGameplayCamShaking(false)

            SetPedArmour(playerPed, GetPedArmour(playerPed) - 30)
            -- StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
            -- StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
            SetRunSprintMultiplierForPlayer(playerPed, 1.0)
            SetSwimMultiplierForPlayer(playerPed, 1.0)
        else
            ShowNotification(
                "~r~Vous avez déjà consommé de la weed ! Vous voulez faire une overdose. Vous avez perdu un pochon~w~"
            )
        end
    end
)
Citizen.CreateThread( function()
    while true do
       Citizen.Wait(0)
       RestorePlayerStamina(PlayerId(), 1.0)
       end
end)
local prop = nil
function EatSomething(items)
    DeleteEntity(prop)
    local prop_name = items.props
    IsAnimated = true
    local playerPed = PlayerPedId()
    Citizen.CreateThread(
        function()
            local x, y, z = table.unpack(GetEntityCoords(playerPed))
            prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
            AttachEntityToEntity(
                prop,
                playerPed,
                GetPedBoneIndex(playerPed, 18905),
                0.12,
                0.028,
                0.001,
                10.0,
                175.0,
                0.0,
                true,
                true,
                false,
                true,
                1,
                true
            )
            RequestAnimDict("mp_player_inteat@burger")
            while not HasAnimDictLoaded("mp_player_inteat@burger") do
                Wait(0)
            end
            TaskPlayAnim(
                playerPed,
                "mp_player_inteat@burger",
                "mp_player_int_eat_burger_fp",
                8.0,
                -8,
                -1,
                49,
                0,
                0,
                0,
                0
            )
            Wait(3000)
            IsAnimated = false
            ClearPedSecondaryTask(playerPed)
            DeleteObject(prop)
        end
    )
    AddCalories(items.faim)
end

function DrinkSomething()
    DeleteEntity(prop)
    local prop_name = items.props
    IsAnimated = true
    local playerPed = PlayerPedId()
    Citizen.CreateThread(
        function()
            local x, y, z = table.unpack(GetEntityCoords(playerPed))
            prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
            AttachEntityToEntity(
                prop,
                playerPed,
                GetPedBoneIndex(playerPed, 18905),
                0.12,
                0.030,
                0.010,
                -85.0,
                175.0,
                0.0,
                true,
                true,
                false,
                true,
                1,
                true
            )
            RequestAnimDict("mp_player_intdrink")
            while not HasAnimDictLoaded("mp_player_intdrink") do
                Wait(0)
            end
            TaskPlayAnim(playerPed, "mp_player_intdrink", "loop_bottle", 8.0, -8, -1, 49, 0, 0, 0, 0)
            Wait(3000)
            IsAnimated = false
            ClearPedSecondaryTask(playerPed)
            DeleteObject(prop)
        end
    )
    AddWater(items.soif)
end

Citizen.CreateThread(
    function()
        while true do
            Wait(20000)
            --print(soif,faim)
            TriggerServerEvent("savefood", soif, faim)
            TriggerEvent("updateStatus", soif, faim)
        end
    end
)

local objId = nil
local notif = 0
local tobj = {}

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end
  
RegisterNetEvent('Ero_object:SpawnProp')
AddEventHandler('Ero_object:SpawnProp', function(prop_bo, prop_ve, animdi, animcl, cnt, anm2)
  
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(GetPlayerPed(-1))
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords + forward * 1.0)
      
    local forwardx = GetEntityForwardX(playerPed)
    local forwardy = GetEntityForwardY(playerPed)
  
    local bouteille = GetHashKey(prop_bo)
    local verre = GetHashKey(prop_ve)
  
    RequestModel(bouteille)
    while not HasModelLoaded(bouteille) do
      Citizen.Wait(0)
    end
  
    obj = CreateObject(bouteille, coords["x"] + forwardx, coords["y"] + forwardy, coords["z"], 1, 1, 0)
    SetEntityHeading(obj, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(obj)
  
    local objN = NetworkGetNetworkIdFromEntity(obj)
    local objspawncoords = GetEntityCoords(obj)
  
    TriggerServerEvent('Ero_object:tinsert', objN, prop_bo, objspawncoords, bouteille, verre, animdi, animcl, cnt, anm2)
end)	
  
RegisterNetEvent('Ero_object:tinsert')
AddEventHandler('Ero_object:tinsert', function(obj, prop_bo, objspawncoords, bouteille, verre, animdi, animcl, cnt, anm2)
    table.insert(tobj, {sobj = obj, model = prop_bo, coords = objspawncoords, prop_b = bouteille, prop_v = verre, animd = animdi, animc = animcl, count = cnt, anim2 = anm2})
end)
  
function distance3D(coords1, coords2)
    return #(coords1 - coords2)
end
  
function cbouteille()
  
    local objId = nil
  
    for k,v in pairs(tobj) do
  
      local pedCoord = GetEntityCoords(GetPlayerPed(-1))
      local objc = GetClosestObjectOfType(pedCoord, 1.0, GetHashKey(v.model), 0, 0, 0)
      local objcCoords = GetEntityCoords(objc)
      local objcexist = DoesEntityExist(objc)
  
      if objc and objcexist then
  
        local objcN = NetworkGetNetworkIdFromEntity(objc)
  
        if objcN == v.sobj then
  
          objprop = v.prop_b
          objVm = v.model
          objVco = v.coords
          objVv = v.prop_v
          objVb = v.prop_b
          objVad = v.animd
          objVac = v.animc
          objVa2 = v.anim2
          objVc = v.count
          objId = objc
          objIndex = k
          break
        else 
          objId = nil
        end
  
      end	
    end
    return objId
end
  
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(500)
  
      objId = cbouteille()
    end
end)
  
Citizen.CreateThread(function()
    while true do
      Citizen.Wait(10)
          
      if objId ~= nil then  
        if IsControlJustReleased(0, 54) then
  
          local playerPed  = GetPlayerPed(-1)
          local coords     = GetEntityCoords(playerPed)
          local objIdcoord = GetEntityCoords(objId)
          local distance   = distance3D(coords, objIdcoord)
                  
          if distance < 1.5 then
                      
            local boneIndexr = GetPedBoneIndex(playerPed, 57005)
            local boneIndexl = GetPedBoneIndex(playerPed, 4089)					
            local forwardx   = GetEntityForwardX(playerPed)
            local forwardy   = GetEntityForwardY(playerPed)
      
            if objVv ~= 0 then
                local objIdN = NetworkGetNetworkIdFromEntity(objId)
  
                TriggerServerEvent('Ero_object:entityvisible', objIdN, 1)
  
                RequestModel(objVv)
                while not HasModelLoaded(objVv) do
                    Citizen.Wait(0)
                end
                verre = CreateObject(objVv, coords["x"] + forwardx * 0.5, coords["y"] + forwardy * 0.5, coords["z"], 1, 1, 0)
                
                RequestModel(objprop)
                while not HasModelLoaded(objprop) do
                    Citizen.Wait(0)
                end
                bouteille = CreateObject(objprop, coords["x"] + forwardx * 0.5, coords["y"] + forwardy * 0.5, coords["z"], 1, 1, 0)
            end
  
            RequestAnimDict(objVad)
              while not HasAnimDictLoaded(objVad) do
                Citizen.Wait(0)
            end
  
            if objVv == 0 then
              if objVc == 3 then
                RequestAnimDict('mp_common')
                  while not HasAnimDictLoaded('mp_common') do
                    Citizen.Wait(0)
                end
  
                TaskPlayAnim(GetPlayerPed(-1),"mp_common","givetake1_b",8.0,-8.0,-1,0,0,false,false,false)
                Citizen.Wait(500)
                AttachEntityToEntity(objId, playerPed, boneIndexr, 0.10, -0.10, -0.10, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
                while not IsEntityAttachedToAnyPed(objId) do
                  Citizen.Wait(0)
                  AttachEntityToEntity(objId, playerPed, boneIndexr, 0.10, -0.10, -0.10, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
                  if notif == 0 then
                    notify('Veuilez patientez jusqu\'à avoir la bière dans la main')
                    notif = 1
                  end
                end
                notif = 0
  
              elseif objVc < 3 then 
                AttachEntityToEntity(objId, playerPed, boneIndexr, 0.10, -0.10, -0.10, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
                Citizen.Wait(100)
                TaskPlayAnim(playerPed, objVad, objVac, 1.0, -1.0, 7000, 0, 1, false, false, false)
                Citizen.Wait(7000)
              end
            else
              AttachEntityToEntity(verre, playerPed, boneIndexl, 0.05, -0.10, -0.0, 90.0, 90.0, 170.0, true, true, false, true, 1, true)
              AttachEntityToEntity(bouteille, playerPed, boneIndexr, 0.10, -0.10, -0.10, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
              Citizen.Wait(1000)
              TaskPlayAnim(playerPed, objVad, objVac, 1.0, -1.0, 10000, 0, 1, false, false, false)
              Citizen.Wait(10000)
            end
                      
            if objVv ~= 0 then
              DeleteObject(bouteille)
              Citizen.Wait(1500)
              objIdNet = NetworkGetNetworkIdFromEntity(objId)
              DeleteObject(verre)
              TriggerServerEvent('Ero_object:entityvisible', objIdNet, 2)
  
            elseif objVv == 0 then
              AttachEntityToEntity(objId, playerPed, boneIndexr, 0.10, -0.10, -0.10, 90.0, 90.0, 210.0, true, true, false, true, 1, true)
              Citizen.Wait(100)
              objIdNet = NetworkGetNetworkIdFromEntity(objId)
            end
        
            TriggerServerEvent('Ero_object:count', objIndex, objIdNet, objVm, objVco, objVb, objVv, objVad, objVac, objVc, objVa2)
          end	
        end
      end
    end
end)
  
RegisterNetEvent('Ero_object:delete')
AddEventHandler('Ero_object:delete', function(index, obj)
    table.remove(tobj, index)
    local objd = NetworkGetEntityFromNetworkId(obj)
    DeleteObject(objd)
end)
                  
RegisterNetEvent('Ero_object:rcount')
AddEventHandler('Ero_object:rcount', function(index, obj, modelb, coord, propb, propv, animdi, animcli, cnt, anm2)
    tobj[index] = {sobj = obj, model = modelb, coords = coord, prop_b = propb, prop_v = propv, animd = animdi, animc = animcli, count = cnt, anim2 = anm2}
    objId = nil
end)
  
RegisterNetEvent('Ero_object:visible')
AddEventHandler('Ero_object:visible', function(entity, val)
    local entityN = NetworkGetEntityFromNetworkId(entity)
  
    if val == 1 then
      SetEntityVisible(entityN, false, 0)
    elseif val == 2 then
      SetEntityVisible(entityN, true, 0)
    end
end)







petrolCanPrice = 20

lang = "fr"

settings = {}

settings["fr"] = {
    openMenu = "Appuyez sur ~g~E~w~ pour ouvrir le menu.",
    fuelError = "~r~Vous n'êtes pas au bon endroit.",
    buyFuel = "acheter de l'essence",
    liters = "litres",
    percent = "pourcent",
    confirm = "Valider",
    getJerryCan = "Appuyez sur ~g~E~w~ pour acheter un bidon d'essence (" .. petrolCanPrice .. "$)",
    refuel = "Appuyez sur ~g~E~w~ pour remplir votre voiture d'essence.",
    price = "prix"
}

showBar = true
showText = true

hud_form = 1
hud_x = 0.086
hud_y = 0.9883

text_x = 0.2575
text_y = 0.975

--electricityPrice = 1

randomPrice = false
price = 1
essence = 0.142
local stade = 0
local lastModel = 0

local vehiclesUsed = {}

local currentCans = 0

Citizen.CreateThread(
    function()
        TriggerServerEvent("essence:addPlayer")
        while true do
            Citizen.Wait(2)
            if not IsPedInAnyVehicle(PlayerPedId(), -1) then
                Citizen.Wait(1)
            else
                renderBoxes()

                if (currentCans > 0) then
                    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                    local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
                    if (GetVehicleNumberPlateText(veh) == nil) then
                        Citizen.Wait(15000)
                    end
                    if (GetVehicleNumberPlateText(veh) ~= nil) then
                        local _, number = GetCurrentPedWeapon(PlayerPedId())

                        if (number == 883325847) then
                            Info(settings[lang].refuel)
                            if (IsControlJustPressed(1, 38)) then
                                RequestAnimDict("weapon@w_sp_jerrycan")
                                while not HasAnimDictLoaded("weapon@w_sp_jerrycan") do
                                    Citizen.Wait(100)
                                end

                                local toPercent = essence / 0.142
                                --print(5000/toPercent)

                                TaskPlayAnim(PlayerPedId(), "weapon@w_sp_jerrycan", "fire", 8.0, -8, -1, 49, 0, 0, 0, 0)
                                local done = false
                                local amountToEssence = 0.142 - essence
                                while done == false do
                                    Wait(0)
                                    local _essence = essence
                                    if (amountToEssence - 0.0005 > 0) then
                                        amountToEssence = amountToEssence - 0.0005
                                        essence = _essence + 0.0005
                                        _essence = essence
                                        if (_essence > 0.142) then
                                            essence = 0.142
                                            TriggerEvent(
                                                "advancedFuel:setEssence",
                                                100,
                                                GetVehicleNumberPlateText(veh),
                                                GetDisplayNameFromVehicleModel(GetEntityModel(veh))
                                            )
                                            done = true
                                        end
                                        SetVehicleUndriveable(veh, true)
                                        SetVehicleEngineOn(veh, false, false, false)
                                        local essenceToPercent = (essence / 0.142) * 65
                                        SetVehicleFuelLevel(veh, round(essenceToPercent))
                                        Wait(100)
                                    else
                                        essence = essence + amountToEssence
                                        local essenceToPercent = (essence / 0.142) * 65
                                        SetVehicleFuelLevel(veh, round(essenceToPercent))
                                        TriggerEvent(
                                            "advancedFuel:setEssence",
                                            100,
                                            GetVehicleNumberPlateText(veh),
                                            GetDisplayNameFromVehicleModel(GetEntityModel(veh))
                                        )
                                        done = true
                                    end
                                end
                                TaskPlayAnim(
                                    PlayerPedId(),
                                    "weapon@w_sp_jerrycan",
                                    "fire_outro",
                                    8.0,
                                    -8,
                                    -1,
                                    49,
                                    0,
                                    0,
                                    0,
                                    0
                                )
                                Wait(500)
                                ClearPedTasks(PlayerPedId())
                                currentCans = currentCans - 1

                                if (currentCans == 0) then
                                    RemoveWeaponFromPed(PlayerPedId(), 0x34A67B97)
                                end
                                SetVehicleEngineOn(veh, true, false, false)
                            --		SetVehicleUndriveable(veh, false)
                            end
                        end
                    end
                end
            end
        end
    end
)

local veh = nil
-- Citizen.CreateThread(function()

-- 	while true do
-- 		Citizen.Wait(100)

-- 		if  (IsPedInAnyVehicle(PlayerPedId(), -1)) then
-- 			local kmh = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * 3.6
-- 			local vitesse = math.ceil(kmh)
--             local _essence = GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false))
-- 			if(vitesse > 0 and vitesse <20) then
-- 				stade = 0.0000005
-- 			elseif(vitesse >= 20 and vitesse <50) then
-- 				stade = 0.000010
-- 			elseif(vitesse >= 50 and vitesse <70) then
-- 				stade =0.000010
-- 			elseif(vitesse >= 70 and vitesse <90) then
-- 				stade = 0.000004
-- 			elseif(vitesse >=90 and vitesse <130) then
-- 				stade = 0.000004
-- 			elseif(vitesse >= 130) then
-- 				stade = 0.000004
-- 			else
-- 				stade = 0.000002
-- 			end

-- 			if(_essence - stade > 0) then
-- 				essence = _essence - stade
-- 				local essenceToPercent = (essence/0.142)*65
-- 				SetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId()),round(essenceToPercent))
-- 			else
-- 				essence = 0
-- 				SetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId()),0)
-- 				SetVehicleUndriveable(GetVehiclePedIsUsing(PlayerPedId()), true)
-- 			end
-- 		end

-- end
--end)

RegisterNetEvent("getess")
AddEventHandler(
    "getess",
    function()
        renderBoxes()
    end
)
local lastPlate = 0
local refresh = true

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
            if essence == 0.142 then
                Citizen.Wait(5000)
            else
                local percent = (essence / 0.142) * 100
            end
        end
    end
)
function drawRct2(x, y, width, height, r, g, b, a)
    DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end

function isBlackListedModel()
end

function renderBoxes()
    if (IsPedInAnyVehicle(PlayerPedId(), -1) and GetPedVehicleSeat(PlayerPedId()) == -1 and not isBlackListedModel()) then
        local percent = (essence / 0.142) * 100

        if (showBar) then
            --		drawRct2(hud_x-0.073, hud_y-0.005, 0.145, 0.015,0,0,0,180)
            --		drawRct2(hud_x-0.071, hud_y-0.0025, essence,0.010,	241, 196, 15,255)
            if percent > 50 then
            else
            end
        end

        if (showText) then
            local percent = (essence / 0.142) * 100
            TriggerEvent("sendessence", percent)
        end
    end
end

function isNearStation()
    local ped = PlayerPedId()
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)

    for _, items in pairs(station) do
        if
            (GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) <
                3.5)
         then
            return true, items.s
        end
    end

    return false
end

function isNearBoatStation()
    local ped = PlayerPedId()
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)

    for _, items in pairs(boat_stations) do
        if
            (GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) <
                10)
         then
            return true, items.s
        end
    end

    return false
end

function Info(text, loop)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end

function round(num, dec)
    local mult = 10 ^ (dec or 0)
    return math.floor(num * mult + 0.5) / mult
end

function DrawAdvancedText(x, y, w, h, sc, text, r, g, b, a, font, jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1 + w, y - 0.02 + h)
end

function drawTxt(x, y, width, height, scale, text, r, g, b, a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function drawRct(x, y, width, height, r, g, b, a)
    DrawRect(x + width / 2, y + height / 2, width, height, r, g, b, a)
end

RegisterNetEvent("essence:setEssence")
AddEventHandler(
    "essence:setEssence",
    function(ess, vplate, vmodel)
        if (ess ~= nil and vplate ~= nil and vmodel ~= nil) then
            local bool, index = searchByModelAndPlate(vplate, vmodel)

            if (bool and index ~= nil) then
                vehiclesUsed[index].es = ess
            else
                table.insert(vehiclesUsed, {plate = vplate, model = vmodel, es = ess})
            end
        end
    end
)

RegisterNetEvent("essence:buyCan")
AddEventHandler(
    "essence:buyCan",
    function()
        GiveWeaponToPed(PlayerPedId(), 0x34A67B97, currentCans + 1, 0, true)
        currentCans = currentCans + 1
    end
)

RegisterNetEvent("vehicule:sendFuel")
AddEventHandler(
    "vehicule:sendFuel",
    function(bool, ess)
        if (bool == 1) then
            essence = ess
        else
            essence = (math.random(30, 100) / 100) * 0.142
            --print(essence,essence,essence,essence,essence,essence )
            vehicle = GetVehiclePedIsUsing(PlayerPedId())
            TriggerServerEvent(
                "essence:setToAllPlayerEscense",
                essence,
                GetVehicleNumberPlateText(GetVehiclePedIsUsing(PlayerPedId())),
                GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())))
            )
        end
    end
)

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i = -2, GetVehicleMaxNumberOfPassengers(vehicle) do
        if (GetPedInVehicleSeat(vehicle, i) == ped) then
            return i
        end
    end
    return -2
end

AddEventHandler(
    "playerSpawned",
    function()
        TriggerServerEvent("essence:playerSpawned")
        TriggerServerEvent("essence:addPlayer")
    end
)

RegisterNetEvent("showNotif")
AddEventHandler(
    "showNotif",
    function(text)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(text)
        DrawNotification(false, false)
    end
)

RegisterNetEvent("advancedFuel:setEssence")
AddEventHandler(
    "advancedFuel:setEssence",
    function(percent, plate, model)
        local toEssence = (percent / 100) * 0.142

        if
            (GetVehicleNumberPlateText(GetVehiclePedIsUsing(PlayerPedId())) == plate and
                model == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
         then
            essence = toEssence
            local essenceToPercent = (essence / 0.142) * 65
            SetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId()), round(essenceToPercent))
        end

        TriggerServerEvent("advancedFuel:setEssence_s", percent, plate, model)
    end
)

RegisterNetEvent("essence:sendEssence")
AddEventHandler(
    "essence:sendEssence",
    function(array)
        for i, k in pairs(array) do
            vehiclesUsed[i] = {plate = k.plate, model = k.model, es = k.es}
        end
    end
)

function IsVehInArray()
    for _, k in pairs(vehiclesUsed) do
        if
            (k.plate == GetVehicleNumberPlateText(GetVehiclePedIsUsing(PlayerPedId())) and
                k.model == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
         then
            return true
        end
    end

    return false
end

function searchByModelAndPlate(plate, model)
    for i, k in pairs(vehiclesUsed) do
        if (k.plate == plate and k.model == model) then
            return true, i
        end
    end

    return false, nil
end

function getVehIndex()
    local index = -1

    for i, k in pairs(vehiclesUsed) do
        if
            (k.plate == GetVehicleNumberPlateText(GetVehiclePedIsUsing(PlayerPedId())) and
                k.model == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
         then
            index = i
        end
    end

    return index
end

showBar = true
showText = true

hud_form = 1
hud_x = 0.086
hud_y = 0.9883

text_x = 0.2575
text_y = 0.975

electricityPrice = 1

randomPrice = false
price = 1

local blipNameFuel = settings[lang].fuelStation
local blipNameFuelBoat = settings[lang].boatFuelStation
local blipNameFuelAvions = settings[lang].avionFuelStation
local blipNameFuelHeli = settings[lang].heliFuelStation


station = {
    {x = -82.098, y = -1761.612, z = 29.635, s = 1},
    {x = -79.506, y = -1754.321, z = 29.604, s = 1},
    {x = -78.241, y = -1762.897, z = 29.592, s = 1},
    {x = -75.489, y = -1756.029, z = 29.603, s = 1},
    {x = -73.959, y = -1764.495, z = 29.427, s = 1},
    {x = -71.135, y = -1757.619, z = 29.42, s = 1},
    {x = -70.017, y = -1765.910, z = 29.356, s = 1},
    {x = -67.389, y = -1758.793, z = 29.366, s = 1},
    {x = -65.458, y = -1767.296, z = 29.138, s = 1},
    {x = -62.760, y = -1760.176, z = 29.133, s = 1},
    {x = -61.468, y = -1768.718, z = 29.077, s = 1},
    {x = -59.106, y = -1761.805, z = 29.078, s = 1},
    {x = 1214.171, y = -1405.432, z = 35.224, s = 2},
    {x = 1211.517, y = -1408.289, z = 35.198, s = 2},
    {x = 1211.747, y = -1402.370, z = 35.224, s = 2},
    {x = 1208.667, y = -1405.622, z = 35.224, s = 2},
    {x = 1208.224, y = -1399.316, z = 35.224, s = 2},
    {x = 1205.354, y = -1402.141, z = 35.224, s = 2},
    {x = 1205.686, y = -1397.004, z = 35.224, s = 2},
    {x = 1202.977, y = -1399.678, z = 35.224, s = 2},
    {x = 254.526, y = -1268.720, z = 29.148, s = 3},
    {x = 254.465, y = -1261.328, z = 29.145, s = 3},
    {x = 254.431, y = -1253.17, z = 29.193, s = 3},
    {x = 258.271, y = -1268.676, z = 29.143, s = 3},
    {x = 258.309, y = -1261.318, z = 29.143, s = 3},
    {x = 258.324, y = -1253.436, z = 29.143, s = 3},
    {x = 263.091, y = -1268.743, z = 29.143, s = 3},
    {x = 263.130, y = -1261.356, z = 29.143, s = 3},
    {x = 263.058, y = -1253.579, z = 29.143, s = 3},
    {x = 266.983, y = -1268.678, z = 29.144, s = 3},
    {x = 266.964, y = -1261.245, z = 29.143, s = 3},
    {x = 266.801, y = -1253.554, z = 29.143, s = 3},
    {x = 272.069, y = -1268.790, z = 29.145, s = 3},
    {x = 271.992, y = -1261.357, z = 29.143, s = 3},
    {x = 271.987, y = -1253.431, z = 29.143, s = 3},
    {x = 275.562, y = -1253.391, z = 29.159, s = 3},
    {x = 275.751, y = -1261.135, z = 29.161, s = 3},
    {x = 275.746, y = -1268.520, z = 29.164, s = 3},
    {x = -517.408, y = -1207.231, z = 18.265, s = 4},
    {x = -520.156, y = -1205.908, z = 18.245, s = 4},
    {x = -524.803, y = -1203.655, z = 18.236, s = 4},
    {x = -527.604, y = -1202.526, z = 18.228, s = 4},
    {x = -529.784, y = -1207.092, z = 18.185, s = 4},
    {x = -526.845, y = -1208.236, z = 18.185, s = 4},
    {x = -522.081, y = -1210.286, z = 18.185, s = 4},
    {x = -519.478, y = -1211.580, z = 18.185, s = 4},
    {x = -521.226, y = -1215.387, z = 18.185, s = 4},
    {x = -524.0596, y = -1214.104, z = 18.185, s = 4},
    {x = -528.617, y = -1212.008, z = 18.185, s = 4},
    {x = -531.552, y = -1210.861, z = 18.185, s = 4},
    {x = -533.238, y = -1214.797, z = 18.222, s = 4},
    {x = -530.4897, y = -1216.199, z = 18.226, s = 4},
    {x = -525.775, y = -1218.204, z = 18.2196, s = 4},
    {x = -523.142, y = -1219.551, z = 18.223, s = 4},
    {x = -712.8, y = -939.076, z = 19.017, s = 5},
    {x = -712.671, y = -932.42, z = 19.017, s = 5},
    {x = -717.642, y = -932.702, z = 19.017, s = 5},
    {x = -717.805, y = -939.401, z = 19.017, s = 5},
    {x = -721.448, y = -939.311, z = 19.017, s = 5},
    {x = -721.194, y = -932.431, z = 19.017, s = 5},
    {x = -726.673, y = -932.539, z = 19.017, s = 5},
    {x = -726.786, y = -939.402, z = 19.017, s = 5},
    {x = -729.805, y = -939.128, z = 19.017, s = 5},
    {x = -729.859, y = -932.606, z = 19.017, s = 5},
    {x = -735.479, y = -932.548, z = 19.017, s = 5},
    {x = -735.46, y = -939.304, z = 19.017, s = 5},
    {x = 829.205, y = -1026.126, z = 26.639, s = 6},
    {x = 829.19, y = -1030.921, z = 26.644, s = 6},
    {x = 825.634, y = -1031.114, z = 26.411, s = 6},
    {x = 825.527, y = -1026.295, z = 26.383, s = 6},
    {x = 821.075, y = -1026.074, z = 26.256, s = 6},
    {x = 821.109, y = -1030.78, z = 26.288, s = 6},
    {x = 817.243, y = -1030.984, z = 26.298, s = 6},
    {x = 817.062, y = -1026.27, z = 26.264, s = 6},
    {x = 812.567, y = -1026.071, z = 26.24, s = 6},
    {x = 812.552, y = -1030.897, z = 26.293, s = 6},
    {x = 808.941, y = -1030.992, z = 26.287, s = 6},
    {x = 808.542, y = -1026.427, z = 26.254, s = 6},
    {x = 1186.53, y = -340.309, z = 69.174, s = 7},
    {x = 1179.598, y = -341.844, z = 69.18, s = 7},
    {x = 1178.429, y = -337.235, z = 69.179, s = 7},
    {x = 1185.646, y = -335.332, z = 69.175, s = 7},
    {x = 1185.367, y = -332.38, z = 69.174, s = 7},
    {x = 1178.171, y = -333.305, z = 69.177, s = 7},
    {x = 1177.089, y = -328.684, z = 69.176, s = 7},
    {x = 1184.271, y = -327.465, z = 69.174, s = 7},
    {x = 1183.672, y = -323.215, z = 69.174, s = 7},
    {x = 1176.257, y = -324.663, z = 69.175, s = 7},
    {x = 1175.17, y = -319.89, z = 69.174, s = 7},
    {x = 1182.66, y = -318.644, z = 69.174, s = 7},
    {x = -1437.312, y = -286.044, z = 46.208, s = 8},
    {x = -1446.43, y = -276.008, z = 46.227, s = 8},
    {x = -1443.389, y = -273.284, z = 46.22, s = 8},
    {x = -1434.062, y = -283.562, z = 46.208, s = 8},
    {x = -1430.493, y = -280.436, z = 46.208, s = 8},
    {x = -1439.556, y = -270.2, z = 46.208, s = 8},
    {x = -1436.778, y = -267.439, z = 46.208, s = 8},
    {x = -1427.062, y = -277.362, z = 46.208, s = 8},
    {x = -2107.887, y = -325.411, z = 13.021, s = 9},
    {x = -2107.643, y = -318.982, z = 13.023, s = 9},
    {x = -2106.943, y = -310.851, z = 13.024, s = 9},
    {x = -2102.681, y = -311.261, z = 13.025, s = 9},
    {x = -2103.46, y = -319.553, z = 13.025, s = 9},
    {x = -2104.055, y = -325.896, z = 13.023, s = 9},
    {x = -2099.485, y = -326.493, z = 13.025, s = 9},
    {x = -2098.887, y = -319.953, z = 13.026, s = 9},
    {x = -2097.994, y = -311.942, z = 13.025, s = 9},
    {x = -2093.86, y = -312.045, z = 13.025, s = 9},
    {x = -2094.759, y = -320.407, z = 13.026, s = 9},
    {x = -2095.541, y = -326.675, z = 13.025, s = 9},
    {x = -2090.85, y = -327.063, z = 13.023, s = 9},
    {x = -2090.183, y = -320.594, z = 13.025, s = 9},
    {x = -2089, y = -312.438, z = 13.023, s = 9},
    {x = -2085.3, y = -313.258, z = 13.022, s = 9},
    {x = -2086.29, y = -321.439, z = 13.023, s = 9},
    {x = -2087.07, y = -327.707, z = 13.021, s = 9},
    {x = 610.642, y = 263.84, z = 103.089, s = 11},
    {x = 610.487, y = 274.025, z = 103.089, s = 11},
    {x = 614.158, y = 273.897, z = 103.089, s = 11},
    {x = 613.999, y = 263.946, z = 103.089, s = 11},
    {x = 618.761, y = 263.787, z = 103.089, s = 11},
    {x = 619.319, y = 274.03, z = 103.089, s = 11},
    {x = 622.839, y = 274.157, z = 103.089, s = 11},
    {x = 622.803, y = 263.882, z = 103.089, s = 11},
    {x = 628.062, y = 263.682, z = 103.089, s = 11},
    {x = 627.883, y = 274.04, z = 103.089, s = 11},
    {x = 631.485, y = 273.982, z = 103.089, s = 11},
    {x = 631.268, y = 263.801, z = 103.089, s = 11},
    {x = 2571.546, y = 364.883, z = 108.457, s = 12},
    {x = 2571.674, y = 359.022, z = 108.457, s = 12},
    {x = 2575.468, y = 359.222, z = 108.457, s = 12},
    {x = 2575.691, y = 364.609, z = 108.457, s = 12},
    {x = 2579.197, y = 364.535, z = 108.457, s = 12},
    {x = 2578.942, y = 358.71, z = 108.457, s = 12},
    {x = 2582.92, y = 358.653, z = 108.457, s = 12},
    {x = 2583.109, y = 364.208, z = 108.457, s = 12},
    {x = 2586.732, y = 364.159, z = 108.457, s = 12},
    {x = 2586.38, y = 358.222, z = 108.468, s = 12},
    {x = 2590.354, y = 358.396, z = 108.457, s = 12},
    {x = 2590.786, y = 364.089, z = 108.457, s = 12},
    {x = -1804.793, y = 793.065, z = 138.515, s = 13},
    {x = -1810.376, y = 798.735, z = 138.516, s = 13},
    {x = -1807.252, y = 801.005, z = 138.522, s = 13},
    {x = -1802.277, y = 795.508, z = 138.514, s = 13},
    {x = -1798.711, y = 799.15, z = 138.523, s = 13},
    {x = -1803.762, y = 804.526, z = 138.523, s = 13},
    {x = -1801.253, y = 807.34, z = 138.513, s = 13},
    {x = -1795.465, y = 801.903, z = 138.515, s = 13},
    {x = -1792.444, y = 804.804, z = 138.513, s = 13},
    {x = -1797.53, y = 810.42, z = 138.522, s = 13},
    {x = -1794.563, y = 813.348, z = 138.513, s = 13},
    {x = -1789.008, y = 807.492, z = 138.514, s = 13},
    {x = -2551.511, y = 2325.05, z = 33.073, s = 14},
    {x = -2558.042, y = 2324.596, z = 33.072, s = 14},
    {x = -2558.206, y = 2328.878, z = 33.073, s = 14},
    {x = -2551.687, y = 2329.217, z = 33.072, s = 14},
    {x = -2552.436, y = 2332.262, z = 33.06, s = 14},
    {x = -2558.387, y = 2331.756, z = 33.072, s = 14},
    {x = -2558.517, y = 2336.213, z = 33.073, s = 14},
    {x = -2552.635, y = 2336.533, z = 33.06, s = 14},
    {x = -2552.219, y = 2339.827, z = 33.073, s = 14},
    {x = -2558.59, y = 2339.32, z = 33.072, s = 14},
    {x = -2558.816, y = 2343.877, z = 33.109, s = 14},
    {x = -2552.367, y = 2344.159, z = 33.109, s = 14},
    {x = 49.162, y = 2777.058, z = 57.884, s = 15},
    {x = 47.811, y = 2777.97, z = 57.884, s = 15},
    {x = 50.043, y = 2781.144, z = 57.884, s = 15},
    {x = 51.367, y = 2779.877, z = 57.884, s = 15},
    {x = 262.636, y = 2608.435, z = 44.896, s = 16},
    {x = 265.346, y = 2605.549, z = 44.85, s = 16},
    {x = 1035.65, y = 2672.706, z = 39.551, s = 17},
    {x = 1043.192, y = 2672.968, z = 39.551, s = 17},
    {x = 1035.687, y = 2666.274, z = 39.551, s = 17},
    {x = 1043.431, y = 2666.217, z = 39.551, s = 17},
    {x = 1207.123, y = 2662.956, z = 37.81, s = 18},
    {x = 1209.731, y = 2660.546, z = 37.81, s = 18},
    {x = 1210.722, y = 2659.631, z = 37.81, s = 18},
    {x = 2538.21, y = 2594.137, z = 37.945, s = 19},
    {x = 2679.949, y = 3261.648, z = 55.241, s = 20},
    {x = 2682.505, y = 3265.69, z = 55.241, s = 20},
    {x = 2679.16, y = 3267.362, z = 55.241, s = 20},
    {x = 2676.994, y = 3263.163, z = 55.241, s = 20},
    {x = 2000.82, y = 3774.122, z = 32.181, s = 21},
    {x = 2003.129, y = 3775.418, z = 32.181, s = 21},
    {x = 2005.051, y = 3776.813, z = 32.181, s = 21},
    {x = 2008.517, y = 3778.995, z = 32.181, s = 21},
    {x = 2010.64, y = 3774.883, z = 32.181, s = 21},
    {x = 2006.902, y = 3772.949, z = 32.181, s = 21},
    {x = 2004.598, y = 3771.526, z = 32.181, s = 21},
    {x = 2002.138, y = 3769.921, z = 32.181, s = 21},
    {x = 1682.869, y = 4932.726, z = 42.07, s = 22},
    {x = 1685.909, y = 4930.688, z = 42.079, s = 22},
    {x = 1688.638, y = 4928.758, z = 42.078, s = 22},
    {x = 1691.594, y = 4926.91, z = 42.078, s = 22},
    {x = 1705.103, y = 6412.621, z = 32.747, s = 23},
    {x = 1700.705, y = 6414.56, z = 32.712, s = 23},
    {x = 1697.003, y = 6416.653, z = 32.672, s = 23},
    {x = 1698.584, y = 6420.036, z = 32.638, s = 23},
    {x = 1702.779, y = 6418.326, z = 32.64, s = 23},
    {x = 1706.708, y = 6416.178, z = 32.638, s = 23},
    {x = 189.383, y = 6606.512, z = 31.85, s = 24},
    {x = 184.984, y = 6606.252, z = 31.849, s = 24},
    {x = 181.602, y = 6605.191, z = 31.848, s = 24},
    {x = 177.916, y = 6604.186, z = 31.849, s = 24},
    {x = 174.111, y = 6603.921, z = 31.849, s = 24},
    {x = 170.189, y = 6603.134, z = 31.848, s = 24},
    {x = -98.26, y = 6417.974, z = 31.458, s = 25},
    {x = -92.331, y = 6423.958, z = 31.459, s = 25},
    {x = -90.086, y = 6421.26, z = 31.484, s = 25},
    {x = -95.719, y = 6415.342, z = 31.482, s = 25}
}

electric_stations = {
    {x = -55.938, y = -1756.631, z = 29.121},
    {x = 1217.986, y = -1385.517, z = 35.139},
    {x = 286.122, y = -1264.363, z = 29.284},
    {x = -545.695, y = -1222.068, z = 18.279},
    {x = 820.384, y = -1038.054, z = 26.549},
    {x = -714.51, y = -919.327, z = 19.014},
    {x = 1170.2, y = -320.836, z = 69.177},
    {x = -1414.777, y = -279.977, z = 46.293},
    {x = -2076.135, y = -324.185, z = 13.158},
    {x = 626.667, y = 249.346, z = 103.046},
    {x = 2563.333, y = 353.385, z = 108.464},
    {x = -1816.798, y = 798.601, z = 138.106},
    {x = 2541.891, y = 2609.431, z = 37.945},
    {x = 1189.907, y = 2658.11, z = 37.831},
    {x = 1031.292, y = 2660.109, z = 39.551},
    {x = 265.647, y = 2600.547, z = 44.774},
    {x = 63.991, y = 2787.675, z = 57.88},
    {x = -2553.863, y = 2321.008, z = 33.06},
    {x = 2680.59, y = 3274.363, z = 55.241},
    {x = 1984.787, y = 3783.526, z = 32.181},
    {x = 1696.633, y = 4917.12, z = 42.078},
    {x = 1689.197, y = 6435.085, z = 32.559},
    {x = 152.939, y = 6629.043, z = 31.717},
    {x = -92.825, y = 6393.375, z = 31.452}
}

boat_stations = {
    {x = -801.0068, y = -1507.842, z = 1.03, s = 26},
    {x = -803.487, y = -1501.317, z = 1.03, s = 26},
    {x = 3855.96, y = 4465.36, z = 2.71, s = 29}
}

stationsText = {}

stationsText[1] = {x = -74.592, y = -1760.252, z = 31.918}
stationsText[2] = {x = 1208.313, y = -1402.669, z = 40.767}
stationsText[3] = {x = 265.023, y = -1261.405, z = 33.168}
stationsText[4] = {x = -529.663, y = -1209.177, z = 21.466}
stationsText[5] = {x = -723.968, y = -934.613, z = 21.266}
stationsText[6] = {x = 818.99, y = -1027.275, z = 31.054}
stationsText[7] = {x = 1181.935, y = -330.186, z = 71.619}
stationsText[8] = {x = -1434.47, y = -279.401, z = 49.933}
stationsText[9] = {x = -2096.767, y = -320.107, z = 15.805}
stationsText[11] = {x = 620.982, y = 268.854, z = 104.687}
stationsText[12] = {x = 2581.117, y = 361.841, z = 110.219}
stationsText[13] = {x = -1798.993, y = 802.521, z = 140.814}
stationsText[14] = {x = -2555.255, y = 2334.299, z = 34.852}
stationsText[15] = {x = 49.59, y = 2779.02, z = 60.281}
stationsText[16] = {x = 264.326, y = 2606.995, z = 46.209}
stationsText[17] = {x = 1038.993, y = 2667.874, z = 41.174}
stationsText[18] = {x = 1207.744, y = 2660.217, z = 39.659}
stationsText[19] = {x = 2539.638, y = 2594.742, z = 40.245}
stationsText[20] = {x = 2679.517, y = 3263.776, z = 57.554}
stationsText[21] = {x = 2005.045, y = 3774.279, z = 33.887}
stationsText[22] = {x = 1687.317, y = 4929.79, z = 43.837}
stationsText[23] = {x = 1701.67, y = 6416.484, z = 35.091}
stationsText[24] = {x = 179.988, y = 6602.996, z = 33.918}
stationsText[25] = {x = -94.239, y = 6419.58, z = 32.615}

stationsText[26] = {x = -802.513, y = -1504.675, z = 2}
stationsText[27] = {x = 7.313, y = -2777.435, z = 3.451}
stationsText[28] = {x = 1326.863, y = 4218.219, z = 33.55}

stationsText[31] = {x = -1229.625, y = -2877.264, z = 15.921}

stationsText[33] = {x = -1112.407, y = -2883.893, z = 15.921}

StationsPrice = {}

function isNearStationMarker(items)
    local ped = PlayerPedId()
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)

    if (GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 250) then
        return true, GetDistanceBetweenCoords(
            items.x,
            items.y,
            items.z,
            plyCoords["x"],
            plyCoords["y"],
            plyCoords["z"],
            true
        )
    end

    return false
end

function isNearBoatStationMarker(items)
    local ped = PlayerPedId()
    local plyCoords = GetEntityCoords(PlayerPedId(), 0)

    if (GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 250) then
        return true, GetDistanceBetweenCoords(
            items.x,
            items.y,
            items.z,
            plyCoords["x"],
            plyCoords["y"],
            plyCoords["z"],
            true
        )
    end

    return false
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 1.1 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

RegisterNetEvent("essence:sendPrice")
AddEventHandler(
    "essence:sendPrice",
    function(st)
        StationsPrice = st
    end
)

local inMenu = false
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                if GetEntitySpeed(GetVehiclePedIsIn(ped, false)) < 2 then
                    local isNearFuelStation, stationNumber = isNearStation()
                    local isNearFuelBStation, _ = isNearBoatStation()

                    if isNearFuelStation or isNearFuelPStation or isNearFuelHStation or isNearFuelBStation then
                        SetTextComponentFormat("STRING")
                        AddTextComponentString("Appuyez sur ~INPUT_CONTEXT~ pour acheter de l'essence")
                        DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                    end

                    if (IsControlJustPressed(1, 38)) then
                        if isNearFuelStation or isNearFuelPStation or isNearFuelHStation or isNearFuelBStation then
                            TriggerEvent("essence:OpenMenu", true)
                            inMenu = true
                        end
                    end
                else
                    Wait(1000)
                end
            else
                Wait(2000)
            end
        end
    end
)

-- Vehicles to enable/disable air control
local vehicleClassDisableControl = {
    [0] = true, --compacts
    [1] = true, --sedans
    [2] = true, --SUV's
    [3] = true, --coupes
    [4] = true, --muscle
    [5] = true, --sport classic
    [6] = true, --sport
    [7] = true, --super
    [8] = false, --motorcycle
    [9] = true, --offroad
    [10] = true, --industrial
    [11] = true, --utility
    [12] = true, --vans
    [13] = false, --bicycles
    [14] = false, --boats
    [15] = false, --helicopter
    [16] = false, --plane
    [17] = true, --service
    [18] = true, --emergency
    [19] = false --military
}

-- Main thread
Citizen.CreateThread(
    function()
        while true do
            -- Loop forever and update every frame
            Citizen.Wait(0)

            -- Get player, vehicle and vehicle class
            local player = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(player, false)
            local vehicleClass = GetVehicleClass(vehicle)

            -- Disable control if player is in the driver seat and vehicle class matches array
            if ((GetPedInVehicleSeat(vehicle, -1) == player) and vehicleClassDisableControl[vehicleClass]) then
                -- Check if vehicle is in the air and disable L/R and UP/DN controls
                if IsEntityInAir(vehicle) then
                    DisableControlAction(2, 59)
                    DisableControlAction(2, 60)
                end
            end
        end
    end
)

-- ------------------------------------------
-- --	iEnsomatic RealisticVehicleFailure  --
-- ------------------------------------------
-- --
-- --	Created by Jens Sandalgaard
-- --
-- --	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
-- --
-- --	https://github.com/iEns/RealisticVehicleFailure
-- --

-- local pedInSameVehicleLast=false
-- local vehicle
-- local lastVehicle
-- local vehicleClass
-- local fCollisionDamageMult = 0.0
-- local fDeformationDamageMult = 0.0
-- local fEngineDamageMult = 0.0
-- local fBrakeForce = 1.0
-- local isBrakingForward = false
-- local isBrakingReverse = false

-- local healthEngineLast = 1000.0
-- local healthEngineCurrent = 1000.0
-- local healthEngineNew = 1000.0
-- local healthEngineDelta = 0.0
-- local healthEngineDeltaScaled = 0.0

-- local healthBodyLast = 1000.0
-- local healthBodyCurrent = 1000.0
-- local healthBodyNew = 1000.0
-- local healthBodyDelta = 0.0
-- local healthBodyDeltaScaled = 0.0

-- local healthPetrolTankLast = 1000.0
-- local healthPetrolTankCurrent = 1000.0
-- local healthPetrolTankNew = 1000.0
-- local healthPetrolTankDelta = 0.0
-- local healthPetrolTankDeltaScaled = 0.0
-- local tireBurstLuckyNumber

-- math.randomseed(GetGameTimer());

-- local tireBurstMaxNumber = cfg.randomTireBurstInterval * 1200; 												-- the tire burst lottery runs roughly 1200 times per minute
-- if cfg.randomTireBurstInterval ~= 0 then tireBurstLuckyNumber = math.random(tireBurstMaxNumber) end			-- If we hit this number again randomly, a tire will burst.

-- local fixMessagePos = math.random(repairCfg.fixMessageCount)
-- local noFixMessagePos = math.random(repairCfg.noFixMessageCount)

-- -- Display blips on map
-- Citizen.CreateThread(function()
-- 	if (cfg.displayBlips == true) then
-- 		for _, item in pairs(repairCfg.mechanics) do
-- 			item.blip = AddBlipForCoord(item.x, item.y, item.z)
-- 			SetBlipSprite(item.blip, item.id)
-- 			SetBlipAsShortRange(item.blip, true)
-- 			BeginTextCommandSetBlipName("STRING")
-- 			AddTextComponentString(item.name)
-- 			EndTextCommandSetBlipName(item.blip)
-- 		end
-- 	end
-- end)

-- local function notification(msg)
-- 	SetNotificationTextEntry("STRING")
-- 	AddTextComponentString(msg)
-- 	DrawNotification(false, false)
-- end

-- local function isPedDrivingAVehicle()
-- 	local ped = PlayerPedId()
-- 	vehicle = GetVehiclePedIsIn(ped, false)
-- 	if IsPedInAnyVehicle(ped, false) then
-- 		-- Check if ped is in driver seat
-- 		if GetPedInVehicleSeat(vehicle, -1) == ped then
-- 			local class = GetVehicleClass(vehicle)
-- 			-- We don't want planes, helicopters, bicycles and trains
-- 			if class ~= 15 and class ~= 16 and class ~=21 and class ~=13 then
-- 				return true
-- 			end
-- 		end
-- 	end
-- 	return false
-- end

-- local function IsNearMechanic()
-- 	local ped = PlayerPedId()
-- 	local pedLocation = GetEntityCoords(ped, 0)
-- 	for _, item in pairs(repairCfg.mechanics) do
-- 		local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  pedLocation["x"], pedLocation["y"], pedLocation["z"], true)
-- 		if distance <= item.r then
-- 			return true
-- 		end
-- 	end
-- end

-- local function fscale(inputValue, originalMin, originalMax, newBegin, newEnd, curve)
-- 	local OriginalRange = 0.0
-- 	local NewRange = 0.0
-- 	local zeroRefCurVal = 0.0
-- 	local normalizedCurVal = 0.0
-- 	local rangedValue = 0.0
-- 	local invFlag = 0

-- 	if (curve > 10.0) then curve = 10.0 end
-- 	if (curve < -10.0) then curve = -10.0 end

-- 	curve = (curve * -.1)
-- 	curve = 10.0 ^ curve

-- 	if (inputValue < originalMin) then
-- 	  inputValue = originalMin
-- 	end
-- 	if inputValue > originalMax then
-- 	  inputValue = originalMax
-- 	end

-- 	OriginalRange = originalMax - originalMin

-- 	if (newEnd > newBegin) then
-- 		NewRange = newEnd - newBegin
-- 	else
-- 	  NewRange = newBegin - newEnd
-- 	  invFlag = 1
-- 	end

-- 	zeroRefCurVal = inputValue - originalMin
-- 	normalizedCurVal  =  zeroRefCurVal / OriginalRange

-- 	if (originalMin > originalMax ) then
-- 	  return 0
-- 	end

-- 	if (invFlag == 0) then
-- 		rangedValue =  ((normalizedCurVal ^ curve) * NewRange) + newBegin
-- 	else
-- 		rangedValue =  newBegin - ((normalizedCurVal ^ curve) * NewRange)
-- 	end

-- 	return rangedValue
-- end

-- local function tireBurstLottery()
-- 	local tireBurstNumber = math.random(tireBurstMaxNumber)
-- 	if tireBurstNumber == tireBurstLuckyNumber then
-- 		-- We won the lottery, lets burst a tire.
-- 		if GetVehicleTyresCanBurst(vehicle) == false then return end
-- 		local numWheels = GetVehicleNumberOfWheels(vehicle)
-- 		local affectedTire
-- 		if numWheels == 2 then
-- 			affectedTire = (math.random(2)-1)*4		-- wheel 0 or 4
-- 		elseif numWheels == 4 then
-- 			affectedTire = (math.random(4)-1)
-- 			if affectedTire > 1 then affectedTire = affectedTire + 2 end	-- 0, 1, 4, 5
-- 		elseif numWheels == 6 then
-- 			affectedTire = (math.random(6)-1)
-- 		else
-- 			affectedTire = 0
-- 		end
-- 		SetVehicleTyreBurst(vehicle, affectedTire, false, 1000.0)
-- 		tireBurstLuckyNumber = math.random(tireBurstMaxNumber)			-- Select a new number to hit, just in case some numbers occur more often than others
-- 	end
-- end

-- RegisterNetEvent('iens:repair')
-- AddEventHandler('iens:repair', function()
-- 	if isPedDrivingAVehicle() then
-- 		local ped = PlayerPedId()
-- 		vehicle = GetVehiclePedIsIn(ped, false)
-- 		if IsNearMechanic() then
-- 			SetVehicleUndriveable(vehicle,false)
-- 			SetVehicleFixed(vehicle)
-- 			healthBodyLast=1000.0
-- 			healthEngineLast=1000.0
-- 			healthPetrolTankLast=1000.0
-- 			SetVehicleEngineOn(vehicle, true, false )
-- 			notification("~g~Le mécanicien a réparé votre voiture!")
-- 			return
-- 		end
-- 		if GetVehicleEngineHealth(vehicle) < cfg.cascadingFailureThreshold + 5 then
-- 			if GetVehicleOilLevel(vehicle) > 0 then
-- 				SetVehicleUndriveable(vehicle,false)
-- 				SetVehicleEngineHealth(vehicle, cfg.cascadingFailureThreshold + 5)
-- 				SetVehiclePetrolTankHealth(vehicle, 750.0)
-- 				healthEngineLast=cfg.cascadingFailureThreshold +5
-- 				healthPetrolTankLast=750.0
-- 					SetVehicleEngineOn(vehicle, true, false )
-- 				SetVehicleOilLevel(vehicle,(GetVehicleOilLevel(vehicle)/3)-0.5)
-- 				notification("~g~" .. repairCfg.fixMessages[fixMessagePos] .. ", maintenant aller à un mécanicien!")
-- 				fixMessagePos = fixMessagePos + 1
-- 				if fixMessagePos > repairCfg.fixMessageCount then fixMessagePos = 1 end
-- 			else
-- 				notification("~r~Votre véhicule est trop endommagé. Incapable de réparer!")
-- 			end
-- 		else
-- 			notification("~y~" .. repairCfg.noFixMessages[noFixMessagePos] )
-- 			noFixMessagePos = noFixMessagePos + 1
-- 			if noFixMessagePos > repairCfg.noFixMessageCount then noFixMessagePos = 1 end
-- 		end
-- 	else
-- 		notification("~y~Vous devez être dans un véhicule pour pouvoir le réparer")
-- 	end
-- end)

-- RegisterNetEvent('iens:notAllowed')
-- AddEventHandler('iens:notAllowed', function()
-- 	notification("~r~Tu n'as pas la permission pour réparer le véhicule")
-- end)

-- if cfg.torqueMultiplierEnabled or cfg.preventVehicleFlip or cfg.limpMode then
-- 	Citizen.CreateThread(function()
-- 		while true do
-- 			Citizen.Wait(0)
-- 			if cfg.torqueMultiplierEnabled or cfg.sundayDriver or cfg.limpMode then
-- 				if pedInSameVehicleLast then
-- 					local factor = 1.0
-- 					if cfg.torqueMultiplierEnabled and healthEngineNew < 900 then
-- 						factor = (healthEngineNew+200.0) / 1100
-- 					end
-- 					if cfg.sundayDriver and GetVehicleClass(vehicle) ~= 14 then -- Not for boats
-- 						local accelerator = GetControlValue(2,71)
-- 						local brake = GetControlValue(2,72)
-- 						local speed = GetEntitySpeedVector(vehicle, true)['y']
-- 						-- Change Braking force
-- 						local brk = fBrakeForce
-- 						if speed >= 1.0 then
-- 							-- Going forward
-- 							if accelerator > 127 then
-- 								-- Forward and accelerating
-- 								local acc = fscale(accelerator, 127.0, 254.0, 0.1, 1.0, 10.0-(cfg.sundayDriverAcceleratorCurve*2.0))
-- 								factor = factor * acc
-- 							end
-- 							if brake > 127 then
-- 								-- Forward and braking
-- 								isBrakingForward = true
-- 								brk = fscale(brake, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(cfg.sundayDriverBrakeCurve*2.0))
-- 							end
-- 						elseif speed <= -1.0 then
-- 							-- Going reverse
-- 							if brake > 127 then
-- 								-- Reversing and accelerating (using the brake)
-- 								local rev = fscale(brake, 127.0, 254.0, 0.1, 1.0, 10.0-(cfg.sundayDriverAcceleratorCurve*2.0))
-- 								factor = factor * rev
-- 							end
-- 							if accelerator > 127 then
-- 								-- Reversing and braking (Using the accelerator)
-- 								isBrakingReverse = true
-- 								brk = fscale(accelerator, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(cfg.sundayDriverBrakeCurve*2.0))
-- 							end
-- 						else
-- 							-- Stopped or almost stopped or sliding sideways
-- 							local entitySpeed = GetEntitySpeed(vehicle)
-- 							if entitySpeed < 1 then
-- 								-- Not sliding sideways
-- 								if isBrakingForward == true then
-- 									--Stopped or going slightly forward while braking
-- 									DisableControlAction(2,72,true) -- Disable Brake until user lets go of brake
-- 									SetVehicleForwardSpeed(vehicle,speed*0.98)
-- 									SetVehicleBrakeLights(vehicle,true)
-- 								end
-- 								if isBrakingReverse == true then
-- 									--Stopped or going slightly in reverse while braking
-- 									DisableControlAction(2,71,true) -- Disable reverse Brake until user lets go of reverse brake (Accelerator)
-- 									SetVehicleForwardSpeed(vehicle,speed*0.98)
-- 									SetVehicleBrakeLights(vehicle,true)
-- 								end
-- 								if isBrakingForward == true and GetDisabledControlNormal(2,72) == 0 then
-- 									-- We let go of the brake
-- 									isBrakingForward=false
-- 								end
-- 								if isBrakingReverse == true and GetDisabledControlNormal(2,71) == 0 then
-- 									-- We let go of the reverse brake (Accelerator)
-- 									isBrakingReverse=false
-- 								end
-- 							end
-- 						end
-- 						if brk > fBrakeForce - 0.02 then brk = fBrakeForce end -- Make sure we can brake max.
-- 						SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce', brk)  -- Set new Brake Force multiplier
-- 					end
-- 					if cfg.limpMode == true and healthEngineNew < cfg.engineSafeGuard + 5 then
-- 						factor = cfg.limpModeMultiplier
-- 					end
-- 					SetVehicleEngineTorqueMultiplier(vehicle, factor)
-- 				end
-- 			end
-- 			if cfg.preventVehicleFlip then
-- 				local roll = GetEntityRoll(vehicle)
-- 				if (roll > 75.0 or roll < -75.0) and GetEntitySpeed(vehicle) < 2 then
-- 					DisableControlAction(2,59,true) -- Disable left/right
-- 					DisableControlAction(2,60,true) -- Disable up/down
-- 				end
-- 			end
-- 		end
-- 	end)
-- end

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(50)
-- 		local ped = PlayerPedId()
-- 		if isPedDrivingAVehicle() then
-- 			vehicle = GetVehiclePedIsIn(ped, false)
-- 			vehicleClass = GetVehicleClass(vehicle)
-- 			healthEngineCurrent = GetVehicleEngineHealth(vehicle)
-- 			if healthEngineCurrent == 1000 then healthEngineLast = 1000.0 end
-- 			healthEngineNew = healthEngineCurrent
-- 			healthEngineDelta = healthEngineLast - healthEngineCurrent
-- 			healthEngineDeltaScaled = healthEngineDelta * cfg.damageFactorEngine * cfg.classDamageMultiplier[vehicleClass]

-- 			healthBodyCurrent = GetVehicleBodyHealth(vehicle)
-- 			if healthBodyCurrent == 1000 then healthBodyLast = 1000.0 end
-- 			healthBodyNew = healthBodyCurrent
-- 			healthBodyDelta = healthBodyLast - healthBodyCurrent
-- 			healthBodyDeltaScaled = healthBodyDelta * cfg.damageFactorBody * cfg.classDamageMultiplier[vehicleClass]

-- 			healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)
-- 			if cfg.compatibilityMode and healthPetrolTankCurrent < 1 then
-- 				--	SetVehiclePetrolTankHealth(vehicle, healthPetrolTankLast)
-- 				--	healthPetrolTankCurrent = healthPetrolTankLast
-- 				healthPetrolTankLast = healthPetrolTankCurrent
-- 			end
-- 			if healthPetrolTankCurrent == 1000 then healthPetrolTankLast = 1000.0 end
-- 			healthPetrolTankNew = healthPetrolTankCurrent
-- 			healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
-- 			healthPetrolTankDeltaScaled = healthPetrolTankDelta * cfg.damageFactorPetrolTank * cfg.classDamageMultiplier[vehicleClass]

-- 			if healthEngineCurrent > cfg.engineSafeGuard+1 then
-- 				SetVehicleUndriveable(vehicle,false)
-- 			end

-- 			if healthEngineCurrent <= cfg.engineSafeGuard+1 and cfg.limpMode == false then
-- 				SetVehicleUndriveable(vehicle,true)
-- 			end

-- 			-- If ped spawned a new vehicle while in a vehicle or teleported from one vehicle to another, handle as if we just entered the car
-- 			if vehicle ~= lastVehicle then
-- 				pedInSameVehicleLast = false
-- 			end

-- 			if pedInSameVehicleLast == true then
-- 				-- Damage happened while in the car = can be multiplied

-- 				-- Only do calculations if any damage is present on the car. Prevents weird behavior when fixing using trainer or other script
-- 				if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 or healthPetrolTankCurrent ~= 1000.0 then

-- 					-- Combine the delta values (Get the largest of the three)
-- 					local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled, healthBodyDeltaScaled, healthPetrolTankDeltaScaled)

-- 					-- If huge damage, scale back a bit
-- 					if healthEngineCombinedDelta > (healthEngineCurrent - cfg.engineSafeGuard) then
-- 						healthEngineCombinedDelta = healthEngineCombinedDelta * 0.7
-- 					end

-- 					-- If complete damage, but not catastrophic (ie. explosion territory) pull back a bit, to give a couple of seconds og engine runtime before dying
-- 					if healthEngineCombinedDelta > healthEngineCurrent then
-- 						healthEngineCombinedDelta = healthEngineCurrent - (cfg.cascadingFailureThreshold / 5)
-- 					end

-- 					------- Calculate new value

-- 					healthEngineNew = healthEngineLast - healthEngineCombinedDelta

-- 					------- Sanity Check on new values and further manipulations

-- 					-- If somewhat damaged, slowly degrade until slightly before cascading failure sets in, then stop

-- 					if healthEngineNew > (cfg.cascadingFailureThreshold + 5) and healthEngineNew < cfg.degradingFailureThreshold then
-- 						healthEngineNew = healthEngineNew-(0.038 * cfg.degradingHealthSpeedFactor)
-- 					end

-- 					-- If Damage is near catastrophic, cascade the failure
-- 					if healthEngineNew < cfg.cascadingFailureThreshold then
-- 						healthEngineNew = healthEngineNew-(0.1 * cfg.cascadingFailureSpeedFactor)
-- 					end

-- 					-- Prevent Engine going to or below zero. Ensures you can reenter a damaged car.
-- 					if healthEngineNew < cfg.engineSafeGuard then
-- 						healthEngineNew = cfg.engineSafeGuard
-- 					end

-- 					-- Prevent Explosions
-- 					if cfg.compatibilityMode == false and healthPetrolTankCurrent < 750 then
-- 						healthPetrolTankNew = 750.0
-- 					end

-- 					-- Prevent negative body damage.
-- 					if healthBodyNew < 0  then
-- 						healthBodyNew = 0.0
-- 					end
-- 				end
-- 			else
-- 				-- Just got in the vehicle. Damage can not be multiplied this round
-- 				-- Set vehicle handling data
-- 				fDeformationDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult')
-- 				fBrakeForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
-- 				local newFDeformationDamageMult = fDeformationDamageMult ^ cfg.deformationExponent	-- Pull the handling file value closer to 1
-- 				if cfg.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult', newFDeformationDamageMult * cfg.deformationMultiplier) end  -- Multiply by our factor
-- 				if cfg.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fWeaponDamageMult', cfg.weaponsDamageMultiplier/cfg.damageFactorBody) end -- Set weaponsDamageMultiplier and compensate for damageFactorBody

-- 				--Get the CollisionDamageMultiplier
-- 				fCollisionDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult')
-- 				--Modify it by pulling all number a towards 1.0
-- 				local newFCollisionDamageMultiplier = fCollisionDamageMult ^ cfg.collisionDamageExponent	-- Pull the handling file value closer to 1
-- 				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult', newFCollisionDamageMultiplier)

-- 				--Get the EngineDamageMultiplier
-- 				fEngineDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult')
-- 				--Modify it by pulling all number a towards 1.0
-- 				local newFEngineDamageMult = fEngineDamageMult ^ cfg.engineDamageExponent	-- Pull the handling file value closer to 1
-- 				SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult', newFEngineDamageMult)

-- 				-- If body damage catastrophic, reset somewhat so we can get new damage to multiply
-- 				if healthBodyCurrent < cfg.cascadingFailureThreshold then
-- 					healthBodyNew = cfg.cascadingFailureThreshold
-- 				end
-- 				pedInSameVehicleLast = true
-- 			end

-- 			-- set the actual new values
-- 			if healthEngineNew ~= healthEngineCurrent then
-- 				SetVehicleEngineHealth(vehicle, healthEngineNew)
-- 			end
-- 			if healthBodyNew ~= healthBodyCurrent then SetVehicleBodyHealth(vehicle, healthBodyNew) end
-- 			if healthPetrolTankNew ~= healthPetrolTankCurrent then SetVehiclePetrolTankHealth(vehicle, healthPetrolTankNew) end

-- 			-- Store current values, so we can calculate delta next time around
-- 			healthEngineLast = healthEngineNew
-- 			healthBodyLast = healthBodyNew
-- 			healthPetrolTankLast = healthPetrolTankNew
-- 			lastVehicle=vehicle
-- 			if cfg.randomTireBurstInterval ~= 0 and GetEntitySpeed(vehicle) > 10 then tireBurstLottery() end
-- 		else
-- 			if pedInSameVehicleLast == true then
-- 				-- We just got out of the vehicle
-- 				lastVehicle = GetVehiclePedIsIn(ped, true)
-- 				if cfg.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fDeformationDamageMult', fDeformationDamageMult) end -- Restore deformation multiplier
-- 				SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fBrakeForce', fBrakeForce)  -- Restore Brake Force multiplier
-- 				if cfg.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fWeaponDamageMult', cfg.weaponsDamageMultiplier) end	-- Since we are out of the vehicle, we should no longer compensate for bodyDamageFactor
-- 				SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fCollisionDamageMult', fCollisionDamageMult) -- Restore the original CollisionDamageMultiplier
-- 				SetVehicleHandlingFloat(lastVehicle, 'CHandlingData', 'fEngineDamageMult', fEngineDamageMult) -- Restore the original EngineDamageMultiplier
-- 			end
-- 			pedInSameVehicleLast = false
-- 		end
-- 	end
-- end)
