local Missions = {}
local goFastCount = {}


RegisterServerEvent("illegalGoFast:addCount")
AddEventHandler("illegalGoFast:addCount", function()
  local steam64 = GetPlayerIdentifiers(source)[1]
  if (goFastCount[steam64] == nil) then 
    goFastCount[steam64] = 1
  else 
    goFastCount[steam64] = goFastCount[steam64] + 1
    print(steam64 .. " - " .. goFastCount[steam64])
  end
end)


RegisterServerCallback(
  "illegalGoFast:canGoFast",
  function(source, callback)
    local steam64 = GetPlayerIdentifiers(source)[1]

    if (goFastCount[steam64] == nil or goFastCount[steam64] <= 5) then 
      callback(true)
    else 
      callback(false)
    end     
  end
)

RegisterServerEvent('startIllegalMission')
AddEventHandler('startIllegalMission',function(m)
    --print(json.encode(m))
    table.insert(Missions,m)
    --print("started")
    TriggerClientEvent("SyncMissions", -1, Missions)
end)


RegisterServerEvent('editIllegalMission')
AddEventHandler('editIllegalMission',function( m)
    for i = 1 , #Missions , 1 do
        if Missions[i].id == m.id then
            Missions[i] = m
        end
    end
    TriggerClientEvent("SyncMissions", -1, Missions)
end)


RegisterServerCallback(
    "illegalDoesThisPlateExist",
    function(source, callback,plates)
        --print(plates)
        local f = false
        local c = {}
        --print(Missions)
        for i = 1 , #Missions , 1 do
            if Missions[i].plates == plates then
                f = true
                c = Missions[i]
                break
            end
        end
        callback(f,c)
end)



RegisterServerEvent('MissionFinished')
AddEventHandler('MissionFinished',function(m)
    for i = 1 , #Missions , 1 do
        if Missions[i].id == m.id then
            table.remove(Missions , i )
            break
        end
    end
    TriggerClientEvent("SyncMissions", -1, Missions)
end)
