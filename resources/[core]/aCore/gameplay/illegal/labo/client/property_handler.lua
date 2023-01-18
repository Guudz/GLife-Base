local Labos = {}
local myUUID = 0
local createdCamera = nil
local currentPed = nil
local currPed = nil
local currentI = nil
local PosSS = {}
local animandped = {}
local MYPOS = {}
local tempOptions2 = {}
local lastInd = 0
local lastN = nil
local UpgradeList = { 
    {
      ["Produits"] = {name="set_up",price=250},
      -- basic
      ["Equipement"] = {name="table_equipment",price=350},
      ["Table"] = {name="equipment_basic",price=800},
      -- ameliorer
      
      ["Équipement MK2"] = {name="equipment_upgrade",price=2500},
      ["Production amélioré"] = {name="production_upgrade",price=1850},

       ["Niveau de sécurité 0"] = {name="",price=0},
       ["Niveau de sécurité moyen"] = {name="security_low",price=7500},
       ["Niveau de sécurité élevé"] = {name="security_high",price=15000},
    },
}
local LaboList = {"Laboratoire Cocaine"}
local editIPL = {}
local CoordsCamList = {
    {
        coords={x=1086.79,y=-3199.36,z=-37.36},
        r={x=-200.0,y=-180.0,z=-130.29},
        entry ={x=1088.52,y=-3187.82,z=-39.0},
        coffre = {x=1093.59,y=-3199.09,z=-39.98},
        gestion = {x=1087.23,y=-3194.27,z=-38.99}
    },
}
local InteriorPeds = {
    { -- COKE
        {
            pos = {x=1090.27,y=-3194.85,z=-38.99,h=178.63},
            anim = {
                dict = "anim@amb@business@coc@coc_packing@",
                anim = "fill_basicmould_v2_pressoperator"
            }
        },
        {
            pos = {x=1092.9,y=-3194.85,z=-38.99,h=178.63},
            anim = {
                dict = "anim@amb@business@coc@coc_packing@",
                anim = "fill_basicmould_v2_pressoperator"
            }
        },
        {
            pos = {x=1095.28,y=-3194.85,z=-38.99,h=178.63},
            anim = {
                dict = "anim@amb@business@coc@coc_packing@",
                anim = "fill_basicmould_v2_pressoperator"
            }
        },
        {
            pos = {x=1090.27,y=-3196.67,z=-38.99,h=353.63},
            anim = {
                dict = "anim@amb@business@coc@coc_packing@",
                anim = "full_cycle_basicmould_v3_pressoperator"
            }
        },
        {
            pos = {x=1092.93,y=-3196.67,z=-38.99,h=353.63},
            anim = {
                dict = "anim@amb@business@coc@coc_packing@",
                anim = "fill_basicmould_v2_pressoperator"
            }
        },
        {
            pos = {x=1095.38,y=-3196.67,z=-38.99,h=353.63},
            anim = {
                dict = "anim@amb@business@coc@coc_packing@",
                anim = "fill_basicmould_v2_pressoperator"
            }
        },
    }
}
local recipes = {
    { -- coke
        ["coke1"] = { -- cocaine
            amount = 1, -- combien la recette rapporte de cocaine
            time = 0.8, -- en heure (0.5 pour 30m)
            required = {
                {name ="coke" , count = 5},
             },
            requiredEquipement = {
                "set_up","equipment_basic" ,"table_equipment"
            },
            speedUp = {
                "equipment_upgrade","production_upgrade"
            }
        },
        ["meth"] = { -- cocaine
        amount = 1, -- combien la recette rapporte de cocaine
        time = 0.8, -- en heure (0.5 pour 30m)
        required = {
            {name = "ephedrine" , count = 5},
         },
        requiredEquipement = {
            "set_up","equipment_basic" ,"table_equipment"
        },
        speedUp = {
            "equipment_upgrade","production_upgrade"
        }
    },
    ["weed_pooch"] = { -- cocaine
    amount = 1, -- combien la recette rapporte de cocaine
    time = 0.8, -- en heure (0.5 pour 30m)
    required = {
        {name = "weed_graines" , count = 5},
     },
    requiredEquipement = {
        "set_up","equipment_basic" ,"table_equipment"
    },
    speedUp = {
        "equipment_upgrade","production_upgrade"
    }
},
    }
}
function IsLaboUpgraded(index,recipe)
    local r = recipes[index][recipe]
    local found = 1
    for i = 1 , #r.speedUp , 1 do
        for k, v in pairs(currentLabos.options) do
            if r.speedUp[i] == v then
                found = found + 1 
            end
        end
    end
    return found
