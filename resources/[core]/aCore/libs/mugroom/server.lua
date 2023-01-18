local Register = {}

print("------------------------------------------------------------")
print("^1Storage Cleaner^0")
print("^6Storage Cleaner will deduplicates items in the database.^0")
print("------------------------------------------------------------")

MySQL.ready(
    function()
        MySQL.Async.fetchAll(
            "SELECT * FROM `migration` WHERE migration_id = 'fix_storage_20200905'",
            {},
            function(results)
                if (results[1] == nil) then
                    MySQL.Async.fetchAll(
                        "SELECT * FROM `storages_inventory_items2`",
                        {},
                        function(results)
                            for indexResult, duplicateResult in pairs(results) do
                                local newItems = {}
                                local metadata = json.decode(duplicateResult.metadata)

                                for key, value in pairs(metadata) do
                                    if (type(value) == "string") then
                                        value = json.decode(value)
                                    end
                                    newItems[key] = value
                                end

                                print(
                                    "^1Updated  " ..
                                        duplicateResult.storage_name ..
                                            " " .. #newItems .. "x " .. duplicateResult.item_name .. " elements ^0"
                                )

                                MySQL.Async.execute(
                                    "UPDATE storages_inventory_items2 SET metadata = @metadata, qty = @qty  WHERE storage_name = @storageName AND item_name = @itemName",
                                    {
                                        ["@metadata"] = json.encode(newItems),
                                        ["@qty"] = #newItems,
                                        ["@storageName"] = duplicateResult.storage_name,
                                        ["@itemName"] = duplicateResult.item_name
                                    },
                                    function(insertId)
                                    end
                                )
                            end
                        end
                    )

                    MySQL.Async.execute(
                        "INSERT INTO migration (migration_id) VALUES (@migrationId)",
                        {
                            ["@migrationId"] = "fix_storage_20200905"
                        }
                    )
                end
            end
        )

        MySQL.Async.fetchAll(
            "SELECT id, count(id) FROM `storages_inventory_items` GROUP BY id HAVING count(id) > 1",
            {},
            function(results)
                for index, row in pairs(results) do
                    MySQL.Async.fetchAll(
                        "SELECT * FROM `storages_inventory_items` where id = @id",
                        {["@id"] = row.id},
                        function(duplicateResults)
                            print("^2Fixing duplicate for ID " .. row.id .. "^0")
                            for indexResult, duplicateResult in pairs(duplicateResults) do
                                local storageName = duplicateResult["name"]
                                local itemName = duplicateResult["itemName"]
                                local metadataItem = duplicateResult["metadata"]
                                local labelItem = duplicateResult["label"]

                                MySQL.Async.insert(
                                    "INSERT INTO storages_inventory_items (name,itemName,metadata,label) VALUES (@name,@itemName,@metadata,@label)",
                                    {
                                        ["@name"] = storageName,
                                        ["@itemName"] = itemName,
                                        ["@metadata"] = metadataItem,
                                        ["@label"] = labelItem
                                    },
                                    function(insertId)
                                        print(
                                            "^2Fixing duplicate for ID " ..
                                                row.id .. " (new row : " .. insertId .. ")^0"
                                        )
                                    end
                                )
                            end
                            print("^4 Deleting row(s) with id " .. row.id .. "^0")
                            MySQL.Sync.execute(
                                "DELETE FROM storages_inventory_items WHERE id = @duplicateId",
                                {["@duplicateId"] = row.id}
                            )
                        end
                    )
                end
            end
        )

        -- local itemVariableIncrementForId = 0

        -- MySQL.Async.fetchAll(
        --     "SELECT * FROM `storages_inventory_items`",
        --     {},
        --     function(results)
        --         for key, value in pairs(results) do
        --             local randomTest = uuid.seeder()
        --             local uuidForItem = uuid.new(randomTest)
        --             randomTest = uuid.seeder()
        --             itemVariableIncrementForId = itemVariableIncrementForId + 1
        --             uuidForItem = uuidForItem .. "-" .. itemVariableIncrementForId

        --             element = {}
        --             element["id"] = uuidForItem
        --             if (value.metadata == nil) then
        --                 element["metadata"] = {}
        --             else
        --                 element["metadata"] = json.decode(value.metadata)
        --             end
        --             element["label"] = value.label

        --             MySQL.Async.insert(
        --                 "INSERT INTO storages_inventory_items2 (storage_name, item_name, qty, metadata) VALUES (@name,@itemName,1, JSON_OBJECT(@itemId, @metadata)) " ..
        --                     "ON DUPLICATE KEY UPDATE qty=qty+1, metadata=JSON_MERGE_PRESERVE(metadata, JSON_OBJECT(@itemId, @metadata));",
        --                 {
        --                     ["@name"] = value.name,
        --                     ["@itemName"] = value.itemName,
        --                     ["@itemId"] = uuidForItem,
        --                     ["@metadata"] = json.encode(element)
        --                 },
        --                 function(insertId)
        --                     print(
        --                         "^2Migration #" ..
        --                             insertId .. " storage " .. value.name .. " for item " .. value.itemName .. "^0"
        --                     )
        --                 end
        --             )
        --         end
        --     end
        -- )

        -- local itemVariableIncrementForId = 0

        -- MySQL.Async.fetchAll(
        --     "SELECT * FROM `players_inventory`",
        --     {},
        --     function(results)
        --         for key, value in pairs(results) do
        --             local inventory = json.decode(value["inventory"])
        --             for key2, value2 in pairs(inventory) do
        --                 for key3, value3 in pairs(value2) do
        --                     if (value3.id ~= nil) then
        --                         local randomTest = uuid.seeder()
        --                         local uuidForItem = uuid.new(randomTest)
        --                         randomTest = uuid.seeder()
        --                         itemVariableIncrementForId = itemVariableIncrementForId + 1
        --                         uuidForItem = uuidForItem .. "-" .. itemVariableIncrementForId

        --                         inventory[key2][key3].id = uuidForItem
        --                     end
        --                 end
        --             end

        --             MySQL.Async.execute(
        --                 "UPDATE players_inventory SET inventory = @inventory WHERE uuid = @uuid",
        --                 {
        --                     ["@inventory"] = json.encode(inventory),
        --                     ["@uuid"] = value.uuid
        --                 },
        --                 function(insertId)
        --                     print("21Migration #" .. insertId .. " user " .. value.uuid .. "^0")
        --                 end
        --             )
        --         end
        --     end
        -- )
    end
)

