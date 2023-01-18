---GetIdentifiers
---@param source _G
---@return table
local function GetIdentifiers(source)
    local identifiers = {}
    local playerIdentifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end

local function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

-- TODO Use query jointure
---@type table
local Query = {  }

---GetCharacterLimit
---@param Source _G
---@param Identifier string
---@param Callback function
---@return table
---@public
function Query:GetCharacterLimit(Source, Identifier, Callback)
    MySQL.Async.fetchAll('SELECT character_count,character_limit FROM whitelist WHERE identifier = @identifiers', { ["@identifiers"] = Identifier }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            Callback(result[1].character_count, result[1].character_limit)
        else
            DropPlayer(Source, "Une erreur est survenue lors de votre connexion [GetCharacterLimit], Merci de Contacter le support. #ERR01")
        end
    end)
end

---GetSelectedCharacter
---@param Source _G
---@param Identifer string
---@param Callback function
---@return table
---@public
function Query:GetSelectedCharacter(Source, Identifer, Callback)
    MySQL.Async.fetchAll('SELECT uuid FROM users WHERE identifier = @identifiers AND is_active = @is_active', { ["@identifiers"] = Identifer, ["@is_active"] = 1 }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            if (#result > 1) then
                DropPlayer(Source, "Une erreur est survenue lors de votre connexion [GetSelectedCharacter - #result > 1], Merci de Contacter le support. #ERR02")
            else
                MySQL.Async.fetchAll('SELECT * FROM players_appearance WHERE uuid = @uuid', { ["@uuid"] = result[1].uuid }, function(appearance)
                    if (appearance ~= nil and appearance[1] ~= nil) then
                        Callback(true, appearance) --- Players already selected
                    else
                        DropPlayer(Source, "Une erreur est survenue lors de votre connexion [GetSelectedCharacter - players_appearance], Merci de Contacter le support.")
                    end
                end)
            end
        else
            Callback(false, {})
        end
    end)
end

---GetAllCharacter
---@param Source _G
---@param Identifier string
---@param Callback function
---@return table
---@public
function Query:GetAllCharacter(Source, Identifier, Callback)
    MySQL.Async.fetchAll('SELECT uuid FROM users WHERE identifier = @identifiers', { ["@identifiers"] = Identifier }, function(result)
        if (result ~= nil) then
            for i = 1, #result do
                MySQL.Async.fetchAll('SELECT * FROM players_appearance WHERE uuid = @uuid', { ["@uuid"] = result[i].uuid }, function(list)
                    Callback(list)
                end)
            end
        else
            DropPlayer(Source, "Une erreur est survenue lors de votre connexion [GetAllCharacter], Merci de Contacter le support.")
        end
    end)
end

---GetAllCharacterIdentity
---@param Source table
---@param Identifier table
---@param Callback table
function Query:GetAllCharacterIdentity(Source, Identifier, Callback)
    MySQL.Async.fetchAll('SELECT uuid FROM users WHERE identifier = @identifiers', { ["@identifiers"] = Identifier }, function(result)
        if (result ~= nil) then
            for i = 1, #result do
                MySQL.Async.fetchAll('SELECT * FROM players_identity WHERE uuid = @uuid', { ["@uuid"] = result[i].uuid }, function(list)
                    Callback(list)
                end)
            end
        else
            DropPlayer(Source, "Une erreur est survenue lors de votre connexion [GetAllCharacterIdentity], Merci de Contacter le support.")
        end
    end)
end

---GetAllCharacterUsers
---@param Source _G
---@param Identifier string
---@param Callback function
function Query:GetAllCharacterUsers(Source, Identifier, Callback)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers', { ["@identifiers"] = Identifier }, function(result)
        if (result ~= nil) then
            Callback(result)
        else
            DropPlayer(Source, "Une erreur est survenue lors de votre connexion [GetAllCharacterUsers], Merci de Contacter le support.")
        end
    end)
end

---GetAllCharacterJobs
---@param Source _G
---@param Identifier string
---@param Callback function
function Query:GetAllCharacterJobs(Source, Identifier, Callback)
    MySQL.Async.fetchAll('SELECT uuid FROM users WHERE identifier = @identifiers', { ["@identifiers"] = Identifier }, function(result)
        if (result ~= nil) then
            for i = 1, #result do
                MySQL.Async.fetchAll('SELECT * FROM players_jobs WHERE uuid = @uuid', { ["@uuid"] = result[i].uuid }, function(list)
                    Callback(list)
                end)
            end
        else
            DropPlayer(Source, "Une erreur est survenue lors de votre connexion [GetAllCharacterJobs], Merci de Contacter le support.")
        end
    end)
end

---RequestPlayerContent
---@param Source _G
---@param Identifier string
---@param Callback function
function Query:RequestPlayerContent(Source, Identifier, Callback)
    Query:GetAllCharacter(Source, Identifier, function(Skins)
        Query:GetAllCharacterIdentity(Source, Identifier, function(Identity)
            Query:GetAllCharacterJobs(Source, Identifier, function(Jobs)
                Query:GetAllCharacterUsers(Source, Identifier, function(Users)
                    Callback(Skins, Identity, Jobs, Users)
                end)
            end)
        end)
    end)
end

--- Active ID : 0  = Personnage active uniquement besoin de chargé le contenue
--- Active ID : 1  = Pas de personnage active mes retourne une table avec tout les personnage de l'utilisateur
--- Active ID : 2  = Pas de personnage crée un perso
RegisterServerCallback('spawned:requestData', function(source, Callback)
    local identifier = GetIdentifiers(source).steam
    Query:GetCharacterLimit(source, identifier, function(Current, Limit)
        if (Current == Limit) then
            Query:GetSelectedCharacter(source, identifier, function(Active, Table)
                if (Active) then
                    -- TODO Rework sa j'ai la flemme si tu veux
                    Query:GetAllCharacter(source, identifier, function(Skins)
                        Query:GetAllCharacterIdentity(source, identifier, function(Identity)
                            Query:GetAllCharacterJobs(source, identifier, function(Jobs)
                                Query:GetAllCharacterUsers(source, identifier, function(Users)
                                    Callback(true, 0, Skins, Identity, Jobs, Users)
                                end)
                            end)
                        end)
                    end)
                else
                    -- TODO Rework sa j'ai la flemme si tu veux
                    Query:GetAllCharacter(source, identifier, function(Skins)
                        Query:GetAllCharacterIdentity(source, identifier, function(Identity)
                            Query:GetAllCharacterJobs(source, identifier, function(Jobs)
                                Query:GetAllCharacterUsers(source, identifier, function(Users)
                                    Callback(false, 1, Skins, Identity, Jobs, Users)
                                end)
                            end)
                        end)
                    end)
                end
            end)
        else
            Callback(false, 2, {})
        end
    end)
end)