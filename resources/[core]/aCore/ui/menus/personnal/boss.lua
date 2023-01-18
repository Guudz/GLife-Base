
Boss = setmetatable({}, Boss)
local message = {}
local orgas = false
function Boss:Load()
    if orgas then
        TriggerServerCallback('mail:GetMessage', function(Data)
            message = {}
            if Data ~= nil then
                for i = 1 , #Data, 1 do
                    message[i] = Data[i]
                end
            end
        end,Orga:Get().name)
    else
        TriggerServerCallback('mail:GetMessage', function(Data)
            message = {}
            if Data ~= nil then
                for i = 1 , #Data, 1 do
                    message[i] = Data[i]
                end
            end
        end,Job:Get().name)
    end
end

local employes = {}
RegisterCommand("loadBoss", function()
    Boss:Load()
end)
function OpenBossMenu()
    if Job:IsBoss() or Job:IsCoBoss() then
        orgas = false
        RageUI.Visible(RMenu:Get('personnal', 'boss'),not RageUI.Visible(RMenu:Get('personnal', 'boss')))
    end
end

function OpenBossOrgaMenu()
    if Orga:IsBoss() or Orga:IsCoBoss() then
        orgas = true
        RageUI.Visible(RMenu:Get('personnal', 'boss'),not RageUI.Visible(RMenu:Get('personnal', 'boss')))
    end
end
local function Format(_J,_I)
    employes = {}
    for i = 1 , #_J, 1 do
        local J = _J[i]
        employes[i] = {}
        for x = 1 , #_I, 1 do
            if _J[i].uuid == _I[x].uuid then
                employes[i].job = J.name
                employes[i].rank = J.rank
                employes[i].first_name = _I[x].first_name
                employes[i].last_name = _I[x].last_name
                employes[i].uuid = _I[x].uuid
                employes[i].source = J.source
                break
            end
        end
    end
end
local function Promouvoir()
    if Jobs[CurrentEmployes.job].grade[CurrentEmployes.rank+1] ~= nil then
        CurrentEmployes.rank = CurrentEmployes.rank + 1
        if not orgas then
            TriggerServerEvent("job:UpdateJob3",Job:Get().name,CurrentEmployes.rank,CurrentEmployes.uuid)
            TriggerPlayerEvent("Jobs:SetJob2",CurrentEmployes.source,Job:Get().name,CurrentEmployes.rank)
        else
            TriggerServerEvent("orga:UpdateJob2",Orga:Get().name,CurrentEmployes.rank,CurrentEmployes.uuid)
            TriggerPlayerEvent("Orga:SetJob2",CurrentEmployes.source,Orga:Get().name,CurrentEmployes.rank)
        end
    end
end
local function Retrograder()
    if Jobs[CurrentEmployes.job].grade[CurrentEmployes.rank-1] ~= nil then
        CurrentEmployes.rank = CurrentEmployes.rank - 1
        if not orgas then
            TriggerServerEvent("job:UpdateJob3",Job:Get().name,CurrentEmployes.rank,CurrentEmployes.uuid)
            TriggerPlayerEvent("Jobs:SetJob2",CurrentEmployes.source,Job:Get().name,CurrentEmployes.rank)
        else
            TriggerServerEvent("orga:UpdateJob2",Orga:Get().name,CurrentEmployes.rank,CurrentEmployes.uuid)
            TriggerPlayerEvent("Orga:SetJob2",CurrentEmployes.source,Orga:Get().name,CurrentEmployes.rank)
        end
    end
end
RMenu.Add('personnal', "boss", RageUI.CreateMenu("Gestion entreprise", "Actions disponibles",0,10,nil,nil,215, 185, 165,1.0))
RMenu.Add('personnal', "list_employés", RageUI.CreateSubMenu(RMenu:Get('personnal', 'boss'),"Gestion entreprise", "Listes des employés",10,100))
RMenu.Add('personnal', "boss_mail", RageUI.CreateSubMenu(RMenu:Get('personnal', 'boss'),"Gestion entreprise", "Messages reçus",10,100))
RMenu.Add('personnal', "boss_mail_manage", RageUI.CreateSubMenu(RMenu:Get('personnal', 'boss_mail'),"Gestion entreprise", "Actions disponibles",10,100))

RegisterCommand('+booss', function()
    OpenBossMenu()
end, false)
RegisterCommand('-booss', function()
    OpenBossMenu()
end, false)
RegisterCommand('booss', function()
    OpenBossMenu()
end, false)
RegisterKeyMapping('booss', 'Menu patron', 'keyboard', 'F1')

