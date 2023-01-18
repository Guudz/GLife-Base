Config = {

	-- repopulate the map with vehicles that were lost when the server rebooted
	populateOnReboot = false,
  
	-- save vehicle data on txAdmin scheduled restart
	txAdmin = false,
  
	-- how close a player needs to get to a deleted persistent vehicle before it is respawned
	respawnDistance = 350, -- 350+
  
	-- don't respawn a vehicle that's been destroyed
	forgetOnDestroyed = false,
  
	-- time in ms that the server waits before it attempts to spawn vehicles and update their properties/coords. 
	serverTickTime = 1500, -- anything lower than 1000 will cause unnecessary server load. Anything higher than 3000 may cause vehicle popping depending on "respawnDistance"
  
   -- enable debugging to see server console messages; can be toggled with server command: pv-toggle-debugging
	debug = false,
  }

-- doorlock

  Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = {"police", "lssd"},
		locked = false,
		maxDistance = 2.5,
		doors = {
			{objHash = 0xA3C5F5BC, objHeading = 270.0, objCoords = vector3(434.7, -980.6, 30.8)},
			{objHash = 0xA3C5F5BC, objHeading = -270.0, objCoords = vector3(434.7, -983.2, 30.8)}
		}
	},

	{
		textCoords = vector3(441.85, -998.27, 31.5),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = 0xA3C5F5BC, objHeading = 0.0, objCoords = vector3(440.73920, -998.74620, 30.81530)},
			{objHash = 0xA3C5F5BC, objHeading = 180.0, objCoords = vector3(443.06180, -998.74620, 30.81530)}
		}
	},

	{
		textCoords = vector3(457.02, -972.12, 31.5),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = 0xA3C5F5BC, objHeading = 0.0, objCoords = vector3(455.88620, -972.25430, 30.81531)},
			{objHash = 0xA3C5F5BC, objHeading = 180.0, objCoords = vector3(458.20870, -972.25430, 30.81531)}
		}
	},



	-- Parking
	{
		objHash = 0x6D191563,
		objHeading = 270.0,
		objCoords = vector3(464.15910, -974.66560, 26.37070),
		textCoords = vector3(464.1, -975.3, 27.1),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 2.5
	},

	{
		objHash = 0x6D191563,
		objHeading = 90.0,
		objCoords = vector3(464.15660, -997.50930, 26.37070),
		textCoords = vector3(464.1, -996.97, 27.1),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 2.5
	},

	-- Recepcion
	{
		objHash = 0xFA3CCA67,
		objHeading = 180.0,
		objCoords = vector3(440.52010, -986.23350, 30.82319),
		textCoords = vector3(441.19, -986.08, 31.5),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 2.5
	},
	{
		objHash = 0xAC27AE32,
		objHeading = 0.0,
		objCoords = vector3(440.52010, -977.60110, 30.82319),
		textCoords = vector3(441.19, -977.41, 31.5),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 2.5
	},

	-- Parking afuera
	{
		textCoords = vector3(471.41, -1009.0, 26.9),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = 0x8E5E7B9, objHeading = 90.0, objCoords = vector3(471.37580, -1010.19800, 26.40548)},
			{objHash = 0x8E5E7B9, objHeading = 270.0, objCoords = vector3(471.36790, -1007.79300, 26.40548)}
		}
	},

	{
		textCoords = vector3(468.72, -1000.43, 26.9),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = 0xEEC93374, objHeading = 180.0, objCoords = vector3(469.92740, -1000.54400, 26.40548)},
			{objHash = 0xEEC93374, objHeading = 0.0, objCoords = vector3(467.52220, -1000.54400, 26.40548)}
		}
	},



	-- Captain Office
	{
		objHash = 0Xfa3cca67,
		objHeading = 270.0,
		objCoords = vector3(458.65430, -990.64980, 30.82319),
		textCoords = vector3(458.65430, -990.0, 31.5),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 1.25
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objHash = 0xFCD204A6,
		objHeading = 180.0,
		objCoords = vector3(481.00840, -1004.11800, 26.48005),
		textCoords = vector3(481.65, -1004.11, 27.2),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 1.25
	},

	{
		objHash = 0xFCD204A6,
		objHeading = 270.0,
		objCoords = vector3(476.61570, -1008.87500, 26.48005),
		textCoords = vector3(476.61, -1008.28, 27.2),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 1.25
	},

	-- Cell 1
	{
		objHash = 0xFCD204A6,
		objHeading = 0.0,
		objCoords = vector3(477.91260, -1012.18900, 26.48005),
		textCoords = vector3(477.31, -1012.18900, 27.2),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 1.25
	},

	-- Cell 2
	{
		objHash = 0xFCD204A6,
		objHeading = 0.0,
		objCoords = vector3(480.91280, -1012.18900, 26.48005),
		textCoords = vector3(480.31, -1012.18900, 27.2),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 1.25
	},

	-- Cell 3
	{
		objHash = 0xFCD204A6,
		objHeading = 0.0,
		objCoords = vector3(483.91270, -1012.18900, 26.48005),
		textCoords = vector3(483.31, -1012.18900, 27.2),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 1.25
	},

	-- Cell 4
	{
		objHash = 0xFCD204A6,
		objHeading = 180.0,
		objCoords = vector3(484.17640, -1007.73400, 26.48005),
		textCoords = vector3(484.77, -1007.73400, 27.2),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 1.25
	},

	--
	-- Mission Row Back
	--

	-- Back Gate
	{
		objHash = GetHashKey('hei_prop_station_gate'),
		objHeading = 90.0,
		objCoords = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objHash = GetHashKey('v_ilev_shrfdoor'),
		objHeading = 30.0,
		objCoords = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = {"police", "lssd"},
		locked = false,
		maxDistance = 1.25
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = {"police", "lssd"},
		locked = false,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_shrf2door'), objHeading = 315.0, objCoords  = vector3(-443.1, 6015.6, 31.7)},
			{objHash = GetHashKey('v_ilev_shrf2door'), objHeading = 135.0, objCoords  = vector3(-443.9, 6016.6, 31.7)}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objHash = GetHashKey('prop_gate_prison_01'),
		objCoords = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 12,
		size = 2
	},

	{
		objHash = GetHashKey('prop_gate_prison_01'),
		objCoords = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = {"police", "lssd"},
		locked = true,
		maxDistance = 12,
		size = 2
	},
	    ----- PILLBOX
		{
			textCoords = vector3(303.87, -582.28, 43.28),
			authorizedJobs = {"lsms"},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -434783486, objHeading = 339.34, objCoords = vector3(302.80, -581.42, 43.43)},
				{objHash = -1700911976, objHeading = 340.00, objCoords = vector3(305.22, -582.31, 43.43)}
			}
		},
		{
			textCoords = vector3(325.16, -590.03, 43.28),
			authorizedJobs = {"lsms"},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -434783486, objHeading = 340.00, objCoords = vector3(324.24, -589.23, 43.43)},
				{objHash = -1700911976, objHeading = 340.00, objCoords = vector3(326.65, -590.11, 43.43)}
			}
		},
		{
			textCoords = vector3(327.27, -593.89, 43.28),
			authorizedJobs = {"lsms"},
			locked = true,
			maxDistance = 2.0,
			doors = {
				{objHash = -434783486, objHeading = 250.00, objCoords = vector3(328.14, -592.78, 43.43)},
				{objHash = -1700911976, objHeading = 250.00, objCoords = vector3(327.26, -595.20, 43.43)}
			}
		},
		----- UNICORN
		{
			objHash = GetHashKey("prop_strip_door_01"),
			objHeading = 30.00,
			objCoords = vector3(127.9, -1298.5, 29.41),
			textCoords = vector3(128.9, -1297.5, 29.41),
			authorizedJobs = {"unicorn"},
			locked = true,
			maxDistance = 1.50
		},
		{
			objHash = GetHashKey("prop_magenta_door"),
			objHeading = -149.82,
			objCoords = vector3(96.0, -1284.8, 29.4),
			textCoords = vector3(97.0, -1286.8, 29.4),
			authorizedJobs = {"unicorn"},
			locked = true,
			maxDistance = 1.50
		},
		{
			objHash = GetHashKey("v_ilev_roc_door2"),
			objHeading = 27.74,
			objCoords = vector3(134.48, -1290.6, 29.27),
			textCoords = vector3(134.48, -1290.6, 29.27),
			authorizedJobs = {"unicorn"},
			locked = true,
			maxDistance = 1.50
		},
		{
			objHash = GetHashKey("v_ilev_roc_door2"),
			objHeading = 298.04,
			objCoords = vector3(135.67, -1279.44, 29.42),
			textCoords = vector3(135.67, -1279.44, 29.42),
			authorizedJobs = {"unicorn"},
			locked = true,
			maxDistance = 1.50
		},
		-------- PRISON
	
		{
			objHash = GetHashKey("prop_gate_prison_01"),
			objHeading = 90.0,
			objCoords = vector3(1844.9, 2604.8, 44.6),
			textCoords = vector3(1844.9, 2608.5, 48.0),
			authorizedJobs = {"police"},
			locked = true,
			maxDistance = 16.0
		},
		{
			objHash = GetHashKey("prop_gate_prison_01"),
			objHeading = 90.0,
			objCoords = vector3(1818.5, 2604.8, 44.6),
			textCoords = vector3(1818.5, 2608.4, 48.0),
			authorizedJobs = {"police"},
			locked = true,
			maxDistance = 16.0
		},
	
		-------- BANQUE
	
		{
			objHash = GetHashKey("hei_v_ilev_bk_gate_pris"),
			objCoords = vector3(257.09, 220.59, 106.29),
			textCoords = vector3(257.09, 220.59, 106.29),
			authorizedJobs = {"banker"},
			locked = true,
			maxDistance = 1.50
		},
		{
			objHash = GetHashKey("v_ilev_bk_door"),
			objCoords = vector3(237.15, 228.26, 106.28),
			textCoords = vector3(237.15, 228.26, 106.28),
			authorizedJobs = {"banker"},
			locked = true,
			maxDistance = 1.50
		}
}


-- priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other people with priority
-- a lot of the steamid converting websites are broken rn and give you the wrong steamid. I use https://steamid.xyz/ with no problems.
-- you can also give priority through the API, read the examples/readme.
Config.Priority = {
    ["steam:110000133e1f3a4"] = 100
}

-- require people to run steam
Config.RequireSteam = false

-- "whitelist" only server
Config.PriorityOnly = false

-- disables hardcap, should keep this true
Config.DisableHardCap = true

-- will remove players from connecting if they don't load within: __ seconds; May need to increase this if you have a lot of downloads.
-- i have yet to find an easy way to determine whether they are still connecting and downloading content or are hanging in the loadscreen.
-- This may cause session provider errors if it is too low because the removed player may still be connecting, and will let the next person through...
-- even if the server is full. 10 minutes should be enough
Config.ConnectTimeOut = 600

-- will remove players from queue if the server doesn't recieve a message from them within: __ seconds
Config.QueueTimeOut = 90

-- will give players temporary priority when they disconnect and when they start loading in
Config.EnableGrace = false

-- how much priority power grace time will give
Config.GracePower = 5

-- how long grace time lasts in seconds
Config.GraceTime = 480

-- on resource start, players can join the queue but will not let them join for __ milliseconds
-- this will let the queue settle and lets other resources finish initializing
Config.JoinDelay = 30000

-- will show how many people have temporary priority in the connection message
Config.ShowTemp = false

-- simple localization
Config.Language = {
    joining = "\xF0\x9F\x8E\x89Connexion en cours...",
    connecting = "\xE2\x8F\xB3Connexion en cours...",
    idrr = "\xE2\x9D\x97[File D'attente] Erreur: impossible de récupérer vos identifiants, essayez de redémarrer.",
    err = "\xE2\x9D\x97[File D'attente] Il y avait une erreur",
    pos = "\xF0\x9F\x90\x8CVous êtes %d/%d dans la file d'attente \xF0\x9F\x95\x9C%s",
    connectingerr = "\xE2\x9D\x97[File D'attente] Erreur: erreur lors de l'ajout à la liste de connexion",
    timedout = "\xE2\x9D\x97[File D'attente] Erreur: expiration du délai ?",
    wlonly = "\xE2\x9D\x97[RainLayer City] Ce serveur ouvre samedi 29 mai, discord.gg/rainlayercity",
    steam = "\xE2\x9D\x97 [RainLayer City] Erreur: Steam doit être en cours d'exécution"
}