local MenusJob = {}
RegisterCommand('+jobM', function()
    --RageUI.Visible(RMenu:Get('jobs',tab.menu.name),true)
end, false)
RegisterCommand('-jobM', function()
    --RageUI.Visible(RMenu:Get('jobs',tab.menu.name),true)
end, false)
RegisterCommand('jobM', function()
   -- RageUI.Visible(RMenu:Get('jobs',tab.menu.name),true)
end, false)


function LoadJobMenu( tab )
    RMenu.Add('jobs',tab.menu.name, RageUI.CreateMenu(tab.menu.title, tab.menu.subtitle, 10, 100, nil, nil, 99, 14, 78, 1.0))
    if tab.submenus ~= nil then
        for k , v in pairs(tab.submenus) do
            RMenu.Add('jobs',k, RageUI.CreateSubMenu(RMenu:Get('jobs',v.submenu),v.title, v.subtitle,10,100))
            table.insert(MenusJob,{menu=RMenu:Get('jobs',k),data=v.menus})
        end
    end
    RegisterCommand('+jobM', function()
        RageUI.Visible(RMenu:Get('jobs',tab.menu.name),true)
    end, false)
    RegisterCommand('-jobM', function()
        RageUI.Visible(RMenu:Get('jobs',tab.menu.name),true)
    end, false)
    RegisterCommand('jobM', function()
        RageUI.Visible(RMenu:Get('jobs',tab.menu.name),true)
    end, false)
    RegisterKeyMapping('jobM', 'Menu ' .. tab.menu.title, 'keyboard', 'F6')
    table.insert(MenusJob,{menu=RMenu:Get('jobs',tab.menu.name),data=tab})
end



local curMenu = nil

Citizen.CreateThread(function()
    while true do
        Wait(1)
        for i = 1 , #MenusJob ,1 do
            if RageUI.Visible(MenusJob[i].menu) then
                curMenu = MenusJob[i].menu
                RageUI.DrawContent({ header = true, glare = true }, function()
                    if MenusJob[i].data.submenus ~= nil then
                        for k ,v in pairs(MenusJob[i].data.submenus) do
                            RageUI.Button(k,nil,{},true,function(_,_,Selected)
                                if Selected then
                            --        Players.SelectedUUID = i.uuid
                                end
                            end,RMenu:Get('jobs',k))
                        end
                    end
                        for _ ,v in pairs(MenusJob[i].data.buttons) do
                            RageUI.Button(v.label,v.desc,{},true,function(_,Active,Selected)
                                if Selected then
                                    v.onSelected()
                                end
                                if Active then
                                    if v.ActiveFct ~= nil then
                                        v.ActiveFct()
                                    end
                                end
                            end)

                        end
                    
                end, function()
                end)
            end
        end
    end
end)



local MenusOrga = {}

function LoadOrgaMenu( tab )
    --print("ooo")
    print(tab.menu.name)
    RMenu.Add('Orga',tab.menu.name, RageUI.CreateMenu(tab.menu.title, tab.menu.subtitle,10,100))
    if tab.submenus ~= nil then
        for k , v in pairs(tab.submenus) do
            RMenu.Add('Orga',k, RageUI.CreateSubMenu(RMenu:Get('Orga',v.submenu),v.title, v.subtitle,10,100))
            table.insert(MenusOrga,{menu=RMenu:Get('Orga',k),data=v.menus})
        end
    end
    KeySettings:Add("keyboard","F7",function() RageUI.Visible(RMenu:Get('Orga',tab.menu.name),true) end,tab.menu.name)

    table.insert(MenusOrga,{menu=RMenu:Get('Orga',tab.menu.name),data=tab})
end

local curMenu = nil

Citizen.CreateThread(function()
    while true do
        Wait(1)
        for i = 1 , #MenusOrga ,1 do
            if RageUI.Visible(MenusOrga[i].menu) then
                curMenu = MenusOrga[i].menu
                RageUI.DrawContent({ header = true, glare = true }, function()
                    if MenusOrga[i].data.submenus ~= nil then
                        for k ,v in pairs(MenusOrga[i].data.submenus) do
                            RageUI.Button(k,nil,{},true,function(_,_,Selected)
                                if Selected then
                            --        Players.SelectedUUID = i.uuid
                                end
                            end,RMenu:Get('Orga',k))
                        end
                    end
                        for _ ,v in pairs(MenusOrga[i].data.buttons) do
                            RageUI.Button(v.label,v.desc,{},true,function(_,Active,Selected)
                                if Selected then
                                    v.onSelected()
                                end
                                if Active then
                                    if v.ActiveFct ~= nil then
                                        v.ActiveFct()
                                    end
                                end
                            end)

                        end
                    
                end, function()
                end)
            end
        end
    end
end)


function ClosecurretnJobMenu()
    RageUI.Visible(curMenu,false)
end


local accounts=  {}
local filteracc = nil
function LoadCustomMenu(k)
    if k == "gouv" then
        RMenu.Add('jobs',"gouvmain", RageUI.CreateMenu("Gouvernement", "Actions disponibles",10,100))
        RMenu.Add('jobs',"gouvaccounts", RageUI.CreateSubMenu(RMenu:Get('jobs',"gouvmain"),"Gouvernement","Comptes disponibles"))
        KeySettings:Add("keyboard","F6",function() RageUI.Visible(RMenu:Get('jobs',"gouvmain"),true) end,"gouv_menu")
    end
end
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('jobs',"gouvmain")) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Consulter comptes",nil,{},true,function(_,Active,Selected)
                    if Selected then
                        TriggerServerCallback("getAllBanks",function(result)
                            --(dump(result))
                            accounts = result
                        end)
                    end
                end,RMenu:Get('jobs',"gouvaccounts"))
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('jobs',"gouvaccounts")) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Rechercher",nil,{RightLabel = "🔍"},true,function(_,Active,Selected)
                    if Selected then
                        filteracc = KeyboardInput("Entrez un nom de compte",nil,500)
                    end
                end)
                for i  = 1 , #accounts , 1 do
                    if filteracc == nil or string.find(accounts[i].label,filteracc) then
                        RageUI.Button(accounts[i].label,accounts[i].iban,{RightLabel = accounts[i].amount .."$" },true,function(_,Active,Selected)

                        end)
                    end
                end
            end, function()
            end)
        end
    end
end)