local function GetIdentifiers(source)
    local identifiers = {}
    local playerIdentifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end

function GetUUID(source, CallBack)
    --("o",source)
    local steam = GetIdentifiers(source).steam
    MySQL.Async.fetchAll(
        "SELECT uuid FROM users WHERE identifier = @identifiers",
        {
            ["@identifiers"] = steam
        },
        function(result)
            if result[1] ~= nil then
                CallBack(result[1].uuid)
            end
        end
    )
end

local function InsertIdentity(UUID, FacePicture, FirstName, LastName, BirthDate, Origin)
    MySQL.Async.execute(
        "INSERT INTO players_identity (uuid, face_picutre, first_name, last_name, birth_date, origine) VALUES (@uuid, @face_picutre, @first_name, @last_name, @birth_date, @origine)",
        {
            ["@uuid"] = UUID,
            ["@face_picutre"] = FacePicture,
            ["@first_name"] = FirstName,
            ["@last_name"] = LastName,
            ["@birth_date"] = BirthDate,
            ["@origine"] = Origin,
            ["@created_at"] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
            ["@updated_at"] = os.date("%Y-%m-%d %H:%M:%S", os.time())
        }
    )
end

local function InsertAppearance(UUID, Model, Face, Outfit, Tattoo)
    --(UUID, Model, Face, Outfit, Tattoo)
    MySQL.Async.execute(
        "INSERT INTO players_appearance (uuid, model, face, outfit, tattoo) VALUES (@uuid, @model, @face, @outfit, @tattoo)",
        {
            ["@uuid"] = UUID,
            ["@model"] = Model,
            ["@face"] = json.encode(Face),
            ["@outfit"] = json.encode(Outfit),
            ["@tattoo"] = json.encode({}),
            ["@created_at"] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
            ["@updated_at"] = os.date("%Y-%m-%d %H:%M:%S", os.time())
        }
    )
end

local function InsertJob(UUID, Name, Grade)
    MySQL.Async.execute(
        "INSERT INTO players_jobs (uuid, name,rank) VALUES (@uuid, @name, @rank)",
        {
            ["@uuid"] = UUID,
            ["@name"] = Name,
            ["@rank"] = Grade,
            ["@created_at"] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
            ["@updated_at"] = os.date("%Y-%m-%d %H:%M:%S", os.time())
        }
    )
end

local function UpdateRegisterCharecterCount(Source)
    MySQL.Async.fetchAll(
        "SELECT character_count FROM whitelist WHERE identifier = @identifier",
        {["@identifier"] = GetIdentifiers(Source).steam},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                local currentCharacter = result[1].character_count
                MySQL.Async.execute(
                    "UPDATE whitelist SET character_count=@character_count where identifier=@identifier",
                    {["@identifier"] = GetIdentifiers(Source).steam, ["@character_count"] = currentCharacter + 1}
                )
            else
                DropPlayer(
                    Source,
                    "Une exception non gérée vient de se produire [UpdateRegisterCharecterCount], Merci de contacter un développeur rapidement."
                )
            end
        end
    )
end

RegisterServerEvent("mugroom:RegisterNewPlayer")
AddEventHandler(
    "mugroom:RegisterNewPlayer",
    function(CreatePlayer, SpawnLocation)
        local source = source
        --(source)
        print(json.encode(CreatePlayer))

        print(json.encode(CreatePlayer.Identity))
        -- for k,v in pairs(z) do
        --     print(json.encode(v))
        -- end
        local Identity = CreatePlayer.Identity
        local Model = CreatePlayer.Model
        local Face = CreatePlayer.Face
        local Outfit = CreatePlayer.Outfit
        local Tattoo = {}
        GetUUID(
            source,
            function(UUID)
                --(UUID)
                --(Model)
                print(json.encode(Identity))
                InsertAppearance(UUID, Model, Face, Outfit, Tattoo)
                InsertIdentity(
                    UUID,
                    "N/A",
                    Identity.first_name,
                    Identity.last_name,
                    Identity.birth_date,
                    Identity.origine
                )
                InsertJob(UUID, "chomeur", 1)
                UpdateRegisterCharecterCount(source)
            end
        )
    end
)

