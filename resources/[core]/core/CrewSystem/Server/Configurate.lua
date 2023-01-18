-- ESX = nil

CreateThread(function()
    -- while not ESX do
    --     TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    --     Wait(500)
    -- end

	if enable_rank then
		MySQL.Async.execute('CREATE TABLE IF NOT EXISTS ranking_crew(id int AUTO_INCREMENT, name varchar(100), created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, members int DEFAULT 1, kills int, PRIMARY KEY(id))')
	end

	MySQL.Async.execute('CREATE TABLE IF NOT EXISTS crew(id int AUTO_INCREMENT, name varchar(100), identifier varchar(100), grade varchar(50), PRIMARY KEY(id))',{},
	function()
		MySQL.Async.fetchAll('SELECT * FROM crew', {},
		function(result)
			for i,k in pairs(result) do
				local found = false

				for _, crew in pairs(crews) do
					if crew.name == k.name then
						table.insert(crew.players, {
							identifier = k.identifier,
							source = -1,
							grade = k.grade
						})

						found = true
					end
				end

				if not found then
					table.insert(crews, {
						name = k.name,
						players = {
							{identifier = k.identifier, source = -1, grade = k.grade}
						}
					})
				end
			end
		end)
	end)
end)

function getIdentifier(source)
	local identifier = GetPlayerIdentifier(source)

    return identifier
end

function GetPlayerFromIdentifier(identifier)
    local Players = GetPlayersOnline()

    for _, player in pairs(Players) do
        if getIdentifier(player) == identifier then
            return player
        end
    end

    return nil
end

function showNotification(source, message)
    TriggerClientEvent('esx:showNotification', source, message)
    TriggerClientEvent('chat:addMessage', source, { args = { message }})
end

function GetPlayersOnline()
    return GetPlayers()
end

function getName(source)
    local name = GetPlayerName(source)
    return name
end