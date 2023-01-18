RMenu.Add("darknet", "main", RageUI.CreateMenu("Darknet", "Actions disponibles", 10, 100, nil, nil, 99, 14, 78, 1.0))

RMenu.Add("darknet","canal",RageUI.CreateSubMenu(RMenu:Get("darknet", "main"), "Darknet", "Canaux disponibles", 10, 100))
RMenu.Add("darknet","settings",RageUI.CreateSubMenu(RMenu:Get("darknet", "main"), "Darknet", "Paramètres disponibles", 10, 100))


--msg
RMenu.Add("darknet","message",RageUI.CreateSubMenu(RMenu:Get("darknet", "main"), "Darknet", "Actions disponibles", 10, 100))
RMenu.Add("darknet","send_message",RageUI.CreateSubMenu(RMenu:Get("darknet", "message"), "Darknet", "Rédigez votre message", 10, 100))
RMenu.Add("darknet","list_message",RageUI.CreateSubMenu(RMenu:Get("darknet", "message"), "Darknet", "Messages disponibles", 10, 100))

--canal
RMenu.Add("darknet","canal",RageUI.CreateSubMenu(RMenu:Get("darknet", "main"), "Darknet", "Canaux disponibles", 10, 100))
RMenu.Add("darknet","channel",RageUI.CreateSubMenu(RMenu:Get("darknet", "canal"), "Darknet", "Messages disponibles", 10, 100))

RMenu:Get("darknet", "main").Closed = function()
    ClearPedTasks(GetPlayerPed(-1))
end
local oldddS = nil
local currentDarknet = {}
local channels = {}
function generateRandomUsername()
    local wordlist = j("words")  
            
    local random = Random(#wordlist)
    if random == 0 then random = 1 end
    local mot = firstToUpper(wordlist[random][1])
    local randomN = Random(999)
    local concat = mot..randomN

    Inventory.SelectedItem.label = concat
    Inventory.SelectedItem.data = {}
    Inventory.SelectedItem.data.username = concat

    ShowNotification("~g~Le nom d'utilisateur de ce boitier darknet est ~b~" ..concat)
end
local function Refresh()
    TriggerServerCallback("getDarknetInfos",function(result,_channels)
        currentDarknet = result
        currentDarknet.messages = {}
        currentDarknet.index = 1
        for i = 1 , #currentDarknet , 1 do
            table.insert(currentDarknet.messages,currentDarknet[i].id)
        end
        channels = _channels
    end,Inventory.SelectedItem.data.username)
end
local function Refresh2()
    currentDarknet.messages = {}

    for i = 1 , #currentDarknet , 1 do
        table.insert(currentDarknet.messages,currentDarknet[i].id)
    end
    currentDarknet.index = oldddS - 1
end
function OpenDarkNet(item)
    local f = false
    if item.data.password ~= nil then
        local n = tostring(KeyboardInput("Code ?",nil,4))

        if n ~= nil then
            if n == item.data.password then
                f = true
            end
        end
    else
        f = true
    end
    CloseAllMenus()
    if f then
        Citizen.CreateThread(function()
            Refresh()
            Wait(300)
            RageUI.Visible(RMenu:Get("darknet", "main"),true)
            TriggerServerEvent("darknet:ActiveMy",Inventory.SelectedItem.data.username)
        end)
    else
        ShowNotification("~r~Mauvais mot de passe !")
    end
end



-- ANIM

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if RageUI.Visible(RMenu:Get("darknet", "main")) then
            PhonePlayText() 
        end
    end
end)

local function Delete(id)
    for i = 1 , #currentDarknet , 1 do
        if currentDarknet[i].id == id then
            currentDarknet[i] = nil
        end
    end

end



local selectedmsg = {}
local oldI = nil
local sendingmsg = {}
local currentChannel = {}
local currentChannelname = nil

