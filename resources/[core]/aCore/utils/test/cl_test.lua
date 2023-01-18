

local duiObj
local txd

local startTime = 0
local runtimeTxd = "meows"
local currentScreen = {}
local allscreens = {
	{ propName = "hei_heist_str_avunitl_03", propPos = vec3(-781.93, 340.81, 211.197), target = "tvscreen" },
	{ propName = "hei_heist_str_avunitl_03", propPos = vec3(-21.85, -578.68, 78.23), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-40.24, -571.04, 88.93), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-5.11, -585.55, 99.05), target = "tvscreen" },
	{ propName = "prop_tv_flat_02", propPos = vec3(986.53, -95.11, 75.48), target = "tvscreen" },
	{ propName = "prop_tv_flat_michael", propPos = vec3(1120.17, -3144.56, -35.86), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-802.07, 343.2, 158.82), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunitm_01", propPos = vec3(-781.41, 338.47, 186.11), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunitm_03", propPos = vec3(-780.6, 319.28, 194.89), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-801.6, 342.81, 206.44), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-754.51, 314.45, 222.07), target = "tvscreen" },
	{ propName = "prop_tv_03", propPos = vec3(-9.01, -1441.68, 31.28), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(3.89, 530.31, 175.67), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-893.23, -376.56, 84.3), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-936.88, -374.77, 108.26), target = "tvscreen" },
	{ propName = "hei_heist_str_avunitl_03", propPos = vec3(-907.03, -383.23, 112.47), target = "tvscreen" },
	{ propName = "prop_tv_flat_02", propPos = vec3(-1161.55, -1520.14, 10.47), target = "tvscreen" },
	{ propName = "des_tvsmash_start", propPos = vec3(-810.59, 170.46, 77.25), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-892.74, -423.08, 94.28), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-920.44, -438.59, 120.42), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-877.98, -451.21, 125.35), target = "tvscreen" },

	{ propName = "ex_prop_ex_tv_flat_01", propPos = vec3(-1567.5, -579.75, 108.94), target = "ex_tvscreen" },
	{ propName = "ex_prop_ex_tv_flat_01", propPos = vec3(-138.44, -639.81, 169.24), target = "ex_tvscreen" },
	{ propName = "ex_prop_ex_tv_flat_01", propPos = vec3(-1373.87, -476.79, 72.46), target = "ex_tvscreen" },
	{ propName = "ex_prop_ex_tv_flat_01", propPos = vec3(-70.19, -809.12, 243.8), target = "ex_tvscreen" },

	{ propName = "prop_tv_03", propPos = vec3(256.73, -995.45, -98.86), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(337.28, -996.67, -99.03), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-1479.18, -531.98, 55.74), target = "tvscreen" },
	{ propName = "hei_heist_str_avunitl_03", propPos = vec3(-1469.46, -548.59, 72.24), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-479.78, -716.99, 52.22), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-455.88, -681.25, 75.9), target = "tvscreen" },
	{ propName = "prop_tv_flat_01", propPos = vec3(-623.85, 67.78, 106.84), target = "tvscreen" },
	{ propName = "hei_heist_str_avunitl_03", propPos = vec3(-606.34, 40.26, 96.4), target = "tvscreen" },

	{ propName = "prop_trev_tv_01", propPos = vec3(1979.02, 3819.52, 34.09), target = "tvscreen" },

	{ propName = "apa_mp_h_str_avunits_01", propPos = vec3(-568.26, 642.93, 144.44), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunits_04", propPos = vec3(-161.65, 482.89, 136.24), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunits_01", propPos = vec3(-1281.54, 432.18, 96.5), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunits_01", propPos = vec3(377.45, 404.73, 144.51), target = "tvscreen" },

	{ propName = "apa_mp_h_str_avunits_04", propPos = vec3(331.14, 421.66, 147.97), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunits_01", propPos = vec3(127.29, 543.4, 182.91), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunits_01", propPos = vec3(-850.26, 674.47, 151.46), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunits_04", propPos = vec3(-771.4, 604.59, 142.73), target = "tvscreen" },
	{ propName = "apa_mp_h_str_avunits_04", propPos = vec3(-664.09, 585.9, 143.97), target = "tvscreen" },
	-- Studio musique
	{ propName = "hei_heist_str_avunitl_03", propPos = vec3(7.1, 10.3, 33.34), target = "tvscreen" },
	-- 
	{ propName = "prop_tv_02", propPos = vec3(104.2, -1290.51, 28.26), target = "tvscreen", dist = 60 }
}


local function deleteScreen()
	if not duiObj then return end
	DestroyDui(duiObj)
	duiObj = nil

end

local function createScreen(intID, link, seconds, startTime, boolResume)
	local tbl = allscreens[intID]
	currentScreen = { link = link, seconds = seconds, screenID = intID }

	if boolResume then
		seconds = (seconds or 0) + math.floor(startTime and (GetCloudTimeAsInt() - startTime) or 0)
	end

	if not duiObj then
		duiObj = CreateDui(link .. "&start=" .. seconds, 1920, 1080)
		txd = CreateRuntimeTxd(runtimeTxd)
		CreateRuntimeTextureFromDuiHandle(txd, "woof", GetDuiHandle(duiObj))
	else
		SetDuiUrl(duiObj, link)
	end

	if not currentScreen.handle then
		currentScreen.handle = CreateNamedRenderTargetForModel(tbl.target, GetHashKey(tbl.propName))
	end

	if not boolResume then
		currentScreen.startTime = startTime
	end

end
function CreateNamedRenderTargetForModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end

	return handle
end
RegisterNetEvent("tonnio_nb:screenUpdate")
AddEventHandler("tonnio_nb:screenUpdate", function(_id, _data)
	if _id == 1 or _id == 3 then
		createScreen(_data.screenID, "https://www.youtube.com/embed/" .. _data.link .. "?autoplay=1&mute=0&controls=0&iv_load_policy=3&showinfo=0&enablejsapi=1", _data.seconds or 0, _data.startTime, _id == 3)
	elseif _id == 2 then
		deleteScreen()
		currentScreen = {}
	end
end)

local function GetClosestScreen(plyPos)
	local playerInterior = GetInteriorAtCoords(plyPos)
	for k,v in pairs(allscreens) do
		if GetDistanceBetweenCoords(plyPos, v.propPos) <= (v.dist or 20) and playerInterior == GetInteriorAtCoords(v.propPos) then
			return k
		end
	end
end

RegisterCommand("screen", function(src, args, m)
		arg = m:gsub("screen ", "")
		local link, seconds, youtubeID = arg, 10
		youtubeID = link:gsub(".*?v=*", "")

		if not youtubeID or youtubeID:len() ~= 11 then return end
		local closestScreen =  GetClosestScreen(GetEntityCoords(PlayerPedId()))
		
		--createScreen(closestScreen, "https://www.youtube-nocookie.com/embed/"..youtubeID.."?autoplay=1&mute=0&controls=0&iv_load_policy=3&showinfo=0&enablejsapi=1", 0, 1, _id == 3)
		TriggerEvent("getInstanceHost",function(id)
			TriggerPlayerEvent("castscreenToAll",-1,"https://www.youtube-nocookie.com/embed/"..youtubeID.."?autoplay=1&mute=0&controls=0&iv_load_policy=3&showinfo=0&enablejsapi=1",id)
		end)
end)
RegisterNetEvent("castscreenToAll")
AddEventHandler("castscreenToAll",function(url,id)
	TriggerEvent("getInstanceHost",function(_id)
		if _id == id then
			local closestScreen =  GetClosestScreen(GetEntityCoords(PlayerPedId()))
				
			createScreen(closestScreen, url, 0, 1, _id == 3)
		end
	end)
end)
-- TODO: si trop loin OFF
Citizen.CreateThread(function()
	txd = CreateRuntimeTxd(runtimeTxd)
	while true do
		Citizen.Wait(1000)

		local base = currentScreen and currentScreen.screenID and allscreens[currentScreen.screenID]
		if base ~= nil then
			local dist = base and GetDistanceBetweenCoords(base.propPos, GetEntityCoords(PlayerPedId())) <= (base.dist or 10)
			if dist and not duiObj and base and currentScreen.link then
				local link = currentScreen.link .. "&start=" .. (currentScreen.seconds + math.floor(currentScreen.startTime and (GetCloudTimeAsInt() - currentScreen.startTime) or 0))
				duiObj = CreateDui(link, 1920, 1080)
				txd = CreateRuntimeTxd(runtimeTxd)
				CreateRuntimeTextureFromDuiHandle(txd, "woof", GetDuiHandle(duiObj))
				--('screen resumed\n')
			elseif currentScreen.screenID and duiObj and not dist then
				deleteScreen()
			end
		end
	end
end)

Citizen.CreateThread(function()
	local defaultRender = GetDefaultScriptRendertargetRenderId()
	while true do
		Citizen.Wait(0)

		if currentScreen and currentScreen.screenID and duiObj then
			SetTextRenderId(currentScreen.handle)
			Set_2dLayer(4)
			SetScriptGfxDrawBehindPausemenu(1)
			DrawSprite(runtimeTxd, "woof", 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
			SetTextRenderId(defaultRender)
			SetScriptGfxDrawBehindPausemenu(0)
		end
	end
end)

AddEventHandler("onResourceStop", function(r)
	if r ~= GetCurrentResourceName() then return end
	deleteScreen()
end)








-- local function CreateNamedRenderTargetForModel(name, model)
-- 	local handle = 0

-- 	if not IsNamedRendertargetRegistered(name) then
-- 		RegisterNamedRendertarget(name, 0) -- TODO wuts bool?
-- 	end

-- 	if not IsNamedRendertargetLinked(model) then
-- 		LinkNamedRendertarget(model)
-- 	end

-- 	if IsNamedRendertargetRegistered(name) then
-- 		handle = GetNamedRendertargetRenderId(name)
-- 	end

-- 	return handle
-- end


-- local function LoadScaleForm(scaleform)
-- 	local scaleform = RequestScaleformMovie(scaleform)
-- 	if scaleform ~= 0 then
-- 		while not HasScaleformMovieLoaded(scaleform) do
-- 			Citizen.Wait(0)
-- 		end
-- 	end
-- 	return scaleform
-- end


-- function CreateObj (model, coords, cb, ...)
-- 	local entity = nil
-- 	RequestModel(model)
-- 	while not HasModelLoaded(model) do Citizen.Wait(0) end
-- 	SetModelAsNoLongerNeeded(model)
-- 	entity = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)
-- 	if cb ~= nil then cb(entity, ...) end
-- 	return entity
-- end


-- local BLIMP = {}

-- BLIMP.model = 1575467428

-- BLIMP.scaleform_name = "blimp_text"
-- BLIMP.scaleform = nil

-- BLIMP.rendertarget_name = "blimp_text"
-- BLIMP.rendertarget = nil

-- function BLIMP.SetScrollSpeed(scrollSpeed)
-- 	PushScaleformMovieFunction(BLIMP.scaleform, "SET_SCROLL_SPEED")
-- 	PushScaleformMovieFunctionParameterFloat(scrollSpeed + 0.0)
-- 	PopScaleformMovieFunctionVoid()
-- end

-- function BLIMP.SetColour (colour)
-- 	PushScaleformMovieFunction(BLIMP.scaleform, "SET_COLOUR")
-- 	PushScaleformMovieFunctionParameterInt(colour)
-- 	PopScaleformMovieFunctionVoid()
-- end; BLIMP.SetColor = BLIMP.SetColour

-- function BLIMP.SetMessage(message)
-- 	PushScaleformMovieFunction(BLIMP.scaleform, "SET_MESSAGE")
-- 	PushScaleformMovieFunctionParameterString(message)
-- 	PopScaleformMovieFunctionVoid()
-- end

-- function BLIMP.RenderMessage ()
-- 	SetTextRenderId(BLIMP.rendertarget)
-- 		Set_2dLayer(4)
-- 		Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
-- 		Citizen.InvokeNative(0x40332D115A898AF5, BLIMP.scaleform, 1)
-- 		DrawScaleformMovie(BLIMP.scaleform, 0.0, -0.08, 1.0, 1.7, 255, 255, 255, 255, 0)
-- 	SetTextRenderId(GetDefaultScriptRendertargetRenderId())
-- end

-- Citizen.CreateThread(function ()
-- 	-- Create blimp by player
-- 	local ob = CreateObj(BLIMP.model, LocalPlayer().Pos)

-- 	BLIMP.scaleform = LoadScaleForm(BLIMP.scaleform_name)
-- 	BLIMP.rendertarget = CreateNamedRenderTargetForModel(BLIMP.rendertarget_name, BLIMP.model)
-- 	BLIMP.SetMessage("RainLayer City, c'est pour bientôt")
-- 	BLIMP.SetColor(1)
-- 	BLIMP.SetScrollSpeed(5.0)

-- 	--print('BLIMP scaleform handle:' .. BLIMP.scaleform)
-- 	--print('BLIMP rendertarget handle:' .. BLIMP.rendertarget)

-- 	while true do
-- 		BLIMP.RenderMessage()
-- 		Citizen.Wait(0)
-- 	end
-- end)


-- Citizen.CreateThread(function ()
-- 	local context = GetHashKey("MINI_PROSTITUTE_LOW_RESTRICTED_PASSENGER")

-- 	while true do
-- 		ped = LocalPlayer().Ped
-- 		vehicle = GetVehiclePedIsIn(ped, false)

-- 		-- Ped is in vehicle
-- 		if DoesEntityExist(vehicle) and IsVehicleDriveable(vehicle, true) then
-- 			local engine = GetIsVehicleEngineRunning(vehicle)

-- 			-- Ped is in drivers seat
-- 			if GetPedInVehicleSeat(vehicle, -1) == ped then
-- 				-- Listen for vehicle exit
-- 				if IsControlJustPressed(0, 23) then
-- 					local held = 0
-- 					while GetIsTaskActive(ped, 159) do
-- 						-- Accumulate held
-- 						if IsControlPressed(0, 23) then held = held + 1
-- 						else
-- 							held = 0
-- 						end

-- 						-- Held - turn engine off
-- 						if held > 20 then
-- 							SetVehicleEngineOn(vehicle, false, false, false)
-- 							SetVehicleJetEngineOn(vehicle, false)
-- 							break

-- 						-- Don't let the engine shut off
-- 						else
-- 							SetVehicleEngineOn(vehicle, true, false, false)
-- 							SetVehicleJetEngineOn(vehicle, true)
-- 						end

-- 						Wait(0)
-- 					end
-- 					ResetPedInVehicleContext(ped)

-- 				-- Engine is off | Prevent default engine on
-- 				elseif not engine then
-- 					SetPedInVehicleContext(ped, context)
-- 					-- Listen for engine on
-- 					if IsControlJustPressed(0, 32) then
-- 						ResetPedInVehicleContext(ped)
-- 						SetVehicleEngineOn(vehicle, true, false, false)
-- 						SetVehicleJetEngineOn(vehicle, true)
-- 					end
-- 				end
-- 			end

-- 			-- Passenger
-- 			if GetPedInVehicleSeat(vehicle, 0) == ped then
-- 				SetPedInVehicleContext(ped, context)
-- 			end
-- 		end

-- 		Wait(0)
-- 	end
-- end)

Citizen.CreateThread(function ()
	local b = false
	local ped = PlayerPedId()

	-- FIXME
	local VehicleInteractions = {
		{ --[[bone = "door_dside_f",]] door = 0, seat = -1 }, -- Door left front (driver)
		{ --[[bone = "door_pside_f",]] door = 1, seat =  0 }, -- Door right front
		{ --[[bone = "door_dside_r",]] door = 2, seat = 1 }, -- Door left back
		{ --[[bone = "door_pside_r",]] door = 3, seat = 2 }, -- Door right back
		-- { bone = "bonnet", door = 4, range = 1.5 }, -- Vehicle hood - May not always be a door?
		-- { bone = "boot", door = 5, range = 1.5 }, -- Vehicle trunk
		-- { door = 6 }, -- Back | Trunk2 ?
		-- { door = 7 }, -- Back2 ?
		{ bone = 'seat_dside_r2', seat = 3 }, -- seat in vehicle back or on vehicle side
		{ bone = 'seat_pside_r2', seat = 4 }, -- .. bone may not correspond to seat
		{ bone = 'seat_dside_r1',  seat = 5 },-- ..
		{ bone = 'seat_pside_r1', seat = 6 }, -- ..
	}

	while true do
		ped = LocalPlayer().Ped

		-- if IsControlJustPressed(0, 23, true) then -- 23 INPUT_ENTER
		-- 	if GetIsTaskActive(ped, 160) then
		-- 		local nearest
		-- 		local dist = math.huge
		-- 		local ppos = GetEntityCoords(ped)
		-- 		local vehicle = GetVehiclePedIsTryingToEnter(ped)

		-- 		-- Override entering the drivers seat with the nearest interaction
		-- 		if DoesEntityExist(vehicle) and GetSeatPedIsTryingToEnter(ped) == -1 then
		-- 			local bone
		-- 			local len
		-- 			local coords

		-- 			for i, v in ipairs(VehicleInteractions) do
		-- 				coords = false

		-- 				-- Use bone coords
		-- 				if v.bone then
		-- 					bone = GetEntityBoneIndexByName(vehicle, v.bone)

		-- 					if bone ~= -1 then
		-- 						coords = GetWorldPositionOfEntityBone(vehicle, bone)
		-- 					end

		-- 				-- Use entry position
		-- 				elseif v.door and DoesVehicleHaveDoor(vehicle, v.door) then
		-- 					coords = GetEntryPositionOfDoor(vehicle, v.door)
		-- 				end

		-- 				-- Is interaction is nearest
		-- 				if coords then
		-- 					len = GetDistanceBetweenCoords(vector3(ppos.x, ppos.y, ppos.z), coords)
		-- 					 -- Ignore out of interaction range
		-- 					if v.range and len > v.range then
		-- 					elseif len < dist then
		-- 						dist = len
		-- 						nearest = i
		-- 					end
		-- 				end
		-- 			end
		-- 		end

		-- 		if nearest then
		-- 			nearest = VehicleInteractions[nearest]

		-- 			-- If there's not a seat
		-- 			if not nearest.seat then
		-- 				local door = nearest.door
		-- 				if door then -- open the door specified
		-- 					ClearPedTasks(ped)
		-- 					ClearPedTasksImmediately(ped)

		-- 					if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
		-- 						SetVehicleDoorShut(vehicle, door, false)
		-- 						PlayVehicleDoorCloseSound(vehicle, 1)
		-- 					else
		-- 						-- TODO task and check if task starts otherwise SetVehicleDoorOpen
		-- 						--TaskOpenVehicleDoor(ped, vehicle, -1, door, 1.0)
		-- 						SetVehicleDoorOpen(vehicle, door, true, false)
		-- 						PlayVehicleDoorOpenSound(vehicle, 0)
		-- 					end
		-- 				end
		-- 			else
		-- 				local seat = nearest.seat
		-- 				local occupant = GetPedInVehicleSeat(vehicle, seat)

		-- 				if DoesEntityExist(occupant) then
		-- 					local rel1 = GetRelationshipBetweenPeds(ped, occupant)
		-- 					if seat ~= -1 then ClearPedTasks(ped) end
		-- 					if rel1 >= 3 and rel1 <= 5 or rel1 == 255 then
		-- 					end
		-- 				else
		-- 					ClearPedTasks(ped)
		-- 					CanShuffleSeat(vehicle, false)
		-- 					TaskEnterVehicle(ped, vehicle, 5000, seat, 1.0, 1, 0)
		-- 				end

		-- 				---- Failed to gain enter task
		-- 				-- Wait(0)
		-- 				-- if GetVehiclePedIsTryingToEnter(ped) == 0 then end
		-- 			end
		-- 		end
		-- 	end
		-- end

		Wait(0)
	end
end)



-- function LoadModel (model)
-- 	if not IsModelInCdimage(model) then return end

-- 	RequestModel(model)

-- 	while not HasModelLoaded(model) do Citizen.Wait(0) end

-- 	return model
-- end

-- function CreateObj (model, coords, ang, networked)
-- 	LoadModel(model)

-- 	local entity = CreateObject(model, coords.x, coords.y, coords.z, networked == true, true, true)

-- 	SetEntityHeading(entity, ang or 0.0)
-- 	SetModelAsNoLongerNeeded(model)

-- 	return entity
-- end

-- function headsUp(text)
-- 	SetTextComponentFormat('STRING')
-- 	AddTextComponentString(text)
-- 	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
-- end

-- DecorRegister('tr_container', 3)

-- RegisterCommand('pin', function (source, arg, rawInput)
-- 	local playerPed = PlayerPedId()
-- 	local vehicle = GetVehiclePedIsIn(PlayerPedId(), 0)

-- 	if GetPedInVehicleSeat(vehicle, -1) == playerPed --[[Driver]] then
-- 		if IsVehicleAttachedToTrailer(vehicle) then
-- 			local IsVehicleAttachedToTrailer, trailer =  GetVehicleTrailerVehicle(vehicle, 0)

-- 			if GetEntityModel(trailer) == GetHashKey('trflat') then
-- 				if DecorExistOn(trailer, 'tr_container') then
-- 					local box = NetToObj(DecorGetInt(trailer, 'tr_container'))

-- 					if DoesEntityExist(box) then
-- 						headsUp('Container detached from trailer')
-- 						DetachEntity(box, trailer, false)
-- 						DecorRemove(trailer, 'tr_container')
-- 					end
-- 				else
-- 					local bone = GetEntityBoneIndexByName(trailer, "chassis")
-- 					local coords = GetEntityCoords(trailer) + GetWorldPositionOfEntityBone(trailer, bone)
-- 					local box = GetClosestObjectOfType(coords, 1.5, GetHashKey('prop_contr_03b_ld'), 0, 0, 1);

-- 					if DoesEntityExist(box) then
-- 						DecorSetInt(trailer, 'tr_container', ObjToNet(box))
-- 						AttachEntityToEntity(box, trailer, bone, 4103,
-- 							-0.0, 0.35, -0.0, -- position
-- 							0.0, 0.0, 0.0, -- rotation
-- 							false, false, false, false, 2, true
-- 						)

-- 						headsUp('Attached container to trailer')
-- 						--print('Attached container to trailer', IsEntityUpright(box, 10.0))
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end)

-- Citizen.CreateThread(function ()
--     Wait(9000)
-- 	local vehicle
-- 	local veh = -1

-- 	local wasPinned
-- 	local boxModel = GetHashKey('prop_contr_03b_ld') -- THRIFTEX
-- 	local boxHealth

-- 	---- DEBUG Create a box infront of player

-- 	box = CreateObj(boxModel, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 15.0, 0.0), 0.0, true)
-- 	FreezeEntityPosition(box, 0)
-- 	ActivatePhysics(box)
-- 	--
-- 	-- phantom
-- 	-- trflat
-- 	-- handler

-- 	local nearestBox

-- 	while true do
-- 		-- Check player vehicle
-- 		veh = GetVehiclePedIsIn(PlayerPedId(), 0)
-- 		if vehicle ~= veh then
-- 			if not IsEntityDead(PlayerPedId()) and GetEntityModel(veh) == GetHashKey('handler') then
-- 				vehicle = veh
-- 				--print('Enter vehicle ' .. vehicle)
-- 			else
-- 				vehicle = nil
-- 				veh = nil
-- 			end
-- 		end

-- 		-- In 'handler vehicle
-- 		if vehicle then
-- 			local box = GetClosestObjectOfType(GetEntityCoords(vehicle, 1), 15.0, boxModel, 0, 0, 1);
-- 			local boxCoords = GetEntityCoords(box)
-- 			local wasPressed = IsControlJustPressed(0, 51)


-- 			SetInputExclusive(0, 51) -- no horn


-- 			-- FIXME How to get nearest trailer for container placement
-- 			rayHandle, targeted, targetedCoords, surfaceNormal, targetedEntity = GetShapeTestResult(StartShapeTestCapsule(
-- 				boxCoords.x, boxCoords.y, boxCoords.z - 1.0,
-- 				boxCoords.x, boxCoords.y, boxCoords.z - 1.0,
-- 				2.0,
-- 				10, box, 7
-- 			))

-- 			if DoesEntityExist(targetedEntity) and GetEntityModel(targetedEntity) == GetHashKey('trflat') then
-- 				targetedCoords = GetEntityCoords(targetedEntity)
-- 				if GetDistanceBetweenCoords(boxCoords, targetedCoords) <= 1.5 then
-- 					DrawMarker(
-- 						1, targetedCoords.x, targetedCoords.y, targetedCoords.z + 0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0,
-- 						1.5, 1.5, 5.0,
-- 						0, 255, 0, 100, false, false, 2, false, false, false, false
-- 					)
-- 				end
-- 			end
-- 			-----

-- 			if wasPressed then
-- 				wasPinned = N_0x89d630cf5ea96d23(vehicle, box)

-- 				RequestScriptAudioBank("Container_Lifter", false, -1)

-- 				if wasPinned then -- Unpin attached entity
-- 					if N_0x62ca17b74c435651(vehicle) ~= 1 then
-- 						PlaySoundFromEntity(-1, "Container_Release", vehicle, "CONTAINER_LIFTER_SOUNDS", 0, 0);
-- 						headsUp('CONTAINER WAS RELEASED.')
-- 						--print('CONTAINER WAS RELEASED.' )
-- 					end
-- 				else
-- 					-- Pin entity to vehicle
-- 					if GetDistanceBetweenCoords(
-- 						GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "frame_2")), GetEntityCoords(box), true) < 5.0 then
-- 						N_0x6a98c2ecf57fa5d4(vehicle, box)
-- 						if N_0x62ca17b74c435651(vehicle) == 1 then
-- 							PlaySoundFromEntity(-1, "Container_Attach", vehicle, "CONTAINER_LIFTER_SOUNDS", 0, 0)
-- 							headsUp('CONTAINER WAS ATTACHED.')
-- 							--print('CONTAINER WAS ATTACHED.')
-- 						end

