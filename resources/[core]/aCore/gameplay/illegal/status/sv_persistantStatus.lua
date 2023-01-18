illegalPersistantStatus = {}

RegisterServerEvent("aCore_status:addOn")
AddEventHandler(
    "aCore_status:addOn",
    function(element)
        local steam64 = GetPlayerIdentifiers(source)[1]
        if (illegalPersistantStatus[element] == nil) then
            illegalPersistantStatus[element] = {}
        end

        illegalPersistantStatus[element][steam64] = GetGameTimer()
    end
)

RegisterServerCallback(
    "aCore_status:isOnStatus",
    function(source, callback, element, playerSource)
        local steam64 = GetPlayerIdentifiers(playerSource)[1]
        if (illegalPersistantStatus[element] == nil) then
            illegalPersistantStatus[element] = {}
            callback(false)
        elseif (illegalPersistantStatus[element][steam64] == nil) then
            callback(false)
        else
            callback(true)
        end
    end
)
