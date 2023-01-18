function InsertLog(type,action,detail)
    TriggerServerEvent("insert:Logs", type,action,detail )
end