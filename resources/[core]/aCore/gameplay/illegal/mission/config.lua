missionConfig = {}

missionConfig.receleurPos = {
    {x = -467.76, y = -2699.06, z = 5.07, a = 215.92} --{x=3089.95,y=-4713.24,z=15.26,a=215.92}    --{x=-467.76,y=-2699.06,z=5.07,a=215.92}
}

missionConfig.receleurGoFastPos = {
    {
        name = "Angelo",
        pos = {x = 916.73, y = -1269.57, z = 24.56, a = 1.9}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "csb_ramp_hic"
    },
    {
        name = "Francesco",
        pos = {x = 733.48, y = -1311.22, z = 25.64, a = 75.88}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "ig_ramp_hic"
    },
    {
        name = "Giovanni",
        pos = {x = 644.13, y = -858.84, z = 13.67, a = 44.58}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "u_m_m_rivalpap"
    },
    {
        name = "Roberto",
        pos = {x = 1403.67, y = -568.93, z = 73.34, a = 125.99}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "cs_terry"
    },
    {
        name = "Lucas",
        pos = {x = 1125.1, y = -1406.63, z = 33.54, a = 280.9}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "mp_m_weapwork_01"
    },
    {
        name = "Alessandro",
        pos = {x = 1003.77, y = -1560.95, z = 29.77, a = 40.14}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "a_m_o_soucent_01"
    },
    {
        name = "Marco",
        pos = {x = 819.4, y = -2365.87, z = 29.16, a = 266.66}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "a_m_y_soucent_01"
    },
    {
        name = "Vincenzo",
        pos = {x = 158.33, y = -2968.5, z = 4.93, a = 189.44}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "u_m_m_rivalpap"
    },
    {
        name = "Vahid",
        pos = {x = 1198.31, y = -3112.5, z = 4.54, a = 246.35}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "u_m_m_rivalpap"
    },
    {
        name = "Ignacio",
        pos = {x = 511.1, y = -1985.86, z = 23.99, a = 264.14}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "u_m_m_rivalpap"
    }
}

missionConfig.startPointGoFast = {
    {pos = vector3(-2257.78, 4279.44, 44.55), heading = 45.54},
    {pos = vector3(-2258.85, 4276.27, 44.37), heading = 48.07},
    {pos = vector3(-2260.33, 4273.78, 44.19), heading = 46.09},
    {pos = vector3(-2262.56, 4271.54, 43.89), heading = 44.92},
    {pos = vector3(-2268.17, 4264.79, 43.1), heading = 57.96},
    {pos = vector3(-2270.44, 4262.13, 42.82), heading = 53.87},
    {pos = vector3(-2272.94, 4257.68, 42.5), heading = 52.81},
    {pos = vector3(-2272.7, 4280.81, 44.84), heading = 229.75},
    {pos = vector3(-2268.61, 4284.55, 45.43), heading = 239.82},
    {pos = vector3(-2252.63, 4301.77, 46.49), heading = 210.81},
    {pos = vector3(-2251.16, 4305.15, 46.5), heading = 215.86},
    {pos = vector3(-2192.44, 4247.84, 47.34), heading = 37.71},
    {pos = vector3(-2194.86, 4245.59, 47.2), heading = 35.74},
    {pos = vector3(-2197.43, 4243.73, 47.25), heading = 37.04}
}

missionConfig.boss = {
    {
        name = "Pablo",
        pos = {x = 473.52, y = -1310.39, z = 28.23, a = 202.32}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "g_m_m_chicold_01",
        missions = {"Récupération de véhicule", "Récupération de véhicule de luxe"}
    },
    {
        name = "Armando",
        pos = {x = -2175.59, y = 4294.85, z = 48.06, a = 240.76}, --{x=3091.76,y=-4712.5,z=15.26,a=202.32}, --{x=473.52,y=-1310.39,z=28.23,a=202.32},
        model = "u_m_m_promourn_01",
        missions = {"Go Fast - Cannabis", "Go Fast - Meth", "Go Fast - Cocaine", "Go Fast - Armes"}
    }
}