end
function equipementIsOK(index,recipe)

    local r = recipes[index][recipe]
    local found = 0
    for i = 1 , #r.requiredEquipement , 1 do
        for k, v in pairs(currentLabos.options) do
            if r.requiredEquipement[i] == v then
                found = found + 1 
            end
        end
    end
    
    return found == #r.requiredEquipement
end
function canStartARecipe(index,recipe)
    --print(index,recipe)
    local r = recipes[index][recipe]
    local found = 0
    for i = 1 , #r.required , 1 do
        for k,v in pairs(currentLabos.Storages.items) do
            if k == r.required[i].name then
                if #v >= r.required[i].count then
                    found = found + 1
                end
            end
        end
    end
    return found == #r.required
end

function startRecipe(index,recipe)
    local r = recipes[index][recipe]
    local found = 0
    for i = 1 , #r.required , 1 do
        for k, v in pairs(currentLabos.Storages.items) do
            if k == r.required[i].name then
                for _i = 1, r.required[i].count, 1 do
                    --table.remove(currentLabos.Storages.items[r.required[i].name], 1)

                    ShowNotification("Vous avez lancé la production de ~b~" .. r.amount .. "x " .. Items[recipe].label)
                    currentLabos.Storages:RemoveItem(r.required[i].name,v[1].id)
                    --TriggerServerEvent("rage-reborn:RemoveItemFromStorage2", v[1].id,r.required[i].name, currentLabos.name.."_storage")
                end
            end
        end
    end
end
RMenu.Add('labos',"gestion", RageUI.CreateMenu(nil, "Actions disponibles",10,100))
RMenu.Add('labos',"production", RageUI.CreateSubMenu(RMenu:Get('labos',"gestion"),nil, "Actions disponibles",10,100))
RMenu.Add('labos',"gestion_listNPC", RageUI.CreateSubMenu(RMenu:Get('labos',"gestion"),nil, "Listes des employés",10,100))
RMenu.Add('labos',"NPC", RageUI.CreateSubMenu(RMenu:Get('labos',"gestion"),nil, "Actions disponibles",10,100))


RMenu.Add('labos',"main", RageUI.CreateMenu(nil, "Actions disponibles",10,100))
RMenu.Add('labos',"options", RageUI.CreateSubMenu(RMenu:Get('labos',"main"),nil, "Actions disponibles",10,100))
RMenu.Add('labos',"workers", RageUI.CreateSubMenu(RMenu:Get('labos',"main"),nil, "Actions disponibles",10,100))
RMenu:Get('labos',"workers").Closed = function()
    createdCamera  = nil
    DeleteEntity(currentPed)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    currentPed = nil
    currPed = nil
end
RMenu:Get('labos',"options").Closed = function()
    createdCamera  = nil
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
end

local function addStorage()
    currentLabos.Storages = Storage.New(currentLabos.name.."_storage", currentLabos.capacity)
    currentLabos.Storages:LinkToPos(CoordsCamList[currentLabos.indexx].coffre)
end
local function addGestion()
    Zone:Add(CoordsCamList[currentLabos.indexx].gestion,function()
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec la propriété")
        KeySettings:Add("keyboard","E",function()
            RageUI.Visible(RMenu:Get('labos',"gestion"),true)
        end,"Gestion")
        KeySettings:Add("controller",46,function()
            RageUI.Visible(RMenu:Get('labos',"gestion"),true)
        end,"Gestion")
    end,function()
        KeySettings:Clear("keyboard","E","Gestion")
        KeySettings:Clear("controller",46,"Gestion")
        Hint:RemoveAll()
        CloseAllMenus()
    end,currentLabos.indexx,1.3)
end
local function EnterProperty()
    local playerPed      = LocalPlayer().Ped
    local propertyX = currentLabos
    local property = CoordsCamList[currentLabos.indexx]
    Citizen.CreateThread(function()
        DoScreenFadeOut(0)
        while not IsScreenFadedOut() and not IsInteriorReady(GetInteriorAtCoords(property.entry.x,  property.entry.y,  property.entry.z)) do
            Citizen.Wait(0)
        end
        SetEntityCoords(playerPed, property.entry.x,  property.entry.y,  property.entry.z)
        DoScreenFadeIn(0)
        DrawSub(propertyX.name, 5000)
        w = propertyX["capacity"]
        SetupPed()
        

        
        addStorage()
        addGestion()
        TriggerServerEvent("ENTERLABOS",propertyX.id)
        TriggerServerEvent("RequestUpdateLabs",propertyX.id)

    end)
