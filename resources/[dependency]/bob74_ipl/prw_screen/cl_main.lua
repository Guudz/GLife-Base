

local duiObj
local txd
local currInstance = 0
local startTime = 0
local runtimeTxd = "meows"
local currentScreen = {}


local function deleteScreen()
	if not duiObj then return end
	DestroyDui(duiObj)
	duiObj = nil

end

local function createScreen(intID, link, seconds, startTime, boolResume)
	local tbl = allscreens[intID]
	if allscreens[intID] == nil then return end
	currentScreen = { link = link, seconds = seconds, screenID = intID }

	if boolResume then
		seconds = (seconds or 0) + math.floor(startTime and (GetCloudTimeAsInt() - startTime) or 0)
	end

	if not duiObj then
		duiObj = CreateDui(link .. "&start=" .. seconds, 1280, 720)
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



	local duiLong = duiObj

	SendDuiMouseMove(duiLong, 75, 700)
	Wait(550)
	SendDuiMouseMove(duiLong, 95 + math.ceil(10 * 5), 702)
	Wait(5)
	SendDuiMouseDown(duiLong, 'left')
	Wait(7)
	SendDuiMouseUp(duiLong, 'left')

	SendDuiMouseMove(duiLong, 75, 500)
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
RegisterNetEvent("screenStart")
AddEventHandler("screenStart", function(url)
	local closestScreen =  GetClosestScreen(GetEntityCoords(PlayerPedId()))
	print(url)
	print(json.encode(closestScreen))
	createScreen(closestScreen, url, 0, 1, true)

	--createScreen(closestScreen, "https://www.youtube.com/embed/" .. youtubeID .. "?autoplay=1&mute=0&controls=0&iv_load_policy=3&showinfo=0&enablejsapi=1", 0, 1, _id == 3)
end)

function GetClosestScreen(plyPos)
	local playerInterior = GetInteriorAtCoords(plyPos)
	for k,v in pairs(allscreens) do
		if GetDistanceBetweenCoords(plyPos, v.propPos) <= (v.dist or 20.0) and playerInterior == GetInteriorAtCoords(v.propPos) then
			return k
		end
	end
end





-- TODO: si trop loin OFF
Citizen.CreateThread(function()

	txd = CreateRuntimeTxd(runtimeTxd)
	while true do
		Citizen.Wait(1000)

		local base = currentScreen and currentScreen.screenID and allscreens[currentScreen.screenID]
		local dist = base and GetDistanceBetweenCoords(base.propPos, GetEntityCoords(PlayerPedId())) <= (base.dist or 10)
		if dist and not duiObj and base and currentScreen.link then
			Citizen.Trace('screen resumed\n')
			RestartScreen()
		elseif currentScreen.screenID and duiObj and not dist then
			deleteScreen()
			Citizen.Trace('screen stopped\n')
		end
	end
end)
Citizen.CreateThread(function()
	while true do 
		Wait(1500)
		TriggerEvent("instance:get",function(id)
			currInstance = id.host
			--(currInstance)
		end)
		
	end
end)
ServerCallbacks = {}

CurrentRequestId = 0

TriggerServerCallback = function(name, cb, ...)
    ServerCallbacks[CurrentRequestId] = cb
    TriggerServerEvent('_trigger_server_callback', name, CurrentRequestId, ...)
    if CurrentRequestId < 65535 then
        CurrentRequestId = CurrentRequestId + 1
    else
        CurrentRequestId = 0
    end
end

RegisterNetEvent('_server_callback')
AddEventHandler('_server_callback', function(requestId, ...)
    ServerCallbacks[requestId](...)
    ServerCallbacks[requestId] = nil
end)

function RestartScreen()

	TriggerServerCallback("screen:GetInfo",function(infos)
		local link = infos.url .. "&start=" .. (infos.Ttime or 0)
		duiObj = CreateDui(link, 1920,1080)
		txd = CreateRuntimeTxd(runtimeTxd)
		CreateRuntimeTextureFromDuiHandle(txd, "woof", GetDuiHandle(duiObj))
	end,currInstance)
end


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
function newscreen(d)
	local data = d
	local _id = {host=currInstance}
	_id.url = "https://www.youtube.com/embed/" .. data .. "?autoplay=0&mute=0&volume=0.2&controls=0&iv_load_policy=3&showinfo=0&enablejsapi=1"
		
	TriggerServerEvent("screen:start",_id)
end



