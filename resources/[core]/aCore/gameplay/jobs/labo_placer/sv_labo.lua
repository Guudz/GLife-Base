RegisterServerEvent("core:NewLabo")
AddEventHandler("core:NewLabo",function(bool)
    MySQL.Async.execute(
        "INSERT INTO players_labo (capacity,name,entry,price,indexx) VALUES(@capacity,@name,@pos,@price,@index)",
           {

                ['@capacity']   = bool.max,
                ['@name']   = bool.name,
                ['@pos']   = bool.entry,
                ['@price']   = bool.price, 
                ['@index'] = bool.index,
                
            }
    )
end)