local Config = {}
function j(d)
    return json.decode(LoadResourceFile("aCore", "statics/data/" .. d .. ".json"))
end

local IndexName = {}

RegisterNetEvent("esx_addons_gcphone:call")
AddEventHandler(
    "esx_addons_gcphone:call",
    function(data)
        --(dump(data))
        x, y, z = table.unpack(GetEntityCoords(LocalPlayer().Ped))
        pos = {x = x, y = y, z = z}
        local message = nil
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 200)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0)
            Wait(0)
        end
        if (GetOnscreenKeyboardResult()) then
            message = GetOnscreenKeyboardResult()
        end
        TriggerServerEvent("call:makeCall", data.number, pos, message)
    end
)

Config.TatooCat = {
    {name = "Catégorie courses", value = "mpairraces_overlays"},
    {name = "Catégorie buisness", value = "mpbusiness_overlays"},
    {name = "Catégorie hipster", value = "mphipster_overlays"},
    {name = "Catégorie multijoueur", value = "multiplayer_overlays"},
    {name = "Catégorie noël", value = "mpchristmas2_overlays"},
    {name = "Catégorie luxe", value = "mpluxe_overlays"},
    {name = "Catégorie luxe 2", value = "mpluxe2_overlays"},
    {name = "Catégorie lowrider ", value = "mplowrider_overlays"},
    {name = "Catégorie lowrider 2", value = "mplowrider2_overlays"},
    {name = "Catégorie stunt", value = "mpstunt_overlays"},
    {name = "Catégorie biker", value = "mpbiker_overlays"},
    {name = "Catégorie plage", value = "mpbeach_overlays"},
    {name = "Catégorie contrebandier", value = "mpsmuggler_overlays"},
    {name = "Catégorie import-export", value = "mpimportexport_overlays"},
    {name = "Catégorie spéciaux", value = "mpgunrunning_overlays"}
}

local Pos = {
    --{x=1322.645,y=-1651.976,z=52.275},
    {x = -1153.676, y = -1425.68, z = 4.954},
    {x = 322.139, y = 180.467, z = 103.587},
    --{x=-3170.071,y=1075.059,z=20.829},
    {x=1864.633,y=3747.738,z=33.032}
    --{x=-293.713,y=6200.04,z=31.487}  -- Paleto Bay
}
local index = {}
local zone = false
currentTattoos = {}
local function Open()
    local Clothes = {}
    if isMale() then
        Clothes = GetNuMale()
    else
        Clothes = GetNuFemale()
    end
    UpdateEntityOutfit(LocalPlayer().Ped, Clothes)
    RageUI.Visible(RMenu:Get("tatoo", "main"), true)
end

local function Enter()
    zone = true
-- Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le catalogue")
-- KeySettings:Add("keyboard","E",Open,"Tattoo")
-- KeySettings:Add("controller",46,Open,"Tattoo")
end
local function Exit()
    zone = false
    -- Hint:RemoveAll()
    -- if RageUI.Visible(RMenu:Get('shops', CurrentZone)) then
    --     RageUI.Visible(RMenu:Get('shops', CurrentZone),not RageUI.Visible(RMenu:Get('shops', CurrentZone)))
    -- end
    -- KeySettings:Clear("keyboard","E","Tattoo")
    -- KeySettings:Clear("controller",46,"Tattoo")
end

Citizen.CreateThread(
    function()
        for i = 1, #Pos, 1 do
            v = Pos[i]
            local blip = AddBlipForCoord(v.x, v.y, v.z)
            SetBlipSprite(blip, 75)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, 59)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Salon de tatouage")
            EndTextCommandSetBlipName(blip)
        end
        -- while true do
        --     Wait(2)
        --     if RageUI.Visible(RMenu:Get("tatoo","main")) and zone then
        --         RageUI.DrawContent({ header = true, glare = false }, function()
        --             for i = 1 ,#Config.TatooCat,1 do
        --                 RageUI.Button(Config.TatooCat[i].name,nil,{},true,function(_,_,Selected)
        --                     if Selected then
        --                         index = j(Config.TatooCat[i].value)
        --                         indexName = Config.TatooCat[i].value
        --                     end
        --                 end,RMenu:Get("tatoo","category"))
        --             end
        --         end, function()
        --         end)
        --     end
        --     if RageUI.Visible(RMenu:Get("tatoo","category")) and zone then
        --         RageUI.DrawContent({ header = true, glare = false }, function()
        --             for i = 1 , #index , 1 do
        --                 local label = nil
        --                 label = GetLabelText(index[i].Name)
        --                 if label == "NULL" then
        --                     label = "Tatouage "..i
        --                 end
        --                 RageUI.Button(label,nil,{RightLabel=translate[index[i].Zone] .. 5000 .. "$"},true,function(_,Active,Selected)
        --                     if Active then

        --                         drawTattoo(index[i].HashNameMale,indexName)
        --                     end
        --                     if Selected then
        --                         local canBuy = Money:CanBuy(5000)
        --                         if canBuy then
        --                             table.insert(currentTattoos,{hash=index[i].HashNameMale,dict=indexName})
        --                             TriggerServerEvent("tatoo:add",currentTattoos)
        --                             TriggerServerEvent("money:Pay", 5000 )
        --                         end
        --                     end
        --                 end)
        --             end
        --         end, function()
        --         end)
        --     end
        -- end
    end
)

function cleanPlayer()
    ClearPedDecorations(PlayerPedId())

    for i = 1, #currentTattoos, 1 do
        if currentTattoos[i] ~= nil then
            ApplyPedOverlay(PlayerPedId(), currentTattoos[i].dict, currentTattoos[i].hash)
        end
    end
end

function drawTattoo(collection, currentHash)
    ClearPedDecorations(PlayerPedId())
    for _, k in pairs(currentTattoos) do
        ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(k.nameHash))
    end
    ApplyPedOverlay(PlayerPedId(), GetHashKey(collection), GetHashKey(currentHash))
end
