Citizen.CreateThread(function()
    Wait(0)
    while Job == nil or Job:Get() == nil do
      Wait(1)
    end
   -- --("ready immo")
    if Job:Get().name == "admin_drug" then
        local PosOfMarker, isMarkerEnabled,WeightOfPos,PosOfInterior,cam, numberOfHouse
        local PosInLabelAppart = 1
        local 			createdCamera  = nil
        local UpgradeList = {
          {
            -- basic
            ["Presse à cocaïne"] = {name="coke_press_basic",price=800},
            ["Production"] = {name="production_basic",price=800},
            ["Equipement"] = {name="table_equipment",price=800},
            -- ameliorer
            ["Équipement MK2"] = {name="equipment_upgrade",price=400},
            ["Presse à cocaïne MK2"] = {name="coke_press_upgrade",price=800},
            ["Production amélioré"] = {name="production_upgrade",price=800},
            ["Equipement de table amélioré"] = {name="table_equipment_upgrade",price=800},

            ["Niveau de sécurité 0"] = {name="",price=0},
            ["Niveau de sécurité moyen"] = {name="security_low",price=800},
            ["Niveau de sécurité élevé"] = {name="security_high",price=800},
          },
        }
        local AppartementList = {"Laboratoire Cocaine"}
        local CoordsCamList = {
          {
              coords={x=1086.79,y=-3199.36,z=-37.36},
              r={x=-200.0,y=-180.0,z=-130.29},
              entry ={x=1088.52,y=-3187.82,z=-39.0},
              coffre = {x=1093.59,y=-3199.09,z=-39.0}
          },
        }
        function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
            AddTextEntry("FMMC_KEY_TIP1", TextEntry)
            DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
            blockinput = true
        
            while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                Citizen.Wait(0)
            end
        
            if UpdateOnscreenKeyboard() ~= 2 then
                local result = GetOnscreenKeyboardResult()
                Citizen.Wait(500)
                blockinput = false
                return result
            else
                Citizen.Wait(500)
                blockinput = false
                return nil
            end
        end
        local price
        local oldIndex
        local priceAm 
        local CurrentIndexS
        local CurrentProperty
        local MYPOS
        local users = {}
        local usersID = {}
        local selectedPri = 0
        local selectedID = 0 
        local PosOfGarage = nil
        local selectedName = ""
        local px = true
        local nbrplace = 5
        local CurrentSonnerieSalope = nil
        RMenu.Add('immo',"main", RageUI.CreateMenu("Immobilier ", "Actions disponibles",10,100))

        RMenu.Add('immo',"put_proprio", RageUI.CreateSubMenu(RMenu:Get('immo',"main"),"Immobilier ", "Actions disponibles",10,100))
        RMenu:Get('immo',"put_proprio").Closed = function()
            PosOfMarker, isMarkerEnabled,WeightOfPos,PosOfInterior,cam, numberOfHouse  = nil
            PosInLabelAppart = 1
            createdCamera  = nil
            DestroyCam(createdCamera, 0)
            RenderScriptCams(0, 0, 1, 1, 1)
            createdCamera = 0
            ClearTimecycleModifier("scanline_cam_cheap")
            SetFocusEntity(GetPlayerPed(PlayerId()))
        end
        KeySettings:Add("keyboard","F6",function() RageUI.Visible(RMenu:Get('immo',"main"),true) end,"immo")
      --  RageUI.Visible(RMenu:Get('immo',"put_proprio"),true)
        Citizen.CreateThread(function()
            while true do
                Wait(1)
                if RageUI.Visible(RMenu:Get('immo',"main")) then
                  RageUI.DrawContent({ header = true, glare = false }, function()
                    RageUI.Button("Créer une propriété", nil, {
                      --RightLabel = "→"
                      }, true, function(Hovered, Active, Selected)

                    end,RMenu:Get('immo',"put_proprio"))
                    RageUI.Button("Facture", nil, {
                      --RightLabel = "→"
                      }, true, function(Hovered, Active, Selected)
                        if Selected then
                          CreateFacture("immo")
                        end
                        if Active then
                          HoverPlayer()
                        end
                    end)
                  end, function()
                  end)
                end
                if RageUI.Visible(RMenu:Get('immo',"put_proprio")) then
                    RageUI.DrawContent({ header = true, glare = false }, function()
                        if isMarkerEnabled then
                            DrawMarker(25, PosOfMarker.x, PosOfMarker.y, PosOfMarker.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 255, 255, 255, 100)
                            if PosOfGarage ~= nil then
                              DrawMarker(25, PosOfGarage.x, PosOfGarage.y, PosOfGarage.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0,  125, 0, 0, 100)
                            end
                          end
                          RageUI.Button("Placer une propriété", "Place l'entrée de la propriété", {
                            --RightLabel = "→"
                            }, true, function(Hovered, Active, Selected)
                              if Active then
                                coords = LocalPlayer().Pos
                                if PosOfMarker == nil then
                                  DrawMarker(25, coords.x, coords.y, coords.z-0.95, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 255, 255, 255, 100)
                                else
                                  DrawMarker(25, PosOfMarker.x, PosOfMarker.y, PosOfMarker.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 255, 255, 255, 100)
                                end
                              end
                              if Selected then
                                isMarkerEnabled = true
                                coords =  LocalPlayer().Pos
                                PosOfMarker = {x=coords.x,y=coords.y,z=coords.z-0.95}
                              end
                          end,RMenu:Get('immo',"main_second"))
                    
                          if isMarkerEnabled then
                            DrawMarker(25, PosOfMarker.x, PosOfMarker.y, PosOfMarker.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 255, 255, 255, 100)
                    
                            RageUI.Button("Capacité du coffre", nil, {
                              RightLabel = WeightOfPos
                              }, true, function(Hovered, Active, Selected)
                                if Selected then
                                  amount = KeyboardInput("Entrez la capacité du coffre", nil, 5)
                                  if tonumber(amount) ~= nil then
                                    WeightOfPos = tonumber(amount) .. "KG"
                                  end
                                end 
                            end)
                            RageUI.List("Intérieur", AppartementList, PosInLabelAppart,nil, {},true, function(Hovered, Active, Selected, Index)
                              PosInLabelAppart = Index
                              if Active and oldIndex ~= Index then
                                DestroyCam(createdCamera, 0)
                                RenderScriptCams(0, 0, 1, 1, 1)
                                createdCamera = 0
                                ClearTimecycleModifier("scanline_cam_cheap")
                                SetFocusEntity(GetPlayerPed(PlayerId()))
                                oldIndex = Index
                                m = CoordsCamList[Index]
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
                              elseif not Active then
                                DestroyCam(createdCamera, 0)
                                RenderScriptCams(0, 0, 1, 1, 1)
                                createdCamera = 0
                                ClearTimecycleModifier("scanline_cam_cheap")
                                SetFocusEntity(GetPlayerPed(PlayerId()))
                              end
                            end)
                           
                            RageUI.Button("Prix", nil, {
                              RightLabel = price
                              }, true, function(Hovered, Active, Selected)
                                if Selected then
                                  amount = KeyboardInput("Entrez le prix de la propriété", nil, 25)
                                  if tonumber(amount) ~= nil then
                                    priceAm = amount
                                    price = amount .. "$"
                    
                                  end
                                end 
                            end)

                            if price ~= nil then
                    
                              RageUI.Button("Enregistrer la propriété",nil, {
                                }, true, function(Hovered, Active, Selected)
                                  if Selected then
                                    Citizen.CreateThread(function()
                                      for i = 1 , 10 , 1 do
                                        Wait(1)
                                        RageUI.GoBack()
                                      end
                                    end)
                                    appartement = {index=PosInLabelAppart,price=priceAm,max=WeightOfPos,name="labo_"..Random(999999),entry=json.encode(PosOfMarker)}
                                    TriggerServerEvent("core:NewLabo", appartement)
                                  end 
                              end)
                            end
                        end
                    end, function()
                    end)
                end
            end
        end)
    end
end)

RegisterNetEvent("core:SyncApparts")
AddEventHandler("core:SyncApparts",function()

end)


RegisterNetEvent("core:SyncApparts2")
AddEventHandler("core:SyncApparts2",function(r)


end)