-- 						boxHealth = GetEntityHealth(box) -- track health changes
-- 					else
-- 						headsUp('NO CONTAINER NEARBY')
-- 					end
-- 				end
-- 			elseif N_0x62ca17b74c435651(vehicle) == 1 then
-- 				-- Entity being damaged
-- 				if HasEntityCollidedWithAnything(box) then
-- 					PlaySoundFromEntity(-1, "Container_Land", vehicle, "CONTAINER_LIFTER_SOUNDS", 0, 0)
-- 					Wait(100) -- magic
-- 					if N_0x62ca17b74c435651(vehicle) ~= 1 or N_0x89d630cf5ea96d23(vehicle, box) == 1 then
-- 						headsUp('CONTAINER DAMAGED AND FELL.')
-- 						--print('CONAINER DAMAGED AND FELL')
-- 					end
-- 				else
-- 					headsUp('CONTAINER HEALTH: ' .. GetEntityHealth(box) )
-- 				end

-- 				boxHealth = GetEntityHealth(box)

-- 			-- Entity is being released
-- 			elseif wasPinned then
-- 				wasPinned = false
-- 				--headsUp('Container falling.')
-- 			end
-- 		end

-- 		Wait(0)
-- 	end
-- end)




-- local tablet = false
-- local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
-- local tabletAnim = "base"
-- local tabletProp = `prop_cs_tablet`
-- local tabletBone = 60309
-- local tabletOffset = vector3(0.03, 0.002, -0.0)
-- local tabletRot = vector3(10.0, 160.0, 0.0)

