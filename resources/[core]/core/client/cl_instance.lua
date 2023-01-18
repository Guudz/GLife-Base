local Instance = {
    players = {},
    name = nil
}
GetPlayers = function()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end
RegisterNetEvent("localInstance")
AddEventHandler(
    "localInstance",
    function(name)
        Instance.name = name
        local playerID = PlayerId()
        local ped = PlayerPedId()
        for _, v in pairs(GetPlayers()) do
            local serverID = GetPlayerServerId(v)
            if not tableHasValue(userInProperty, serverID) then
                SetEntityNoCollisionEntity(GetPlayerPed(v), ped, false)
            else
                SetEntityNoCollisionEntity(GetPlayerPed(v), ped, true)
            end
        end
    end
)
RegisterNetEvent("exitInstance")
AddEventHandler(
    "exitInstance",
    function()
        Instance.name = nil
        local ped = PlayerPedId()
        for _, v in pairs(GetPlayers()) do
            SetEntityNoCollisionEntity(GetPlayerPed(v), ped, true)
        end
    end
)

AddEventHandler(
    "instance:enter",
    function(instance)
        Instance.name = instance
    end
)

AddEventHandler(
    "instance:leave",
    function()
        Instance.name = nil
        local ped = PlayerPedId()
        for _, v in pairs(GetPlayers()) do
            SetEntityNoCollisionEntity(GetPlayerPed(v), ped, true)
        end
    end
)

function tableHasValue(tbl, value, k)
    if not tbl or not value or type(tbl) ~= "table" then
        return
    end
    for _, v in pairs(tbl) do
        if k and v[k] == value or v == value then
            return true, _
        end
    end
end
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if type(Instance.name) == "string" and Instance.name ~= nil then
                --print("je suis instancié")
                local playerID = PlayerId()
                for _, i in pairs(GetPlayers()) do
                    local otherPed = GetPlayerPed(i)
                    if otherPed and i ~= playerID then
                        SetEntityVisible(otherPed)
                        SetEntityLocallyInvisible(otherPed)
                    end
                end
            end
        end
    end
)

--[[Citizen.CreateThread(
    function()
        while true do
            Wait(100)
            if Instance.name == nil then
                local ped = PlayerPedId()
                for _, v in pairs(GetPlayers()) do
                    SetEntityVisible(GetPlayerPed(v), true)
                    SetEntityLocallyVisible(GetPlayerPed(v))
                    Wait(5)
                end
            end
        end
    end
)]]
function JoinInstanceWithIds(array)
    Instanced = array
    local players = GetPlayers()
    amInInstance = true
    for k, v in pairs(players) do
        local Ped = GetPlayerPed(v)
        SetEntityVisible(Ped, false)
        SetEntityCollision(Ped, false)
    end
end
function LeaveInstance()
    Instanced = {}
    local players = GetPlayers()
    amInInstance = false
    for k, v in pairs(players) do
        local Ped = GetPlayerPed(v)
        SetEntityVisible(Ped, true)
        SetEntityCollision(Ped, true)
    end
    Wait(1000)
    JoinInstanceWithIds({2})
end