local Selector = {}

function Selector:GetCharacterSkin(Source, UUID, Callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM players_appearance WHERE uuid = @uuid",
        {["@uuid"] = UUID},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                Callback(result)
            else
                DropPlayer(
                    Source,
                    "Une exception non gérée vient de se produire [GetCharacterSkin], Merci de contacter un développeur rapidement."
                )
            end
        end
    )
end

function Selector:GetCharacterIdentity(Source, UUID, Callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM players_identity WHERE uuid = @uuid",
        {["@uuid"] = UUID},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                Callback(result)
            else
                DropPlayer(
                    Source,
                    "Une exception non gérée vient de se produire [GetCharacterIdentity], Merci de contacter un développeur rapidement."
                )
            end
        end
    )
end

function Selector:GetCharacterJobs(Source, UUID, Callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM players_jobs WHERE uuid = @uuid",
        {["@uuid"] = UUID},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                Callback(result)
            else
                DropPlayer(
                    Source,
                    "Une exception non gérée vient de se produire [GetCharacterJobs], Merci de contacter un développeur rapidement."
                )
            end
        end
    )
end

function Selector:GetUsersValue(Source, UUID, Callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM users WHERE identifier=@identifiers",
        {["@identifiers"] = GetIdentifiers(Source).steam},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                Callback(result)
            else
                DropPlayer(
                    Source,
                    "Une exception non gérée vient de se produire [GetUsersValue], Merci de contacter un développeur rapidement."
                )
            end
        end
    )
end
local AlreadyCoiffed = {}

RegisterServerCallback(
    "isAlreadyCoiffed",
    function(source, callback)
        callback(AlreadyCoiffed[source] == nil)
    end
)

RegisterServerEvent("face:Save")
AddEventHandler(
    "face:Save",
    function(skin)
        AlreadyCoiffed[source] = 1
        MySQL.Sync.execute(
            "UPDATE players_appearance SET face=@face WHERE uuid=@uuid",
            {["@uuid"] = Player.GetPlayer(source).uuid, ["@face"] = json.encode(skin)}
        )
    end
)

RegisterServerEvent("aCore:cutHairs")
AddEventHandler(
    "aCore:cutHairs",
    function(distantPlayer)
        print(distantPlayer)
        TriggerClientEvent("getCutCheveux", distantPlayer)
    end
)

RegisterServerEvent("mugroom:SelectedPlayer")
AddEventHandler(
    "mugroom:SelectedPlayer",
    function(UUID)
        local source = source
        if (UUID ~= nil) then
            MySQL.Sync.execute(
                "UPDATE users SET is_active=@is_active WHERE uuid=@uuid",
                {["@uuid"] = UUID, ["@is_active"] = true}
            )
            Citizen.Wait(500)
            Selector:GetCharacterSkin(
                source,
                UUID,
                function(Skins)
                    Selector:GetCharacterIdentity(
                        source,
                        UUID,
                        function(Identity)
                            Selector:GetUsersValue(
                                source,
                                UUID,
                                function(Users)
                                    Selector:GetCharacterJobs(
                                        source,
                                        UUID,
                                        function(Jobs)
                                            TriggerClientEvent("selector:onExited", source)

                                            TriggerClientEvent(
                                                "spawnhandler:LoadCharacter",
                                                source,
                                                Skins,
                                                Identity,
                                                Jobs,
                                                Users
                                            )
                                        end
                                    )
                                end
                            )
                        end
                    )
                end
            )
        else
            DropPlayer(
                source,
                "Une exception non gérée vient de se produire, [UUID IS NULL] Merci de contacter un développeur rapidement."
            )
        end
    end
)

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 30/09/2019 18:37
---

---@type table
SQL = SQL or {} -- TODO Remove this and replace with Database value
Event = Event or {}
Database = Database or {}
Players = Players or {}

function Database:UpdateEconomy(uuid, column, operator, value)
    MySQL.Async.execute(
        "UPDATE players_economy SET " ..
            column .. " = " .. column .. " " .. operator .. " " .. value .. " WHERE uuid=@uuid",
        {["@uuid"] = uuid},
        function()
            return true
        end
    )
end

function Database:onRemoveConnected(source)
    MySQL.Async.execute(
        "DELETE FROM connected WHERE identifier=@identifier",
        {
            ["@identifier"] = GetIdentifiers(source)[servers.identifier]
        }
    )
end

function Database:UpdatePermissions(uuid, table)
    if (type(table) == "table") then
        MySQL.Async.execute(
            "UPDATE whitelist SET permissions = @table WHERE identifier=@identifier",
            {["@table"] = json.encode(table), ["@identifier"] = uuid},
            function()
                return true
            end
        )
    else
        error("DATABASE : Update permisssions table is not a table")
    end
