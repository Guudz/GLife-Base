


RegisterServerCallback("bikershop:BuyVehicle", function(source, callback,price,targetSource,vehicle)
    local _veh = json.encode(vehicle)
    local pUUID = Player.GetPlayer(source).uuid
    local uuid = Player.GetPlayer(targetSource).uuid

    MySQL.Async.execute(
        'INSERT INTO players_vehicles (uuid,settings,plate,label) VALUES(@uuid,@settings,@plate,@label)',
        {
            ['@uuid'] = uuid,
            ['@settings'] = _veh,
            ['@plate'] = vehicle.plate,
            ['@label'] = vehicle.label,

        }
    )

    MySQL.Async.execute(
        'INSERT INTO motos_sold (buyer,model,plate,vendor,prices,date) VALUES(@buyer,@model,@plate,@vendor,@price,@date)',
        {
            ['@buyer'] = uuid,
            ['@vendor'] = pUUID,
            ['@plate'] = vehicle.plate,
            ['@model'] = vehicle.label,
            ['@price'] = price,
            ['@date'] = os.date("%Y-%m-%d %H:%M:%S", os.time())

        }
    )
    --(true)
    callback(true)
end)

RegisterServerCallback("bikershop:GetAll", function(source, callback)

    MySQL.Async.fetchAll('SELECT * FROM motos_sold  ', {}, function(result)
        MySQL.Async.fetchAll('SELECT * FROM players_identity', {}, function(_result)
            callback(result,_result)
        end)
    end)
end)