PublicFarm = {

    --Point de drogue
    Weed = {
        recolte = {
            type = "recolte",
            workSize = 2.5,
            Pos = {x = 2226.15, y = 5575.95, z = 53.66},
            giveitem = "weed_graines",
            blip = "none",
            add = "~w~+ 1 ~r~Graine de Cannabis",
        },
        traitement = {
            type = "traitement",
            workSize = 1.5,
            blip = "none",
            Pos =  {x=-1323.54,y=-1236.19,z=4.62},
            required = "weed",
            giveitem = "weed_pooch",
            add = "~w~+ 1 Pochon de ~r~Cannabis"
        },
        vente = {
    		type = "vente",
            workSize = 1.5,
            blip = "none",
    		Pos = {x=1110.78,y=-464.64,z=67.31},
    		required = "weed_pooch",
    		RemoveItem = "weed_pooch",
    		price = math.random( 35,40 ),
    		add = "~w~- 1 Pochon de ~r~Cannabis"
    	},
    },
 --[[   Acide = {
        recolte = {
            type = "recolte",
            workSize = 1.5,
            Pos = {x=1396.31,y=3607.65,z=38.94},
            giveitem = "acidecoke",
            blip = "none",
            add = "~w~+ 1 Acide ~r~Sulfurique",
        },
    },
    Acetone = {
        recolte = {
            type = "recolte",
            workSize = 1.5,
            Pos = {x=114.55,y=-5.65,z=67.81},
            giveitem = "acetone",
            blip = "none",
            add = "~w~+ 1 ~r~Acetone",
        },
    },--]]
    Cocaine = {
        recolte = {
            type = "recolte",
            workSize = 2.5,
            Pos = {x=-278.99,y=2205.70,z=129.85},
            giveitem = "coke",
            blip = "none",
            add = "~w~+ 1 ~r~Cocaïne",
        },
        traitement = {
            type = "traitement",
            workSize = 1.5,
            blip = "none",
            Pos =  {x=3822.29,y=4470.70,z=5.53},
            required = "coke",
            giveitem = "coke1",
            add = "~w~+ 1 Pochon de ~r~Cocaïne"
        },
        vente = {
    		type = "vente",
            workSize = 1.5,
            blip = "none",
    		Pos = {x=548.51,y=-633.37,z=25.90},
    		required = "coke1",
    		RemoveItem = "coke1",
    		price = math.random( 55,60 ),
    		add = "~w~- 1 Pochon de ~r~Cocaïne"
    	},
    },
    Meth = {
        recolte = {
            type = "recolte",
            workSize = 1.5,
            Pos = {x=3190.79,y=5269.02,z=23.09},
            giveitem = "ephedrine",
            blip = "none",
            add = "~w~+ 1 ~r~Ephedrine",
        },
        traitement = {
            type = "traitement",
            workSize = 1.5,
            blip = "none",
            Pos =  {x=1181.20,y=-3113.76,z=6.02},
            required = {
                {name = "ephedrine" , count = 1},
             },
            giveitem = "meth",
            add = "~w~+ 1 Pochon de ~r~Meth"
        },
        vente = {
    		type = "vente",
            workSize = 1.5,
            blip = "none",
    		Pos = {x=684.911,y=-853.51,z=16.74},
    		required = "meth",
    		RemoveItem = "meth",
    		price = math.random( 60,80 ),
    		add = "~w~- 1 Pochon de ~r~Meth"
    	},
    },

--Job de farm public
    Vigneron = {
    	recolte = {
    		type = "recolte",
    		workSize = 1.5,
    		Pos = {x=-1814.76,y=2151.70,z=117.44},
    		giveitem = "raisin",
            blip = "none",
    		add = "~b~ +1 Raisin",
    	},
    	traitement = {
    		type = "traitement",
    		workSize = 1.5,
            blip = "none",
    		Pos = {x=346.44,y=3406.10,z=36.48},
    		required = "raisin",
    		giveitem = "jus_raisin",
            RemoveItem = "raisin",
    		add = "~b~ +1 Jus de jus de raisin"
    	},
    	vente = {
    		type = "vente",
    		workSize = 1.5,
    		Pos = {x=2874.01,y=4459.11,z=48.52},
            blip = "none",
    		required = "jus_raisin",
    		RemoveItem = "jus_raisin",
    		price = math.random( 10,20 ),
    		add = "~b~- 1 Jus de raisin"
    	},
    },

    Pecheur = {
    	recolte = {
    		type = "recolte",
    		workSize = 13.5,
    		Pos = {x = 100.34, y = 4042.98, z = 30.0},
    		giveitem = "poisson",
            blip = "none",
    		add = "~b~ +1 Poisson Chat",
            anim = {
    			lib = "amb@world_human_stand_fishing@base",
    			anim = "base"
    		},
    	},
        recolte2 = {
    		type = "recolte",
    		workSize = 13.5,
    		Pos = {x = 486.61, y = 3904.81, z = 30.0},
    		giveitem = "poisson2",
            blip = "none",
    		add = "~b~ +1 Brochet",
            anim = {
    			lib = "amb@world_human_stand_fishing@base",
    			anim = "base"
    		},
    	},
        recolte3 = {
    		type = "recolte",
    		workSize = 13.5,
    		Pos = {x = 869.91, y = 3872.93, z = 30.0},
    		giveitem = "poisson3",
            blip = "none",
    		add = "~b~ +1 Carpe",
            anim = {
    			lib = "amb@world_human_stand_fishing@base",
    			anim = "base",
    		},
    	},
        recolte4 = {
    		type = "recolte",
    		workSize = 13.5,
    		Pos = {x = 1200.18, y = 3947.33, z = 30.0},
    		giveitem = "poisson4",
            blip = "none",
    		add = "~b~ +1 Perche",
            anim = {
    			lib = "amb@world_human_stand_fishing@base",
    			anim = "base"
    		},
    	},
        recolte5 = {
    		type = "recolte",
    		workSize = 13.5,
    		Pos = {x = 1582.86, y = 4142.36, z = 30.0},
    		giveitem = "poisson5",
            blip = "none",
    		add = "~b~ +1 Gardon",
            anim = {
    			lib = "amb@world_human_stand_fishing@base",
    			anim = "base"
    		},
    	},
        recolte6 = {
    		type = "recolte",
    		workSize = 13.5,
    		Pos = {x = 1987.81, y = 4252.86, z = 30.0},
    		giveitem = "poisson6",
            blip = "none",
    		add = "~b~ +1 Silure Glane",
            anim = {
    			lib = "amb@world_human_stand_fishing@base",
    			anim = "base"
    		},
    	},
    	vente = {
    		type = "vente",
    		workSize = 1.5,
    		Pos = {x=1357.10,y=4386.39,z=44.34},
            blip = "none",
    		required = "poisson",
    		RemoveItem = "poisson",
    		price = math.random( 1,3 ),
    		add = "~b~- 1 Poisson Chat"
    	},
        vente2 = {
    		type = "vente",
    		workSize = 1.5,
    		Pos = {x=1529.78,y=3778.16,z=34.51},
            blip = "none",
    		required = "poisson2",
    		RemoveItem = "poisson2",
    		price = math.random( 2,5 ),
    		add = "~b~- 1 Brochet"
    	},
        vente3 = {
    		type = "vente",
    		workSize = 1.5,
    		Pos = {x=1915.85,y=582.68,z=176.36},
            blip = "none",
    		required = "poisson3",
    		RemoveItem = "poisson3",
    		price = math.random( 4,7 ),
    		add = "~b~- 1 Carpe"
    	},
        vente4 = {
    		type = "vente",
    		workSize = 1.5,
    		Pos = {x=-800.46,y=-1341.46,z=5.15},
            blip = "none",
    		required = "poisson4",
    		RemoveItem = "poisson4",
    		price = math.random( 5,8 ),
    		add = "~b~- 1 Perche"
    	},
        vente5 = {
    		type = "vente",
    		workSize = 1.5,
    		Pos = {x=-184.126,y=6541.67,z=11.09},
            blip = "none",
    		required = "poisson5",
    		RemoveItem = "poisson5",
    		price = math.random( 8,10 ),
    		add = "~b~- 1 Gardon"
    	},
        vente6 = {
    		type = "vente",
    		workSize = 1.5,
    		Pos = {x = 753.07, y = -3198.469, z = 5.181},
            blip = "none",
    		required = "poisson6",
    		RemoveItem = "poisson6",
    		price = math.random( 10,12 ),
    		add = "~b~- 1 Silure Glane"
    	},
    },

    Cueilleur = {
    	recolte = {
    		type = "recolte",
    		workSize = 1.5,
    		Pos = {x=363.24,y=6516.56,z=28.28},
    		giveitem = "pomme",
            blip = "none",
    		add = "~b~ +1 Pomme",
    	},
    	traitement = {
    		type = "traitement",
    		workSize = 1.5,
            blip = "none",
    		Pos = {x=460.49,y=3568.85,z=33.24},
    		required = "pomme",
    		giveitem = "jus_pomme",
            RemoveItem = "pomme",
    		add = "~b~ +1 Jus de pomme"
    	},
    	vente = {
    		type = "vente",
    		workSize = 1.5,
    		Pos = {x=1702.94,y=4936.09,z=42.07},
            blip = "none",
    		required = "jus_pomme",
    		RemoveItem = "jus_pomme",
    		price = math.random( 5,25 ),
    		add = "~b~- 1 Jus de pomme"
    	},
    },
    
}




local knockedOut = false
local wait = 15
local count = 60


function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