RegisterCommand('+booxss', function()
    OpenBossOrgaMenu()
end, false)
RegisterCommand('-booxss', function()
    OpenBossOrgaMenu()
end, false)
RegisterCommand('booxss', function()
    OpenBossOrgaMenu()
end, false)
RegisterKeyMapping('booxss', 'Menu patron organisation', 'keyboard', 'F9')
RMenu:Get('personnal', 'list_employés'):AddInstructionButton({
    [1] = GetControlInstructionalButton(2, 314, 0),
    [2] = "Promouvoir",
})
RMenu:Get('personnal', 'list_employés'):AddInstructionButton({
    [1] = GetControlInstructionalButton(2, 315, 0),
    [2] = "Rétrograder",
})
Citizen.CreateThread(function()
    for i = 1, 255 do
        Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
    end
    while true do
        Citizen.Wait(0)
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            ClearPlayerWantedLevel(PlayerId())
        end
    end
end)
Citizen.CreateThread(function()

    while true do
        Wait(1)
        
        --for i = 
        
        if RageUI.Visible(RMenu:Get('personnal', 'boss')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                if not orgas then
                    RageUI.Button("Mes messages","Consulter les ~b~Candidatures~w~ / ~b~Mails ~w~reçus",{RightLabel = "→→"},true,function(_,_,Selected)
                        if Selected then
                            Boss:Load()
                        end
                    end,RMenu:Get('personnal', 'boss_mail'))
                end
                RageUI.Button("Recruter",nil,{RightLabel = "→→"},true,function(_,A,Selected)
                    if A then
                        HoverPlayer()
                    end
                    if Selected then
                        local player = GetPlayerServerIdInDirection(5.0)
                        if orgas then
                            TriggerServerEvent("orga:UpdateJob2",Orga:Get().name,1,player)
                            TriggerPlayerEvent("Orga:SetJob2",player,Orga:Get().name,1)
                        else
                            if player ~= false  then
                                TriggerServerEvent("job:UpdateJob2",Job:Get().name,1,player)
                                TriggerPlayerEvent("Jobs:SetJob2",player,Job:Get().name,1)
                            end
                        end
                    end
                end)

                RageUI.Button("Virer",nil,{RightLabel = "→→"},true,function(_,A,Selected)
                    if A then
                        HoverPlayer()
                    end
                    if Selected then
                        local player = GetPlayerServerIdInDirection(5.0)
                        if player ~= false then

                            if orgas then
                                TriggerServerEvent("orga:UpdateJob2","chomeur",1,player)
                                TriggerPlayerEvent("Orga:SetJob2",player,"chomeur",1)
                            else
                                if player ~= false  then
                                    TriggerServerEvent("job:UpdateJob2","chomeur",1,player)
                                    TriggerPlayerEvent("Jobs:SetJob2",player,"chomeur",1)
                                end
                            end

                        end
                    end
                end)
                if not orgas then
                    RageUI.Button("Annonces",nil,{RightLabel = "→→"},true,function(_,A,Selected)
                        if A then
                            HoverPlayer()
                        end
                        if Selected then
                            local text = KeyboardInput("Texte de l'annonce",nil,255)
                            if text ~= nil then
                                for i = 1 , #GetActivePlayers(),1 do
                                    local id = GetPlayerServerId(GetActivePlayers()[i])
                                    if orgas then
                                        TriggerPlayerEvent("RageUI:Popup",id,{message="~b~Annonce ".. Jobs[Orga:Get().name].label2 .. "\n~s~~h~"..text})
                                    else
                                        TriggerPlayerEvent("RageUI:Popup",id,{message="~b~Annonce ".. Jobs[Job:Get().name].label2 .. "\n~s~~h~"..text})
                                    end
                                end
                            --  --(dump(GetPlayerServerId(GetActivePlayers()[1])))
                            end
                        end
                    end)
                end
                RageUI.Button("Listes des employés",nil,{RightLabel = "→→"},true,function(_,A,Selected)
                    if Selected then
                        if orgas then
                            TriggerServerCallback('jobs:GetEmploy2', function(Data,_D)
                                employes.orga = Format(Data,_D)
                            end,Orga:Get().name)
                        else
                            TriggerServerCallback('jobs:GetEmploy', function(Data,_D)
                                employes.job = Format(Data,_D)
                            end,Job:Get().name)
                        end
                    end
                end,RMenu:Get('personnal', 'list_employés'))
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('personnal', 'list_employés')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                if IsControlJustPressed(0, 96) then
                    Promouvoir()
                end
                if IsControlJustPressed(0, 97) then
                    Retrograder()
                end
                for i = 1 , #employes, 1 do
                    if employes[i].last_name ~= nil then
                        RageUI.Button(employes[i].first_name .. " " .. employes[i].last_name,nil,{RightLabel = Jobs[employes[i].job].label .. " - " .. Jobs[employes[i].job].grade[employes[i].rank].label },true,function(_,A,Selected)
                            if A then
                                CurrentEmployes = employes[i]
                            end
                        end)
                    end
                end
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('personnal', 'boss_mail')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                if #message ~= 0 then
                    for i = 1 , #message,1 do
                        RageUI.Button("Message N°"..message[i].id,"Expéditeur : ~b~".. message[i].expeditor .."~s~\n" ..message[i].message ,{},true,function(_,_,Selected)
                            if Selected then
                                IndexMessage = i
                            end
                        end,RMenu:Get('personnal', 'boss_mail_manage'))
                    end
                else
                    RageUI.Button("Vide",nil,{},true,function(_,_,Selected)
                    end)
                end
            end, function()
            end)
        end

        if RageUI.Visible(RMenu:Get('personnal', 'boss_mail_manage')) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Transférer",nil,{},true,function(_,_,Selected)
                    if Selected then
                        local mailTo = KeyboardInput("Email du destinataire (50 caractère maximum !)",nil,50)
                        if tostring(mailTo) ~= nil then
                            if orgas then
                                TriggerServerEvent("mail:AddMail",mailTo,message[IndexMessage].message,Orga:Get().name)
                            else
                                TriggerServerEvent("mail:AddMail",mailTo,message[IndexMessage].message,Job:Get().name)
                            end
                        end
                        RageUI.GoBack()
                        Wait(400)
                        Boss:Load()
                        RageUI.Visible(RMenu:Get('personnal', 'boss_mail_manage'),false)
                        RageUI.Visible(RMenu:Get('personnal', 'boss'),not RageUI.Visible(RMenu:Get('personnal', 'boss')))
                    end
                end)
                RageUI.Button("Supprimer",nil,{},true,function(_,_,Selected)
                    if Selected then
                        TriggerServerEvent("mail:DeleteFromId",message[IndexMessage].id)
                        table.remove(message,IndexMessage)
                        RageUI.GoBack()
                    end
                end)
            end, function()
            end)
        end
    end
end)
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end