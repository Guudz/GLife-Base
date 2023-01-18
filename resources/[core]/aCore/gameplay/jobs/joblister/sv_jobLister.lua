local AnnounceData = {}
local AnnounceDataByJob = {}
RegisterServerEvent("joblisting:SyncMyJobAnnounce")
AddEventHandler("joblisting:SyncMyJobAnnounce",function(job,_table,table2)
    --print(job)
    if AnnounceDataByJob[job] == nil then
        AnnounceDataByJob[job] = {}
    end
    table.insert( AnnounceDataByJob[job], _table )
    AnnounceData = table2
end)



RegisterServerEvent("job:AddMails")
AddEventHandler("job:AddMails",function(job,msg)

end)


RegisterServerCallback('joblisting:RequestData', function(source, callback,job)
    callback(AnnounceData,AnnounceDataByJob[job])
end)

RegisterServerEvent("storevehicletow")
AddEventHandler("storevehicletow",function(pl)
    MySQL.Async.execute(
        "UPDATE players_vehicles SET pound=1 where plate=@id",
        {
            ["@id"] = pl,
            ["@data"] = pl,
        }
    )
end)


RegisterServerEvent("facture:pay")
AddEventHandler("facture:pay",function(_facture)
    local account = Banking.GetAccount(_facture.account)
    account.addMoney(_facture.montant)
    TriggerClientEvent("facture:paied",_facture.source)
end)
RegisterServerEvent("facture:send")
AddEventHandler("facture:send",function(_facture)
    local _s = source
    _facture.source = _s
    TriggerClientEvent("facture:get",_facture.playerId,_facture)
end)