end
function drawX3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local function ExitProperty()
    outside = MYPOS
    if currentLabos ~= nil then
      Zone:Remove(CoordsCamList[currentLabos.indexx].coffre)
      TriggerServerEvent("EXITLABOS",currentLabos.id)
    end
    Citizen.CreateThread(function()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
              Citizen.Wait(0)
        end
        if outside == nil then
            outside = {x=212.19,y=-934.99,z=24.28}
        end
        SetEntityCoords(LocalPlayer().Ped, outside.x,  outside.y,  outside.z)
        DoScreenFadeIn(800)
    end)
    DeletePed()
    currentLabos = nil
end
local function Exit3()
    KeySettings:Clear("keyboard","E","Labos")
    KeySettings:Clear("controller",46,"Labos")
    Hint:RemoveAll()
end
local function Exit()

    KeySettings:Clear("keyboard","E","Labos")
    KeySettings:Clear("controller",46,"Labos")
    Hint:RemoveAll()
end
local function Open()
    RageUI.Visible(RMenu:Get('labos',"main"),true)
    --Exit()
end
local function Enter(z)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec la propriété")
    KeySettings:Add("keyboard","E",Open,"Labos")
    KeySettings:Add("controller",46,Open,"Labos")
    currentLabos = Labos[z]
    currentI = z
end
function SetupLabos()

    while PlyUuid == nil do Wait(0) end
    PlyUUID = PlyUuid

    for i = 1 , #Labos, 1 do
        local own = false
        while PlyUUID == nil do Wait(0) end
        --print(PlyUUID)
        if PlyUUID == Labos[i].owner then
            own = true
        end
        if not own then
            if Labos[i].coowner ~= nil then
                for _i = 1 , #Labos[i].coowner , 1 do
                    if PlyUUID == Labos[i].coowner[_i] then
                        own = true
                        break
                    end
                end
            end
        end
        while Job == nil or Job:Get() == nil do
            Wait(1)
        end

        if own or Job:Get().name == "admin_drug" then
            local coulour = 2
            local size = 0.6
            local name = "Laboratoire"
            if Job:Get().name == "admin_drug" and not own then
                coulour = 55
                name = nil
                size = 0.45
                if Labos[i].owner ~= nil then
                    coulour = 84
                end
            end
            local blip = AddBlipForCoord(Labos[i].Pos.x, Labos[i].Pos.y, Labos[i].Pos.z)
            SetBlipSprite (blip, 499 )
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, size)
            SetBlipColour (blip,  coulour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(name)
            EndTextCommandSetBlipName(blip)
        end
        

        Zone:Add(Labos[i].Pos,Enter,Exit,i,1.3)
    end
end
local function DisplayCam()
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    m = CoordsCamList[currentLabos.indexx]
    c = m.coords
    r = m.r
    
    local int = GetInteriorAtCoords(
      c.x , 
      c.y , 
      c.z 
    )
    LoadInterior(int)
    while not IsInteriorReady(int) do
      Wait(1)
    end
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 2)
    SetCamCoord(cam,c.x,c.y,c.z)
    SetCamRot(cam, r.x,r.y,r.z, 1)
    SetFocusArea(c.x,c.y,c.z,c.x,c.y,c.z)
    RenderScriptCams(1, 0, 0, 1, 1)
    createdCamera = cam
end
local function Format()
    for i = 1 , #Labos, 1 do
        Labos[i].Pos = json.decode(Labos[i].entry)
        Labos[i].capacity = string.gsub(Labos[i].capacity, "KG", "")
        Labos[i].capacity = tonumber(Labos[i].capacity)
        Labos[i].coowner = Labos[i].coowner == nil and {} or json.decode(Labos[i].coowner)
        Labos[i].options = Labos[i].current == nil and {} or json.decode(Labos[i].current)
        Labos[i].workers = Labos[i].workers == nil and {} or json.decode(Labos[i].workers)
    end
    SetupLabos()
end
local function Exit22()
    TriggerEvent('instance:leave')
    ExitProperty()

    KeySettings:Clear("keyboard","E","Appart_")
    KeySettings:Clear("controller",46,"Appart_")
    Hint:RemoveAll()
