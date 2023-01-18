ConfigTax = 21
function GeneratePhoneNumber()
    prefix = 555
    math.randomseed(GetGameTimer())
    return prefix .. math.random(1111, 9999)
end
function GeneratePoliceSerial()
    local serial = "POLICE-"
    math.randomseed(GetGameTimer())
    local num = math.random(11111, 99999)
    return serial .. num
end
local BasicShops = {
    {
        name = "tel",
        price = 150,
        data = {battery = 99},
        fct = GeneratePhoneNumber,
        type = "number"
    },
     {
         name = "bread",
         price = 4,
         data = {}
     },
    {
        name = "kebab",
        price = 20,
        data = {}
    },
    {
        name = "water",
        price = 4,
        data = {}
    },
     {
         name = "jus_pomme",
         price = 20,
         data = {}
     }
}
local _identity = {}
function SetMyIdentity(id)
    id[1].serial = math.random(111111111, 9999999999)
    id[1].male = GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") and "M" or "F"
    _identity = id[1]
end
function GetIdentity()
    return _identity
end

function HasNoMedic()
    local result = nil
    TriggerServerCallback(
        "service:Count",
        function(nb)
            if nb == 0 then
                RageUI.Popup(
                    {message = "~g~Mes collègues ne sont pas en service, je vais m'occuper de vous après paiement"}
                )
                result = true
            else
                RageUI.Popup({message = "~r~Mes collègues sont à l'intérieur. Merci d'aller les rencontrer"})
                result = false
            end
        end,
        "lsms"
    )

    while (result == nil) do
        Wait(10)
    end

    return result
end

function HealPlayerFromMedic()
    local timeATA = 1000 * 60 * 1
    exports["mythic_progbar"]:Progress(
        {
            name = "soigner_grrr",
            duration = 60000,
            label = "Soins médicaux en cours...",
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true
            },
            animation = anim
        },
        function(cancelled)
            if not cancelled then
                ClearPedTasks(LocalPlayer().Ped)
            end
        end
    )
    local playerPed = PlayerPedId()
    RequestAnimDict("amb@medic@standing@timeofdeath@idle_a")
    local j = 0
    while not HasAnimDictLoaded("amb@medic@standing@timeofdeath@idle_a") and j <= 50 do
        Citizen.Wait(100)
        j = j + 1
    end

    if j >= 50 then
        ShowNotification("~r~~h~ERREUR ~h~~w~: Animation trop longue a charger.")
    else
        TaskPlayAnim(playerPed, "amb@medic@standing@timeofdeath@idle_a", "idle_a", 8.0, 1.0, -1, 2)
        RemoveAnimDict("amb@medic@standing@timeofdeath@idle_a")
    end
    FreezeEntityPosition(playerPed, true)
    Wait(timeATA)
    FreezeEntityPosition(playerPed, false)
    RemoveLoadingPrompt()
    ClearPedTasks(PlayerPedId())
    SetEntityHealth(PlayerPedId(), 200)
    RageUI.Popup({message = "~g~Vous êtes soigné !\n~y~Pensez à appliquer les ATA~w~"})
    TriggerServerEvent("entreprise:Add", "lsms", 1250)
end