RegisterNetEvent("requestSyncDarknet")
AddEventHandler("requestSyncDarknet",function(msg)
    currentChannel = msg
end)
--- MENU
Citizen.CreateThread(function()
    while true do
        Wait(1)
        -- messages

        if RageUI.Visible(RMenu:Get("darknet", "list_message")) then
            RageUI.DrawContent({header = true, glare = false},function()

                if currentDarknet.messages[currentDarknet.index] then
                    RageUI.List("Message",currentDarknet.messages,currentDarknet.index,nil,{RightLabel = "→→"},true,function(_, Active, Selected, Index)
                        if Active and oldI ~= Index then
                            oldI = Index
                            currentDarknet.index = Index

                            for i = 1 , #currentDarknet, 1 do
                                if currentDarknet[i].id == currentDarknet.messages[Index] then
                                    selectedmsg = currentDarknet[i]
                                end
                            end
                        end
                    end)
                    if selectedmsg.src ~= nil then
                        RageUI.Button("@"..selectedmsg.src .. "   ➡➡➡",nil,{RightLabel="@"..selectedmsg.dest},true,function(_,_,S)end)


                        RageUI.Button(selectedmsg.content,nil,{RightLabel = "→→"},true,function(_,_,S)
                        
                        end)

                        RageUI.CenterButton("~b~"..selectedmsg.date,nil,{RightLabel = "→→"},true,function(_,_,S)
                        
                        end)

                        RageUI.CenterButton("⚠️ ~r~Supprimer",nil,{RightLabel = "→→"},true,function(_,_,S)
                            if S then
                                TriggerServerEvent("darknet:DeleteMessage",selectedmsg.id)
                                selectedmsg = {}
                                oldddS = currentDarknet.index
                                oldI = nil
                                Delete(selectedmsg.id)
                                Refresh2()
                            end
                        end)
                    end
                else
                    RageUI.Button("Vide",nil,{},true,function(_,_,S)
                        
                    end)
                end
            end)
        end

        if RageUI.Visible(RMenu:Get("darknet", "send_message")) then
            RageUI.DrawContent({header = true, glare = false},function()
                RageUI.Button("Destinataire",nil,{RightLabel=sendingmsg.dst},true,function(_,_,S)
                    if S then
                        local msg = tostring(KeyboardInput("Destinataire",nil,100))

                        if msg ~= nil and #msg ~= 0 then
                            sendingmsg.dst = msg
                        end
                    end
                end)

                RageUI.Button("Message",nil,{RightLabel=sendingmsg.msg},true,function(_,_,S)
                    if S then
                        local msg = tostring(KeyboardInput("Entrez votre message",nil,100))

                        if msg ~= nil and #msg ~= 0 then
                            sendingmsg.msg = msg
                        end
                    end
                end)


                RageUI.Button("Envoyer",nil,{RightLabel = "→→"},true,function(_,_,S)
                    if S then
                        if sendingmsg.msg ~= nil and sendingmsg.dst ~= nil then
                            sendingmsg.src = Inventory.SelectedItem.data.username
                            TriggerServerEvent("darknet:SendMessage",sendingmsg)
                            sendingmsg = {}
                            ShowNotification("~g~Message envoyé")
                        else
                            ShowNotification("~r~Vous n'avez pas remplis tout les champs")
                        end
                    end
                end)
            end)
        end
        if RageUI.Visible(RMenu:Get("darknet", "message")) then
            RageUI.DrawContent({header = true, glare = false},function()
                RageUI.Button('Envoyer un message',nil,{RightLabel = "→→"},true,function(_,_,S)
                    if S then
                        sendingmsg = {}
                    end
                end,RMenu:Get("darknet", "send_message"))

                RageUI.Button('Boite de réception',nil,{RightLabel = "→→"},true,function(_,_,S)
                    if S then
                        Refresh()
                    end
                end,RMenu:Get("darknet", "list_message"))


                RageUI.Button('⚠️ Vider la boite de réception',nil,{RightLabel = "→→"},true,function(_,_,S)
                    if S then
                        local yes = KeyboardInput("Êtes-vous sûr ?","Oui",20)

                        if yes ~= nil and yes == "Oui" then
                            Inventory.SelectedItem.data.messages = {}

                            TriggerServerEvent("darknet:WipeMsg",Inventory.SelectedItem.data.username)
                        end
                    end
                end)
            end)
        end

        -- canal

        if RageUI.Visible(RMenu:Get("darknet", "canal")) then
            RageUI.DrawContent({header = true, glare = false},function()
                for k , v in pairs(channels) do
                    RageUI.Button('#'..k,nil,{RightLabel = "→→"},true,function(_,_,S)
                        if S then
                            currentChannel = v
                            currentChannelname = k
                            TriggerServerEvent("darknet:join",k)
                            RMenu:Get("darknet", "channel").Closed = function()
                                TriggerServerEvent("darknet:left",k)
                            end
                            RageUI.Refresh()
                        end
                    end,RMenu:Get("darknet", "channel"))
                end
            end)
        end

        if RageUI.Visible(RMenu:Get("darknet", "channel")) then
            RageUI.DrawContent({header = true, glare = false},function()
                RageUI.Button('Envoyer un message',nil,{RightLabel = "→→"},true,function(_,_,S)
                    if S then
                        local msg = tostring(KeyboardInput("Entrez votre message",nil,100))

                        if msg ~= nil and #msg ~= 0 and msg ~= "nil" then
                            TriggerServerEvent("darknet:AddMessageChan",{msg=msg,channel=currentChannelname,src=Inventory.SelectedItem.data.username})
                        end
                    end
                end)

                for i = #currentChannel , 1  , -1 do
                    RageUI.Button("@"..currentChannel[i].src,currentChannel[i].msg,{RightLabel=currentChannel[i].date},true,function(_,_,S)

                    end)
                end
            end)
        end


        if RageUI.Visible(RMenu:Get("darknet", "settings")) then
            RageUI.DrawContent({header = true, glare = false},function()
                RageUI.Button('Réinitialiser le boitier',nil,{RightLabel = "→→"},true,function(_,_,S)
                    if S then
                        CloseAllMenus()
                        Inventory.SelectedItem.label = nil
                        Inventory.SelectedItem.data = nil
                        TriggerServerEvent("darknet:WipeMsg",Inventory.SelectedItem.data.username)
                        ShowNotification("~g~Boitier Réinitialisé")
                    end
                end)

                if Inventory.SelectedItem.data.password == nil then
                    RageUI.Button('Définir un mot de passe',nil,{RightLabel = "→→"},true,function(_,_,S)
                        if S then
                            local num = tostring(KeyboardInput("Code (4 chiffres)",nil,4))
                            if num ~= nil and #num == 4 then
                                Inventory.SelectedItem.data.password = num
                                ShowNotification("~g~Mot de passe définis")
                            end
                        end
                    end)
                else
                    RageUI.Button('Changer le mot de passe',nil,{RightLabel = "→→"},true,function(_,_,S)
                        if S then
                            local num = tostring(KeyboardInput("Code (4 chiffres)",nil,4))
                            if num ~= nil and #num == 4 then
                                Inventory.SelectedItem.data.password = num
                                ShowNotification("~g~Mot de passe changé")
                            end
                        end
                    end)
                end
            end)
        end
        -- main
        if RageUI.Visible(RMenu:Get("darknet", "main")) then
            RageUI.DrawContent({header = true, glare = false},function()
                RageUI.Button('Messages',nil,{RightLabel = "→→"},true,function(_,_,S)
                    if S then
                        Refresh()   
                    end
                end,RMenu:Get("darknet", "message"))

                RageUI.Button('Canaux',nil,{RightLabel = "→→"},true,function(_,_,S)
                    if S then
                        
                    end
                end,RMenu:Get("darknet", "canal"))

                RageUI.Button('Paramètre du boitier',nil,{RightLabel = "→→"},true,function(_,_,S)
                     if S then
                        
                     end
                end,RMenu:Get("darknet", "settings"))
            end)
        end
    end
end)