end
local function Enter2(pos)
    PosSS = pos
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour sortir")
    KeySettings:Add("keyboard","E",Exit22,"Appart_")
    KeySettings:Add("controller",46,Exit22,"Appart_")
end
 
local function Exit2()
    KeySettings:Clear("keyboard","E","Appart_")
    KeySettings:Clear("controller",46,"Appart_")
    Hint:RemoveAll()
end
Citizen.CreateThread(function()
    while Job == nil or Job:Get() == nil do
        Wait(1)
    end
    for i=1 , #CoordsCamList , 1 do
        local property = CoordsCamList[i]
        property.entry.z = property.entry.z - 0.9
        Zone:Add(property.entry,Enter2,Exit2,property.entry,1.3)
       -- Marker:Add(property.entry,_Marker)
    end
    TriggerServerCallback("GetAllLabo",function(labo,uuid)
        --print(uuid,uuid)
        Labos = labo
        PlyUUID = uuid
        Format()
    end)

end)

local workers = {
    {
        label = "Ouvrier",
        ped = "mp_f_cocaine_01",
        energie = 0.6,
        vitesse = 0.5,
        variation = {
            {k=math.random(0,6),v=math.random(0,3)},
            {k=0,v=0},
            {k=math.random(0,3),v=math.random(0,1)},
            {k=math.random(0,3),v=math.random(0,1)},
            {k=math.random(0,3),v=math.random(0,3)},
            {k=0,v=0},
            {k=math.random(0,3),v=0},
            {k=0,v=0},
            {k=0,v=0},
            {k=0,v=0},
            {k=0,v=0},
        },
        price = 8500,
        specialities = {"mp_specitem_coke"}
    },
    {
        label = "Scientifique",
        ped = "s_m_m_scientist_01",
        energie = 0.9,
        vitesse = 1.0,
        variation = {
            {k=math.random(0,3),v=math.random(0,2)}, -- 0
            {k=math.random(0,0),v=math.random(0,2)}, -- 1
            {k=math.random(0,0),v=math.random(0,0)}, -- 2
            {k=math.random(0,1),v=math.random(0,1)}, -- 3
            {k=math.random(0,1),v=math.random(0,3)}, -- 4
            {k==math.random(0,0),v=math.random(0,0)}, -- 5
            {k=math.random(0,0),v=math.random(0,0)}, -- 6
            {k=math.random(0,0),v=math.random(0,0)}, -- 7
            {k=math.random(0,2),v=math.random(0,1)}, -- 8
            {k=math.random(0,1),v=math.random(0,1)}, -- 9
            {k=math.random(0,0),v=math.random(0,2)}, -- 10
            {k=math.random(0,1),v=math.random(0,4)}, -- 11
        },
        price = 25000,
        specialities = {"mp_specitem_coke","mp_specitem_meth","mp_specitem_weed"}
    },
}
local function displayCamPed()
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 2)
    SetCamCoord(cam,0,0,900.0)
    SetCamRot(cam, -200.0,-180.0,90.0, 1)
    SetFocusArea(0,0,9000.0,0,0,000.0,0,0,900.0)
    RenderScriptCams(1, 0, 0, 1, 1)
    createdCamera = cam
end

