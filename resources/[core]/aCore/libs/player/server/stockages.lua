 ------------------
------STOCKAGE------
 ------------------

--
RegisterServerEvent("stockage:RemoveItem")
AddEventHandler("stockage:RemoveItem", function(id)
    MySQL.Async.execute(
        'DELETE From storages_inventory_items WHERE id = @id',
        {
            ['@id']   = id,
        }
    )
end)
RegisterServerEvent("stockage:DepositItem")
AddEventHandler("stockage:DepositItem", function(o)
    MySQL.Async.execute(
        'INSERT INTO storages_inventory_items (plate,name,data,label,type) VALUES(@plate,@name,@data,@label,@type)',
        {
            ['@plate']   =o[4],
            ['@name'] = o[1],
            ['@data'] = json.encode(o[3]),
            ['@label'] = o[2],
            ['@type'] = o[5],

        }
    )
end)
RegisterServerEvent("stockage:AddMoneyToAccount")
AddEventHandler("stockage:AddMoneyToAccount", function(plate,money,type)
    local player = Player.GetPlayer(source)
    if type == "dirty" then
        player.removeBlackMoney(money)
        MySQL.Async.execute(
            'UPDATE storages_inventory_accounts SET dark_money = @money + money where name=@plate',
               {
                    ['@money']   = money,
                    ['@plate'] = plate,
                }
        )
    else
        player.removeMoney(money)
        MySQL.Async.execute(
            'UPDATE storages_inventory_accounts SET money= @money + money where name=@plate',
               {
                    ['@money']   =money,
                    ['@plate'] = plate,
                }
        )
    end
end)
RegisterServerEvent("stockage:RemoveFromAccount")
AddEventHandler("stockage:RemoveFromAccount", function(plate,money,type)
    local player = Player.GetPlayer(source)
    if type == "black_money" then
        player.addBlackMoney(money)
        MySQL.Async.execute(
            'UPDATE storages_inventory_accounts SET dark_money = @money - money where name=@plate',
               {
                    ['@money']   = money,
                    ['@plate'] = plate,
                }
        )
    else
        player.addMoney(money)
        MySQL.Async.execute(
            'UPDATE storages_inventory_accounts SET money= @money - money where name=@plate',
               {
                    ['@money']   =money,
                    ['@plate'] = plate,
                }
        )
    end

end)