end

function Database:GetPlayersActive(source, identifier, callback)
    MySQL.Async.fetchAll(
        "SELECT uuid,position FROM players WHERE identifier=@identifier AND is_active = @is_active",
        {["@identifier"] = identifier, ["@is_active"] = 1},
        function(data)
            if (data ~= nil and data[1] ~= nil) then
                if (#data > 1) then
                    DropPlayer(
                        source,
                        "[rage-reborn] you have too many active characters. report : contact@dylan-malandain.io"
                    )
                    callback(false, false)
                else
                    callback(data[1].uuid, data[1].position)
                end
            else
                callback(false, false)
            end
        end
    )
end

function Database:DeleteWhereID(table, id)
    MySQL.Async.execute("DELETE From " .. table .. " WHERE id = @id", {["@id"] = id})
end

function Database:GetCharacterLimit(source, identifier, callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM whitelist WHERE identifier=@identifier",
        {["@identifier"] = identifier},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                --callback(false)
                local json = json.decode(result[1].character_table)
                if (json.limit == json.current) then
                    callback(true)
                else
                    callback(false)
                end
            else
                DropPlayer(
                    source,
                    "[rage-reborn] selecting all content in whitelist is null. report : contact@dylan-malandain.io"
                )
            end
        end
    )
end

function Database:GetContentTableWithUUID(source, uuid, table, callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM " .. table .. " WHERE uuid=@uuid",
        {["@uuid"] = uuid},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                callback(result[1])
            else
                DropPlayer(
                    source,
                    string.format(
                        "[rage-reborn] GetContentTableWithUUID Table : %s | impossible to retrieve values with uuid. report : contact@dylan-malandain.io",
                        table
                    )
                )
            end
        end
    )
end

function Database:GetContentTableWithMultipleUUID(source, uuidTable, queryTable, callback)
    local storage = {}
    for i = 1, #uuidTable do
        MySQL.Async.fetchAll(
            "SELECT * FROM " .. queryTable .. " WHERE uuid=@uuid",
            {["@uuid"] = uuidTable[i]},
            function(result)
                if (result ~= nil and result[1] ~= nil) then
                    table.insert(storage, result[1])
                else
                    DropPlayer(
                        source,
                        string.format(
                            "[rage-reborn] GetContentTableWithUUID Table : %s | impossible to retrieve values with uuid. report : contact@dylan-malandain.io",
                            queryTable
                        )
                    )
                end
            end
        )
    end
    Citizen.Wait(100.0)
    callback(storage)
    Citizen.Wait(100.0)
    storage = nil
end

function Database:GetWhitelistContent(source, identifier, callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM whitelist WHERE identifier=@identifier",
        {["@identifier"] = identifier},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                callback(result[1])
            else
                DropPlayer(
                    source,
                    string.format(
                        "[rage-reborn] GetWhitelistContent | impossible to retrieve values with uuid. report : contact@dylan-malandain.io"
                    )
                )
            end
        end
    )
end

function Database:GetSelectedPlayerContent(source, identifier, uuid, callback)
    self:GetContentTableWithUUID(
        source,
        uuid,
        "players_appearance",
        function(appearance)
            self:GetContentTableWithUUID(
                source,
                uuid,
                "players_economy",
                function(economy)
                    self:GetContentTableWithUUID(
                        source,
                        uuid,
                        "players_identity",
                        function(identity)
                            self:GetContentTableWithUUID(
                                source,
                                uuid,
                                "players_needs",
                                function(needs)
                                    self:GetContentTableWithUUID(
                                        source,
                                        uuid,
                                        "players_jobs",
                                        function(jobs)
                                            self:GetContentTableWithUUID(
                                                source,
                                                uuid,
                                                "players_organization",
                                                function(organization)
                                                    MySQL.Async.fetchAll(
                                                        "SELECT * FROM players_inventory WHERE uuid=@uuid",
                                                        {["@uuid"] = uuid},
                                                        function(inventory)
                                                            self:GetWhitelistContent(
                                                                source,
                                                                identifier,
                                                                function(permissions)
                                                                    callback(
                                                                        appearance,
                                                                        economy,
                                                                        identity,
                                                                        needs,
                                                                        permissions.permissions,
                                                                        inventory,
                                                                        jobs,
                                                                        organization
                                                                    )
                                                                end
                                                            )
                                                        end
                                                    )
                                                end
                                            )
                                        end
                                    )
                                end
                            )
                        end
                    )
                end
            )
        end
    )
end

function Database:GetAllUUID(_s, identifier, callback)
    local storage = {}
    MySQL.Async.fetchAll(
        "SELECT uuid FROM players WHERE identifier=@identifier",
        {["@identifier"] = identifier},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                for i = 1, #result do
                    table.insert(storage, result[i].uuid)
                end
            else
                DropPlayer(
                    _s,
                    string.format(
                        "[rage-reborn] GetAllUUID | impossible to retrieve values with identifier. report : contact@dylan-malandain.io"
                    )
                )
            end
        end
    )
    Citizen.Wait(100.0)
    callback(storage)
    Citizen.Wait(100.0)
    storage = nil
end

function Database:GetAllPlayerContent(_s, uuidList, callback)
    -- TODO Add Jobs
    -- TODO Add Organization
    Database:GetContentTableWithMultipleUUID(
        _s,
        uuidList,
        "players_appearance",
        function(appearance)
            Database:GetContentTableWithMultipleUUID(
                _s,
                uuidList,
                "players_economy",
                function(economy)
                    Database:GetContentTableWithMultipleUUID(
                        _s,
                        uuidList,
                        "players_identity",
                        function(identity)
                            callback(#uuidList, appearance, economy, identity, {}, {})
                        end
                    )
                end
            )
        end
    )
end

function Database:SelectedPlayer(uuid)
    MySQL.Async.execute(
        "UPDATE players SET is_active=1 WHERE uuid=@uuid",
        {["@uuid"] = uuid},
        function()
            return true
        end
    )
end

function Database:UnselectedPlayers(source, identifier)
    Database:GetAllUUID(
        source,
        identifier,
        function(_)
            for i = 1, #_ do
                MySQL.Sync.execute(
                    "UPDATE players SET is_active=0 WHERE uuid=@uuid",
                    {["@uuid"] = _[i]},
                    function()
                    end
                )
            end
        end
    )
end

function Database:RegisterPlayer(source, position, callback)
    TriggerEvent(
        "rage-reborn:uuid",
        function(uuid)
            MySQL.Async.execute(
                "INSERT INTO players (identifier, uuid, is_active, position) VALUES (@identifier, @uuid, @is_active, @position)",
                {
                    ["@identifier"] = GetIdentifiers(source)[servers.identifier],
                    ["@uuid"] = uuid,
                    ["@is_active"] = 1,
                    ["@position"] = json.encode(position),
                    ["@created_at"] = GetDatetime(),
                    ["@updated_at"] = GetDatetime()
                }
            )
            callback(uuid)
        end
    )
end

function Database:RegisterJobs(uuid)
    MySQL.Async.execute(
        "INSERT INTO players_jobs (uuid, jobs, rank_id, settings, permission) VALUES (@uuid, @jobs, @rank_id, @settings, @permission)",
        {
            ["@uuid"] = uuid,
            ["@jobs"] = "unemployed",
            ["@rank_id"] = 0,
            ["@settings"] = json.encode({}),
            ["@permission"] = json.encode({}),
            ["@created_at"] = GetDatetime(),
            ["@updated_at"] = GetDatetime()
        }
    )
end

function Database:RegisterOrganization(uuid)
    MySQL.Async.execute(
        "INSERT INTO players_organization (uuid, name, rank_id, settings, permission) VALUES (@uuid, @name, @rank_id, @settings, @permission)",
        {
            ["@uuid"] = uuid,
            ["@name"] = nil,
            ["@rank_id"] = 0,
            ["@settings"] = json.encode({}),
            ["@permission"] = json.encode({}),
            ["@created_at"] = GetDatetime(),
            ["@updated_at"] = GetDatetime()
        }
    )
end

function Database:RegisterIdentity(uuid, first_name, last_name, birth_date, origine)
    MySQL.Sync.execute(
        "INSERT INTO players_identity (uuid, face_picutre, first_name, last_name, birth_date, origine) VALUES (@uuid, @face_picutre, @first_name, @last_name, @birth_date, @origine)",
        {
            ["@uuid"] = uuid,
            ["@face_picutre"] = first_name,
            ["@first_name"] = first_name,
            ["@last_name"] = last_name,
            ["@birth_date"] = birth_date,
            ["@origine"] = origine,
            ["@created_at"] = GetDatetime(),
            ["@updated_at"] = GetDatetime()
        }
    )
end

function Database:RegisterAppearance(uuid, model, face, outfit, tattoo)
    MySQL.Sync.execute(
        "INSERT INTO players_appearance (uuid, model, face, outfit, tattoo) VALUES (@uuid, @model, @face, @outfit, @tattoo)",
        {
            ["@uuid"] = uuid,
            ["@model"] = model,
            ["@face"] = json.encode(face),
            ["@outfit"] = json.encode(outfit),
            ["@tattoo"] = json.encode(tattoo),
            ["@created_at"] = GetDatetime(),
            ["@updated_at"] = GetDatetime()
        }
    )
end

function Database:RegisterEconomy(uuid, money, dirty_money)
    MySQL.Sync.execute(
        "INSERT INTO players_economy (uuid, money, dirty_money) VALUES (@uuid, @money, @dirty_money)",
        {
            ["@uuid"] = uuid,
            ["@money"] = money,
            ["@dirty_money"] = dirty_money,
            ["@created_at"] = GetDatetime(),
            ["@updated_at"] = GetDatetime()
        }
    )
end

function Database:RegisterNeeds(uuid)
    content = {food = 100, drink = 100, sickness = 100}
    MySQL.Sync.execute(
        "INSERT INTO players_needs (uuid, content, health, armour) VALUES (@uuid, @content, @health, @armour)",
        {
            ["@uuid"] = uuid,
            ["@content"] = json.encode(content),
            ["@health"] = 100,
            ["@armour"] = 100,
            ["@created_at"] = GetDatetime(),
            ["@updated_at"] = GetDatetime()
        }
    )
end

function Database:UpdateCharacterCount(source, type)
    MySQL.Async.fetchAll(
        "SELECT character_table FROM whitelist WHERE identifier=@identifier",
        {["@identifier"] = GetIdentifiers(source)[servers.identifier]},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                local _tbl = json.decode(result[1].character_table)
                if (type == "add") then
                    _tbl.current = _tbl.current + 1
                else
                    _tbl.current = _tbl.current - 1
                end
                MySQL.Async.execute(
                    "UPDATE whitelist SET character_table=@character_table, updated_at=@updated_at WHERE identifier=@identifier",
                    {
                        ["@character_table"] = json.encode(_tbl),
                        ["@updated_at"] = GetDatetime(),
                        ["@identifier"] = GetIdentifiers(source)[servers.identifier]
                    }
                )
            else
                DropPlayer(
                    source,
                    "[rage-reborn] fatal error on update character count. report : contact@dylan-malandain.io"
                )
            end
        end
    )
end

function Database:DeletePlayerWithUUID(source, uuid)
    MySQL.Sync.execute("DELETE FROM players WHERE uuid=@uuid", {["@uuid"] = uuid})
    MySQL.Sync.execute("DELETE FROM players_appearance WHERE uuid=@uuid", {["@uuid"] = uuid})
    MySQL.Sync.execute("DELETE FROM players_economy WHERE uuid=@uuid", {["@uuid"] = uuid})
    MySQL.Sync.execute("DELETE FROM players_identity WHERE uuid=@uuid", {["@uuid"] = uuid})
    MySQL.Sync.execute("DELETE FROM players_inventory WHERE uuid=@uuid", {["@uuid"] = uuid})
    MySQL.Sync.execute("DELETE FROM players_needs WHERE uuid=@uuid", {["@uuid"] = uuid})
    MySQL.Sync.execute("DELETE FROM players_jobs WHERE uuid=@uuid", {["@uuid"] = uuid})
    MySQL.Sync.execute("DELETE FROM players_organization WHERE uuid=@uuid", {["@uuid"] = uuid})
    self:UpdateCharacterCount(source, "remove")
end

function SQL:GetPlayersActive(source, identifier, callback)
    MySQL.Async.fetchAll(
        "SELECT uuid,position FROM players WHERE identifier=@identifier AND is_active = @is_active",
        {["@identifier"] = identifier, ["@is_active"] = 1},
        function(data)
            if (data ~= nil and data[1] ~= nil) then
                if (#data > 1) then
                    DropPlayer(
                        source,
                        "[rage-reborn] you have too many active characters. report : contact@dylan-malandain.io"
                    )
                    callback(false, false)
                else
                    callback(data[1].uuid, data[1].position)
                end
            else
                callback(false, false)
            end
        end
    )
end

function SQL:GetAppearanceWithUUID(source, uuid, callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM players_appearance WHERE uuid=@uuid",
        {["@uuid"] = uuid},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                callback(result[1])
            else
                DropPlayer(
                    source,
                    "[rage-reborn] GetAppearanceWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io"
                )
            end
        end
    )
end

function SQL:GetIdentityWithUUID(source, uuid, callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM players_identity WHERE uuid=@uuid",
        {["@uuid"] = uuid},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                callback(result[1])
            else
                DropPlayer(
                    source,
                    "[rage-reborn] GetIdentityWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io"
                )
            end
        end
    )
end

function SQL:GetNeedsWithUUID(source, uuid, callback)
    MySQL.Async.fetchAll(
        "SELECT * FROM players_needs WHERE uuid=@uuid",
        {["@uuid"] = uuid},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                callback(result[1])
            else
                DropPlayer(
                    source,
                    "[rage-reborn] GetNeedsWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io"
                )
            end
        end
    )
end

function SQL:SavingNeeds()
end

function SQL:GetAllUUID(source, identifier, callback)
    local storage = {}
    MySQL.Async.fetchAll(
        "SELECT uuid FROM players WHERE identifier = @identifiers",
        {["@identifiers"] = identifier},
        function(result)
            if (result ~= nil and result[1] ~= nil) then
                for i = 1, #result do
                    table.insert(storage, {uuid = result[i].uuid})
                end
                callback(storage)
                storage = {}
            else
                DropPlayer(
                    source,
                    "[rage-reborn] GetAllUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io"
                )
            end
        end
    )
end

function SQL:GetAllAppearanceWithUUID(source, uuid, callback)
    local storage = {}
    setmetatable(storage, {__index = table})
    for i = 1, #uuid do
        MySQL.Async.fetchAll(
            "SELECT * FROM players_appearance WHERE uuid = @uuid",
            {["@uuid"] = uuid[i].uuid},
            function(result)
                if (result ~= nil and result[1] ~= nil) then
                    -- La sa -- yes
                    storage:insert(
                        {
                            uuid = uuid[i].uuid,
                            face = result[1].face,
                            outfit = result[1].outfit,
                            tattoo = result[1].tattoo
                        }
                    )
                else
                    DropPlayer(
                        source,
                        "[rage-reborn] GetAllAppearanceWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io"
                    )
                end
            end
        )
    end
    callback(storage)
    --storage = {}
end

function SQL:GetAllIdentityWithUUID(source, uuid, callback)
    local storage = {}
    for k, v in pairs(uuid) do
        MySQL.Async.fetchAll(
            "SELECT * FROM players_identity WHERE uuid = @uuid",
            {["@uuid"] = v.uuid},
            function(result)
                if (result ~= nil and result[1] ~= nil) then
                    table.insert(storage, {uuid = v.uuid, table = result[1]})
                else
                    DropPlayer(
                        source,
                        "[rage-reborn] GetAllIdentityWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io"
                    )
                end
            end
        )
    end
    callback(storage)
    storage = {}
end

RegisterServerCallback(
    "rage-reborn:GetStorageItems",
    function(source, callback, name)
        print(name)
        MySQL.Async.fetchAll(
            "SELECT * FROM storages_inventory_items2 WHERE storage_name = @name",
            {
                ["@name"] = name
            },
            function(result)
                callback(result)
            end
        )
    end
)

function GetStorageByName(name)
    local RRR = nil
    MySQL.Async.fetchAll(
        "SELECT * FROM storages_inventory_items WHERE name = @name",
        {
            ["@name"] = name
        },
        function(result)
            RRR = result
        end
    )
    while RRR == nil do
        Wait(0)
    end
    return RRR
end

function GetDatetime(time)
    time = time or os.time()
    return os.date("%Y-%m-%d %H:%M:%S", time)
end
RegisterServerEvent("rage-reborn:RemoveItemFromStorage")
AddEventHandler(
    "rage-reborn:RemoveItemFromStorage",
    function(id, name)
        --Database:DeleteWhereID("storages_inventory_items",id)
        MySQL.Async.execute(
            "DELETE From storages_inventory_items WHERE id = @id and itemName=@name",
            {["@id"] = id, ["@name"] = name}
        )
    end
)

RegisterServerEvent("rage-reborn:DepositStockageItem")
AddEventHandler(
    "rage-reborn:DepositStockageItem",
    function(item)
        local _source = source
        MySQL.Async.insert(
            "INSERT INTO storages_inventory_items (name,itemName,metadata,label) VALUES (@name,@itemName,@metadata,@label)",
            {
                ["@name"] = item.storage,
                ["@itemName"] = item.name,
                ["@metadata"] = json.encode(item.metadata),
                ["@label"] = item.label
            },
            function(insertId)
                --TriggerClientEvent('inventory:updateItemIdFromDb', _source, item.id,insertId, item)
            end
        )
    end
)

RegisterServerEvent("rage-reborn:DepositStockageItem2")
AddEventHandler(
    "rage-reborn:DepositStockageItem2",
    function(item)
        local _source = source
        element = {}
        element["id"] = item.id
        element["metadata"] = item.metadata
        element["label"] = item.label

        MySQL.Async.fetchAll(
            "SELECT * FROM `storages_inventory_items2` WHERE item_name = @itemName AND storage_name = @storageName",
            {
                ["@storageName"] = item.storage,
                ["@itemName"] = item.name
            },
            function(results)
                local itemsToSave = {}
                local elementCount = 0
                local metadata = {}
                local hasChanged = false
                local added = 0

                if (results[1] ~= nil and results[1].metadata ~= nil) then
                    metadata = json.decode(results[1].metadata)
                    metadata[item.id] = element
                    added = added + 1

                    MySQL.Async.execute(
                        "UPDATE storages_inventory_items2 SET metadata = @metadata  WHERE storage_name = @storageName AND item_name = @itemName",
                        {
                            ["@metadata"] = json.encode(metadata),
                            ["@storageName"] = item.storage,
                            ["@itemName"] = item.name
                        },
                        function(insertId)
                            --print("^2Added " .. added .. " elements ^0")
                        end
                    )
                else
                    metadata[item.id] = element
                    added = added + 1

                    MySQL.Async.insert(
                        "INSERT INTO storages_inventory_items2 (storage_name, item_name, metadata) VALUES (@name,@itemName, @metadata) " ..
                            "ON DUPLICATE KEY UPDATE qty=0, metadata=JSON_MERGE_PRESERVE(metadata, @metadata);",
                        {
                            ["@name"] = item.storage,
                            ["@itemName"] = item.name,
                            ["@metadata"] = json.encode(metadata)
                        },
                        function(insertId)
                            --print("^2Added " .. added .. " elements ^0")
                        end
                    )
                end
            end
        )
    end
)

local totalCount = 0

RegisterServerEvent("rage-reborn:RemoveItemFromStorage2")
AddEventHandler(
    "rage-reborn:RemoveItemFromStorage2",
    function(id, itemName, storageName)
        print(id, itemName, storageName)
        --Database:DeleteWhereID("storages_inventory_items",id)
        totalCount = totalCount + 1
        print("Total called : " .. totalCount)

        MySQL.Async.fetchAll(
            "SELECT * FROM `storages_inventory_items2` WHERE item_name = @itemName AND storage_name = @storageName",
            {
                ["@storageName"] = storageName,
                ["@itemName"] = itemName
            },
            function(results)
                local m = json.decode(results[1].metadata)
                m[id] = nil

                MySQL.Async.execute(
                    "UPDATE storages_inventory_items2 set metadata = @m WHERE storage_name = @storageName AND item_name = @itemName",
                    {
                        ["@m"] =  json.encode(m),
                        ["@storageName"] = storageName,
                        ["@itemName"] =itemName
                    },
                    function(insertId)
                    end
                )
            end
        )
        MySQL.Async.execute(
            "UPDATE storages_inventory_items2 set metadata = JSON_REMOVE(metadata, @id) WHERE storage_name = @storageName AND item_name = @itemName",
            {
                ["@id"] =  "$." .. id,
                ["@storageName"] = storageName,
                ["@itemName"] =itemName
            },
            function(insertId)
            end
        )
    end
)

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

RegisterServerEvent("rage-reborn:TransfertToInventory")
AddEventHandler(
    "rage-reborn:TransfertToInventory",
    function(ids, itemName, storageName)
        local _source = source
        MySQL.Async.fetchAll(
            "SELECT * FROM `storages_inventory_items2` WHERE item_name = @itemName AND storage_name = @storageName",
            {
                ["@storageName"] = storageName,
                ["@itemName"] = itemName
            },
            function(results)
                local items = {}
                local elementCount = 0
                local metadata = {}
                local hasChanged = false
                local removed = 0
                if (results[1] ~= nil and results[1].metadata ~= nil) then
                    metadata = json.decode(results[1].metadata)

                    for key, v in pairs(metadata) do
                        if (has_value(ids, key) == true) then
                            if (type(v) == "string") then
                                value = json.decode(v)
                            elseif (type(v) == "table") then
                                value = v
                            else
                                return
                            end
                            objectValue = {}
                            objectValue.id = value.id
                            objectValue.name = itemName
                            objectValue.label = value.label
                            objectValue.data = value.metadata
                            table.insert(items, objectValue)
                            elementCount = elementCount + 1
                            metadata[key] = nil
                            hasChanged = true
                            removed = removed + 1
                        end
                    end
                end

                if (hasChanged == true) then
                    MySQL.Async.execute(
                        "UPDATE storages_inventory_items2 SET metadata = @metadata  WHERE storage_name = @storageName AND item_name = @itemName",
                        {
                            ["@metadata"] = json.encode(metadata),
                            ["@storageName"] = storageName,
                            ["@itemName"] = itemName
                        },
                        function(insertId)
                            --TriggerClientEvent('inventory:updateItemIdFromDb', _source, item.id,insertId, item)
                        end
                    )

                    local sendItems = {}
                    local itemSent = 0

                    for key, v in pairs(items) do
                        table.insert(sendItems, v)
                        itemSent = itemSent + 1
                        if (itemSent >= 75) then
                            TriggerClientEvent("aCore:inventory:addItems", _source, sendItems)
                            sendItems = {}
                            itemSent = 0
                        end
                    end

                    TriggerClientEvent("aCore:inventory:addItems", _source, sendItems)
                end
            end
        )
    end
)

RegisterServerEvent("rage-reborn:TransfertToStorage")
AddEventHandler(
    "rage-reborn:TransfertToStorage",
    function(items, itemName, storageName)
        local _source = source
        MySQL.Async.fetchAll(
            "SELECT * FROM `storages_inventory_items2` WHERE item_name = @itemName AND storage_name = @storageName",
            {
                ["@storageName"] = storageName,
                ["@itemName"] = itemName
            },
            function(results)
                local itemsToSave = {}
                local elementCount = 0
                local metadata = {}
                local hasChanged = false
                local added = 0

                if (results[1] ~= nil and results[1].metadata ~= nil) then
                    metadata = json.decode(results[1].metadata)

                    for itemKey, itemValue in pairs(items) do
                        metadata[itemValue.id] = itemValue
                        added = added + 1
                    end

                    MySQL.Async.execute(
                        "UPDATE storages_inventory_items2 SET metadata = @metadata WHERE storage_name = @storageName AND item_name = @itemName",
                        {
                            ["@metadata"] = json.encode(metadata),
                            ["@storageName"] = storageName,
                            ["@itemName"] = itemName
                        },
                        function(insertId)
                            --print("^2Added " .. added .. " elements ^0")
                        end
                    )
                else
                    for itemKey, itemValue in pairs(items) do
                        metadata[itemValue.id] = itemValue
                        added = added + 1
                    end

                    MySQL.Async.insert(
                        "INSERT INTO storages_inventory_items2 (storage_name, item_name, qty, metadata) VALUES (@name,@itemName,0, @metadata) " ..
                            "ON DUPLICATE KEY UPDATE qty=0, metadata=JSON_MERGE_PRESERVE(metadata, @metadata);",
                        {
                            ["@name"] = storageName,
                            ["@itemName"] = itemName,
                            ["@metadata"] = json.encode(metadata)
                        },
                        function(insertId)
                            -- print("^2Added " .. added .. " elements ^0")
                        end
                    )
                end
            end
        )
    end
)