local prenomInd = {"Emily","Madison","Hailey","Kaitlyn","Hannah","Sarah","Brianna","Ashley","Alexis","Abigail","Emma","Samantha","Olivia","Elizabeth","Jasmine","Katherine","Jacob","Michael","Matthew","Joshua","Nicholas","Christopher","Joseph","Ethan","Andrew","Daniel","William","Anthony","Jonathan","Zachary","David"}
local function GeneratePrenom()
    local m = Random(#prenomInd)
    while m == 0 do
        m = Random(#prenomInd)
    end
    return prenomInd[m]
end

function DisplayPed(index)
    DeleteEntity(currentPed)
    currPed = workers[index]
    displayCamPed()
    currPed.name = currPed.name == nil and GeneratePrenom() or currPed.name
    RequestAndWaitModel(currPed.ped)
    local ped = CreatePed(4, currPed.ped,-3.0,-0.1,898.0, -90.0, false,false)
    local variation = currPed.variation
    for i = 1 , #variation , 1 do
        SetPedComponentVariation(ped, i-1, variation[i].k, variation[i].v, 0)
    end
    FreezeEntityPosition(ped, true)
    currentPed = ped
end
---- MENUS
local function isCoOwn(PlyUuid)
    local found = false
    if currentLabos.coowner ~= nil then
        for i = 1 , #currentLabos.coowner, 1 do
            if currentLabos.coowner[i] == PlyUuid then
                found = true
                break
            end
        end
    end
    return found
end
local old= nil
local tempOptions = {}

local offset = {
    0,120,240
}

local function Format(items)
    local _Items = {}
    for i = 1, #items, 1 do
        local p = items[i]
        if _Items[p.itemName] == nil then
            _Items[p.itemName] = {}
        end
        local data = p.metadata ~= nil and json.decode(p.metadata) or nil
        local label = data ~= nil and data.label or nil
        table.insert(_Items[p.itemName], { name = p.itemName, data = data, label = label, id = p.id })
    end
    return _Items
end
function returnTime(time,bl)
    return bl and MilliSecondsToClock(time) or SecondsToClock(time)
end
local currentPed = {}
local indexRecipe = 1

RegisterNetEvent("updateStockLabo")
AddEventHandler("updateStockLabo",function(L)
    print("xx")
    Wait(750)
    currentLabos.Storages:RefreshDB()
end)
RegisterNetEvent("UpdateLabosTime")
AddEventHandler("UpdateLabosTime",function(L)
    if currentLabos ~= nil then
        for k , v in pairs(L) do
            if currentLabos.id == k then
                currentLabos.time = v.time
            end
        end
    end
    for k ,v in pairs(L) do
        for i = 1 , #Labos , 1 do
            if k == Labos[i] then
                Labos[i] = v.time
            end
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if currPed ~= nil then
            RenderSprite("shared", "bggradient_16x512", 1200.0, 225, 370, 500, 255, 255, 255, 255)
            RenderText(currPed.label,1385.0, 230,2,0.6,255,255,255,255,"Center")

            RenderText("Energie",1208.0, 310,4,0.45,255,255,255,255)
            local Width = currPed.energie*270
            RenderSprite("timerbars", "damagebarfill_128", 1285 , 320, 270, 20, 0, 255, 255, 255, 100)
            RenderSprite("timerbars", "damagebarfill_128", 1285, 320, Width, 20, 0, 255, 255, 255, 255)

            RenderText("Vitesse",1208.0, 370,4,0.45,255,255,255,255)
            local Width = currPed.vitesse*270
            RenderSprite("timerbars", "damagebarfill_128", 1285 , 380, 270, 20, 0, 255, 255, 255, 100)
            RenderSprite("timerbars", "damagebarfill_128", 1285, 380, Width, 20, 0, 255, 255, 255, 255)


            RenderText("Spécialitées",1385.0, 430,4,0.6,255,255,255,255,"Center")
            for i = 1 , #currPed.specialities , 1 do
                local offset = offset[i]
                RenderSprite("mpinventory",currPed.specialities[i] , 1230.0+offset, 490.0, 60, 60, 0, 255, 255, 255, 255)
            end
            RenderText("Prix : ~g~" .. currPed.price .. "$ ~s~/ semaine",1385.0, 580,4,0.6,255,255,255,255,"Center")

            RenderText(currPed.name,900.0, 270,4,0.45,255,255,255,255)
        --    RenderRectangle(1200.0, 520,370, 70,255,255,255,255)
        end
        if RageUI.Visible(RMenu:Get("labos","gestion")) then
            RageUI.DrawContent({ header = false, glare = false }, function()
                RageUI.Button("Listes des travailleurs",nil,{},true,function(_,_,S)
                    
                end,RMenu:Get("labos","gestion_listNPC"))

                RageUI.Button("Production",nil,{},true,function(_,_,S)
                    if S then
                        TriggerServerCallback('rage-reborn:GetStorageItems', function(Items)
                            currentLabos.Storages.items = FormatStorage(Items)
                            
                        end, currentLabos.name.."_storage")
                    end
                end,RMenu:Get("labos","production"))
            end)
        end


        if RageUI.Visible(RMenu:Get("labos","production")) then
            RageUI.DrawContent({ header = false, glare = false }, function()
                local s = {}
                for k ,v in pairs(recipes[currentLabos.indexx]) do
                    table.insert(s,Items[k].label)
                end
                local t = {}
                for k ,v in pairs(recipes[currentLabos.indexx]) do
                    table.insert(t,k)
                end
                if currentLabos.time == nil then
                    currentLabos.time = 0
                end
                RageUI.List("Commencer la production", s,  indexRecipe, nil,{}, true, function(Hovered, Active, Selected, Index)
                    indexRecipe = Index
                    if Selected then

        
        
                        if currentLabos.time < GetGameTimer() then
                            currentLabos.time = 0 
                        end
                        print(currentLabos.time)
                        if currentLabos.time ~= 0 then
                            ShowNotification("~r~Il y a déjà une production en cours")
                        else
                            if equipementIsOK(currentLabos.indexx,t[Index]) then
                                if canStartARecipe(currentLabos.indexx,t[Index]) then
                                    currentLabos.time = (GetGameTimer() + (60 * 60000) * (recipes[currentLabos.indexx][t[Index]].time/#currentLabos.workers)/IsLaboUpgraded(currentLabos.indexx,t[Index]))
                                    local p = recipes[currentLabos.indexx][t[Index]]
                                    p.give = t[Index]
                                    startRecipe(currentLabos.indexx,t[Index])
                                    TriggerServerEvent("startLabosProd",currentLabos,p,(recipes[currentLabos.indexx][t[Index]].time/#currentLabos.workers)/IsLaboUpgraded(currentLabos.indexx,t[Index]))
                                else
                                    ShowNotification("~r~Il n'y a pas les ingrédient nécessaire")
                                end
                            else
                                ShowNotification("~r~Votre laboratoire n'est pas assez équipé")
                            end
                        end
                    end
                end)
                RageUI.Button("Arrêter la production",nil,{},true,function(_,_,S)
                    if S then
                        currentLabos.time = 0
                        TriggerServerEvent("startLabosProd",currentLabos,nil)
                    end
                end)
                
                RageUI.Button("Temps restant estimé",nil,{RightLabel=returnTime(currentLabos.time-GetGameTimer(),true)},true,function(_,_,S)
                        
                end)


                RageUI.CenterButton("~b~↓↓ ~s~Stocks ~b~↓↓", nil, {}, true, function(_, _, _)
                
                end)
                if currentLabos.Storages.items ~= nil and tablelength(currentLabos.Storages.items) > 0 then
                    for k,v in pairs(currentLabos.Storages.items) do
                        RageUI.Button(Items[k].label,nil,{RightLabel = #v},true,function(_,_,S)
                            
                        end)
                    end
                else
                    RageUI.Button("Vide",nil,{},true,function(_,_,S)
                        
                    end)
                end

            end)
        end
        if RageUI.Visible(RMenu:Get("labos","gestion_listNPC")) then
            RageUI.DrawContent({ header = false, glare = false }, function()
                for i = 1 , #currentLabos.workers , 1 do
                    RageUI.Button(currentLabos.workers[i].name,nil,{},true,function(_,_,S)
                        currentPed = currentLabos.workers[i]
                    end,RMenu:Get("labos","NPC"))
                end
            end)
        end

        if RageUI.Visible(RMenu:Get("labos","NPC")) then
            RageUI.DrawContent({ header = false, glare = false }, function()
                 RageUI.Button("~r~Virer",nil,{},true,function(_,_,S)
                     if S then
                         TriggerServerEvent("")
                     end
                 end)
                RageUI.CenterButton("~b~--~s~ Informations ~b~--",nil,{},true,function(_,_,S)
                    
                end)
                --print(currentPed.vitesse)
                RageUI.Progress("Vitesse", currentPed.vitesse*10, 10, nil, false, true, function() end)
                RageUI.Progress("Efficacité", currentPed.energie*10, 10, nil, false, true, function() end)
                RageUI.Button("Niveau",nil,{RightLabel=currentPed.level},true,function(_,_,S)
                        
                end)
                local capacities = ""

                local specialities = {
                    ["mp_specitem_coke"] = "Cocaïne ",
                    ["mp_specitem_meth"] = "Méthamphétamine",
                    ["mp_specitem_weed"] = "Cannabis"
                }

                for i = 1 , #currentPed.specialite , 1 do
                    capacities = capacities .. " | " .. specialities[currentPed.specialite[i]]
                end
                RageUI.Button("Capacitée(s)",nil,{RightLabel=capacities},true,function(_,_,S)
                        
                end)

            end)
        end

        if RageUI.Visible(RMenu:Get('labos',"main")) then
            RageUI.DrawContent({ header = false, glare = false }, function()

                if currentLabos == nil then return CloseAllMenus() end

                if isCoOwn(PlyUuid) or PlyUuid == currentLabos.owner then 
                    LabosAction()
                else
                    RageUI.Button("Sonner",nil,{},true,function(_,_,S)
                
                    end)
                end
                if PlyUuid == currentLabos.owner then
                    RageUI.Button("Ajouter propriétaire",nil,{},true,function(_,_,S)
                    end)
                end
            end)
        end

        if RageUI.Visible(RMenu:Get('labos',"workers")) then
            RageUI.DrawContent({ header = false, glare = false }, function()
                for i = 1 , #workers , 1 do
                    RageUI.Button(workers[i].label,nil,{RightLabel = workers[i].price.."$"},true,function(_,a,s)
                        if a and old ~= i then
                            old = i
                            DisplayPed(i)
                        end
                        if s and #currentLabos.workers + 1 <= #InteriorPeds[currentLabos.indexx]  then
                                RMenu:Get('labos',"workers").Closed()
                                CloseAllMenus()
                                dataonWait = {price=workers[i].price,fct=function()
                                    ShowNotification("~g~"..workers[i].name.. " à rejoint votre laboratoire")
                                    local mx = {name=workers[i].name,model=workers[i].ped,index=i,variation=workers[i].variation,level=1,vitesse=workers[i].vitesse,energie=workers[i].energie,specialite=workers[i].specialities}
                                    table.insert(currentLabos.workers,mx)
                                    TriggerServerEvent("addWorkersLabo", currentLabos.workers,currentLabos.id)
                                    Labos[currentI].workers = currentLabos.workers
                                end}           
                                TriggerEvent("payWith?")
                        end
                    end)
                end
            end)
        end
        if RageUI.Visible(RMenu:Get('labos',"options")) then
            RageUI.DrawContent({ header = false, glare = false }, function()
                DisplayCam()
                for k ,v in pairs(UpgradeList[currentLabos.indexx]) do
                    
                    RageUI.Checkbox(k .. " (" ..  v.price .."$)",nil, tableHasValue(tempOptions, v.name),{},function(Hovered,Active,Selected,Checked)


                        if Selected and not tableHasValue(tempOptions, v.name) then
                            RMenu:Get('labos',"options").Closed()
                            print("ok")
                            CloseAllMenus()
                            dataonWait = {price=v.price,fct=function()
                                Citizen.CreateThread(function()
                                    DoScreenFadeOut(1)
                                    editIPL[currentLabos.indexx].Style.Set(tempOptions)
                                    table.insert(tempOptions,v.name)
                                    RefreshInterior(editIPL[currentLabos.indexx].interiorId)
                                    DoScreenFadeIn(1000)
                                    TriggerServerEvent("EditLabosOptions",currentLabos.id,tempOptions)
                                    TriggerPlayerEvent("EditLabos",-1,currentLabos)
                                end)
                                RMenu:Get('labos',"options").Closed()

                            end,no = function()
                                RMenu:Get('labos',"options").Closed()
                            end}           
                            TriggerEvent("payWith?")
                        end
                        if Selected and tableHasValue(tempOptions, v.name) then
                            for k ,c in pairs(tempOptions) do
                                if v.name == c then
                                    tempOptions[k] = nil
                                end
                            end
                            TriggerServerEvent("EditLabosOptions",currentLabos.id,tempOptions)
                            TriggerPlayerEvent("EditLabos",-1,currentLabos)
                        end
                    end)
                end
            end)
        end
    end
end)

RegisterNetEvent("EditLabos")
AddEventHandler("EditLabos",function(t)
    for i = 1 ,#Labos , 1 do
        if Labos[i].id == t.id then
            Labos[i] = t
        end
    end
end)
function ApplyOptions()
    editIPL[currentLabos.indexx].Style.Set(currentLabos.options)
    RefreshInterior(editIPL[currentLabos.indexx].interiorId)
end
function LabosAction()
    RageUI.Button("Rentrer",nil,{},true,function(_,_,S)
        if S then
            MYPOS = currentLabos.Pos
            
            ApplyOptions()
            CloseAllMenus()
            TriggerServerEvent("instance:checkifexist",currentLabos.name)
            while Exist == false do
              Wait(1)
              print(Exist)
            end
            if Exist == nil then
              TriggerEvent('instance:create', 'labos', {property =currentLabos.name , owner = currentLabos.name})
            else
              TriggerEvent("instance:enter",{host=Exist,property = currentLabos.name, owner = currentLabos.name,type="property"})
            end
            Exist = false
            Exit3()
            
        end 
    end)
    RageUI.Button("Options",nil,{},true,function(_,_,S)
        if S then
            editIPL[currentLabos.indexx].Style.Set(currentLabos.options)
            RefreshInterior(editIPL[currentLabos.indexx].interiorId)
            tempOptions = currentLabos.options
        end
    end,RMenu:Get('labos',"options"))

    RageUI.Button("Engager ouvrier",nil,{},true,function(_,_,S)
        
    end,RMenu:Get('labos',"workers"))

end


RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)

	if instance.type == 'labos' then
		TriggerEvent('instance:enter', instance)
	end

end)
function EnterLabos()
    return EnterProperty()
end
function ExitLabos()
    return ExitProperty()
end

exports('EnterLabos', EnterLabos)
exports('ExitLabos', ExitLabos)
function Tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

local pedOn = false
local peds = {}
local function DeletePed()
    for i = 1 , #peds , 1 do
        DeleteEntity(peds[i])
    end
    animandped = {}
end
local idleAnims = {
    {dict="missheistpaletoscoresetup_setup2", anim = "cops_response_waitloop_bank_manager"},
    {dict="random@car_thief@waiting_ig_4",anim = "idle_a"},
    {dict="missmic_4premierejimwaitbef_prem",anim = "wait_idle_b"},
    {dict="anim@amb@clubhouse@mini@darts@",anim = "wait_idle"},
    {dict="random@street_race",anim = "_streetracer_wait_loop"},
    {dict="move_characters@peter@waiting",anim = "wait_a"},
    {dict="move_characters@peter@waiting",anim = "wait_b"},
    {dict="move_characters@peter@waiting",anim = "wait_c"},
    {dict="missmic_4premierejimwaitbef_prem",anim = "wait_base"}
}
function SetupPed()
    DeletePed()
    Labos[currentI].workers = currentLabos.workers

    currentLabos.workers = Labos[currentI].workers
    --print(dump(currentLabos.workers))
    for i = 1 , #currentLabos.workers , 1 do
        RequestAndWaitModel(currentLabos.workers[i].model)
        local _ped = CreatePed(4, currentLabos.workers[i].model,InteriorPeds[currentLabos.indexx][i].pos.x,InteriorPeds[currentLabos.indexx][i].pos.y,InteriorPeds[currentLabos.indexx][i].pos.z-1.0, InteriorPeds[currentLabos.indexx][i].pos.h, false, true)
        local variation = currentLabos.workers[i].variation
        for i = 1 , #variation , 1 do
            SetPedComponentVariation(_ped, i-1, variation[i].k, variation[i].v, 0)
        end
        SetPedFleeAttributes(_ped, 0, 0)
        SetPedKeepTask(_ped, true)
        SetBlockingOfNonTemporaryEvents(_ped, true)
        SetEntityInvincible(_ped, true)
        FreezeEntityPosition(_ped, true)
        animandped[_ped] = idleAnims[math.random(1,#idleAnims)]
        v = idleAnims[math.random(1,#idleAnims)]
        doAnim({v.dict,v.anim},nil,9,_ped)
        table.insert( peds, _ped )
    end
    pedOn = true
end
local function DrawText3DTest(coords, text, size)

    local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.25, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 950
    DrawRect(_x,_y+0.0675, 0.01+ factor, 0.16, 11, 11, 11, 150)
end

Citizen.CreateThread(function()
    local isControlJustPressed, getEntityCoords, drawText3D = IsControlJustPressed, GetEntityCoords, DrawText3D
    local isInputDisabled = IsInputDisabled
    Wait(2000)
    editIPL = {
        [1] = exports["bob74_ipl"]:GetBikerCocaineObject()
    }
    while true do
        Citizen.Wait(0)
        if currentLabos ~= nil then 
            local Player = LocalPlayer()
            local ped, vehicle = Player.Ped, Player:GetVehicle()
            for i = 1 , #currentLabos.workers , 1 do
                local pos = GetEntityCoords(peds[i])
                drawText3D(pos.x, pos.y, pos.z + 1.0, currentLabos.workers[i].name, 7.0)

                if IsControlPressed(0, Keys["L"]) then
                    DrawText3DTest(pos,"Statistiques\nKG Produit : ~b~14KG ~s~\nFatigue : ~b~87/100~s~\nNiveau : ~b~1\n~" ,1.0)
                end
            end
        end
    end
end)