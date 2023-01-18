

function GetIdentifiers(source)
    local identifiers = {}
    if source == nil then return print("^1Source = nil^0") end
    local playerIdentifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end
RegisterServerCallback('getInventory', function(source, callback)
    local _source = source
    local ply = Player.GetPlayer(_source)
    while ply.uuid == nil do Wait(1) end
        MySQL.Async.fetchAll('SELECT inventory FROM players_inventory WHERE uuid = @uuid', {
            ["@uuid"] = ply.uuid
        }, function(result)
            if result[1] == nil then
                result[1] = {
                    inventory = {}
                }
                MySQL.Async.execute(
                    'INSERT INTO players_inventory (uuid,inventory) VALUES(@uuid,@items)',
                    {
                        ['@uuid']   =ply.uuid,
                        ['@items'] = json.encode({})
 
            
                    }
                )
            end
            callback(result[1].inventory)
        end)
end)



RegisterServerEvent("inventory:giveOtherPlayer")
AddEventHandler("inventory:giveOtherPlayer", function(item,targetSource)
    ply = Player.GetPlayer(source)
    targetPLY = Player.GetPlayer(targetSource)
    for i = 1 , #item , 1 do
        ply.RemoveItem(item[i].id,item[i].name)
        Wait(10)
        if Items[item[i].name].weight + targetPLY.Weight <= 32 then
            targetPLY.AddItem(item[i].name,1,item[i].data,item[i].label,item[i].id)
            ply.Weight = ply.Weight - Items[item[i].name].weight
            targetPLY.Weight = targetPLY.Weight + Items[item[i].name].weight
        else
            ply.AddItem(item[i].name,1,item[i].data,item[i].label)
            TriggerClientEvent("RageUI:Popup", source, {message="Le joueur n'a plus de place."})
            TriggerClientEvent("RageUI:Popup", targetSource, {message="Vous n'avez plus de place."})
            break
        end
    end
end)

RegisterServerEvent("core:buymunition")
AddEventHandler("core:buymunition", function(amount,itemName)

    ply.AddItem(itemName,amount)

end)
RegisterServerEvent("inventory:AddItem")
AddEventHandler("inventory:AddItem", function(item)
    --ply = Player.GetPlayer(source)
   -- ply.AddItem(item.name,1,item.data,item.label,item.id)
end)

RegisterServerEvent("inventory:AddItem2")
AddEventHandler("inventory:AddItem2", function(item,_source)
    ply = Player.GetPlayer(_source)
    ply.AddItem(item.name,1,item.data,item.label)
end)
RegisterServerEvent("inventory:RemoveItem")
AddEventHandler("inventory:RemoveItem", function(id,name)
  --  ply = Player.GetPlayer(source)
   -- ply.RemoveItem(id,name)
end)
RegisterServerEvent("player:RemoveItem")
AddEventHandler("player:RemoveItem", function(_source,id,name)
    ply = Player.GetPlayer(_source)
    ply.RemoveItem(id,name)
end)
RegisterServerEvent("inventory:UpdateWeight")
AddEventHandler("inventory:UpdateWeight", function(weight)
    ply = Player.GetPlayer(source)
    ply.Weight = weight
end)

RegisterServerCallback('inventory:renameItem', function(source,callback,id,label)
    local _source = source
    ply = Player.GetPlayer(source)
    ply.RenameItem(id,label)
    callback(true)
end)



RegisterServerEvent("inventory:editData")
AddEventHandler("inventory:editData", function(id,data)
    MySQL.Async.execute(
        'UPDATE players_inventory SET data= @data where id=@id',
           {
                ['@id']   =id,
                ['@data'] = json.encode(data),
            }
    )
end)
--


RegisterServerEvent("inventory:SaveInventory")
AddEventHandler("inventory:SaveInventory",function(inv)
    local ply = Player.GetPlayer(source)
    if inv == "null" then return end
    if #inv > #json.encode({}) then
        MySQL.Async.fetchAll('SELECT inventory FROM players_inventory WHERE uuid = @uuid', {
            ["@uuid"] = ply.uuid
        }, function(result)
            if result[1] == nil then
                MySQL.Async.execute(
                    'INSERT INTO players_inventory (uuid,inventory) VALUES(@uuid,@items)',
                    {
                        ['@uuid']   =ply.uuid,
                        ['@items'] = inv
                    }
                )
            end
        end)
        if inv ~= "null" or inv ~= "[]" then 
            MySQL.Async.execute(
                'UPDATE players_inventory SET inventory= @inv where uuid=@uuid',
                {
                        ['@uuid']   = ply.uuid,
                        ['@inv'] = inv,
                }
            )
        end
    end
end)


RegisterServerCallback('core:GetSourceFromUUID', function(source,callback,UUID)
    local ttt = GetALLPLAYERS()

    for k ,v in pairs(ttt) do
        if v.uuid == UUID then
            callback(k)
        end
    end
end)

RegisterServerCallback('core:GetMysource', function(source,callback,UUID)
    callback(source)
end)

RegisterServerCallback('stockage:GetItems', function(source,callback,plate)
    MySQL.Async.fetchAll('SELECT * FROM storages_inventory_items WHERE plate = @palte', {
        ["@palte"] = plate
    }, function(result)

        MySQL.Async.fetchAll('SELECT * FROM storages_inventory_accounts WHERE plate = @palte', {
            ["@palte"] = plate
        }, function(_result)
            if _result[1] == nil then
                MySQL.Async.execute(
                    'INSERT INTO storages_inventory_accounts (plate) VALUES(@plate)',
                    {
                        ['@plate']   =plate,

            
                    }
                )
                
            end
            _result[1] = {}
            _result[1].money = 0
            _result[1].dark_money = 0
            callback(result,_result[1])
        end)
        
    end)
end)

RegisterServerCallback('player:GetInventory', function(source, callback,targetSource)
    local targetPlayer = Player.GetPlayer(targetSource)
    local money = Users[targetSource].getMoney()
    local black_money = Users[targetSource].getBlackMoney()
    local Inventory = {}
    MySQL.Async.fetchAll('SELECT * FROM players_inventory WHERE uuid = @uuid', {
        ["@uuid"] = targetPlayer.uuid
    }, function(result)
        Inventory = result
        callback(Inventory,{money=money,dark_money=black_money})
    end)
    
end)
RegisterServerEvent("core:SyncItemWithBDD")
AddEventHandler("core:SyncItemWithBDD", function(item)
    MySQL.Async.execute(
        'UPDATE players_inventory SET data=@data where id=@id',
        {
             ['@id']   = item.id,
             ['@data'] = json.encode(item.data),

         }
        )
end)