local Shops =
    setmetatable(
    {
        {
            Pos = {x = -1097.50, y = -839.84, z = 18.00, a = 126.36},
            Blips = {
                sprite = 498,
                color = 15,
                name = "Préfecture"
            },
            Ped = {
                model = "s_m_y_cop_01",
                name = "Tonio"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "identity",
                    price = 15,
                    data = {},
                    type = "identity",
                    fct = GetIdentity
                }
            }
        },
        {
            Pos = {x = 305.16, y = -595.63, z = 42.28, a = 341.29},
            Blips = {
                sprite = 403,
                color = 17,
                name = "Pharmacie"
            },
            Ped = {
                model = "s_m_m_doctor_01",
                name = "Doug"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "soinurgence",
                    price = 1250,
                    data = {},
                    noCount = true,
                    noItem = true,
                    beforePayment = HasNoMedic,
                    afterPayment = HealPlayerFromMedic
                }
            }
        },
        {
            Pos = {x = -448.32, y = 6012.58, z = 30.72, a = 310.17},
            Blips = {
                sprite = 498,
                color = 15,
                name = "Préfecture"
            },
            Ped = {
                model = "s_m_y_sheriff_01",
                name = "Marco"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "identity",
                    price = 15,
                    data = {},
                    type = "identity",
                    fct = GetIdentity
                }
            }
        },
        {
            Pos = {x = 1853.14, y = 3689.05, z = 33.25, a = 206.83},
            Blips = {
                sprite = 498,
                color = 15,
                name = "Préfecture"
            },
            Ped = {
                model = "s_m_y_sheriff_01",
                name = "John"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "identity",
                    price = 15,
                    data = {},
                    type = "identity",
                    fct = GetIdentity
                }
            }
        },
        {
            Pos = {x = 1134.182, y = -982.477, z = 45.416, a = 275.432},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops
        },
        {
            Pos = {x = -46.82, y = -1757.97, z = 28.42, a = 48.73},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops
        },
        {
            Pos = {x = 1119.98, y = -639.6, z = 55.81, a = 293.06},
            Blips = {
                sprite = 456,
                color = 6,
                name = "Jojo"
            },
            Ped = {
                model = "u_m_o_taphillbilly"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "pinces",
                    price = 75,
                    data = {}
                },
                {
                    name = "fertz",
                    price = 15,
                    data = {}
                },
                {
                    name = "crochetage",
                    price = 225,
                    data = {}
                },
                --[[{
                    name = "parapluie",
                    price = 10,
                    data = {}
                },]]--
                {
                    name = "ciseaux",
                    price = 250,
                    data = {}
                },
                {
                    name = "menottes",
                    price = 150,
                    data = {}
                }
            }
        },
        {
            Pos = {x = -29.03, y = 6457.19, z = 30.46, a = 226.06},
            Blips = {
                sprite = 456,
                color = 6,
                name = "Billy"
            },
            Ped = {
                model = "a_m_m_hillbilly_01"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "pinces",
                    price = 75,
                    data = {}
                },
                {
                    name = "fertz",
                    price = 15,
                    data = {}
                },
                {
                    name = "crochetage",
                    price = 225,
                    data = {}
                },
                {
                    name = "parapluie",
                    price = 10,
                    data = {}
                },
                {
                    name = "ciseaux",
                    price = 250,
                    data = {}
                },
                {
                    name = "menottes",
                    price = 150,
                    data = {}
                }
            }
        },
        {
            Pos = {x = 24.376, y = -1345.558, z = 28.421, a = 267.940},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "police"
        },
        {
            Pos = {x = 373.015, y = 328.332, z = 102.566, a = 257.309},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "police"
        },
        {
            Pos = {x = 1697.58, y = 4923.24, z = 41.06, a = 328.71},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
         {
             Pos = {x = 44.38, y = -1005.66, z = 8.28, a = 337.64},
             Blips = {
                 sprite = 1,
                 color = nil,
                 name = "Magasin"
             },
             Ped = {
                 model = "mp_m_shopkeep_01",
                 name = "José"
             },
             braquable = false,
             Menus = {
                 Sprite = "shopui_title_conveniencestore",
                 Enabled = true
             },
             Items = BasicShops,
             bzone = "all"
         },
        {
            Pos = {x = 1392.94, y = 3606.44, z = 33.98, a = 192.91},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = 1164.565, y = -322.121, z = 68.205, a = 100.492},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "police"
        },
        {
            Pos = {x = -1486.530, y = -377.768, z = 39.163, a = 147.669},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "police"
        },
        {
            Pos = {x = -1221.568, y = -908.121, z = 11.326, a = 31.739},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "police"
        },
        {
            Pos = {x = 1728.614, y = 6416.729, z = 34.037, a = 247.369},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = 1958.960, y = 3741.979, z = 31.344, a = 303.196},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = 2676.389, y = 3280.362, z = 54.241, a = 332.305},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = -3243.99, y = 999.86, z = 11.83, a = 0.0},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = -2966.391, y = 391.324, z = 14.043, a = 88.867},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = 2555.474, y = 380.909, z = 107.623, a = 355.737},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = -1820.230, y = 794.343, z = 137.089, a = 130.327},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "police"
        },
        {
            Pos = {x = -3041.18, y = 583.85, z = 6.91, a = 16.09},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = 549.35, y = 2669.06, z = 41.16, a = 90.0},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = 1165.91, y = 2710.77, z = 37.16, a = 180.0},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Pos = {x = -705.9, y = -913.5, z = 18.22, a = 92.47},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "police"
        },
        {
            Pos = {x = 161.89, y = 6642.98, z = 30.71, a = 218.23},
            Blips = {
                sprite = 59,
                color = 43,
                name = "Magasin"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "Apu"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = true
            },
            Items = BasicShops,
            bzone = "all"
        },
        {
            Hidden = true,
            Pos = {x = -28.6, y = 10.06, z = 1.82, a = 243.48},
            --Pos = { x = -15.20, y = 6.46, z = 71.53, a = 243.48 },
            Blips = {},
            Ped = {
                model = "s_m_y_marine_01",
                name = "John"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            Items = {
                {
                    name = "mm9",
                    price = 2,
                    data = {}
                },
                {
                    name = "pistol",
                    price = 1200,
                    data = {},
                    fct = GenerateSerial,
                    type = "serial"
                }
            }
    },
        {
            Hidden = true,
            RestrictedJob = {"restaurant"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = -1852.43, y = -1197.92, z = 12.02, a = 241.75}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Restaurant"
            },
            Ped = {
                model = "s_m_y_chef_01",
                name = "Bob"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "aperitif",
                    price = 1,
                    data = {}
                },
                {
                    name = "entreepearl",
                    price = 5,
                    data = {}
                },
                {
                    name = "platpearl",
                    price = 5,
                    data = {}
                },
                {
                    name = "boissonpearl",
                    price = 5,
                    data = {}
                },
                {
                    name = "bread",
                    price = 2,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"pequetruck"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = 888.74, y = -289.1, z = 65.21, a = 41.49}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Cuisto PequeTruck"
            },
            Ped = {
                model = "s_m_y_chef_01",
                name = "Darnell"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "meat",
                    price = 2,
                    data = {}
                },
                {
                    name = "bread",
                    price = 2,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"ammunation"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = 1079.79, y = -1982.99, z = 30.47, a = 332.55}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Vendeur de pièces en métal"
            },
            Ped = {
                model = "mp_m_waremech_01",
                name = "Pierce"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "metalpiece1",
                    price = 2500,
                    data = {}
                },
                {
                    name = "metalpiece2",
                    price = 7500,
                    data = {}
                },
                {
                    name = "metalpiece3",
                    price = 3500,
                    data = {}
                },
                {
                    name = "metalpiece4",
                    price = 12500,
                    data = {}
                },
                {
                    name = "metalpiece5",
                    price = 15000,
                    data = {}
                },
                {
                    name = "metalpiece6",
                    price = 17500,
                    data = {}
                },
                {
                    name = "metalpiece7",
                    price = 300,
                    data = {}
                },
                {
                    name = "metalpiece8",
                    price = 300,
                    data = {}
                },
                {
                    name = "metalpiece9",
                    price = 1750,
                    data = {}
                },
                {
                    name = "metalpiece10",
                    price = 3000,
                    data = {}
                },
                {
                    name = "metalpiece11",
                    price = 1500,
                    data = {}
                },
                {
                    name = "metalpiece12",
                    price = 500,
                    data = {}
                },
                {
                    name = "metalpiece13",
                    price = 500,
                    data = {}
                },
                {
                    name = "metalpiece14",
                    price = 800,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"ammunation"},
            RestrictedGrade = {"cdi", "chef", "drh", "boss"},
            Pos = {x = 255.91, y = -46.78, z = 68.94, a = 97.76}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Vendeur assistant"
            },
            Ped = {
                model = "s_m_y_armymech_01",
                name = "Gordon"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "mm9",
                    price = 60,
                    data = {}
                },
                {
                    name = "acp45",
                    price = 40,
                    data = {}
                },
                {
                    name = "calibre12",
                    price = 80,
                    data = {}
                },
                {
                    name = "cab",
                    price = 100,
                    data = {}
                },
                {
                    name = "akm",
                    price = 100,
                    data = {}
                },
                {
                    name = "snip",
                    price = 200,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"ammunation"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = -584.38, y = 5289.39, z = 69.26, a = 55.68}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Vendeur de pièces en bois"
            },
            Ped = {
                model = "s_m_m_lathandy_01",
                name = "Woody"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "woodpiece1",
                    price = 300,
                    data = {}
                },
                {
                    name = "woodpiece2",
                    price = 200,
                    data = {}
                },
                {
                    name = "woodpiece3",
                    price = 500,
                    data = {}
                },
                {
                    name = "woodpiece4",
                    price = 300,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"ammunation"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = 286.32, y = -3029.06, z = 4.69, a = 259.22}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Vendeur de pièces en plastique"
            },
            Ped = {
                model = "s_m_y_dockwork_01",
                name = "Tulio"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "plasticpiece1",
                    price = 200,
                    data = {}
                },
                {
                    name = "plasticpiece2",
                    price = 100,
                    data = {}
                },
                {
                    name = "plasticpiece3",
                    price = 400,
                    data = {}
                },
                {
                    name = "plasticpiece4",
                    price = 150,
                    data = {}
                },
                {
                    name = "plasticpiece5",
                    price = 150,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"mecano"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = -351.48, y = -107.57, z = 37.69, a = 159.86}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 446,
                Enabled = false, -- Image off
                color = 43,
                name = "Mécano"
            },
            Ped = {
                model = "ig_benny",
                name = "Angel"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "repairbox2",
                    price = 200,
                    data = {}
                },
                {
                    name = "repairbox",
                    price = 150,
                    data = {}
                },
                {
                    name = "lavage",
                    price = 75,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"mecano2"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = 1779.42, y = 3321.58, z = 40.37, a = 254.02}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Mécano"
            },
            Ped = {
                model = "mp_f_bennymech_01",
                name = "Jessy"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "repairbox2",
                    price = 200,
                    data = {}
                },
                {
                    name = "repairbox",
                    price = 150,
                    data = {}
                },
                {
                    name = "lavage",
                    price = 75,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"journaliste"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = -579.71, y = -935.56, z = 22.87, a = 91.50}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Journaliste"
            },
            Ped = {
                model = "a_f_y_tourist_01",
                name = "Jessy"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "perche",
                    price = 10,
                    data = {}
                },
                {
                    name = "micro",
                    price = 10,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"unicorn"},
            RestrictedGrade = {"cdd", "cdi", "chef", "drh", "boss"},
            Pos = {x = 177.91, y = 307.72, z = 104.37, a = 183.81}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "unicorn"
            },
            Ped = {
                model = "cs_carbuyer",
                name = "Younes"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "whisky",
                    price = 1,
                    data = {}
                },
                {
                    name = "vodka",
                    price = 1,
                    data = {}
                },
                {
                    name = "cognac",
                    price = 1,
                    data = {}
                },
                {
                    name = "rhum",
                    price = 1,
                    data = {}
                },
                {
                    name = "biere",
                    price = 1,
                    data = {}
                },
                {
                    name = "champagne",
                    price = 1,
                    data = {}
                },
                {
                    name = "tequila",
                    price = 1,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"lsms"},
            RestrictedGrade = {"infirmier", "medecin", "medecinchef", "drh", "boss"},
            Pos = {x = 1828.23, y = 3675.16, z = 33.27, a = 233.9}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Médecin"
            },
            Ped = {
                model = "s_m_m_doctor_01",
                name = "John"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "medbox",
                    price = 1,
                    data = {}
                },
                {
                    name = "medikit",
                    price = 1,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"ChihuahuaHotDogs"},
            RestrictedGrade = {"cdd", "boss"},
            Pos = {x = 39.22, y = -1022.23, z = 28.5, a = 56.12}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "ChihuahuaHotDogs"
            },
            Ped = {
                model = "mp_m_shopkeep_01",
                name = "JOJO"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "Hhotdog",
                    price = 1,
                    data = {}
                },
                {
                    name = "kebab",
                    price = 1,
                    data = {}
                },
                {
                    name = "pizza",
                    price = 1,
                    data = {}
                },
                {
                    name = "chips",
                    price = 1,
                    data = {}
                },
                {
                    name = "water",
                    price = 1,
                    data = {}
                },
                {
                    name = "cafe",
                    price = 1,
                    data = {}
                },
                {
                    name = "cola",
                    price = 1,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"lsms"},
            RestrictedGrade = {"infirmier", "medecin", "medecinchef", "drh", "boss"},
            Pos = {x = 337.63, y = -586.51, z = 27.9, a = 296.22}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Médecin"
            },
            Ped = {
                model = "s_m_m_doctor_01",
                name = "Karl"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "medbox",
                    price = 20,
                    data = {}
                },
                {
                    name = "medikit",
                    price = 20,
                    data = {}
                }
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"police"},
            RestrictedGrade = {"boss", "drh" },
            Pos = {x = -1099.93, y = -824.74, z = 13.28, a = 215.97}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = true, -- Image off
                color = 43,
                name = "Police"
            },
            Ped = {
                model = "s_m_y_cop_01",
                name = "John"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "mm9",
                    price = 1,
                    data = {}
                },
                {
                    name = "cab",
                    price = 1,
                    data = {}
                },
                {
                    name = "calibre12",
                    price = 2,
                    data = {}
                },
                {
                    name = "acp45",
                    price = 2,
                    data = {}
                },
                -- {
                --     name = "pistol",
                --     price = 1200,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "pistolcombat",
                    price = 10,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                -- {
                --     name = "pistol50",
                --     price = 1560,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "stungun",
                    price = 10,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "flaregun",
                    price = 10,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                -- {
                --     name = "assaultsmg",
                --     price = 15000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "nightstick",
                    price = 10,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "carrabine",
                    price = 10,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "shootguncompact",
                    price = 10,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "shootgun",
                    price = 10,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                }
              --[[  {
                    name = "smg",
                    price = 10,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                } --]]
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"merryweather"},
            RestrictedGrade = {"chef", "drh", "boss"},
            Pos = {x = 506.66, y = -3122.74, z = 5.07, a = 176.94},
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "Merry Weather"
            },
            Ped = {
                model = "csb_mweather",
                name = "Billy"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "mm9",
                    price = 2,
                    data = {}
                },
                {
                    name = "cab",
                    price = 2,
                    data = {}
                },
                -- {
                --     name = "calibre12",
                --     price = 2,
                --     data = {}
                -- },
                -- {
                --     name = "acp45",
                --     price = 2,
                --     data = {}
                -- },
                -- {
                --     name = "pistol",
                --     price = 1200,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "pistolcombat",
                    price = 1890,
                    data = {},
                    fct = GenerateSerial,
                    type = "serial"
                },
                -- {
                --     name = "pistol50",
                --     price = 1560,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "stungun",
                    price = 530,
                    data = {},
                    fct = GenerateSerial,
                    type = "serial"
                },
                -- {
                --     name = "flaregun",
                --     price = 250,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "assaultsmg",
                --     price = 15000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "nightstick",
                    price = 50,
                    data = {},
                    fct = GenerateSerial,
                    type = "serial"
                },
                {
                    name = "carrabine",
                    price = 20000,
                    data = {},
                    fct = GenerateSerial,
                    type = "serial"
                }
                -- {
                --     name = "shootguncompact",
                --     price = 3400,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "shootgun",
                --     price = 4300,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- },
                -- {
                --     name = "smg",
                --     price = 14000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type = "serial"
                -- }
                -- {
                --     name = "heavysniper",
                --     price = 50000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "compactrifle",
                --     price = 25000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"lssd"},
            RestrictedGrade = {"sergent", "drh", "boss"},
            Pos = {x = -432.82, y = 5990.04, z = 30.72, a = 43.89}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "LSSD"
            },
            Ped = {
                model = "s_f_y_sheriff_01",
                name = "Anna"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "mm9",
                    price = 2,
                    data = {}
                },
                {
                    name = "cab",
                    price = 2,
                    data = {}
                },
                {
                    name = "calibre12",
                    price = 2,
                    data = {}
                },
                {
                    name = "acp45",
                    price = 2,
                    data = {}
                },
                -- {
                --     name = "pistol",
                --     price = 1200,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "pistolcombat",
                    price = 1890,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                -- {
                --     name = "pistol50",
                --     price = 1560,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "stungun",
                    price = 530,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "flaregun",
                    price = 250,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                -- {
                --     name = "assaultsmg",
                --     price = 15000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "nightstick",
                    price = 50,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "carrabine",
                    price = 20000,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "shootguncompact",
                    price = 3400,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "shootgun",
                    price = 4300,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                }
             --[[   {
                    name = "smg",
                    price = 14000,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                }--]]
                -- {
                --     name = "heavysniper",
                --     price = 50000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "compactrifle",
                --     price = 25000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
            }
        },
        {
            Hidden = true,
            RestrictedJob = {"lssd"},
            RestrictedGrade = {"sergent", "drh", "boss"},
            Pos = {x = 1843.53, y = 3693.34, z = 33.20, a = 205.15}, -- { x = 454.1, y = -980.07, z = 29.69, a = 85.87 },
            Blips = {
                sprite = 478,
                Enabled = false, -- Image off
                color = 43,
                name = "LSSD"
            },
            Ped = {
                model = "s_f_y_sheriff_01",
                name = "Jenny"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            braquable = false,
            Items = {
                {
                    name = "mm9",
                    price = 2,
                    data = {}
                },
                {
                    name = "cab",
                    price = 2,
                    data = {}
                },
                {
                    name = "calibre12",
                    price = 2,
                    data = {}
                },
                {
                    name = "acp45",
                    price = 2,
                    data = {}
                },
                -- {
                --     name = "pistol",
                --     price = 1200,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "pistolcombat",
                    price = 1890,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                -- {
                --     name = "pistol50",
                --     price = 1560,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "stungun",
                    price = 530,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "flaregun",
                    price = 250,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                -- {
                --     name = "assaultsmg",
                --     price = 15000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                {
                    name = "nightstick",
                    price = 50,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "carrabine",
                    price = 20000,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "shootguncompact",
                    price = 3400,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                },
                {
                    name = "shootgun",
                    price = 4300,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                }
            --[[    {
                    name = "smg",
                    price = 14000,
                    data = {},
                    fct = GeneratePoliceSerial,
                    type = "serial"
                }--]]
                -- {
                --     name = "heavysniper",
                --     price = 50000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
                -- {
                --     name = "compactrifle",
                --     price = 25000,
                --     data = {},
                --     fct = GeneratePoliceSerial,
                --     type =  "serial"
                -- },
            }
        },
        {
            -- PLC
            Hidden = true,
            RestrictedJob = {"ltd"},
            RestrictedGrade = {"drh", "boss", "tresorier", "employe"},
            Pos = {x = 159.1, y = -3075.11, z = 5.01, a = 267.08},
            Blips = {
                sprite = 354,
                color = 66,
                name = "Batteries"
            },
            Ped = {
                model = "a_m_m_fatlatin_01",
                name = "Grottony"
            },
            Menus = {
                Sprite = "shopui_title_conveniencestore",
                Enabled = false
            },
            Items = {
                {
                    name = "batterypack",
                    price = 50,
                    data = {}
                },
                {
                    name = "telpack",
                    price = 200,
                    data = {}
                }
            }
        }

        -- { -- PLC
        --     Hidden = true,
        --     RestrictedJob = {"mecano2"},
        --     RestrictedGrade = {"drh","boss","tresorier","employe"},
        --     Pos = { x = 1765.27, y = 3323.49, z = 40.45, a = 328.91 },
        --     Blips = {
        --         sprite = 354,
        --         color = 66,
        --         name = "Batteries",
        --     },
        --     Ped = {
        --         model = "a_m_m_fatlatin_01",
        --         name = "Grottony"
        --     },
        --     Menus = {
        --         Sprite = "shopui_title_conveniencestore",
        --         Enabled = false
        --     },
        --     Items = {
        --         {
        --             name = "repairbox",
        --             price = 5,
        --             data = {},
        --         },

        --     }
        -- },
    },
    Shops
)

function GenerateSerial()
    return "~r~Rayé"
end
function Shops:CreateShops()
    for i = 1, #Shops, 1 do
        v = Shops[i]
        if not v.Hidden then
            local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, v.Blips.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, v.Blips.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Blips.name)
            EndTextCommandSetBlipName(blip)
            Blips:AddBlip(blip, "Magasin", v.Blips)
        end
        Zone:Add(v.Pos, self.EnterZone, self.ExitZone, i, 2.5)
        Ped:Add(v.Ped.name, v.Ped.model, v.Pos, nil)
        RMenu.Add("shops", i, RageUI.CreateMenu(nil, "Objets disponibles", 10, 100, v.Menus.Sprite, v.Menus.Sprite))
    end
end

local CurrentZone = nil
function Shops.Open()
    RageUI.Visible(RMenu:Get("shops", CurrentZone), not RageUI.Visible(RMenu:Get("shops", CurrentZone)))
end

-- Citizen.CreateThread(function()
--     while true do
--         Wait(1)
--         local vehicle = (GetVehiclePedIsIn(LocalPlayer().Ped))
--         --print(vehicle)
--             local roll = GetEntityRoll(vehicle)
--             --print(roll)
--             if (roll > 15.0 or roll < -15.0) and GetEntitySpeed(vehicle) < 2 then
--                 DisableControlAction(2,59,true) -- Disable left/right
--                 DisableControlAction(2,60,true) -- Disable up/down
--             end

--     end

-- end)
function Shops.EnterZone(zone)
    while Job:Get() == nil do
        print("waiting")
        Wait(1)
    end
    local jobname = Job:Get().name
    local jobgrade = nil
    if Job:Get().grade[Job:Get().gradenum] ~= nil then
        jobgrade = Job:Get().grade[Job:Get().gradenum].name
    end
    local found1 = false
    if Shops[zone].RestrictedJob == nil then
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
        KeySettings:Add("keyboard", "E", Shops.Open, "Shop")
        KeySettings:Add("controller", 46, Shops.Open, "Shop")
        CurrentZone = zone
    else
        for i = 1, #Shops[zone].RestrictedJob, 1 do
            if Shops[zone].RestrictedJob[i] == jobname then
                found1 = true

                break
            end
        end
        if found1 then
            local found2 = falsew
            for i = 1, #Shops[zone].RestrictedGrade, 1 do
                if Shops[zone].RestrictedGrade[i] == jobgrade then
                    found2 = true
                    break
                end
            end
            if found2 then
                Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
                KeySettings:Add("keyboard", "E", Shops.Open, "Shop")
                KeySettings:Add("controller", 46, Shops.Open, "Shop")
                CurrentZone = zone
            end
        end
    end
end

function Shops.ExitZone(zone)
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get("shops", CurrentZone)) then
            RageUI.Visible(RMenu:Get("shops", CurrentZone), not RageUI.Visible(RMenu:Get("shops", CurrentZone)))
        end
        KeySettings:Clear("keyboard", "E", "Shop")
        KeySettings:Clear("controller", 46, "Shop")
        --Shops.Close()
        CurrentZone = nil
    end
end

Shops:CreateShops()
local currentHeader = true
dataonWait = {}
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if CurrentZone ~= nil then
                if RageUI.Visible(RMenu:Get("shops", CurrentZone)) then
                    RageUI.DrawContent(
                        {header = Shops[CurrentZone].Menus.Enabled, glare = false},
                        function()
                            for i = 1, #Shops[CurrentZone].Items, 1 do
                                RageUI.Button(
                                    Items[Shops[CurrentZone].Items[i].name].label,
                                    nil,
                                    {RightLabel = Shops[CurrentZone].Items[i].price .. "$"},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            local m = nil
                                            print(dump(Shops[CurrentZone].Items[i]))
                                            if Shops[CurrentZone].Items[i].fct ~= nil then
                                                print(Shops[CurrentZone].Items[i].type)
                                                m = Shops[CurrentZone].Items[i].fct()
                                                if Shops[CurrentZone].Items[i].type == "serial" then
                                                    Shops[CurrentZone].Items[i].data.serial = m
                                                elseif Shops[CurrentZone].Items[i].type == "number" then
                                                    Shops[CurrentZone].Items[i].data.num = m
                                                else
                                                    --("ods")
                                                    Shops[CurrentZone].Items[i].data[Shops[CurrentZone].Items[i].type] =
                                                        m
                                                end
                                            end

                                            local count = 1
                                            if
                                                (Shops[CurrentZone].Items[i].noCount ~= nil and
                                                    Shops[CurrentZone].Items[i].noCount == true)
                                             then
                                                count = 1
                                            else
                                                count = KeyboardInput("Combien ? ", 1, 3)
                                            end
                                            count = tonumber(count)

                                            if (Shops[CurrentZone].Items[i].beforePayment ~= nil) then
                                                local beforePayementResult = Shops[CurrentZone].Items[i].beforePayment()
                                                if beforePayementResult == false then
                                                    return
                                                end
                                            end

                                            if
                                                count ~= nil and
                                                    (Inventory.CanReceive(Shops[CurrentZone].Items[i].name, count) or
                                                        (Shops[CurrentZone].Items[i].noItem ~= nil and
                                                            Shops[CurrentZone].Items[i].noItem == true))
                                             then
                                                RageUI.GoBack()
                                                local noItemDelivery =
                                                    Shops[CurrentZone].Items[i].noItem ~= nil and
                                                    Shops[CurrentZone].Items[i].noItem == true
                                                local afterPaymentFct = nil

                                                if (Shops[CurrentZone].Items[i].afterPayment ~= nil) then
                                                    afterPaymentFct = Shops[CurrentZone].Items[i].afterPayment
                                                end

                                                ShowNotification(
                                                    "~g~Prix : " .. Shops[CurrentZone].Items[i].price * count .. "$"
                                                )
                                                items = {
                                                    name = Shops[CurrentZone].Items[i].name,
                                                    data = Shops[CurrentZone].Items[i].data,
                                                    noItem = noItemDelivery,
                                                    afterPayment = afterPaymentFct
                                                }
                                                InsertLog(
                                                    "achats",
                                                    "shops",
                                                    "achat item " ..
                                                        count ..
                                                            "x " ..
                                                                Shops[CurrentZone].Items[i].name ..
                                                                    " prix : " .. Shops[CurrentZone].Items[i].price
                                                )
                                                dataonWait = {
                                                    item = items,
                                                    price = Shops[CurrentZone].Items[i].price * count,
                                                    count = count
                                                }
                                                TriggerEvent("payWith?")
                                            --items = {name=Shops[CurrentZone].Items[i].name,data=Shops[CurrentZone].Items[i].data}
                                            -- AddItemtoInv(items)
                                            -- TriggerServerEvent("money:Pay", Shops[CurrentZone].Items[i].price )
                                            end
                                        end
                                    end
                                )
                            end
                            if #Shops[CurrentZone].Items == 0 then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                            end
                            if Shops[CurrentZone].braquable ~= false then
                                RageUI.Button(
                                    "~r~Braquer",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            if Shops[CurrentZone].bzone ~= "all" then
                                                TriggerServerCallback(
                                                    "service:Count",
                                                    function(nb)
                                                        if nb >= 2 then
                                                            TriggerServerCallback(
                                                                "braquage:Get",
                                                                function(bool)
                                                                    if bool then
                                                                        RageUI.GoBack()

                                                                        if not IsPedArmed(PlayerPedId(), 7) then
                                                                            return ShowNotification("~o~Même pas peur")
                                                                        end

                                                                        StartBraquo(Shops[CurrentZone].bzone)
                                                                        TriggerServerEvent("braquage:Add", CurrentZone)
                                                                    else
                                                                        ShowNotification("Les caisses sont ~r~vides")
                                                                    end
                                                                end,
                                                                CurrentZone
                                                            )
                                                        else
                                                            ShowNotification(
                                                                "Les caisses sont ~r~vides\n~y~Repassez plus tard"
                                                            )
                                                        end
                                                    end,
                                                    Shops[CurrentZone].bzone
                                                )
                                            else
                                                TriggerServerCallback(
                                                    "service:Count",
                                                    function(nbpolice)
                                                        TriggerServerCallback(
                                                            "service:Count",
                                                            function(nblssd)
                                                                allcount = nbpolice + nblssd
                                                                if allcount >= 2 then
                                                                    TriggerServerCallback(
                                                                        "braquage:Get",
                                                                        function(bool)
                                                                            if bool then
                                                                                RageUI.GoBack()
                                                                                if not IsPedArmed(PlayerPedId(), 7) then
                                                                                    return ShowNotification(
                                                                                        "~o~Même pas peur"
                                                                                    )
                                                                                end
                                                                                StartBraquo(Shops[CurrentZone].bzone)
                                                                                TriggerServerEvent(
                                                                                    "braquage:Add",
                                                                                    CurrentZone
                                                                                )
                                                                            else
                                                                                ShowNotification(
                                                                                    "Les caisses sont ~r~vides"
                                                                                )
                                                                            end
                                                                        end,
                                                                        CurrentZone
                                                                    )
                                                                else
                                                                    ShowNotification(
                                                                        "Les caisses sont ~r~vides\n~y~Repassez plus tard"
                                                                    )
                                                                end
                                                            end,
                                                            "lssd"
                                                        )
                                                    end,
                                                    "police"
                                                )
                                            end
                                        end
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end
            end
        end
    end
)
local filter = {"dollar1", "dollar5", "dollar10", "dollar50", "dollar100", "dollar500"}
local am = {1, 5, 10, 50, 100, 500}
local m = {
    dollar1 = {
        index = 1,
        label = {0}
    },
    dollar5 = {
        index = 1,
        label = {0}
    },
    dollar10 = {
        index = 1,
        label = {0}
    },
    dollar50 = {
        index = 1,
        label = {0}
    },
    dollar100 = {
        index = 1,
        label = {0}
    },
    dollar500 = {
        index = 1,
        label = {0}
    }
}

local function GetCurrentMoneySelected()
    local mo = 0
    for k, v in pairs(m) do
        if v.visible then
            p = string.gsub(tostring(k), "dollar", "")
            p = tonumber(p)
            mo = mo + (p * (v.index - 1))
        end
    end

    return mo
end

local function Refresh()
    for k, v in pairs(m) do
        if Inventory.Inventory[k] ~= nil then
            v.visible = true
            v.total = #Inventory.Inventory[k]
            for i = 0, #Inventory.Inventory[k], 1 do
                v.label[i + 1] = i
            end
            v.index = 1
        else
            v.total = 0
            v.visible = false
        end
    end
end
AddEventHandler(
    "payByCard",
    function()
        if Inventory.Inventory["bank_card"] == nil then
            if dataonWait.no ~= nil then
                dataonWait.no()
            end
            dataonWait = {}
            return ShowNotification("~r~Vous n'avez pas de cartes bancaires")
        else
            RageUI.Visible(RMenu:Get("personnal", "choose_card"), true)
        end
    end
)

AddEventHandler(
    "payByCash",
    function()
        if GetTotalMoney() < dataonWait.price then
            if dataonWait.no ~= nil then
                dataonWait.no()
            end
            dataonWait = {}
            return ShowNotification("~r~Vous n'avez pas assez d'argent")
        else
            Refresh()

            RageUI.Visible(RMenu:Get("personnal", "choose_money"), true)
        end
    end
)

RMenu.Add("personnal", "choose_card", RageUI.CreateMenu("aCore", "Cartes bancaire disponibles", 10, 200))
RMenu.Add("personnal", "choose_money", RageUI.CreateMenu("aCore", "Billets disponibles", 10, 200))
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("personnal", "choose_money")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        for k, v in pairs(m) do
                            if v.total > 0 then
                                RageUI.List(
                                    Items[k].label .. " (" .. v.total .. "x)",
                                    v.label,
                                    v.index,
                                    nil,
                                    {},
                                    v.visible,
                                    function(_, Active, Selected, Index)
                                        v.index = Index
                                        if Selected then
                                            local ask = KeyboardInput("Combien ? ~r~(MAX " .. v.total .. ")", nil)

                                            ask = tonumber(ask)
                                            if ask ~= nil then
                                                if ask <= v.total then
                                                    v.index = ask + 1
                                                end
                                            end
                                        end
                                    end
                                )
                            else
                                v.index = 1
                            end
                        end

                        RageUI.Button(
                            "Payer ",
                            nil,
                            {
                                RightLabel = "~g~(" ..
                                    dataonWait.price ..
                                        "$)~s~-" ..
                                            GetCurrentMoneySelected() ..
                                                "$ = " ..
                                                    math.floor(dataonWait.price - GetCurrentMoneySelected()) .. "$"
                            },
                            true,
                            function(_, H, S)
                                if S then
                                    local mT = math.floor(dataonWait.price - GetCurrentMoneySelected())
                                    if mT <= 0 then
                                        ShowNotification("~b~Paiement effectué")
                                        local t = {}
                                        for k, v in pairs(m) do
                                            if #v.label > 1 then
                                                t[k] = v
                                            end
                                            --v.index = 1
                                        end
                                        PayMoney(t)

                                        if m ~= 0 then
                                            ShowNotification("~y~Le vendeur vous rend " .. -mT .. "$")
                                            AddMoney(-mT)
                                        end
                                        if
                                            dataonWait.count ~= nil and dataonWait.item ~= nil and
                                                dataonWait.item.noItem ~= true
                                         then
                                            for i = 1, dataonWait.count, 1 do
                                                dataonWait.item.id = nil
                                                AddItemtoInv(dataonWait.item)
                                            end
                                        end
                                        if dataonWait.fct ~= nil then
                                            dataonWait.fct()
                                        end

                                        if dataonWait.item ~= nil and dataonWait.item.afterPayment ~= nil then
                                            dataonWait.item.afterPayment()
                                        end

                                        RageUI.GoBack()
                                    else
                                        ShowNotification("~r~Vous n'avez pas donné assez d'argent")
                                        if dataonWait.no ~= nil then
                                            dataonWait.no()
                                        end
                                    end
                                end
                            end
                        )
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("personnal", "choose_card")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        for i = 1, #Inventory.Inventory["bank_card"], 1 do
                            RageUI.Button(
                                Items["bank_card"].label .. " #" .. Inventory.Inventory["bank_card"][i].data.number,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local param = Inventory.Inventory["bank_card"][i].data
                                        local code = KeyboardInput("Veuillez entrer le code", nil, 4)
                                        code = tonumber(code)
                                        if code ~= nil then
                                            if code == param.code then
                                                TriggerServerCallback(
                                                    "getBankingAccountsPly2",
                                                    function(result)
                                                        local acc = result[1]
                                                        if acc.amount >= dataonWait.price then
                                                            ShowNotification("Paiement ~g~effectué")
                                                            local x, y, z = GetEntityCoords(PlayerPedId())
                                                            local current_zone = GetLabelText(GetNameOfZone(x, y, z))
                                                            local price = {
                                                                math.floor(
                                                                    (dataonWait.price - (dataonWait.price / 100)) *
                                                                        (100 - ConfigTax),
                                                                    0
                                                                ),
                                                                math.floor(
                                                                    (dataonWait.price - (dataonWait.price / 100)) *
                                                                        ConfigTax,
                                                                    0
                                                                )
                                                            }
                                                            if dataonWait.account ~= nil then
                                                                TriggerServerEvent(
                                                                    "bankingSendMoney",
                                                                    dataonWait.account,
                                                                    dataonWait.price,
                                                                    acc.iban
                                                                )
                                                                TriggerServerEvent(
                                                                    "newTransaction",
                                                                    acc.iban,
                                                                    dataonWait.account,
                                                                    dataonWait.price,
                                                                    "Achats via CB N°" ..
                                                                        param.number ..
                                                                            " adresse : " ..
                                                                                current_zone ..
                                                                                    " détail : " .. dataonWait.detail
                                                                )
                                                            else
                                                                TriggerServerEvent(
                                                                    "bankingRemoveFromAccount2",
                                                                    acc.iban,
                                                                    dataonWait.price
                                                                )
                                                                TriggerServerEvent(
                                                                    "newTransaction",
                                                                    acc.iban,
                                                                    "Service ville",
                                                                    dataonWait.price,
                                                                    "Achats via CB N°" ..
                                                                        param.number .. " adresse : " .. current_zone
                                                                )
                                                            end
                                                         --   TriggerServerEvent("bankingSendMoney","gouv",dataonWait.price,acc.iban)
                                                           -- TriggerServerEvent("newTransaction",acc.iban,"gouv",dataonWait.price,"Taxe -> Achats via CB N°" .. param.number .. " adresse : " .. current_zone  )
                                                            if dataonWait.item ~= nil and dataonWait.item.noItem ~= true then
                                                                for i = 1, dataonWait.count, 1 do
                                                                    dataonWait.item.id = nil
                                                                    AddItemtoInv(dataonWait.item)
                                                                end
                                                            end
                                                            if dataonWait.fct ~= nil then
                                                                dataonWait.fct()
                                                            end
                                                            if
                                                                dataonWait.item ~= nil and
                                                                    dataonWait.item.afterPayment ~= nil
                                                             then
                                                                dataonWait.item.afterPayment()
                                                            end
                                                            TriggerServerEvent("gcPhone:_internalAddMessage","Banque",ATM.Selected.phone_number,"Nouvel achat " .. amount .."$ vers " .. rib1 .. " à partir du compte " .. ATM.Selected.iban,false)
                                                            RageUI.GoBack()
                                                        else
                                                            ShowNotification("Paiement ~r~refusé !")
                                                        end
                                                    end,
                                                    param.account
                                                )
                                            else
                                                ShowNotification("~r~Code incorrect")
                                                RageUI.GoBack()
                                                if dataonWait.no ~= nil then
                                                    dataonWait.no()
                                                end
                                                dataonWait = {}
                                            end
                                        end
                                    end
                                end
                            )
                        end
                    end
                )
            end
        end
    end
)
