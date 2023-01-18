local Players = {
    Identity = {},
    Vehicles = {}
}
local filterTow = nil
RMenu.Add('jobs',"tow", RageUI.CreateMenu(nil, "Joueurs disponibles",10,100,"shopui_title_carmod2","shopui_title_carmod2"))
RMenu.Add('jobs',"tow_vehicle", RageUI.CreateSubMenu(RMenu:Get('jobs',"tow"),nil, "Vehicules disponibles",10,100))
RMenu.Add('jobs',"tow_vehicle_manage", RageUI.CreateSubMenu(RMenu:Get('jobs',"tow"),nil, "Vehicles disponibles",10,100))
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('jobs',"tow")) then
            RageUI.DrawContent({ header = true, glare = false }, function()
                RageUI.Button("Rentrer véhicule",nil,{},true,function(_,_,Selected)
                    if Selected then
                        veh = GetVehiclePedIsIn(LocalPlayer().Ped)
                        TriggerServerEvent("storevehicletow",GetVehicleNumberPlateText(veh))
                        vehicleFct.DeleteVehicle(veh)
                    end
                end)
                if #Players.Identity == 0 then
                    RageUI.Button("Vide",nil,{},true,function(_,_,Selected)
                        if Selected then

                        end
                    end)
                else
                    RageUI.Button("Rechercher",nil,{RightLabel = "🔍"},true,function(_,Active,Selected)
                        if Selected then
                            filterTow = KeyboardInput("Entrez un prénom ou un nom",nil,500)
                            RageUI.Refresh()
                        end
                    end)

                    local found = false
                    for i = 1 , #Players.Identity , 1 do
                        found = false
                        local i = Players.Identity[i]
                        local f = nil
                        if filterTow == nil or string.find(i.first_name,filterTow) or string.find(i.last_name,filterTow) then
                            RageUI.Button(i.first_name .. " " .. i.last_name,nil,{},true,function(_,_,Selected)
                                if Selected then
                                    Players.SelectedUUID = i.uuid
                                end
                            end,RMenu:Get('jobs',"tow_vehicle"))    
                        end


                        
                    end
                    for c = 1 , #Players.Vehicles , 1 do
                        local _c = c 
                        local c = Players.Vehicles[c]
                        f = Jobs[c.uuid]
                        if Jobs[c.uuid] ~= nil  then
                            RageUI.Button(f.label,nil,{},true,function(_,_,Selected)
                                if Selected then
                                    Players.SelectedUUID = c.uuid
                                end
                            end,RMenu:Get('jobs',"tow_vehicle"))    
                        end
                    end


                end
            end, function()
            end)
        end

        if RageUI.Visible(RMenu:Get('jobs',"tow_vehicle")) then
            RageUI.DrawContent({ header = true, glare = false }, function()
                if #Players.Vehicles == 0 then
                    RageUI.Button("Vide",nil,{},true,function(_,_,Selected)
                        if Selected then

                        end
                    end)
                else
                    for i = 1 , #Players.Vehicles , 1 do
                        local _i = i 
                        local i = Players.Vehicles[i]
                        if i.uuid == Players.SelectedUUID then
                            local RightLabel
                           
                            if i.pound then
                                RightLabel = "~HUD_COLOUR_TECH_RED~<C>En fourrière</C>"
                            else
                                RightLabel = "~HUD_COLOUR_DARTS~En garage / Sortie"
                            end
                            RageUI.Button( i.label   ,nil,{RightLabel=RightLabel},true,function(_,_,Selected)
                                if Selected then
                                    if i.pound then 
                                        TriggerServerEvent("vehicle:UnTowVehicle",i.id)
                                        local vehicleData = json.decode(i.settings)
                                        local coords = LocalPlayer().Pos
                                        local heading = GetEntityHeading(LocalPlayer().Ped)
                                        
                                        vehicleFct.SpawnVehicle(vehicleData.model, coords,heading, function(_veh)						
                                            SetPedIntoVehicle(LocalPlayer().Ped,_veh,-1)
                                            vehicleFct.SetVehicleProperties(_veh,vehicleData)
                                            TriggerEvent('persistent-vehicles/register-vehicle', _veh)
                                            currentveh = veh
                                        end)
                                        i.pound = false

                                        
                                    end
                                    

                                end
                            end,RMenu:Get('jobs',"tow"))
                        end
                    end
                end
            end, function()
            end)
        end
    end
end)
function OpenTow()
    TriggerServerCallback('core:GetAllIdentityPlayers', function(Data,_Data)
        Players.Identity  = _Data
        Players.Vehicles = Data
    end)
	RageUI.Visible(RMenu:Get('jobs',"tow"),true)
end