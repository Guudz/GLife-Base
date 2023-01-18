Jobs = {
    chomeur = {
        label = "Citoyen",
        grade = {
            {
                label = "",
                salary = 50
            }
        }
    },
    admin_drug = {
        label = "Admin drogue",
        grade = {
            {
                label = "",
                salary = 0
            }
        }
    },
    mecano2 = {
        label = "FlyWheels Garage",
        label2 = "FlyWheels Garage",
        grade = {
            {
                label = "CDD",
                salary = 45,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 50,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 60,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 80,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 220,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage FlyWheels Garage",
            Pos = {x = 1752.42, y = 3325.83, z = 41.16},
            Properties = {
                type = 3,
                Limit = 10,
                zonesize = 1.0,
                vehicles = {},
                spawnpos = {x = 1755.02, y = 3323.07, z = 40.22, h = 200.6}
            },
            Blipdata = {
                Pos = {x = 1752.42, y = 3325.83, z = 41.16},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "Mécano",
                subtitle = "Actions disponibles",
                name = "mecano_menuperso"
            },
            submenus = {
                ["Actions véhicule"] = {
                    submenu = "mecano_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter l'état du véhicule",
                                onSelected = function()
                                    Mecano.CheckVehicle()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Ouvrir le capot",
                                onSelected = function()
                                    Mecano.OpenTrunk()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Réparer",
                                onSelected = function()
                                    Mecano.Repair()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Nettoyer",
                                onSelected = function()
                                    Mecano.CleanVehicule()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mise en fourière",
                                onSelected = function()
                                    Mecano.Fouriere()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                }
            },
            buttons = {
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                },
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("mecano2")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        Extrapos = {
            Tow = {
                Pos = {
                    {x = 1774.9, y = 3311.02, z = 41.24}
                },
                Enter = EnterZoneTow,
                Exit = ExitZoneTow,
                zonesize = 1.5,
                Blips = {
                    sprite = 473,
                    color = 81,
                    name = "Fourrière FlyWheels Garage"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            },
            LSCustoms = {
                Pos = {
                    {x = 1767.91, y = 3330.06, z = 40.45},
                    {x = 1765.18, y = 3341.17, z = 40.14}
                },
                Enter = function()
                    EnterZoneLSC_NORD()
                end,
                Exit = function()
                    ExitZoneLSC_NORD()
                end,
                zonesize = 3.0,
                Blips = {
                    sprite = 72,
                    color = 81,
                    name = "LSCustom"
                },
                Marker = {
                    type = 23,
                    scale = {x = 4.5, y = 4.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        Storage = {
            {
                Pos = {x = 1764.37, y = 3331.98, z = 40.45},
                Limit = 100,
                Name = "coffre_mecano2"
            }
        }
    },
    coiffeur = {
        label = "Coiffeur",
        label2 = "Coiffeur",
        grade = {
            {
                label = "CDD",
                salary = 40,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 50,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 60,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 80,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 100,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = -1278.90, y = -1115.73, z = 5.99},
                Limit = 100,
                Name = "coffre_coiffeur"
            }
        },
        Menu = {
            menu = {
                title = "coiffeur",
                subtitle = "Action",
                name = "coiffeur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("coiffeur")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Coiffure",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("haircuts", "main"), true)
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil and text ~= "" then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "~s~"}
                            )
                            TriggerPlayerEvent("RageUI:Popup", -1, {message = "~h~" .. text})
                        end
                    end
                }
            }
        }
    },
    ammunation = {
        label = "Ammunation",
        label2 = "Ammunation",
        grade = {
            {
                label = "CDD",
                salary = 50,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 75,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 100,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 827.26, y = -2152.63, z = 28.61},
                Limit = 100,
                Name = "coffre_ammunation"
            }
        },
        garage = {
            Name = "Garage Ammunation",
            Pos = {x = 815.51, y = -2146.35, z = 29.36},
            Properties = {
                type = 3,
                Limit = 2,
                vehicles = {
                    {}
                },
                spawnpos = {x = 821.73, y = -2144.38, z = 28.76, h = 4.216}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Ammunation - Garage Ammunation"
            }
        },
        Extrapos = {
            CraftWeapon = {
                Pos = {
                    {x = 808.11, y = -2157.39, z = 29.61}
                },
                restricted = {2, 3, 4, 5},
                Enter = function()
                    print("ENTER")
                    EnterCraftWeaponZone()
                end,
                Exit = function()
                    print("OUT")

                    ExitCraftWeaponZone()
                end,
                zonesize = 1.5,
                Blips = {
                    sprite = 150,
                    color = 69,
                    name = "Ammunation - Confection d'armes"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.2},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        Extrablips = {
            {
                Pos = {x = 1079.79, y = -1982.99, z = 30.47},
                Blips = {
                    sprite = 478,
                    color = 43,
                    name = "Ammunation - Pièces en métal"
                }
            },
            {
                Pos = {x = -584.38, y = 5289.39, z = 69.26, a = 55.68}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
                Blips = {
                    sprite = 478,
                    Enabled = false, -- Image off
                    color = 43,
                    name = "Ammunation - Pièces en bois"
                }
            },
            {
                Pos = {x = 286.32, y = -3029.06, z = 4.69, a = 259.22}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
                Blips = {
                    sprite = 478,
                    Enabled = false, -- Image off
                    color = 43,
                    name = "Ammunation - Pièces en plastique"
                }
            }
        },
        Menu = {
            menu = {
                title = "ammunation",
                subtitle = "Action",
                name = "ammunation_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("ammunation")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Délivrer le permis port d'arme ~r~[$15.000]",
                    onSelected = function()
                        Police.PutPortWeapon()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil and text ~= "" then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "~s~"}
                            )
                            TriggerPlayerEvent("RageUI:Popup", -1, {message = "~h~" .. text})
                        end
                    end
                }
            }
        }
    },
    tatoo = {
        label = "Tatoueur",
        label2 = "Tatoueur",
        grade = {
            {
                label = "CDD",
                salary = 50,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 75,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 100,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 322.16, y = 185.76, z = 102.59},
                Limit = 100,
                Name = "coffre_tatoo"
            }
        },
        Menu = {
            menu = {
                title = "Tatoueur",
                subtitle = "Action",
                name = "tatoueur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("tatoo")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Tatouage",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("tatoo", "main"), true)
                    end
                }
            }
        }
    },
    Brasseur = {
        label = "Brasseur",
        label2 = "Brasseur",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 50,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 75,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 100,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Storage = {
            {
                Pos = {x = 1966.643, y = 4634.773, z = 40.141},
                Limit = 100,
                Name = "coffre_Brasseur"
            }
        },
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 2.5,
                Pos = {x = 1886.309, y = 4858.142, z = 44.619},
                giveitem = "houblon",
                blipcolor = 7,
                blipname = "Récolte de Houblon",
                add = "~b~+ 1 Houblon",
            },
            traitement = {
                type = "traitement",
                workSize = 2.5,
                blipcolor = 7,
                blipname = "Traitement de Houblon",
                Pos = {x = 407.70, y = 6496.10, z = 26.87},
                required = "houblon",
                giveitem = "bierre",
                add = "~b~+ 1 Bouteille de Bierre"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 5.45,
                blipname = "Vente",
                Pos = {x = 543.7697, y = 2663.2077, z =41.15},
                required = "bierre",
                RemoveItem = "bierre",
                price = math.random(10, 10),
                add = "~b~- 1 Bouteille de Bierre"
            }
    },
        garage = {
            Name = "Garage Brasseur",
            Pos = {x = 1930.040, y = 4635.708, z = 39.4565},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {
                    {
                        name = "bobcatxl",
                        label = "Voiture de service",
                        job = true,
                        tuning = {
                            modXenon = true
                        }
                    }
                },
                spawnpos = {x = 1959.882, y = 4646.546, z = 39.758}
            },
            Blipdata = {
                Pos = {x = 1930.040, y = 4635.708, z = 39.4565},
                Blipcolor = 5,
                Blipname = "Garage Brasseur"
            }
        },
        Menu = {
            menu = {
                title = "Brasseur",
                subtitle = "Action",
                name = "Brasseur_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("Brasseur")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Brasseur",
                    onSelected = function()
                        for i = 1, 10, 1 do
                            Wait(1)
                            RageUI.GoBack()
                        end
                        RageUI.Visible(RMenu:Get("Brasseur", "main"), true)
                    end
                }
            }
        }
    },