-- function ToggleTablet(toggle)
--     if toggle and not tablet then
--         tablet = true

--         Citizen.CreateThread(function()
--             RequestAnimDict(tabletDict)

--             while not HasAnimDictLoaded(tabletDict) do
--                 Citizen.Wait(150)
--             end

--             RequestModel(tabletProp)

--             while not HasModelLoaded(tabletProp) do
--                 Citizen.Wait(150)
--             end

--             local playerPed = PlayerPedId()
--             local tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)
--             local tabletBoneIndex = GetPedBoneIndex(playerPed, tabletBone)

--             SetCurrentPedWeapon(playerPed, `weapon_unarmed`, true)
--             AttachEntityToEntity(tabletObj, playerPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z, tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
--             SetModelAsNoLongerNeeded(tabletProp)

--             while tablet do
--                 Citizen.Wait(100)
--                 playerPed = PlayerPedId()

--                 if not IsEntityPlayingAnim(playerPed, tabletDict, tabletAnim, 3) then
--                     TaskPlayAnim(playerPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
--                 end
--             end

--             ClearPedSecondaryTask(playerPed)

--             Citizen.Wait(450)

--             DetachEntity(tabletObj, true, false)
--             DeleteEntity(tabletObj)
--         end)
--     elseif not toggle and tablet then
--         tablet = false
--     end
-- end

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)

--         if IsControlJustPressed(1, 51) then
--             ToggleTablet(not tablet)
--         end
--     end
-- end)