missionConfig.missionLists = {
    ["Récupération de véhicule"] = {
        levelRequired = 1,
        scenarioIndex = 1,
        policeRequired = 2,
        policeType = {"police"},
        scenarioType = "volvehicule",
        scenarioSettings = {
            cars = {"drafter", "novak", "hellion"},
            hours = 1
        },
        rewards = {
            ["items"] = {
                {
                    name = "water",
                    data = {}
                }
            },
            ["money"] = {
                amount = {150, 200}
            },
            ["xp"] = {300, 400}
        }
    },
    ["Récupération de véhicule de luxe"] = {
        levelRequired = 50,
        scenarioIndex = 1,
        policeRequired = 2,
        policeType = {"police"},
        scenarioType = "volvehicule",
        scenarioSettings = {
            cars = {"italigto", "schlagen", "toros"},
            hours = 1
        },
        rewards = {
            ["items"] = {
                {
                    name = "water",
                    data = {}
                }
            },
            ["money"] = {
                type = "clear",
                amount = {500, 650}
            },
            ["xp"] = {500, 600}
        }
    },
    -- GO FASTS - Armando
    ["Go Fast - Cannabis"] = {
        levelRequired = 1,
        scenarioIndex = 2,
        policeRequired = 2,
        policeType = {"lssd", "police"},
        scenarioType = "gofast",
        scenarioSettings = {
            configStart = {
                positions = {
                    {pos = vector3(-203.64, 6225.17, 31.31), heading = 226.1},
                    {pos = vector3(-118.57, 6211.48, 31.02), heading = 42.1},
                    {pos = vector3(67.39, 6308.24, 31.05), heading = 296.96},
                    {pos = vector3(-24.07, 6382.53, 31.14), heading = 222.36},
                    {pos = vector3(-32.17, 6373.44, 31.12), heading = 223.07},
                    {pos = vector3(14.25, 6354.99, 31.05), heading = 213.35},
                    {pos = vector3(194.56, 6380.45, 31.23), heading = 295.17},
                    {pos = vector3(-289.18, 6302.38, 31.31), heading = 136.82},
                    {pos = vector3(-344.5, 6246.61, 31.31), heading = 313.33},
                    {pos = vector3(-332.09, 6131.59, 31.3), heading = 312.37},
                    {pos = vector3(-700.91, 5781.44, 17.15), heading = 153.64},
                    {pos = vector3(-667.7, 5792.2, 17.15), heading = 61.75},
                    {pos = vector3(-442.12, 6342.33, 12.54), heading = 32.39},
                    {pos = vector3(-71.99, 6341.98, 31.31), heading = 225.13},
                    {pos = vector3(-64.31, 6501.61, 31.31), heading = 133.91},
                    {pos = vector3(-61.88, 6443.54, 31.31), heading = 44.5}
                },
                propInTrunk = "bkr_prop_weed_bigbag_03a"
            },
            cars = {
                "elegy",
                "kuruma",
                "sugoi"
            },
            minutes = 20
        },
        rewards = {
            ["items"] = {
                {
                    name = "water",
                    data = {}
                }
            },
            ["money"] = {
                amount = {450, 600}
            },
            ["xp"] = {650, 750}
        }
    },
    ["Go Fast - Meth"] = {
        levelRequired = 10,
        scenarioIndex = 2,
        policeRequired = 2,
        policeType = {"lssd", "police"},
        scenarioType = "gofast",
        scenarioSettings = {
            configStart = {
                positions = {
                    {pos = vector3(-203.64, 6225.17, 31.31), heading = 226.1},
                    {pos = vector3(-118.57, 6211.48, 31.02), heading = 42.1},
                    {pos = vector3(67.39, 6308.24, 31.05), heading = 296.96},
                    {pos = vector3(-24.07, 6382.53, 31.14), heading = 222.36},
                    {pos = vector3(-32.17, 6373.44, 31.12), heading = 223.07},
                    {pos = vector3(14.25, 6354.99, 31.05), heading = 213.35},
                    {pos = vector3(194.56, 6380.45, 31.23), heading = 295.17},
                    {pos = vector3(-289.18, 6302.38, 31.31), heading = 136.82},
                    {pos = vector3(-344.5, 6246.61, 31.31), heading = 313.33},
                    {pos = vector3(-332.09, 6131.59, 31.3), heading = 312.37},
                    {pos = vector3(-700.91, 5781.44, 17.15), heading = 153.64},
                    {pos = vector3(-667.7, 5792.2, 17.15), heading = 61.75},
                    {pos = vector3(-442.12, 6342.33, 12.54), heading = 32.39},
                    {pos = vector3(-71.99, 6341.98, 31.31), heading = 225.13},
                    {pos = vector3(-64.31, 6501.61, 31.31), heading = 133.91},
                    {pos = vector3(-61.88, 6443.54, 31.31), heading = 44.5}
                },
                propInTrunk = "ba_prop_battle_meth_bigbag_01a"
            },
            cars = {
                "elegy",
                "kuruma",
                "sugoi"
            },
            minutes = 20
        },
        rewards = {
            ["items"] = {
                {
                    name = "water",
                    data = {}
                }
            },
            ["money"] = {
                amount = {500, 650}
            },
            ["xp"] = {750, 850}
        }
    },
    ["Go Fast - Cocaine"] = {
        levelRequired = 20,
        scenarioIndex = 2,
        policeRequired = 3,
        policeType = {"lssd", "police"},
        scenarioType = "gofast",
        scenarioSettings = {
            configStart = {
                positions = {
                    {pos = vector3(-203.64, 6225.17, 31.31), heading = 226.1},
                    {pos = vector3(-118.57, 6211.48, 31.02), heading = 42.1},
                    {pos = vector3(67.39, 6308.24, 31.05), heading = 296.96},
                    {pos = vector3(-24.07, 6382.53, 31.14), heading = 222.36},
                    {pos = vector3(-32.17, 6373.44, 31.12), heading = 223.07},
                    {pos = vector3(14.25, 6354.99, 31.05), heading = 213.35},
                    {pos = vector3(194.56, 6380.45, 31.23), heading = 295.17},
                    {pos = vector3(-289.18, 6302.38, 31.31), heading = 136.82},
                    {pos = vector3(-344.5, 6246.61, 31.31), heading = 313.33},
                    {pos = vector3(-332.09, 6131.59, 31.3), heading = 312.37},
                    {pos = vector3(-700.91, 5781.44, 17.15), heading = 153.64},
                    {pos = vector3(-667.7, 5792.2, 17.15), heading = 61.75},
                    {pos = vector3(-442.12, 6342.33, 12.54), heading = 32.39},
                    {pos = vector3(-71.99, 6341.98, 31.31), heading = 225.13},
                    {pos = vector3(-64.31, 6501.61, 31.31), heading = 133.91},
                    {pos = vector3(-61.88, 6443.54, 31.31), heading = 44.5}
                },
                propInTrunk = "ba_prop_battle_coke_block_01a"
            },
            cars = {
                "elegy",
                "kuruma",
                "sugoi"
            },
            minutes = 20
        },
        rewards = {
            ["items"] = {
                {
                    name = "water",
                    data = {}
                }
            },
            ["money"] = {
                amount = {500, 650}
            },
            ["xp"] = {950, 1050}
        }
    },
    ["Go Fast - Armes"] = {
        levelRequired = 40,
        scenarioIndex = 2,
        policeRequired = 3,
        policeType = {"lssd", "police"},
        scenarioType = "gofast",
        scenarioSettings = {
            configStart = {
                positions = {
                    {pos = vector3(-203.64, 6225.17, 31.31), heading = 226.1},
                    {pos = vector3(-118.57, 6211.48, 31.02), heading = 42.1},
                    {pos = vector3(67.39, 6308.24, 31.05), heading = 296.96},
                    {pos = vector3(-24.07, 6382.53, 31.14), heading = 222.36},
                    {pos = vector3(-32.17, 6373.44, 31.12), heading = 223.07},
                    {pos = vector3(14.25, 6354.99, 31.05), heading = 213.35},
                    {pos = vector3(194.56, 6380.45, 31.23), heading = 295.17},
                    {pos = vector3(-289.18, 6302.38, 31.31), heading = 136.82},
                    {pos = vector3(-344.5, 6246.61, 31.31), heading = 313.33},
                    {pos = vector3(-332.09, 6131.59, 31.3), heading = 312.37},
                    {pos = vector3(-700.91, 5781.44, 17.15), heading = 153.64},
                    {pos = vector3(-667.7, 5792.2, 17.15), heading = 61.75},
                    {pos = vector3(-442.12, 6342.33, 12.54), heading = 32.39},
                    {pos = vector3(-71.99, 6341.98, 31.31), heading = 225.13},
                    {pos = vector3(-64.31, 6501.61, 31.31), heading = 133.91},
                    {pos = vector3(-61.88, 6443.54, 31.31), heading = 44.5}
                },
                propInTrunk = "prop_gun_case_02"
            },
            cars = {
                "elegy",
                "kuruma",
                "sugoi"
            },
            minutes = 20
        },
        rewards = {
            ["items"] = {
                {
                    name = "water",
                    data = {}
                }
            },
            ["money"] = {
                amount = {500, 850}
            },
            ["xp"] = {1300, 1400}
        }
    }
}
