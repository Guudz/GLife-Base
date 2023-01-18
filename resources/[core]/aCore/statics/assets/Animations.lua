Animations = {
	["S'asseoir"] = {
		{ name = "Accouder flow 01", anim = {"missheistdockssetup1ig_12@base", "talk_gantry_idle_base_worker2"}, func = 1 },
		{ name = "Accouder flow 02", anim = {"missheistdockssetup1ig_12@base", "talk_gantry_idle_base_worker4"}, func = 1 },
		{ name = "S'asseoir au sol", anim = {"anim@heists@fleeca_bank@ig_7_jetski_owner","owner_idle"}, func = 1 },
		{ name = "Se poser contre un mur", anim = "WORLD_HUMAN_LEANING"},
		{ name = "S'asseoir par terre", anim = "WORLD_HUMAN_PICNIC"},
		{ name = "S'asseoir cool 2", anim = {"anim@heists@heist_safehouse_intro@phone_couch@male", "phone_couch_male_idle"}, func = 1, a = -180.0 },
		{ name = "Méditation", anim = {"rcmcollect_paperleadinout@", "meditiate_idle"}, func = 1},
		{ name = "Genoux au sol", anim = { "amb@medic@standing@kneel@base", "base" }, func = 1 },
		{ name = "S'asseoir chill", anim = {"missheistpaletoscoresetupleadin", "rbhs_mcs_1_leadin"}, func = 1, a = -180.0 },
		{ name = "S'asseoir cool", anim = {"missfam2leadinoutmcs3", "onboat_leadin_pornguy_a"}, func = 1, a = -180.0 },
	},
	["Actions anim"] = {
		{ name = "Slide", anim = { "anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a"} },
		{ name = "Reverence ", anim = { "anim@arena@celeb@podium@no_prop@", "regal_c_1st"} },
		{ name = "Pleure a genoux", anim = { "mp_bank_heist_1", "f_cower_01" }, func = 1 },
		{ name = "Noter des informations", anim = "WORLD_HUMAN_CLIPBOARD"},
		{ name = "Siffler", anim = {"rcmnigel1c", "hailing_whistle_waive_a"}, func = 48 },
		{ name = "Faire des pompes", anim = "WORLD_HUMAN_PUSH_UPS"},
		{ name = "Je me sens pas bien", anim = {"missfam5_blackout", "pass_out" } },
		{ name = "Locoooo", anim = {"anim@mp_player_intcelebrationmale@you_loco", "you_loco" } },
		{ name = "Wank", anim = {"anim@mp_player_intcelebrationmale@wank", "wank" } },
		{ name = "Laché moi", anim = {"anim@mp_player_intcelebrationmale@freakout", "freakout" } },
		{ name = "Mendier", anim = "WORLD_HUMAN_BUM_FREEWAY"},
		{ name = "Applaudir", anim = "WORLD_HUMAN_CHEERING"},
		{ name = "Slow Clap", anim = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap" } },
		{ name = "Appel téléphonique", anim = {"cellphone@", "cellphone_call_listen_base"}, func = 49 },
		{ name = "Encouragement", anim = {"mini@triathlon", "male_one_handed_a"}},
		{ name = "Prendre une photo", anim = "WORLD_HUMAN_MOBILE_FILM_SHOCKING"},
		{ name = "Bras tendu", anim = {"nm@hands", "flail"}, func = 1},
		{ name = "Yoga", anim = {"amb@world_human_yoga@male@base", "base_a"}},
		{ name = "Mîme", anim = {"special_ped@mime@monologue_5@monologue_5a", "10_ig_1_wa_0"}},
		{ name = "Faire des abdos", anim = "WORLD_HUMAN_SIT_UPS"},
		{ name = "Sortir votre carte", anim = "WORLD_HUMAN_TOURIST_MAP"},
		{ name = "Acrobatie 1", anim = { "anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a"} },
		{ name = "Acrobatie 2", anim = { "anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a"} },
		{ name = "Acrobatie 3", anim = { "anim@arena@celeb@flat@solo@no_props@", "pageant_a_player_a"} },
		{ name = "Radio", anim = {"random@arrests","generic_radio_chatter"}, func = 49 },
	},
	["Gestures"] = {
		{ name = "Bise au doigt", anim = { "anim@mp_player_intcelebrationfemale@finger_kiss", "finger_kiss" } },
		{ name = "Quoi", anim = {"gestures@f@standing@casual", "gesture_bring_it_on"}, func = 48 },
		{ name = "Casse-toi", anim = {"gestures@f@standing@casual", "gesture_bye_hard"}, func = 48 },
		{ name = "Salut", anim = {"gestures@f@standing@casual", "gesture_bye_soft"}, func = 48 },
		{ name = "Viens voir", anim = {"gestures@f@standing@casual", "gesture_come_here_hard"}, func = 48 },
		{ name = "Allez viens..", anim = {"gestures@f@standing@casual", "gesture_come_here_soft"}, func = 48 },
		{ name = "Damn", anim = {"gestures@f@standing@casual", "gesture_damn"}, func = 48 },
		{ name = "Tsss", anim = {"gestures@f@standing@casual", "gesture_displeased"}, func = 48 },
		{ name = "Hey calme", anim = {"gestures@f@standing@casual", "gesture_easy_now"}, func = 48 },
		{ name = "ICI", anim = {"gestures@f@standing@casual", "gesture_hand_down"}, func = 48 },
		{ name = "Gauche", anim = {"gestures@f@standing@casual", "gesture_hand_left"}, func = 48 },
		{ name = "Droite", anim = {"gestures@f@standing@casual", "gesture_hand_right"}, func = 48 },
		{ name = "Oh non", anim = {"gestures@f@standing@casual", "gesture_head_no"}, func = 48 },
		{ name = "Hey toi", anim = {"gestures@f@standing@casual", "gesture_hello"}, func = 48 },
		{ name = "Lourd", anim = {"gestures@f@standing@casual", "gesture_i_will"}, func = 48 },
		{ name = "Moi ?!", anim = {"gestures@f@standing@casual", "gesture_me_hard"}, func = 48 },
		{ name = "Moi", anim = {"gestures@f@standing@casual", "gesture_me"}, func = 48 },
		{ name = "Pas moyen", anim = {"gestures@f@standing@casual", "gesture_no_way"}, func = 48 },
		{ name = "Non non", anim = {"gestures@f@standing@casual", "gesture_nod_no_hard"}, func = 48 },
		{ name = "Non soft", anim = {"gestures@f@standing@casual", "gesture_nod_no_soft"}, func = 48 },
		{ name = "Oui fonce", anim = {"gestures@f@standing@casual", "gesture_nod_yes_hard"}, func = 48 },
		{ name = "Mouai", anim = {"gestures@f@standing@casual", "gesture_nod_yes_soft"}, func = 48 },
		{ name = "C'est ça", anim = {"gestures@f@standing@casual", "gesture_pleased"}, func = 48 },
		{ name = "My man", anim = {"gestures@f@standing@casual", "gesture_point"}, func = 48 },
		{ name = "Aucune idée", anim = {"gestures@f@standing@casual", "gesture_shrug_hard"}, func = 48 },
		{ name = "Aucune idée soft", anim = {"gestures@f@standing@casual", "gesture_shrug_soft"}, func = 48 },
		{ name = "Quoi ?!", anim = {"gestures@f@standing@casual", "gesture_what_hard"}, func = 48 },
		{ name = "Quoi soft", anim = {"gestures@f@standing@casual", "gesture_what_soft"}, func = 48 },
		{ name = "Toi", anim = {"gestures@f@standing@casual", "gesture_you_hard"}, func = 48 },
		{ name = "Toi soft", anim = {"gestures@f@standing@casual", "gesture_you_soft"}, func = 48 },
		{ name = "C'est à moi", anim = {"gestures@f@standing@casual", "getsure_its_mine"}, func = 48 },
	},
	["Expressions"] = {
		{ name = "Loose Thumbs 1", anim = { "anim@arena@celeb@flat@solo@no_props@", "thumbs_down_a_player_a" }, func = 48 },
		{ name = "Mort de rire", anim = { "anim@arena@celeb@flat@solo@no_props@", "taunt_d_player_b" } },
		{ name = "Badmood 1", anim = { "amb@world_human_stupor@male@base", "base" }, func = 1 },
		{ name = "Badmood 2", anim = { "amb@world_human_stupor@male_looking_left@base", "base" }, func = 1 },
		{ name = "Bisou", anim = {"mp_ped_interaction", "kisses_guy_a"}},
		{ name = "Stressé", anim = {"rcmme_tracey1", "nervous_loop"}, func = 1 },
		{ name = "Peace", anim = {"anim@mp_player_intcelebrationmale@peace", "peace" }, func = 48 },
		{ name = "Clown teubé", anim = {"move_clown@p_m_two_idles@", "fidget_short_dance"}},
		{ name = "Face Palm", anim = {"anim@mp_player_intcelebrationmale@face_palm", "face_palm"}},
		{ name = "Patience", anim = {"special_ped@impotent_rage@base", "base"}, func = 1 },
		{ name = "Respect", anim = {"mp_player_int_upperbro_love", "mp_player_int_bro_love_fp"}, func = 48},
		{ name = "Inspecter ses lunettes", anim = {"clothingspecs", "try_glasses_positive_a"}, func = 48},
		{ name = "Réflexion", anim = {"misscarsteal4@aliens", "rehearsal_base_idle_director"}, func = 49},
		{ name = "Check mon flow", anim = {"clothingshirt", "try_shirt_positive_d"}, func = 48},
		{ name = "VICTOIRE", anim = {"mini@tennisexit@", "tennis_outro_win_01_female"}},
		{ name = "Le plus fort", anim = {"rcmbarry", "base"}},
		{ name = "Ta géré!", anim = {"anim@mp_player_intcelebrationmale@thumbs_up", "thumbs_up" } },
		{ name = "Mal de tête", anim = {"misscarsteal4@actor", "stumble"}},
		{ name = "Bro love", anim = {"anim@mp_player_intcelebrationmale@bro_love", "bro_love" } },
		{ name = "Craquer les poignets", anim = {"anim@mp_player_intcelebrationmale@knuckle_crunch", "knuckle_crunch"}},
		{ name = "Salut militaire", anim = {"anim@mp_player_intuppersalute", "idle_a"}, func = 49},
		{ name = "Signe GSF", anim = {"amb@code_human_in_car_mp_actions@gang_sign_b@low@ps@base", "idle_a" }, func = 48 },
		{ name = "Signe Vagos", anim = {"amb@code_human_in_car_mp_actions@v_sign@std@rds@base", "idle_a" }, func = 48 },
		{ name = "Signe Ballas", anim = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b" }, func = 48 },
		{ name = "Signe Gang", anim = { "mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a" }, func = 48 },
		{ name = "Check moi ça !", anim = {"mp_ped_interaction", "handshake_guy_a" } },
		{ name = "Check moi ça 2", anim = {"mp_ped_interaction", "hugs_guy_a"}},
		{ name = "A vos marque ! Partez !", anim = {"random@street_race", "grid_girl_race_start" } },
		{ name = "Il a gagné !", anim = {"random@street_race", "_streetracer_accepted" } },
		{ name = "Ceinturons", anim = {"amb@code_human_wander_idles_cop@male@static", "static" }, func = 49 },
		{ name = "On arrête tous !", anim = {"anim@heists@ornate_bank@chat_manager", "fail" }, func = 48 },
	},
	["Poses"] = {
		{ name = "Prière", anim = {"rcmepsilonism8", "worship_base"}, func = 1 },
		{ name = "Faire du stop", anim = {"random@hitch_lift", "idle_f"}, func = 1 },
		{ name = "Se rendre, à genoux", anims = {
				enter = { { anim = {"random@arrests@busted", "enter"}, flag = 0 }, { anim = {"random@arrests@busted", "idle_a"}, flag = 1 } },
				exit = { { anim = {"random@arrests@busted", "exit"}, flag = 0 } }
			}
		},
		{ name = "Dormir sur place", anim = {"mp_sleep", "sleep_loop"}, func = 49},
		{ name = "PLS", anim = {"timetable@tracy@sleep@", "idle_c"}, func = 1},
		{ name = "Roule au sol", anim = {"missfinale_a_ig_2", "trevor_death_reaction_pt"}, func = 2 },
		{ name = "Blessé au sol", anim = {"combat@damage@rb_writhe", "rb_writhe_loop"}, func = 1 },
		{ name = "Désespéré", anim = {"rcmnigel1c", "idle_d"}, func = 1 },
		{ name = "Essouffler", anim = {"re@construction", "out_of_breath"}},
		{ name = "Faire la statue", anim = "WORLD_HUMAN_HUMAN_STATUE"},
		{ name = "Montrer ses muscles", anim = "WORLD_HUMAN_MUSCLE_FLEX"},
		{ name = "Montrer c’est muscle 2", anim = {"rcmnigel1bnmt_1b", "that_had_to_be_tyler" } },
		{ name = "Méditation extrême", anim = {"misscarsteal1leadin", "devon_idle_02"}, func = 1},
		{ name = "Zombie", anim = {"special_ped@zombie@monologue_1@monologue_1c", "iamundead_2"}, func = 1},
		{ name = "Pose garde", anim = {"amb@world_human_stand_guard@male@base", "base"}, func = 49 },

		{ name = "Bras croisé lourd", anim = {"anim@heists@heist_corona@single_team", "single_team_loop_boss"}, func = 1 },
		{ name = "Faire le maik", anim = {"anim@heists@heist_corona@single_team", "single_team_intro_two"}, func = 49 },
		{ name = "Bras croisé", anim = {"random@street_race", "_car_b_lookout" }, func = 1 },
		{ name = "Holster", anim = {"reaction@intimidation@cop@unarmed", "intro"}, func = 50 },
		{ name = "Patauge",anim = {"move_m@wading", "walk"}},
	},
	["Festives"] = {
		{ name = "Suspens", anim = { "anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_11_v1_male^1" }, f = 1 }, -- content
		{ name = "Coincé", anim = { "anim@amb@nightclub@dancers@black_madonna_entourage@", "li_dance_facedj_15_v2_male^2" }, f = 1 }, -- content
		{ name = "Enchainé", anim = { "anim@amb@nightclub@dancers@black_madonna_entourage@", "hi_dance_facedj_09_v2_male^5" }, f = 1 }, -- content
		{ name = "Hey man", anim = { "anim@amb@nightclub@dancers@club_ambientpeds@", "mi-hi_amb_club_09_v1_male^1" }, f = 1 }, -- content
		{ name = "Move 01", anim = {"anim@mp_player_intupperuncle_disco", "idle_a"}, func = 1 },
		{ name = "Move 02", anim = {"anim@mp_player_intuppersalsa_roll", "idle_a"}, func = 1 },
		{ name = "Move 03", anim = {"anim@mp_player_intupperraise_the_roof", "idle_a"}, func = 1 },
		{ name = "Move 04", anim = {"anim@mp_player_intupperoh_snap", "idle_a"}, func = 1 },
		{ name = "Move 05", anim = {"anim@mp_player_intupperheart_pumping", "idle_a"}, func = 1 },
		{ name = "Move 06", anim = {"anim@mp_player_intupperfind_the_fish", "idle_a"}, func = 1 },
		{ name = "Move 07", anim = {"anim@mp_player_intuppercats_cradle", "idle_a"}, func = 1 },
		{ name = "Move 08", anim = {"anim@mp_player_intupperbanging_tunes", "idle_a"}, func = 1 },
		{ name = "Move 09", anim = {"anim@mp_player_intupperbanging_tunes_right", "idle_a"}, func = 1 },
		{ name = "Move 10", anim = {"anim@mp_player_intupperbanging_tunes_left", "idle_a"}, func = 1 },
		{ name = "Jouer de la musique", anim = "WORLD_HUMAN_MUSICIAN"},
		{ name = "DJ", anim = {"anim@mp_player_intcelebrationmale@dj", "dj"} },
		{ name = "Fausse guitare", anim = {"anim@mp_player_intcelebrationmale@air_guitar", "air_guitar"} },
		{ name = "Mains Jazz", anim = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands"} },
		{ name = "Rock'n roll", anim = {"anim@mp_player_intcelebrationmale@rock", "rock"} },
		{ name = "Faire la fête", anim = "WORLD_HUMAN_PARTYING"},
	},
	["Insolentes"] = {
		{ name = "MDR", anim = { "anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_a" } },
		{ name = "Se curer le nez", anim = {"anim@mp_player_intcelebrationmale@nose_pick", "nose_pick"}},
		{ name = "Bouffe mon doigt", anim = {"anim@mp_player_intcelebrationmale@finger", "finger" } },
		{ name = "Prend mon fuck", anim = {"random@shop_gunstore", "_negative_goodbye"}},
		{ name = "Nananère", anim = {"anim@mp_player_intcelebrationmale@thumb_on_ears", "thumb_on_ears" } },
		{ name = "Vomir", anim = {"missfam5_blackout", "vomit" } },
		{ name = "DTC", anim = {"anim@mp_player_intcelebrationmale@dock", "dock" } },
		{ name = "Chuuuuute", anim = {"anim@mp_player_intcelebrationmale@shush", "shush"}},
		{ name = "Poule Mouillé", anim = {"anim@mp_player_intcelebrationmale@chicken_taunt", "chicken_taunt" } },
		{ name = "Doigt solo", anims = {
				enter = { { anim = { "anim@mp_player_intselfiethe_bird", "enter"} }, { anim = { "anim@mp_player_intselfiethe_bird", "idle_a" }, flag = 49 } },
				exit = { { anim = { "anim@mp_player_intselfiethe_bird", "idle_a" } }, { anim = { "anim@mp_player_intselfiethe_bird", "exit" } } },
			}
		},
		{ name = "Doigt d'honneur", anim = {"mp_player_int_upperfinger", "mp_player_int_finger_01"}, func = 49},
		{ name = "Uriner", anim = {"misscarsteal2peeing", "peeing_intro"}},
		{ name = "Se gratter le cul", anim = {"mp_player_int_upperarse_pick", "mp_player_int_arse_pick"}, func = 49},
		{ name = "Se gratter les couilles", anim = {"mp_player_int_uppergrab_crotch", "mp_player_int_grab_crotch"}, func = 49},
		{ name = "Pluie de fric", anim = { "anim@arena@celeb@flat@solo@props@", "make_it_rain_b_player_b" } },
		{ name = "Pluie de fric 2", anim = { "anim@mp_player_intcelebrationmale@raining_cash", "raining_cash" } },
	},
	["Sexe"] = {
		{ name = "Fellation", anim = {"misscarsteal2pimpsex", "pimpsex_hooker"}},
		{ name = "Se faire sucer 01", anim = {"misscarsteal2pimpsex", "pimpsex_pimp"}},
		{ name = "Se faire sucer 02", anim = {"misscarsteal2pimpsex", "pimpsex_punter"}},
		{ name = "Danse sexy", anim = {"mp_safehouse", "lap_dance_girl"}},
		{ name = "Danse Twerk", anim = {"mini@strip_club@private_dance@part3", "priv_dance_p3"}},
		{ name = "Montrer sa poitrine", anim = {"mini@strip_club@backroom@", "stripper_b_backroom_idle_b"}},
		{ name = "Montrer ses fesses", anim = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper"}, func = 49},
		{ name = "Se faire su*** en voiture", anim = {"oddjobs@towing", "m_blow_job_loop"}, func = 49},
	    { name = "Faire une gaterie en voiture", anim = {"oddjobs@towing", "f_blow_job_loop"}, func = 49},
	    { name = "***** en voiture", anim = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_player"}, func = 49},
	    { name = "Se ***** en voiture", anim = {"mini@prostitutes@sexlow_veh", "low_car_sex_loop_female"}, func = 49},
		{ name = "Mon coeur", anim = {"mini@hookers_spvanilla", "idle_a"}},
	},
	["Danses"] = {
		{ name = "Danser", anim = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao"}},
		{ name = "Danser stylé", anim = {"missfbi3_sniping", "dance_m_default"}, func = 1},
		{ name = "Danse banale", anim = {"rcmnigel1bnmt_1b", "dance_loop_tyler"}, func = 1},

		{ name = "Danse spéciale 01", anim = {"timetable@tracy@ig_5@idle_a", "idle_a"}, func = 1},
		{ name = "Danse spéciale 02", anim = {"timetable@tracy@ig_5@idle_a", "idle_b"}, func = 1},
		{ name = "Danse spéciale 03", anim = {"timetable@tracy@ig_5@idle_b", "idle_e"}, func = 1},
		{ name = "Danse spéciale 04", anim = {"timetable@tracy@ig_5@idle_b", "idle_d"}, func = 1},
		{ name = "Danse de pecno ", anim = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag" }, func = 1 },
		{ name = "Danse basique", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_06_base_laz"}, func = 1 },
		{ name = "Danse turnaround", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_turnaround_laz"}, func = 1 },
		{ name = "Danse crotchgrab", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_13_crotchgrab_laz"}, func = 1 },
		{ name = "Danse flying", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_13_flyingv_laz"}, func = 1 },
		{ name = "Danse robot", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_15_robot_laz"}, func = 1 },
		{ name = "Danse shimmy", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_15_shimmy_laz"}, func = 1 },
		{ name = "Danse crazyrobot", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_15_crazyrobot_laz"}, func = 1 },
		{ name = "Danse smack", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_17_smackthat_laz"}, func = 1 },
		{ name = "Danse spider", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_17_spiderman_laz"}, func = 1 },
		{ name = "Danse hipswivel", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_li_13_hipswivel_laz"}, func = 1 },
		{ name = "Danse Grind", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_li_15_sexygrind_laz"}, func = 1 },
		{ name = "Danse point", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_11_pointthrust_laz"}, func = 1 },
		{ name = "Danse miturn", anim = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_mi_13_turnaround_laz"}, func = 1 },
		{ name = "Danse du ventre", anim = {"mini@strip_club@private_dance@idle", "priv_dance_idle"}, func = 1 },

		{ name = "Dance Salsa Roll", anim = { "anim@mp_player_intcelebrationmale@salsa_roll", "salsa_roll" }, func = 1 },
		{ name = "Danse de soirée 1", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v1_male^4" }, func = 1 },
		{ name = "Danse de soirée 2", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^1" }, func = 1 },
		{ name = "Danse de soirée 3", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_female^2" }, func = 1 },
		{ name = "Danse de soirée 4", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_09_v2_male^2" }, func = 1 },
		{ name = "Danse de soirée 5", anim = { "anim@amb@nightclub@dancers@crowddance_facedj@", "hi_dance_facedj_11_v2_male^2" }, func = 1 },
		{ name = "Danse de soirée 6", anim = { "anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v1_female^1" }, func = 1 },
		{ name = "Danse de soirée 7", anim = { "anim@amb@nightclub@dancers@crowddance_groups@", "hi_dance_crowd_09_v1_female^3" }, func = 1 },
		{ name = "Danse de soirée 8", anim = { "anim@amb@nightclub@djs@black_madonna@", "dance_b_idle_a_blamadon" }, func = 1 },
		{ name = "Danse de soirée 9", anim = { "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center" }, func = 1 },
		{ name = "Danse de soirée 10", anim = { "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center" }, func = 1 },
		{ name = "Danse de soirée 11", anim = { "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up" }, func = 1 },
		{ name = "Dance Disco", anim = { "anim@mp_player_intcelebrationmale@uncle_disco", "uncle_disco" }, func = 1 },
	},
	["Armes"] = {
		{ name = "Tenue classique", anim = {}, func = function(p) SetWeaponAnimationOverride(p, GetHashKey("Default")) end },
		{ name = "Tenue gangster", anim = {}, func = function(p) SetWeaponAnimationOverride(p, GetHashKey("Gang1H")) ShowAboveRadarMessage("~r~Ne fonctionne pas avec toutes les armes.") end },
		{ name = "Tenue 007", anim = {}, func = function(p) SetWeaponAnimationOverride(p, GetHashKey("Hillbilly")) ShowAboveRadarMessage("~r~Ne fonctionne pas avec toutes les armes.") end },
		{ name = "Tenue débutant", anim = {}, func = function(p) SetWeaponAnimationOverride(p, GetHashKey("FirstPersonAiming")) end },
		{ name = "Animation execution", anim = {"oddjobs@suicide", "bystander_pointinto"}, func = 50 },
		{ name = "Animation suicide", anim = {"mp_suicide", "pistol"}, func = 2 },
		{ name = "Check arme", anim = {"mp_corona@single_team", "single_team_intro_one"}},
		{ name = "Arme pointé", anim = {"random@arrests", "cop_gunaimed_door_open_idle"}},
		{ name = "Melée 1", anim = {"anim@deathmatch_intros@melee@2h", "intro_male_melee_2h_b"}},
		{ name = "Melée 2", anim = {"anim@deathmatch_intros@melee@1h", "intro_male_melee_1h_b"}},
		{ name = "Melée 3", anim = {"anim@deathmatch_intros@melee@1h", "intro_male_melee_1h_c"}},
		{ name = "Melée 4", anim = {"mp_deathmatch_intros@melee@2h", "intro_male_melee_2h_d"}},
		{ name = "Melée 5", anim = {"mp_deathmatch_intros@melee@2h", "intro_male_melee_2h_a_gclub"}},
		{ name = "Melée 6", anim = {"mp_deathmatch_intros@melee@1h", "intro_male_melee_1h_b"}},
		{ name = "Fight 1", anim = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e"}},
		{ name = "Fight 2", anim = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_d"}},
		{ name = "Fight 3", anim = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_b"}},
	},
}


demarcheAnim = {
	{ name = "Normale" },
	{ name = "Arrogant", dict = "move_f@arrogant@a" },
	{ name = "Blessé", dict = "move_m@injured" },
	{ name = "Brute", dict = "MOVE_M@TOUGH_GUY@" },
	{ name = "Business", dict = "move_m@business@b" },
	{ name = "Buzzed", dict = "move_m@buzzed" },
	{ name = "Casu A", dict = "move_m@casual@d" },
	{ name = "Casu B", dict = "move_m@casual@e" },
	{ name = "Chic", dict = "move_m@posh@" },
	{ name = "Chichi", dict = "move_f@chichi" },
	{ name = "Clochard", dict = "move_m@hobo@a" },
	{ name = "Courageux", dict = "move_m@brave" },
	{ name = "Déprimé", dict = "move_m@depressed@a" },
	{ name = "Femme", dict = "move_m@femme@" },
	{ name = "Femme 2", dict = "move_f@generic" },
	{ name = "Gros", dict = "move_m@fat@a" },
	{ name = "Intimidation A", dict = "move_m@intimidation@1h" },
	{ name = "Intimidation B", dict = "move_m@intimidation@cop@unarmed" },
	{ name = "Joufflu", dict = "move_f@chubby@a" },
	{ name = "Mangeuse d’homme", dict = "move_f@maneater" },
	{ name = "Musclé", dict = "move_m@muscle@a" },
	{ name = "Pressé", dict = "move_m@hurry@a" },
	{ name = "Sexy", dict = "move_f@sexy@a" },
	{ name = "Shady", dict = "move_m@shadyped@a" },
	{ name = "SWAG", dict = "move_m@swagger" },
	{ name = "Soul", dict = "move_m@drunk@verydrunk" },
	{ name = "Tough", dict = "move_f@tough_guy@" },
	{ name = "Triste", dict = "move_m@sad@a" },
	{ name = "Triste 2", dict = "move_f@sad@a" },
}
emoteList = {
	{ name = "Normale" },
	{ name = "Blessé", dict = "mood_injured_1" },
	{ name = "Chic", dict = "mood_smug_1" },
	{ name = "Colère", dict = "mood_angry_1" },
	{ name = "Concentration", dict = "mood_aiming_1" },
	{ name = "Dormir", dict = "mood_sleeping_1" },
	{ name = "Heureux", dict = "mood_happy_1" },
	{ name = "Milou", dict = "mood_sulk_1" },
	{ name = "Soul", dict = "mood_drunk_1" },
	{ name = "Stressé", dict = "mood_stressed_1" },
}