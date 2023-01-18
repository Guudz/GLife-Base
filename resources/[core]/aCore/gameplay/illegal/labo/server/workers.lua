local Labos = {
    -- [4] = {
    --     timeT = 9000000000,time = 9999999999
    -- }
}

RegisterServerEvent("startLabosProd")
AddEventHandler("startLabosProd",function(labs,recipe,t)
    local LabosP = Labos[labs.id].participants
    Labos[labs.id] = {time=labs.time == 0 and nil or labs.time ,recipe=recipe,name=labs.name,participants=LabosP}
    Labos[labs.id].timeT = os.time() + (3600*t)
    TriggerClientEvent("UpdateLabosTime",-1,Labos)
end)

function GetTimeLabos(id)
    if Labos[id] == nil then return nil end
    return Labos[id].time ~= nil and  Labos[id].time or nil
end


RegisterServerEvent("RequestUpdateLabs")
AddEventHandler("RequestUpdateLabs",function(id)
    TriggerClientEvent("UpdateLabosTime",-1,Labos)
end)
RegisterServerEvent("ENTERLABOS")
AddEventHandler("ENTERLABOS",function(id)
    local _source = source
    if Labos[id] == nil then
        Labos[id] = {}
    end

    if Labos[id].participants == nil then
        Labos[id].participants = {}
    end
    print(id)
    table.insert(Labos[id].participants,_source)
    print(dump(Labos[id]))
end)


RegisterServerEvent("EXITLABOS")
AddEventHandler("EXITLABOS",function(id)
    local _source = source
    for i = 1 , #Labos[id].participants , 1 do
        if Labos[id].participants[i] == _source then
            table.remove(Labos[id].participants,i)
            break
        end
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        for k ,v in pairs(Labos) do 
            if v.timeT ~= nil then 
                local now = os.time()
                if v.timeT-now < 0 then      
                    TriggerEvent("rage-reborn:DepositStockageItem2",{storage=v.name.."_storage",metadata={},id=math.random(11111,99999),name=v.recipe.give})
                    
                    for i = 1 , #v.participants , 1 do
                        TriggerClientEvent("updateStockLabo",v.participants[i])
                    end
                    Labos[k] = nil
                    v = nil
                end
            end
        end
    end

end)