--[[   ChihuahuaHotDogs = {
        label = "ChihuahuaHotDogs",
        label2 = "ChihuahuaHotDogs",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 180,
                name = "cdd",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "ChihuahuaHotDogs",
                subtitle = "Actions disponibles",
                name = "ChihuahuaHotDogs_menuperso"
            },
            buttons = {
                 {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("ChihuahuaHotDogs")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                }
            }
        },
    },--]]
--[[    pequetruck = {
        label = "PequeTruck",
        label2 = "Pequetruck",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 50,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 75,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 100,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Peque'Truck",
                subtitle = "Actions disponibles",
                name = "pequetruck_menuperso"
            },
            buttons = {
                 {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("pequetruck")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil and text ~= "" then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage pequetruck",
            Pos = {x = 770.04, y = -321.35, z = 58.88},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = 770.04, y = -321.35, z = 58.88, h = 284.14}
            },
            Blipdata = {
                Pos = {x = 770.04, y = -321.35, z = 58.88, h = 284.14},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = 890.3, y = -291.93, z = 64.89},
                Limit = 100,
                Name = "coffre_restaurantpeque"
            }
        },
        requiredService = false,
        work = {
            traitement2 = {
                --frites
                type = "traitement",
                workSize = 1.20,
                blipcolor = 5,
                blipname = "Friteuse",
                Pos = {x = 892.57, y = -292.91, z = 65.89},
                required = "pommeterre",
                giveitem = "frites",
                noFarm = true,
                RemoveItem = "pommeterre",
                add = "~b~+ 1  Barquette de frites"
            },
            traitement = {
                --milkshack
                type = "traitement",
                workSize = 1.20,
                blipcolor = 6,
                blipname = "Traitement Milkshake",
                Pos = {x = 889.43, y = -296.76, z = 64.65},
                required = "milk",
                giveitem = "milkshack",
                RemoveItem = "milk",
                noFarm = true,
                add = "~b~+ 1  Milkshake"
            },
            traitement3 = {
                --hamburger
                type = "traitement",
                workSize = 1.20,
                blipcolor = 7,
                noFarm = true,
                blipname = "Grill Burger Poulet",
                Pos = {x = 891.73, y = -290.44, z = 64.88},
                required = {
                    {name = "bread", count = 1},
                    {name = "chicken", count = 1}
                },
                giveitem = "burger",
                RemoveItem = {
                    {name = "bread", count = 1},
                    {name = "chicken", count = 1}
                },
                add = "~b~+ 1  Hamburger poulet"
            },
            traitement5 = {
                --hamburger
                type = "traitement",
                workSize = 1.20,
                blipcolor = 8,
                noFarm = true,
                blipname = "Grill Burger Healthy",
                Pos = {x = 888.95, y = -293.52, z = 64.71},
                required = {
                    {name = "bread", count = 1},
                    {name = "meat", count = 1}
                },
                giveitem = "burgerhealthy",
                RemoveItem = {
                    {name = "bread", count = 1},
                    {name = "meat", count = 1}
                },
                add = "~b~+ 1  Hamburger Healthy"
            }
        }
    },--]]
    journaliste = {
        label = "Journaliste",
        label2 = "Journaliste",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 50,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 75,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 100,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Journaliste",
                subtitle = "Actions",
                name = "journaliste_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("journaliste")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = -580.55, y = -926.00, z = 22.87},
                Limit = 100,
                Name = "coffre_journaliste"
            },
        },
        garage = {
            Name = "Garage Journaliste",
            Pos = {x = -555.99, y = -930.37, z = 23.85},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -555.99, y = -930.37, z = 23.85, h = 267.60}
            },
            Blipdata = {
                Pos = {x = -555.99, y = -930.37, z = 23.85},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        }
    },
    avocat = {
        label = "Avocat",
        label2 = "Avocat",
        FreeAccess = false,
        grade = {
            {
                label = "Avocat",
                salary = 150,
                name = "avocat"
            }
        }
    },
    night = {
        label = "Night-Club",
        label2 = "Night-Club",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 100,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 150,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 200,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 250,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 300,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Night-Club",
                subtitle = "Actions",
                name = "night_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("night")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                }
            }
        },
        garage = {
            Name = "Garage Night-Club",
            Pos = {x = 367.85, y = 296.09, z = 102.50},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = 367.85, y = 296.09, z = 102.50, h = 353.35}
            },
            Blipdata = {
                Pos = "none"
            }
        },
        Storage = {
            {
                Pos = {x = 393.51, y = 278.76, z = 94.10},
                Limit = 100,
                Name = "coffre_NightClub"
            },
            {
                Pos = {x = 356.74, y = 282.33, z = 93.30},
                Limit = 100,
                Name = "Frigo_1"
            },
            {
                Pos = {x = 351.87, y = 288.20, z = 90.30},
                Limit = 100,
                Name = "Frigo_2"
            }
        }
    },
    distillerie = {
        label = "Distillerie",
        label2 = "Distillerie",
        FreeAccess = false,
        grade = {
            {
                label = "CDD",
                salary = 50,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 75,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 100,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Distillerie",
                subtitle = "Actions disponibles",
                name = "distillerie_menuperso"
            },
            buttons = {
                {
                    label = "Craft",
                    onSelected = function()
                        ToggleCraftMenu()
                    end
                },
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("distillerie")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                }
            }
        },
        garage = {
            Name = "Garage distillerie",
            Pos = {x = -1887.76, y = 2045.01, z = 140.86},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -1895.71, y = 2034.61, z = 141.86, h = 339.66}
            },
            Blipdata = {
                Pos = {x = -1887.76, y = 2045.01, z = 140.86},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Storage = {
            {
                Pos = {x = -1912.07, y = 2073.65, z = 139.40},
                Limit = 100,
                Name = "coffre_distillerie"
            }
        },
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 2.5,
                Pos = {x = -1812.54, y = 2206.83, z = 92.37},
                giveitem = "raisin",
                blipcolor = 7,
                blipname = "[Distillerie] Récolte de raisin",
                add = "~b~+ 1 Raisin",
            },
            recolte2 = {
                type = "recolte",
                workSize = 2.5,
                Pos = {x = -1922.77, y = 1963.893, z = 149.18},
                giveitem = "agave",
                blipcolor = 7,
                blipname = "[Distillerie] Récolte D'agave",
                add = "~b~+ 1 Agave",
            },
            recolte3 = {
                type = "recolte",
                workSize = 2.5,
                Pos = {x = -1597.12, y = 2266.27, z = 68.63},
                giveitem = "c_sucre",
                blipcolor = 7,
                blipname = "[Distillerie] Récolte de canne à sucre",
                add = "~b~+ 1 Canne a sucre",
            },
            recolte4 = {
                type = "recolte",
                workSize = 2.5,
                Pos = {x = 2151.64, y = 5167.51, z = 54.67},
                giveitem = "[Distillerie] Récolte de Levure",
                blipcolor = 7,
                blipname = "Récolte",
                add = "~b~+ 1 Levure",
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor = 7,
                blipname = "[Distillerie] Traitement raisin",
                Pos = {x = 472.59, y = 3566.54, z = 33.24},
                required = "raisin",
                giveitem = "jus_raisin",
                RemoveItem = "raisin",
                add = "~b~+ 1  Jus de raisin"
            },
            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor = 7,
                blipname = "[Distillerie] Traitement vin",
                Pos = {x = -1929.02, y = 1779.09, z = 173.07},
                required = "jus_raisin",
                giveitemType = 1,
                add = "~b~+ 1  Bouteille de vin",
                giveitem = {
                    {name = "bouteille_vin", count = 1, chanceDrop = 75},
                    {name = "grand_cru", count = 1, chanceDrop = 25}
                }
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 5.45,
                blipname = "[Distillerie] Vente",
                Pos = {x = 1677.34, y = 4882.38, z = 42.04},
                required = "jus_raisin",
                RemoveItem = "jus_raisin",
                price = math.random(125, 200),
                add = "~b~- 1 Jus de raisin"
            }
        }
    },
    raffinerie = {
        label = "Raffinerie",
        label2 = "Raffinerie",
        FreeAccess = true,
        grade = {
            {
                label = "CDD",
                salary = 50,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Raffinerie",
                subtitle = "Actions disponibles",
                name = "Raffinerie_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("raffinerie")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                }
            }
        },
        requiredService = true,
        work = {
            recolte = {
                type = "recolte",
                workSize = 2.5,
                Pos = {x = 51.48, y = 6300.37, z = 31.23},
                giveitem = "petrol_baril",
                blipcolor = 7,
                blipname = "Récolte",
                add = "~b~+ 1 Baril de Pétrole",
            },
            traitement = {
                type = "traitement",
                workSize = 5.45,
                blipcolor = 7,
                blipname = "Traitement livraison pétrole",
                Pos = {x = 433.07, y = 3575.44, z = 33.24},
                required = "petrol_baril",
                giveitem = "petrol_garbage",
                add = "~b~+ 1  déchets pétroliers"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 5.45,
                blipname = "Vente",
                Pos = {x = 1701.08, y = 4915.01, z = 42.08},
                required = "petrol_garbage",
                price = math.random(75, 100),
                add = "~b~- 1 Déchets pétroliers"
            }
        },
        garage = {
            Name = "Garage Raffinerie",
            Pos = {x = 2905.54, y = 4386.1, z = 50.28},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = 2905.54, y = 4386.1, z = 50.28, h = 291.65}
            },
            Blipdata = {
                Pos = {x = 2905.54, y = 4386.1, z = 50.28},
                Blipcolor = 5,
                Blipname = "Garage Raffinerie"
            }
        }
    },
    lssd = {
        label = "LSSD",
        label2 = "lssd",
        -- radios = {1,2},
        grade = {
            {
                label = "Recrue",
                salary = 225,
                name = "recrue"
            },
            {
                label = "Shérif adjoint",
                salary = 240,
                name = "sherifadjoint"
            },
            {
                label = "Shérif adjoint II",
                salary = 240,
                name = "sherifadjoint2"
            },
            {
                label = "Shérif adjoint III",
                salary = 240,
                name = "sherifadjoint3"
            },
            {
                label = "Sergent I",
                salary = 260,
                name = "sergent"
            },
            {
                label = "Lieutenant",
                salary = 290,
                name = "drh"
            },
            {
                label = "Shérif",
                salary = 330,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage LSSD SandyShore",
            Pos = {x = 1873.98, y = 3686.96, z = 32.59},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = 1873.98, y = 3686.96, z = 33.59, h = 197.337}
            },
            Blipdata = {
                Pos = {x = 1873.98, y = 3686.96, z = 33.59},
                Blipcolor = 5,
                Blipname = "Garage LSSD SandyShore"
            }
        },
        garage2 = {
            Name = "Garage LSSD Paleto",
            Pos = {x = -469.92, y = 6019.82, z = 30.34},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -469.92, y = 6019.82, z = 31.34, h = 294.42}
            },
            Blipdata = {
                Pos = {x = -469.92, y = 6019.82, z = 31.34},
                Blipcolor = 5,
                Blipname = "Garage LSSD Paleto"
            }
        },
        garage3 = {
            Name = "Helipad Sherif",
            Pos = {x = -475.13, y = 5988.67, z = 31.34},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "polmav",
                        label = "Helicoptere de police",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -475.13, y = 5988.67, z = 31.34, h = 315.34}
            },
            Blipdata = {
                Pos = {x = -475.13, y = 5988.67, z = 31.34},
                Blipcolor = 5,
                Blipname = "Helipad Sherif"
            }
        },
        Menu = {
            menu = {
                title = "Sherif",
                subtitle = "Actions disponibles",
                name = "police_menuperso"
            },
            submenus = {
                ["Actions citoyen"] = {
                    submenu = "police_menuperso",
                    title = "Actions citoyen",
                    menus = {
                        buttons = {
                            {
                                label = "Menotter",
                                onSelected = function()
                                    Police.HandcuffPly()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Démenotter",
                                onSelected = function()
                                    Police.CutMenottes()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Amendes",
                                onSelected = function()
                                    CreateFacture("lssd")
                                end
                            },
                            {
                                label = "Test poudre à feu",
                                onSelected = function()
                                    Police.Powder()
                                end
                            },
                            {
                                label = "Test stupéfiant",
                                onSelected = function()
                                    Police.Stup()
                                end
                            },
                            {
                                label = "Photo d'identité",
                                onSelected = function()
                                    Police.PhotoIdent()
                                end
                            },
                            {
                                label = "Mettre dans le véhicule",
                                onSelected = function()
                                    Police.PutInVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Sortir du véhicule",
                                onSelected = function()
                                    Police.SortirVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Actions traffic"] = {
                    submenu = "police_menuperso",
                    title = "Actions traffic",
                    menus = {
                        buttons = {
                            {
                                label = "Modifier la zone",
                                onSelected = function()
                                    Police.EditZone()
                                end
                            },
                            {
                                label = "Changer la vitesse de la zone",
                                desc = "0 pour que les véhicules soient immobiles",
                                onSelected = function()
                                    Police.ChangeZone()
                                end
                            },
                            {
                                label = "Supprimer la limite de vitesse",
                                onSelected = function()
                                    Police.RemoveZone()
                                end
                            },
                            {
                                label = "Afficher la zone",
                                onSelected = function()
                                end,
                                ActiveFct = function()
                                    Police.ShowZone()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Actions véhicule"] = {
                    submenu = "police_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter la plaque",
                                onSelected = function()
                                    Police.PlateCheck()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Crocheter",
                                onSelected = function()
                                    Police.Crocheter()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Immobiliser",
                                onSelected = function()
                                    Police.Immobiliser()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Désimmobiliser",
                                onSelected = function()
                                    Police.Desimmobiliser()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Informations effectifs"] = {
                    submenu = "police_menuperso",
                    title = "Effectifs",
                    menus = {
                        buttons = {
                            {
                                label = "Sherifs en service",
                                onSelected = function()
                                    TriggerServerEvent("service:showOnDuty", "lssd")
                                end
                            },
                            {
                                label = "[COOP] Agents LSPD en service",
                                onSelected = function()
                                    TriggerServerEvent("service:showOnDuty", "police")
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Action objets"] = {
                    submenu = "police_menuperso",
                    title = "Placer objets",
                    menus = {
                        buttons = {
                            {
                                label = "Mettre une herse",
                                onSelected = function()
                                    useHerse()
                                end
                            },
                            {
                                label = "Mettre un cone",
                                onSelected = function()
                                    useCone()
                                end
                            },
                            {
                                label = "Mettre une barriere",
                                onSelected = function()
                                    useBarrier()
                                end
                            },
                            {
                                label = "Supprimer herse",
                                onSelected = function()
                                    DeleteHerse()
                                end
                            },
                            {
                                label = "Supprimer un cone",
                                onSelected = function()
                                    DeleteCone()
                                end
                            },
                            {
                                label = "Supprimer une barriere",
                                onSelected = function()
                                    DeleteBarrier()
                                end
                            }
                        },
                        submenu = {}
                    }
                },
                ["Action renforts"] = {
                    submenu = "police_menuperso",
                    title = "Renforts",
                    menus = {
                        buttons = {
                            {
                                label = "Renforts",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "lssd",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~2 \n~b~Importance : ~s~Légère"
                                    )
                                end,
                                ActiveFct = function()
                                end
                            },
                            {
                                label = "Renforts ~o~important",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "lssd",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~3 \n~b~Importance : ~o~Importante"
                                    )
                                end,
                                ActiveFct = function()
                                end
                            },
                            {
                                label = "Renforts ~r~~h~urgent",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "lssd",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~99 \n~b~Importance : ~r~~h~URGENTE"
                                    )
                                end,
                                ActiveFct = function()
                                end
                            }
                        },
                        submenu = {}
                    }
                }
            },
            buttons = {
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        Storage = {
            -- SandyShore
            {
                Pos = {x = 1855.8, y = 3698.2, z = 33.21},
                Limit = 5000,
                Name = "coffre Saisies"
            },
            {
                Pos = {x = 1861.3, y = 3688.35, z = 33.26},
                Limit = 5000,
                Name = "coffre LSSD"
            },
            -- PALETO
            {
                Pos = {x = -442.06, y = 5987.68, z = 30.82},
                Limit = 5000,
                Name = "coffre Saisies"
            },
            {
                Pos = {x = -439.9, y = 5991.86, z = 30.82},
                Limit = 5000,
                Name = "coffre LSSD"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = 1859.18, y = 3695.75, z = 34.23},
                vestiaire = {
                    type = "Vestiaire",
                    workSize = 1.45,
                    Pos = {x = 1859.18, y = 3695.75, z = 34.23},
                    Tenues = TenueLSSD
                }
            }
        }
    },
    ltd = {     
        label = "Épicier",
        grade = {
            {
                label = "Employé",
                salary = 40,
                name = "employe",
                show = true                
            },
            {
                label = "Trésorier",
                salary = 40,
                name = "tresorier",
                show = true                
            },
            {
                label = "DRH",
                salary = 40,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 40,
                name = "boss",
                show = true            
            }
        },
        garage = {
            Name = "Garage épicier",
            Pos =  {x = -40.92,  y = -1747.97,  z =29.33}, 
            Properties = {
                type = 3,-- = garage self service 
                Limit = 10,
                vehicles = {
                    {name="bison",label="Voiture de service",job=true,tuning = {
                        modXenon = true
                    }},     
                },
                spawnpos = {x = -38.99,  y = -1745.07,  z =29.33,h=224.97}, 

            },
            Blipdata = {
                Pos = {x = -40.92,  y = -1747.97,  z =29.33}, 
                Blipcolor  =7,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "LTD",
                subtitle = "Actions disponibles",
                name = "LTD_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("ltd") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        Storage = {
            {
                Pos = {x=-43.38,y=-1748.37,z=28.42},
                Limit = 500,
                Name = "coffre"
            },
        },
        work = {

            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =51,
                blipname = "Déballage batteries",
                Pos = {x=2919.98,y=4298.13,z=50.91},
                required = "batterypack",
                giveitem = "battery",
                add = "~b~+ 1  Batterie"
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =51,
                blipname = "Déballage téléphones",
                Pos = {x=2919.98,y=4298.13,z=50.91},
                required = "telpack",
                giveitem = "tel",
                add = "~o~+ 1  Téléphone"
            },
        }
    },
    police = {
        label = "LSPD",
        label2 = "LSPD",
        radios = {1, 2},
        grade = {
            {
                label = "En formation",
                salary = 150,
                name = "cadet"
            },
            {
                label = "Cadet",
                salary = 160,
                name = "cadet1"
            },
            {
                label = "Officier",
                salary = 170,
                name = "officier"
            },
            {
                label = "Officier I",
                salary = 180,
                name = "officier1"
            },
            {
                label = "Officier II",
                salary = 190,
                name = "officier2"
            },
            {
                label = "Officier III",
                salary = 200,
                name = "officier3"
            },
            {
                label = "Sergent",
                salary = 210,
                name = "sergent"
            },
            {
                label = "Sergent I",
                salary = 220,
                name = "sergent1"
            },
            {
                label = "Sergent II",
                salary = 230,
                name = "sergent2"
            },
            {
                label = "Lieutenant",
                salary = 240,
                name = "sergent2"
            },
            {
                label = "Capitaine",
                salary = 250,
                name = "sergent2"
            },
            {
                label = "Major",
                salary = 260,
                name = "drh"
            },
            {
                label = "Lieutenant Colonel",
                salary = 270,
                name = "drh"
            },
            {
                label = "Inspecteur de division",
                salary = 280,
                name = "drh"
            },
            {
                label = "Patron",
                salary = 300,
                name = "boss"
            }
        },
        garage = {
            Name = "Garage police",
            Pos = {x = -1058.95, y = -850.47, z = 3.86},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -1058.95, y = -850.47, z = 3.86, h = 150.0}
            },
            Blipdata = {
                Pos = {x = -1058.95, y = -850.47, z = 3.86},
                Blipcolor = 5,
                Blipname = "Garage 1"
            }
        },
        garage2 = {
            Name = "Garage police2",
            Pos = {x = -1074.65, y = -861.32, z = 3.86},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -1074.65, y = -861.32, z = 3.86, h = 150.07}
            },
            Blipdata = {
                Pos = {x = -1074.65, y = -861.32, z = 3.86},
                Blipcolor = 5,
                Blipname = "Garage 2"
            }
        },
        garage3 = {
            Name = "Garage Helipad",
            Pos = {x = -1096.22, y = -832.17, z = 36.70},
            Properties = {
                type = 3,
                Limit = 2,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "polmav",
                        label = "Helicoptere de police",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = -1096.22, y = -832.17, z = 36.70, h = 119.17}
            },
            Blipdata = {
                Pos = {x = -1096.22, y = -832.17, z = 36.70},
                Blipcolor = 5,
                Blipname = "Helipad"
            }
        },
        Menu = {
            menu = {
                title = "Police",
                subtitle = "Actions disponibles",
                name = "police_menuperso"
            },
            submenus = {
                ["Actions citoyen"] = {
                    submenu = "police_menuperso",
                    title = "Actions citoyen",
                    menus = {
                        buttons = {
                            {
                                label = "Menotter",
                                onSelected = function()
                                    Police.HandcuffPly()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Démenotter",
                                onSelected = function()
                                    Police.CutMenottes()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Retrait points permis",
                                onSelected = function()
                                    Police.RetraitPermis()
                                end
                            },
                            {
                                label = "Amendes",
                                onSelected = function()
                                    CreateFacture("police")
                                end
                            },
                            {
                                label = "Test poudre à feu",
                                onSelected = function()
                                    Police.Powder()
                                end
                            },
                            {
                                label = "Test stupéfiant",
                                onSelected = function()
                                    Police.Stup()
                                end
                            },
                            {
                                label = "Photo d'identité",
                                onSelected = function()
                                    Police.PhotoIdent()
                                end
                            },
                            {
                                label = "Mettre dans le véhicule",
                                onSelected = function()
                                    Police.PutInVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            },
                            {
                                label = "Sortir du véhicule",
                                onSelected = function()
                                    Police.SortirVeh()
                                end,
                                ActiveFct = function()
                                    HoverPlayer()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Actions traffic"] = {
                    submenu = "police_menuperso",
                    title = "Actions traffic",
                    menus = {
                        buttons = {
                            {
                                label = "Modifier la zone",
                                onSelected = function()
                                    Police.EditZone()
                                end
                            },
                            {
                                label = "Changer la vitesse de la zone",
                                desc = "0 pour que les véhicules soient immobiles",
                                onSelected = function()
                                    Police.ChangeZone()
                                end
                            },
                            {
                                label = "Supprimer la limite de vitesse",
                                onSelected = function()
                                    Police.RemoveZone()
                                end
                            },
                            {
                                label = "Afficher la zone",
                                onSelected = function()
                                end,
                                ActiveFct = function()
                                    Police.ShowZone()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Actions véhicule"] = {
                    submenu = "police_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter la plaque",
                                onSelected = function()
                                    Police.PlateCheck()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Crocheter",
                                onSelected = function()
                                    Police.Crocheter()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Immobiliser",
                                onSelected = function()
                                    Police.Immobiliser()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Désimmobiliser",
                                onSelected = function()
                                    Police.Desimmobiliser()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Action objets"] = {
                    submenu = "police_menuperso",
                    title = "Placer objets",
                    menus = {
                        buttons = {
                            {
                                label = "Mettre une herse",
                                onSelected = function()
                                    useHerse()
                                end
                            },
                            {
                                label = "Mettre un cone",
                                onSelected = function()
                                    useCone()
                                end
                            },
                            {
                                label = "Mettre une barriere",
                                onSelected = function()
                                    useBarrier()
                                end
                            },
                            {
                                label = "Supprimer herse",
                                onSelected = function()
                                    DeleteHerse()
                                end
                            },
                            {
                                label = "Supprimer un cone",
                                onSelected = function()
                                    DeleteCone()
                                end
                            },
                            {
                                label = "Supprimer une barriere",
                                onSelected = function()
                                    DeleteBarrier()
                                end
                            }
                        },
                        submenu = {}
                    }
                },
                ["Informations effectifs"] = {
                    submenu = "police_menuperso",
                    title = "Effectifs",
                    menus = {
                        buttons = {
                            {
                                label = "Agents LSPD en service",
                                onSelected = function()
                                    TriggerServerEvent("service:showOnDuty", "police")
                                end
                            },
                            {
                                label = "[COOP] Sherifs en service",
                                onSelected = function()
                                    TriggerServerEvent("service:showOnDuty", "lssd")
                                end
                            }
                        },
                        submenus = {}
                    }
                },
                ["Action renforts"] = {
                    submenu = "police_menuperso",
                    title = "Renforts",
                    menus = {
                        buttons = {
                            {
                                label = "Renforts",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "police",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~2 \n~b~Importance : ~s~Légère"
                                    )
                                    ExecuteCommand("me Effectue une demande de renfort")
                                end,
                                ActiveFct = function()
                                end
                            },
                            {
                                label = "Renforts ~o~important",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "police",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~3 \n~b~Importance : ~o~Importante"
                                    )
                                    ExecuteCommand("me Effectue une demande de renfort")
                                end,
                                ActiveFct = function()
                                end
                            },
                            {
                                label = "Renforts ~r~~h~urgent",
                                onSelected = function()
                                    local plyCoords = GetEntityCoords(PlayerPedId())
                                    local x, y, z = table.unpack(plyCoords)
                                    TriggerServerEvent(
                                        "call:makeCall",
                                        "police",
                                        {x = x, y = y, z = z},
                                        "Besoin de renforts\n~b~Code : ~s~99 \n~b~Importance : ~r~~h~URGENTE"
                                    )
                                    ExecuteCommand("me Effectue une demande de renfort")
                                end,
                                ActiveFct = function()
                                end
                            }
                        },
                        submenu = {}
                    }
                }
            },
            buttons = {
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = -1112.80, y = -834.96, z = 33.36},
                Limit = 200,
                Name = "coffre"
            },
            {
                Pos = {x = -1084.68, y = -808.68, z = 10.03},
                Limit = 5000,
                Name = "coffre des saisies"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = -1092.78, y = -826.92, z = 25.82},
                vestiaire = {
                    type = "Vestiaire",
                    workSize = 1.45,
                    Pos = {x = -1092.78, y = -826.92, z = 25.82},
                    Tenues = TenueLSPD
                }
            }
        }
    },
    merryweather = {
        label = "Merry Weather",
        label2 = "Merry Weather",
        grade = {
            {
                label = "CDD",
                salary = 0,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 0,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 0,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 0,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 0,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Merry Weather",
            Pos = {x = 486.78, y = -3153.63, z = 5.07},
            Properties = {
                type = 3,
                Limit = 10,
                zonesize = 1.0,
                vehicles = {},
                spawnpos = {x = 486.78, y = -3153.63, z = 5.07, h = 0.11}
            },
            Blipdata = {
                Pos = {x = 486.78, y = -3153.63, z = 5.07},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "Merry Weather",
                subtitle = "Actions disponibles",
                name = "merryweather_menuperso"
            },
            buttons = {
                 {label="Craft",onSelected=function() ToggleCraftMenu() end},
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("merryweather")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                }
            }
        },
        requiredService = false,
        work = {
            recolte = {
                type = "recolte",
                workSize = 2.5,
                Pos = {x = 667.96, y = -2672.78, z = 5.08},
                giveitem = "pellicule",
                blipcolor = 7,
                blipname = "Récupérer pellicules",
                add = "~b~+ 1 Pellicule Photo",
            },
            traitement = {
                type = "traitement",
                workSize = 2.5,
                blipcolor = 7,
                blipname = "Développer la photo",
                Pos = {x = 498.72, y = -576.41, z = 24.75},
                required = "pellicule",
                giveitem = "photo",
                add = "~b~+ 1 Photo développer"
            },
            vente = {
                type = "vente",
                blipcolor = 7,
                workSize = 2.5,
                blipname = "Vente",
                Pos = {x = 70.08, y = -727.27, z = 44.22},
                required = "photo",
                price = math.random(10, 10),
                add = "~b~- 1 Photo développer"
            }
        },
        Storage = {
            {
                Pos = {x = 503.71, y = -3121.72, z = 5.07},
                Limit = 100,
                Name = "coffre_merryweather"
            },
            {
                Pos = {x = 563.74, y = -3121.59, z = 17.77},
                Limit = 100,
                Name = "coffre_merryweather2"
            }
        }
    },
    banker = {
        label = "Banquier",
        label2 = "Banquier",
        grade = {
            {
                label = "CDD",
                salary = 75,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 100,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 150,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 200,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 250,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Banquier",
                subtitle = "Actions disponibles",
                name = "Banquier_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("banker")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                }
            }
        },
        Storage = {
            {
                Pos = {x = 262.56, y = 220.52, z = 100.75},
                Limit = 100,
                Name = "coffre_banque"
            }
        },
        garage = {
            Name = "Garage Banque",
            Pos = {x = 322.53, y = 266.99, z = 104.42},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {
                    {}
                },
                spawnpos = {x = 323.51, y = 264.28, z = 104.36, h = 253.35}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage_banque"
            }
        },
        Extrapos = {
            Banker = {
                Pos = {
                    {x = 243.70, y = 226.31, z = 106.28},
                    {x = 248.85, y = 224.41, z = 106.28},
                    {x = 254.04, y = 222.45, z = 106.28}
                },
                restricted = {2, 3, 4, 5},
                Enter = function()
                    EnterBankZone()
                end,
                Exit = function()
                    ExitBankZone()
                end,
                zonesize = 1.5,
                Blips = {
                    sprite = 500,
                    color = 69,
                    name = "Gestion comptes"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.2},
                    color = {r = 255, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        }
    },
    gouv = {
        label = "Gouvernement",
        label2 = "Gouvernement",
        grade = {
            {
                label = "Agent de Sécurité",
                salary = 230,
                name = "agent",
                show = true
            },
            {
                label = "Juge",
                salary = 430,
                name = "Juge",
                show = true
            },
            {
                label = "Procureur",
                salary = 430,
                name = "drh",
                show = true
            },
            {
                label = "Gouverneur",
                salary = 630,
                name = "boss",
                show = true
            }
        },
        CustomMenu = true,
        Storage = {
            {
                Pos = {x = -549.16, y = -205.29, z = 46.51},
                Limit = 100,
                Name = "coffre_gouv"
            }
        },
        Menu = {
            menu = {
                title = "Gouvernement",
                subtitle = "Actions disponibles",
                name = "Gouvernement_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("gouvernement")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Délivrer la licence UBER ~r~[$5.000]",
                    onSelected = function()
                        Police.PutPortUber()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Délivrer la licence entreprise ~r~[$90.000]",
                    onSelected = function()
                        Police.PutEntreprise()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
            }
        },
        Storage = {
            {
                Pos = {x = -549.16, y = -205.29, z = 46.51},
                Limit = 100,
                Name = "coffre_gouvernement"
            }
        },
        garage = {
            Name = "Garage gouvernement",
            Pos = {x = -549.45, y = -158.33, z = 38.25},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -558.6, y = -162.17, z = 38.16, h = 292.43}
            },
            Blipdata = {
                Pos = {},
                Blipcolor = 7,
                Blipname = "Garage"
            }
        }
    },
    lsms = {
        label = "LSMS",
        label2 = "LSMS",
        grade = {
            {
                label = "Brancardier",
                salary = 220,
                name = "ambulancier",
                show = true
            },
            {
                label = "Apprentie medecin",
                salary = 240,
                name = "infirmier",
                show = true
            },
            {
                label = "Médecin",
                salary = 260,
                name = "medecin",
                show = true
            },
            {
                label = "Urgentiste",
                salary = 290,
                name = "drh",
                show = true
            },
            {
                label = "Chirurgien",
                salary = 330,
                name = "drh",
                show = true
            },
            {
                label = "Patron",
                salary = 330,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage LSMS Los Santos",
            Pos = {x = 342.79, y = -559.77, z = 28.74},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = 342.79, y = -559.77, z = 28.74, h = 346.54}
            },
            Blipdata = {
                Pos = {x = 342.79, y = -559.77, z = 28.74},
                Blipcolor = 7,
                Blipname = "Garage Los Santos"
            }
        },
        Storage = {
            -- Los Santos
            {
                Pos = {x = 306.58, y = -601.72, z = 42.28},
                Limit = 100,
                Name = "Coffre LSMS"
            }
        },
        garage3 = {
            Name = "Helipad Hopital",
            Pos = {x = 336.39, y = -623.8, z = 29.29},
            Properties = {
                type = 2,
                Limit = 10,
                zonesize = 1.5,
                vehicles = {
                    {
                        name = "polmav",
                        label = "Helicoptere de secours",
                        job = true,
                        tuning = {
                            modXenon = false,
                            modLivery = 0
                        }
                    }
                },
                spawnpos = {x = 336.39, y = -623.8, z = 29.29, h = 256.26}
            },
            Blipdata = {
                Pos = {x = 336.39, y = -623.8, z = 29.29},
                Blipcolor = 5,
                Blipname = "Helipad Hopital"
            }
        },
        Menu = {
            menu = {
                title = "Ambulance",
                subtitle = "Actions disponibles",
                name = "ambulance_menuperso"
            },
            buttons = {
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("lsms")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Délivrer le Certificat médical",
                    onSelected = function()
                        Ambulance.PutCertificat()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Réanimation",
                    onSelected = function()
                        Ambulance.Revive()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Petite blessure",
                    onSelected = function()
                        Ambulance.Heal(25)
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Blessure grave",
                    onSelected = function()
                        Ambulance.Heal(200)
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Mettre dans le véhicule",
                    onSelected = function()
                        Police.PutInVeh()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Sortir du véhicule",
                    onSelected = function()
                        Police.SortirVeh()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = 299.16, y = -598.27, z = 43.28},
                Tenues = {
                    ["Tenue ambulancier"] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 250, ['torso_2'] = 0,
                            ['decals_1'] = 58, ['decals_2'] = 0,
                            ['arms'] = 85,
                            ['pants_1'] = 96, ['pants_2'] = 0,
                            ['shoes_1'] = 69, ['shoes_2'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = 0,
                            ['chain_1'] = 126, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                            ['torso_1'] = 258, ['torso_2'] = 0,
                            ['decals_1'] = 66, ['decals_2'] = 0,
                            ['arms'] = 109,
                            ['pants_1'] = 99, ['pants_2'] = 0,
                            ['shoes_1'] = 72, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 96, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0,

                        }
                    }
                }
            }
        }
    },
    mecano = {
        label = "LS Custom",
        label2 = "LS Custom",
        grade = {
            {
                label = "CDD",
                salary = 120,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 130,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 150,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 170,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 220,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Mécano",
            Pos = {x = -370.50, y = -107.56, z = 38.68},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -365.17, y = -109.17, z = 38.69, h = 78.14}
            },
            Blipdata = {
                Pos = {x = -365.17, y = -109.17, z = 38.69},
                Blipcolor = 5,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "Mécano",
                subtitle = "Actions disponibles",
                name = "mecano_menuperso"
            },
            submenus = {
                ["Actions véhicule"] = {
                    submenu = "mecano_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {
                                label = "Inspecter l'état du véhicule",
                                onSelected = function()
                                    Mecano.CheckVehicle()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Ouvrir le capot",
                                onSelected = function()
                                    Mecano.OpenTrunk()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Réparer",
                                onSelected = function()
                                    Mecano.Repair()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Nettoyer",
                                onSelected = function()
                                    Mecano.CleanVehicule()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            },
                            {
                                label = "Mise en fourière",
                                onSelected = function()
                                    Mecano.Fouriere()
                                end,
                                ActiveFct = function()
                                    Mecano.ShowMarker()
                                end
                            }
                        },
                        submenus = {}
                    }
                }
            },
            buttons = {
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                },
                {
                    label = "Facturation",
                    onSelected = function()
                        CreateFacture("mecano")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annuler l'appel en cours",
                    onSelected = function()
                        TriggerEvent("call:cancelCall")
                    end
                }
            }
        },
        Extrapos = {
            Tow = {
                Pos = {
                    {x = -360.33, y = -128.35, z = 38.69}
                },
                Enter = EnterZoneTow,
                Exit = ExitZoneTow,
                zonesize = 5.5,
                Blips = {
                    sprite = 473,
                    color = 81,
                    name = "Fourrière"
                },
                Marker = {
                    type = 1,
                    scale = {x = 1.5, y = 1.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            },
            LSCustoms = {
                Pos = {
                    {x = -340.60, y = -137.99, z = 39.00},
                    {x = -327.67, y = -144.70, z = 39.05},
                    {x = -324.62, y = -132.04, z = 38.95}
                },
                Enter = function()
                    EnterZoneLSC()
                end,
                Exit = function()
                    ExitZoneLSC()
                end,
                zonesize = 3.5,
                Blips = {},
                Marker = {
                    type = 1,
                    scale = {x = 4.5, y = 4.5, z = 0.6},
                    color = {r = 100, g = 255, b = 255, a = 120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = false
                }
            }
        },
        Storage = {
            {
                Pos = {x = -344.84, y = -124.60, z = 38.00},
                Limit = 100,
                Name = "coffre_mecano"
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x = -347.17, y = -133.36, z = 38.00},
                Tenues = {
                    ['Tenue de services'] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 65, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 38, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 14, ['tshirt_2'] = 0,
                            ['torso_1'] = 59, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 18,
                            ['pants_1'] = 38, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        }
                    }
                }
            },
        },
    },
    concess = {
        label = "Concessionnaire",
        label2 = "Concessionnaire",
        grade = {
            {
                label = "CDD",
                salary = 100,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 150,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 200,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 250,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 300,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Concessionnaire",
                subtitle = "Actions disponibles",
                name = "Concessionnaire_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("concess")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Listes des ventes",
                    onSelected = function()
                        ListesVentes()
                    end
                },
                {
                    label = "Rentrer véhicule",
                    onSelected = function()
                        Mecano.Fouriere()
                    end
                },
                {
                    label = "Créer une clé",
                    onSelected = function()
                        Clef()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Créer une carte grise",
                    onSelected = function()
                        CarteGrise()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                }
            }
        },
        garage = {
            Name = "Garage Concessionnaire",
            Pos = {x = -19.812, y = -1086.99, z = 26.57},
            illimity = true,
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -11.90, y = -1081.24, z = 26.67, h = 127.41}
            },
            Blipdata = {
                Pos = {x = -11.90, y = -1081.24, z = 26.67},
                Blipcolor = 5,
                Blipname = "Garage Concessionnaire"
            }
        },
        Storage = {
            {
                Pos = {x = -38.82, y = -1082.75, z = 25.42},
                Limit = 100,
                Name = "coffre PDM"
            }
        }
    },
    bikershop = {
        label = "Concess Avion",
        label2 = "Concess Avion",
        grade = {
            {
                label = "CDD",
                salary = 100,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 150,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 200,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 250,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 300,
                name = "boss",
                show = true
            }
        },
        Menu = {
            menu = {
                title = "Concess Avion",
                subtitle = "Actions disponibles",
                name = "bikershop_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("bikershop")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Listes des ventes",
                    onSelected = function()
                        ListesVentes()
                    end
                },
                {
                    label = "Rentrer véhicule",
                    onSelected = function()
                        RentrerVeh()
                    end
                },
                {
                    label = "Créer une clé",
                    onSelected = function()
                        Clef()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Créer une carte grise",
                    onSelected = function()
                        CarteGrise()
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                },
                {
                    label = "Annonce",
                    onSelected = function()
                        local text = KeyboardInput("Texte de l'annonce", nil, 255)
                        if text ~= nil then
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                -1,
                                {message = "~b~Annonce " .. Jobs[Job:Get().name].label2 .. "\n~s~~h~" .. text}
                            )
                        end
                    end
                }
            }
        }
    },
    
     ----------------------------- Début gang

     ballas = {
        label = "Ballas",
        grade = {
           {
               label = "Guetteur",
               salary = 0,
               name = "cdd",
               show = true
           },
           {
               label = "Petite-Frappe",
               salary = 0,
               name = "cdi",
               show = true
           },
           {
               label = "Grand",
               salary = 0,
               name = "chef",
               show = true
           },
           {
               label = "Bras Droit",
               salary = 0,
               name = "drh",
               show = true
           },
           {
               label = "OG",
               salary = 0,
               name = "boss",
               show = true
            }
        },
        garage = {
            Name = "Garage Ballas",
            Pos = {x = 104.33, y = -1954.19, z = 20.34},
            illimity = true,
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = 106.57, y = -1944.56, z = 20.8, h = 49.16}
            },
            Blipdata = {
                Pos = {x = 104.33, y = -1954.19, z = 20.34},
                Blipcolor = 5,
                Blipname = "Garage Ballas"
            }
        },
        Storage = {
            {
                Pos = {x = 106.19, y = -1981.38, z = 19.96},
                Limit = 100,
                Name = "coffre Ballas"
            }
        }
    },
    crips = {
        label = "Crips",
        grade = {
           {
               label = "Guetteur",
               salary = 0,
               name = "cdd",
               show = true
           },
           {
               label = "Petite-Frappe",
               salary = 0,
               name = "cdi",
               show = true
           },
           {
               label = "Grand",
               salary = 0,
               name = "chef",
               show = true
           },
           {
               label = "Bras Droit",
               salary = 0,
               name = "drh",
               show = true
           },
           {
               label = "OG",
               salary = 0,
               name = "boss",
               show = true
            }
        },
        garage = {
         Name = "Garage Crips",
         Pos = {x = 394.69, y = -1803.42, z = 28,22},
         illimity = true,
         Properties = {
             type = 3,
             Limit = 10,
             vehicles = {},
             spawnpos = {x = 394.69, y = -1803.42, z = 28,22, h = 236.40}
         },
         Blipdata = {
             Pos = {x = 394.69, y = -1803.42, z = 28,22},
             Blipcolor = 5,
             Blipname = "Garage Crips"
         }
     },
     Storage = {
         {
             Pos = {x = -1556.84, y = -375.88, z = 47.04},
             Limit = 100,
             Name = "coffre Crips"
         }
     }
 },

    bloods = {
        label = "Bloods",
        grade = {
           {
               label = "Guetteur",
               salary = 0,
               name = "cdd",
               show = true
           },
           {
               label = "Petite-Frappe",
               salary = 0,
               name = "cdi",
               show = true
           },
           {
               label = "Grand",
               salary = 0,
               name = "chef",
               show = true
           },
           {
               label = "Bras Droit",
               salary = 0,
               name = "drh",
               show = true
           },
           {
               label = "OG",
               salary = 0,
               name = "boss",
               show = true
            }
        },
        garage = {
         Name = "Garage Bloods",
         Pos = {x = -1564.75, y = -390.19, z = 40,98},
         illimity = true,
         Properties = {
             type = 3,
             Limit = 10,
             vehicles = {},
             spawnpos = {x = -1564.75, y = -390.19, z = 40,98, h = 228.79}
         },
         Blipdata = {
             Pos = {x = -1564.75, y = -390.19, z = 40,98},
             Blipcolor = 5,
             Blipname = "Garage Bloods"
         }
     },
     Storage = {
         {
             Pos = {x = -1556.84, y = -375.88, z = 47.04},
             Limit = 100,
             Name = "coffre Bloods"
         }
     }
 },
    marabunta = {
       label = "Mararunta",
       grade = {
           {
               label = "Pequeno",
               salary = 0,
               name = "cdd",
               show = true
           },
           {
               label = "Capo",
               salary = 0,
               name = "cdi",
               show = true
           },
           {
               label = "Grande",
               salary = 0,
               name = "chef",
               show = true
           },
           {
               label = "Brazo Derecho",
               salary = 0,
               name = "drh",
               show = true
           },
           {
               label = "Jefe",
               salary = 0,
               name = "boss",
               show = true
            }
        },
        garage = {
         Name = "Garage Marabunta",
         Pos = {x = 1250.40, y = -1600.26, z = 51,96},
         illimity = true,
         Properties = {
             type = 3,
             Limit = 10,
             vehicles = {},
             spawnpos = {x = 1250.40, y = -1600.26, z = 51,96, h = 126.43}
         },
         Blipdata = {
             Pos = {x = 1250.40, y = -1600.26, z = 51,96},
             Blipcolor = 5,
             Blipname = "Garage Marabunta"
         }
     },
     Storage = {
         {
             Pos = {x = 1242.52, y = -1572.71, z = 57.20},
             Limit = 100,
             Name = "coffre Marabunta"
         }
     }
 },
    Families = {
       label = "Families",
       grade = {
           {
               label = "Guetteur",
               salary = 0,
               name = "cdd",
               show = true
           },
           {
               label = "Petite-Frappe",
               salary = 0,
               name = "cdi",
               show = true
           },
           {
               label = "Grand",
               salary = 0,
               name = "chef",
               show = true
           },
           {
               label = "Bras Droit",
               salary = 0,
               name = "drh",
               show = true
           },
           {
               label = "OG",
               salary = 0,
               name = "boss",
               show = true
           }
       },
       garage = {
        Name = "Garage Families",
        Pos = {x = -188.68, y = -1584.81, z = 33,79},
        illimity = true,
        Properties = {
            type = 3,
            Limit = 10,
            vehicles = {},
            spawnpos = {x = -188.68, y = -1584.81, z = 33.79, h = 227.97}
        },
        Blipdata = {
            Pos = {x = -188.68, y = -1584.81, z = 33,79},
            Blipcolor = 5,
            Blipname = "Garage Families"
        }
    },
    Storage = {
        {
            Pos = {x = -137.35, y = -1609.83, z = 34.03},
            Limit = 100,
            Name = "coffre Families"
        }
    }
},
   vagos = {
       label = "Vagos",
       grade = {
           {
               label = "Pequeno",
               salary = 0,
               name = "cdd",
               show = true
           },
           {
               label = "Capo",
               salary = 0,
               name = "cdi",
               show = true
           },
           {
               label = "Grande",
               salary = 0,
               name = "chef",
               show = true
           },
           {
               label = "Brazo Derecho",
               salary = 0,
               name = "drh",
               show = true
           },
           {
               label = "Jefe",
               salary = 0,
               name = "boss",
               show = true
            }
        },
        garage = {
         Name = "Garage Vagos",
         Pos = {x = 337.12, y = -2035.76, z = 21.34},
         illimity = true,
         Properties = {
             type = 3,
             Limit = 10,
             vehicles = {},
             spawnpos = {x = 332.51, y = -2031.6, z = 21.2, h = 139.28}
         },
         Blipdata = {
             Pos = {x = 337.12, y = -2035.76, z = 21.34},
             Blipcolor = 5,
             Blipname = "Garage Vagos"
         }
     },
     Storage = {
         {
             Pos = {x = 332.29, y = -2013.03, z = 21.39},
             Limit = 100,
             Name = "coffre Vagos"
        }
    },
},



   -----------------------------  Fin Gang

    immo = {
        label = "Agent Immobilier",
        label2 = "Agent Immobilier",
        grade = {
            {
                label = "CDD",
                salary = 75,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 100,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 150,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 200,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 250,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Immobilier",
            Pos = {x = -1552.04, y = -578.52, z = 25.31},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = -1552.04, y = -578.52, z = 25.71, h = 300.49}
            },
            Blipdata = {
                Pos = {x = -1552.04, y = -578.52, z = 25.71},
                Blipcolor = 5,
                Blipname = "Garage Immobilier"
            }
        },
        Storage = {
            {
                Pos = {x = -1561.43, y = -572.04, z = 107.52},
                Limit = 100,
                Name = "Coffre Immobilier"
            }
        }
    },
    unicorn = {
        label = "Unicorn",
        label2 = "Unicorn",
        grade = {
            {
                label = "CDD",
                salary = 100,
                name = "cdd",
                show = true
            },
            {
                label = "CDI",
                salary = 120,
                name = "cdi",
                show = true
            },
            {
                label = "Chef",
                salary = 140,
                name = "chef",
                show = true
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 200,
                name = "boss",
                show = true
            }
        },
        garage = {
            Name = "Garage Unicorn",
            Pos = {x = 162.71, y = -1281.98, z = 29.09},
            Properties = {
                type = 3,
                Limit = 10,
                vehicles = {},
                spawnpos = {x = 162.71, y = -1281.98, z = 29.09, h = 144.98}
            },
            Blipdata = {
                Pos = {x = 162.71, y = -1281.98, z = 29.09},
                Blipcolor = 5,
                Blipname = "Garage Unicorn"
            }
        },
        Storage = {
            {
                Pos = {x = 131.47, y = -1285.02, z = 28.27},
                Limit = 100,
                Name = "Frigo Unicorn"
            },
            {
                Pos = {x = 93.21, y = -1291.99, z = 28.27},
                Limit = 100,
                Name = "Coffre Patron"
            }
        },
        Menu = {
            menu = {
                title = "Unicorn",
                subtitle = "Actions disponibles",
                name = "unicorn_menuperso"
            },
            buttons = {
                {
                    label = "Facture",
                    onSelected = function()
                        CreateFacture("unicorn")
                    end,
                    ActiveFct = function()
                        HoverPlayer()
                    end
                }
            }
        }
    },

    taxi = {
        label = "Taxi",
        label2 = "Taxi",
        grade = {
            {
                label = "Chaffeur",
                salary = 100,
                name = "employe",
                show = true
            },
            {
                label = "Manager",
                salary = 115,
                name = "employe2",
                show = true
            },
            {
                label = "Patron",
                salary = 130,
                name = "boss",
                show = true
            },
        },
        Menu = {
            menu = {
                title = "Taxi",
                subtitle = "Actions disponibles",
                name = "taxi_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("taxi") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        Storage = {
            {
                Pos = {x = 895.18, y = -179.26, z = 73.7},
                Limit = 100,
                Name = "Coffre taxi"
            },
        },
        garage = {
        Name = "Garage Taxi",
        Pos =  {x = 900.89,  y = -186.7,  z =73.79},
        workSize = 1.5,
        Properties = {
            type = 3,
            Limit = 10,
            vehicles = {},
                spawnpos = {x = 900.89,  y = -186.7,  z =73.79, h = 329.88}

            },
            Blipdata = {
                Pos = {x = 900.89,  y = -186.7,  z =73.79},
                Blipcolor  =5,
                Blipname = "Garage Taxi"
            }
        },
    },

}