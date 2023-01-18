

-- RegisterServerCallback("vehicleshop:BuyVehicle", function(source, callback,price,targetSource,vehicle)
--     local _veh = json.encode(vehicle)
--     local pUUID = Player.GetPlayer(source).uuid


--     MySQL.Async.execute(
--         'INSERT INTO players_vehicles (uuid,settings,plate,label) VALUES(@uuid,@settings,@plate,@label)',
--         {
--             ['@uuid'] = targetSource,
--             ['@settings'] = _veh,
--             ['@plate'] = vehicle.plate,
--             ['@label'] = vehicle.label,

--         }
--     )

--     MySQL.Async.execute(
--         'INSERT INTO vehicles_sold_nord (buyer,model,plate,vendor,prices,date) VALUES(@buyer,@model,@plate,@vendor,@price,@date)',
--         {
--             ['@buyer'] = uuid,
--             ['@vendor'] = pUUID,
--             ['@plate'] = vehicle.plate,
--             ['@model'] = vehicle.label,
--             ['@price'] = price,
--             ['@date'] = os.date("%Y-%m-%d %H:%M:%S", os.time())

--         }
--     )
--     --(true)
--     callback(true)
-- end)
RegisterServerCallback("vehicle:CheckPlateIsUnique", function(source, cb, plate)

    print('plate? ', plate)

    MySQL.Async.fetchAll('SELECT `plate` FROM players_vehicles WHERE `plate` = @plate LIMIT 1',
    {
        ['@plate'] = plate

    }, function (response)
        if response[1] == nil then
            return cb(true)
        end
        return cb(false)
    end)

end)

local function insertNewVehicleIntoDatabase(seller, buyer, vehicleOptions, plate, label, price)
    MySQL.Async.execute(
        "INSERT INTO players_vehicles (uuid,settings,plate,label) VALUES(@uuid,@settings,@plate,@label)",
        {
            ["@uuid"] = buyer,
            ["@settings"] = vehicleOptions,
            ["@plate"] = plate,
            ["@label"] = label
        }
    )

    MySQL.Async.execute(
        "INSERT INTO vehicles_sold (buyer,model,plate,vendor,prices,date) VALUES(@buyer,@model,@plate,@vendor,@price,@date)",
        {
            ["@buyer"] = buyer,
            ["@vendor"] = seller,
            ["@plate"] = plate,
            ["@model"] = label,
            ["@price"] = price,
            ["@date"] = os.date("%Y-%m-%d %H:%M:%S", os.time())
        }
    )
    return true
end



RegisterServerCallback(
    "vehicleshop:BuyVehicle",
    function(source, callback, price, targetSource, vehicle)
        local buyer = Player.GetPlayer(targetSource).uuid
        local vehicleOptions = json.encode(vehicle)
        local seller = Player.GetPlayer(source).uuid
        insertNewVehicleIntoDatabase(seller, buyer, vehicleOptions, vehicle.plate, vehicle.label, price)
        --(true)
        callback(true)
    end
)

RegisterServerCallback(
    "vehicleshop:BuyVehicleForCompany",
    function(source, callback, price, company, vehicle)
        local vehicleOptions = json.encode(vehicle)
        local seller = Player.GetPlayer(source).uuid
        insertNewVehicleIntoDatabase(seller, company, vehicleOptions, vehicle.plate, vehicle.label, price)
        --(true)
        callback(true)
    end
)

RegisterServerCallback("vehicleshop:GetAll", function(source, callback)

    MySQL.Async.fetchAll('SELECT * FROM vehicles_sold', {}, function(result)
        MySQL.Async.fetchAll('SELECT * FROM players_identity', {}, function(_result)
            callback(result,_result)
        end)
    end)
end)

RegisterServerEvent("vehicle:SetProperties")
AddEventHandler("vehicle:SetProperties",function(plate,dat)
    MySQL.Async.execute(
        'UPDATE players_vehicles set settings = @settings WHERE plate = @plate',
        {
            ['@settings'] = json.encode(dat),
            ['@plate'] = plate,

        }
    )
end)

RegisterServerCallback("core:GetVehicleOwnedX",function(source,cb,plate)
    --print(cb)
	local found = false
	MySQL.Async.fetchAll('SELECT * FROM players_vehicles', {
	}, function(result)
		for i = 1 , #result ,1 do
			if result[i].plate == plate then
				found = true
			end
		end
		cb(found)
	end)
end)
RegisterServerCallback("core:GetVehicleOwned+Infos",function(source,cb,plate)
    --print(cb)
    local found = false
    local r = {}
	MySQL.Async.fetchAll('SELECT * FROM players_vehicles', {
	}, function(result)
		for i = 1 , #result ,1 do
			if result[i].plate == plate then
                found = true
                r = result[i]
                --print(r.uuid)
                break
			end
        end
        --print(found,plate)
        MySQL.Async.fetchAll('SELECT first_name,last_name FROM players_identity where uuid = @uuid', {
            ["@uuid"] = r.uuid
        },function(_re)
            local o = os.time()
            p = os.date("%d/%m/%Y",o)
           
            cb(found,r,_re[1],tostring(p))
        end)
	end)
end)