-- ANIM

--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================

local myPedId = nil

local phoneProp = 0
local phoneModel = "prop_amb_phone"
-- OR "prop_npc_phone"
-- OR "prop_npc_phone_02"
-- OR "prop_cs_phone_01"

local currentStatus = "out"
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false

local ANIMS = {
    ["cellphone@"] = {
        ["out"] = {
            ["text"] = "cellphone_text_in",
            ["call"] = "cellphone_call_listen_base"
        },
        ["text"] = {
            ["out"] = "cellphone_text_out",
            ["text"] = "cellphone_text_in",
            ["call"] = "cellphone_text_to_call"
        },
        ["call"] = {
            ["out"] = "cellphone_call_out",
            ["text"] = "cellphone_call_to_text",
            ["call"] = "cellphone_text_to_call"
        }
    },
    ["anim@cellphone@in_car@ps"] = {
        ["out"] = {
            ["text"] = "cellphone_text_in",
            ["call"] = "cellphone_call_in"
        },
        ["text"] = {
            ["out"] = "cellphone_text_out",
            ["text"] = "cellphone_text_in",
            ["call"] = "cellphone_text_to_call"
        },
        ["call"] = {
            ["out"] = "cellphone_horizontal_exit",
            ["text"] = "cellphone_call_to_text",
            ["call"] = "cellphone_text_to_call"
        }
    }
}

function newPhoneProp()
    deletePhone()
    RequestModel(phoneModel)
    while not HasModelLoaded(phoneModel) do
        Citizen.Wait(1)
    end
    phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)
    local bone = GetPedBoneIndex(myPedId, 28422)
    AttachEntityToEntity(phoneProp, myPedId, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

function deletePhone()
    if phoneProp ~= 0 then
        Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(phoneProp))
        phoneProp = 0
    end
end

--[[
	out || text || Call ||
--]]
function PhonePlayAnim(status, freeze, force)
    if currentStatus == status and force ~= true then
        return
    end

    myPedId = PlayerPedId()
    local freeze = freeze or false

    local dict = "cellphone@"
    if IsPedInAnyVehicle(myPedId, false) then
        dict = "anim@cellphone@in_car@ps"
    end
    loadAnimDict(dict)

    local anim = ANIMS[dict][currentStatus][status]
    if currentStatus ~= "out" then
        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
    end
    local flag = 50
    if freeze == true then
        flag = 14
    end
    TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

    if status ~= "out" and currentStatus == "out" then
        Citizen.Wait(380)
        newPhoneProp()
    end

    lastDict = dict
    lastAnim = anim
    lastIsFreeze = freeze
    currentStatus = status

    if status == "out" then
        Citizen.Wait(180)
        deletePhone()
        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
    end
end

function PhonePlayOut()
    PhonePlayAnim("out")
end

function PhonePlayText()
    PhonePlayAnim("text")
end

function PhonePlayCall(freeze)
    PhonePlayAnim("call", freeze)
end

function PhonePlayIn()
    if currentStatus == "out" then
        PhonePlayText()
    end
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
end

-- Citizen.CreateThread(function ()
-- 	Citizen.Wait(200)
-- 	PhonePlayCall()
-- 	Citizen.Wait(2000)
-- 	PhonePlayOut()
-- 	Citizen.Wait(2000)

-- 	PhonePlayText()
-- 	Citizen.Wait(2000)
-- 	PhonePlayCall()
-- 	Citizen.Wait(2000)
-- 	PhonePlayOut()
-- end)
