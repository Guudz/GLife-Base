Storage = setmetatable({}, Storage)
Storage.__index = Storage
Storage.__call = function()
    return "Storage"
end
local storage = {}

local currentStorage = {}
function Storage.New(name, maxWeight)
    local newStorage = {}
    TriggerServerCallback(
        "rage-reborn:GetStorageItems",
        function(Items)
            newStorage = {
                name = name,
                maxWeight = maxWeight,
                items = FormatStorage(Items),
                Weight = 0
            }
        end,
        name
    )
    while newStorage.name == nil do
        Wait(50)
    end
    return setmetatable(newStorage, Storage)
end

function Storage:LinkToPos(Pos, name)
    Marker:Add(
        Pos,
        {
            type = 23,
            scale = {x = 1.5, y = 1.5, z = 0.2},
            color = {r = 255, g = 255, b = 255, a = 120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        }
    )
    Zone:Add(
        Pos,
        function(self)
            Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
            KeySettings:Add(
                "keyboard",
                "E",
                function()
                    currentStorage = self
                    self:RefreshDB()
                    self:RefreshWeight()
                    self:Visible(true)
                end,
                "STORAGEEE"
            )
            KeySettings:Add(
                "controller",
                46,
                function()
                    currentStorage = storage
                    self:RefreshDB()
                    self:RefreshWeight()
                    self:Visible(true)
                end,
                "STORAGEEE"
            )
        end,
        function()
            if currentStorage ~= nil then
                RageUI.Visible(RMenu:Get("storage", "main"), false)
            end
            KeySettings:Clear("keyboard", "E", "STORAGEEE")
            KeySettings:Clear("controller", 46, "STORAGEEE")
            CloseAllMenus()
            Hint:RemoveAll()
            currentStorage = nil
        end,
        self,
        1.5
    )
end
function Storage:Visible(bool)
    if bool then
        currentStorage = self
    end
    RageUI.Visible(RMenu:Get("storage", "main"), bool)
    RMenu:Get("storage", "main").Index = 1
    Citizen.CreateThread(
        function()
            Wait(2500)
            -- Inventory:Load()
        end
    )
end
function FormatStorage(items)
    local _Items = {}
    for i = 1, #items, 1 do
        local p = items[i]
        if _Items[p.item_name] == nil then
            _Items[p.item_name] = {}
        end
        local data = p.metadata ~= nil and json.decode(p.metadata) or nil

        if (data == "{}" or data == nil) then
            -- do nothingg
        else
            for itemId, itemValue in pairs(data) do
                if (type(itemValue) == "string") then
                    itemValue = json.decode(itemValue)
                end

                if itemValue.metadata == nil then
                    itemValue.metadata = {}
                end

                if itemValue.label == nil then
                    itemValue.label = nil
                end

                table.insert(
                    _Items[p.item_name],
                    {name = p.item_name, data = itemValue.metadata, label = itemValue.label, id = itemId}
                )
            end
        end
    end
    return _Items
end
function Storage:AddItem(item)
    if self.items[item.name] == nil then
        self.items[item.name] = {}
    end
    local label = item.label ~= nil and item.label or nil
    table.insert(self.items[item.name], {name = item.name, data = item.metadata, label = label, id = item.id})
end

function Storage:UpdateItemId(item, oldid, newid)
    if self.items[item.name] == nil then
        self.items[item.name] = {}
    end
    local label = item.label ~= nil and item.label or nil
    for k, v in pairs(self.items[item.name]) do
        if (v ~= nil and v.id == oldid) then
            v.id = newid
        end
    end
end

function Storage:RefreshWeight()
    local Weight = 0
    local tmpWeight = nil
    for k, v in pairs(self.items) do
        if v[1] ~= nil then
            p = self.items[k]
            if (Items[v[1].name] == nil or Items[v[1].name].weight == nil) then
                tmpWeight = 0.5
                print("^1-[DBG STOCKAGE 123] - " .. v[1].name .. " aucun poids")
            else
                tmpWeight = Items[v[1].name].weight
            end
            Weight = Weight + (tmpWeight * #v)
        end
    end
    self.Weight = Weight
    RMenu:Get("storage", "main"):SetPageCounter(round(self.Weight, 2) .. "/" .. self.maxWeight .. "KG")
end

function Storage:RefreshDB()
    TriggerServerCallback(
        "rage-reborn:GetStorageItems",
        function(Items)
            self.items = FormatStorage(Items)
        end,
        self.name
    )
end

function Storage:RemoveItem(name, id)
    RMenu:Get("storage", "main").Index = RMenu:Get("storage", "main").Index - 1
    print(name,id)
    self:RefreshWeight()
    for k, v in pairs(self.items) do
        if k == name then
            for i = 1, #v, 1 do
                if v[i].id == id then
                    TriggerServerEvent("rage-reborn:RemoveItemFromStorage2", id, name, self.name)
                    table.remove(self.items[name], i)
                    break
                end
            end
        end
    end
end

function Storage:RemoveItems(items, itemName)
    RMenu:Get("storage", "main").Index = RMenu:Get("storage", "main").Index - 1
    self:RefreshWeight()
    local itemsIds = {}
    print("REMOVED ITEMS !")

    for itemKey, itemValue in pairs(items) do
        table.insert(itemsIds, itemValue.id)
        for k, v in pairs(self.items) do
            if k == itemValue.name then
                for i = 1, #v, 1 do
                    if v[i].id == itemValue.id then
                        table.remove(self.items[itemValue.name], i)
                        break
                    end
                end
            end
        end
    end

    TriggerServerEvent("rage-reborn:RemoveItemsFromStorage2", itemsIds, itemName, self.name)
end

function Storage:TransferToInventory(count, itemName)
    RMenu:Get("storage", "main").Index = RMenu:Get("storage", "main").Index - 1
    self:RefreshWeight()
    local itemsIds = {}

    for k, v in pairs(self.items) do
        if k == itemName then
            local itemsLocal = {}

            if (#v >= count) then
                for i = 1, count do
                    if (self.items[itemName][i] ~= nil) then
                        table.insert(itemsIds, self.items[itemName][i].id)
                        self.items[itemName][i] = nil
                    end
                end
            else
                ShowNotification("Vous n'avez pas assez d'items")
            end

            for i = 1, #v do
                if (self.items[itemName][i] ~= nil) then
                    table.insert(itemsLocal, self.items[itemName][i])
                end
            end

            self.items[itemName] = itemsLocal
        end
    end

    if #itemsIds > 0 then
        ShowNotification(
            "~w~[" ..
                math.random(0, 100) ..
                    "] ~w~Vous avez retirer ~r~" ..
                        count .. "x " .. string.lower(Items[itemName].label) .. " ~w~du coffre~w~"
        )
        TriggerServerEvent("rage-reborn:TransfertToInventory", itemsIds, itemName, self.name)
        ExecuteCommand('me Retire un objet du coffre.')
    end
end

function Storage:TransferToStorage(count, itemName, storageName)
    self:RefreshWeight()
    local itemsIds = {}
    local itemsToStorage = {}
    local itemsToStorage2 = {}

    if self.items[itemName] == nil then
        self.items[itemName] = {}
    end

    for k, v in pairs(Inventory:GetInventory()) do
        if k == itemName then
            local itemsLocal = {}

            if (#v >= count) then
                for i = 1, count do
                    if (Inventory:GetInventory()[itemName][i] ~= nil) then
                        if itemName == "tel" then
                            if Inventory:GetInventory()[itemName][i].data.num == MyNumber then
                                MyNumber = nil
                                MyBattery = 0
                                TriggerEvent("gcphone:UpdateBattery", MyBattery)
                                TriggerEvent("gcPhone:myPhoneNumber", MyNumber)
                                TriggerServerEvent("gcPhone:allUpdate")
                            end
                        end
                        table.insert(
                            itemsToStorage,
                            {
                                id = Inventory:GetInventory()[itemName][i].id,
                                metadata = Inventory:GetInventory()[itemName][i].data,
                                label = Inventory:GetInventory()[itemName][i].label,
                                name = Inventory:GetInventory()[itemName][i].name
                            }
                        )
                        table.insert(
                            itemsToStorage2,
                            {
                                id = Inventory:GetInventory()[itemName][i].id,
                                metadata = Inventory:GetInventory()[itemName][i].data,
                                label = Inventory:GetInventory()[itemName][i].label,
                                name = Inventory:GetInventory()[itemName][i].name
                            }
                        )
                        Inventory:GetInventory()[itemName][i] = nil
                    end
                end
            else
                ShowNotification("Vous n'avez pas assez d'items")
            end

            local test = 0

            if (Inventory:GetInventory()[itemName] ~= nil) then
                for kItem, vItem in pairs(Inventory:GetInventory()[itemName]) do
                    if vItem ~= nil then
                        test = test + 1
                        print("INSERTING " .. test)
                        table.insert(itemsLocal, vItem)
                    end
                end
            end

            Inventory:GetInventory()[itemName] = itemsLocal
            break
        end
    end

    for key2, value2 in pairs(itemsToStorage) do
        table.insert(self.items[itemName], value2)
        print("ADDED")
    end

    if #itemsToStorage2 > 0 then
        local sendItems = {}
        local itemSent = 0

        for key3, value3 in pairs(itemsToStorage2) do
            print("Iterate ")
            table.insert(sendItems, value3)
            itemSent = itemSent + 1
            if (itemSent >= 75) then
                ShowNotification(
                    "~w~[" ..
                        math.random(0, 100) ..
                            "] Vous avez déposer ~b~" ..
                                itemSent .. "x " .. string.lower(Items[itemName].label) .. " ~w~dans le coffre~w~"
                )
                TriggerServerEvent("rage-reborn:TransfertToStorage", sendItems, itemName, self.name)
                Wait(200)
                sendItems = {}
                itemSent = 0
            end
        end
        ShowNotification(
            "~w~[" ..
                math.random(0, 100) ..
                    "] Vous avez déposer ~g~" ..
                        itemSent .. "x " .. string.lower(Items[itemName].label) .. " ~w~dans le coffre~w~"
        )
        print("Triggering ")

        TriggerServerEvent("rage-reborn:TransfertToStorage", sendItems, itemName, self.name)
    end
end

function Storage:CanAcceptItem(item, count)
    self:RefreshWeight()
    local tempWeight = self.Weight
    tempWeight = tempWeight + (Items[item].weight * count)
    if not (tonumber(tempWeight) <= tonumber(self.maxWeight)) then
        ShowNotification("~r~Il n'y a plus de place dans le coffre !")
    end
    return tempWeight <= self.maxWeight
end
function table.hasValue(tbl, value, k)
    if not tbl or not value or type(tbl) ~= "table" then
        return
    end
    for _, v in pairs(tbl) do
        if k and v[k] == value or v == value then
            return true, _
        end
    end
end

function table.removeByValue(tbl, val, i)
    local ntbl = {}
    for k, v in pairs(tbl) do
        if v ~= val and (not i or v[i] ~= val) then
            table.insert(ntbl, v)
        end
    end
    return ntbl
end

function table.count(table, checkCount)
    if not table or type(table) ~= "table" then
        return not checkCount and 0
    end
    local n = 0
    for k, v in pairs(table) do
        n = n + 1
        if checkCount and n >= checkCount then
            return true
        end
    end
    return not checkCount and n
end
RMenu.Add("storage", "main", RageUI.CreateMenu("Coffre", "~w~Objets disponibles"))
RMenu.Add(
    "storage",
    "my_inv",
    RageUI.CreateSubMenu(RMenu:Get("storage", "main"), "Inventaire", "~w~Objets disponibles")
)
RMenu.Add(
    "storage",
    "my_inv_2",
    RageUI.CreateSubMenu(RMenu:Get("storage", "my_inv"), "Inventaire", "~w~Objets disponibles")
)
RMenu.Add(
    "storage",
    "multi_inventory",
    RageUI.CreateSubMenu(RMenu:Get("storage", "main"), "Inventaire", "~w~Actions disponibles")
)
RMenu.Add(
    "storage",
    "dep_retirer",
    RageUI.CreateSubMenu(RMenu:Get("storage", "main"), "Argent", "~w~Actions disponibles")
)
RMenu:Get("storage", "my_inv").Closed = function()
    RMenu:Get("storage", "main").Index = 1
end
RMenu:Get("storage", "multi_inventory").Closed = function()
    RMenu:Get("storage", "main").Index = 1
end
currentStorage = {}
function ShowAboveRadarMessage(message, back)
    if back then
        SetNotificationBackgroundColor(back)
    end
    SetNotificationTextEntry("jamyfafi")
    AddTextComponentString(message)
    if string.len(message) > 99 and AddLongString then
        AddLongString(message)
    end
    return DrawNotification(0, 1)
end
local inventoryFilter = {
    Index = 1,
    Label = {"Aucun", "Nourriture", "Arme", "Vêtements"},
    Filter = {nil, "food", "weapon", "clothes"},
    count = 0
}
local indSelected = nil
local CurrentFilter = nil
local nameSec = nil

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if currentStorage ~= nil and #json.encode(currentStorage) > 5 then
                currentStorage:RefreshWeight()
                Wait(8000)
            end
        end
    end
)
Citizen.CreateThread(
    function()
        RMenu:Get("storage", "my_inv_2"):AddInstructionButton(
            {
                [1] = GetControlInstructionalButton(0, Keys["L"], 0),
                [2] = "Déposer"
            }
        )
        while true do
            Wait(1)
            if currentStorage ~= nil then
                local self = currentStorage
                if RageUI.Visible(RMenu:Get("storage", "dep_retirer")) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            RageUI.Button(
                                "Déposer",
                                nil,
                                {},
                                true,
                                function(_, _, S)
                                    if S then
                                        count = KeyboardInput("~b~Combien ?", nil, 25)
                                        count = tonumber(count)
                                        canBuy = Money:CanBuy(count)
                                        if self.money[self.money.index] + count <= 25000 then
                                            if canBuy then
                                                TriggerServerEvent(
                                                    "stockage:AddMoneyToAccount",
                                                    self.name,
                                                    count,
                                                    self.money.index
                                                )
                                                self.money[self.money.index] = self.money[self.money.index] + count
                                            else
                                                RageUI.Popup({message = "~r~Vous n'avez pas assez d'argent sur vous"})
                                            end
                                        else
                                            ShowNotification("~r~Plus assez de place pour de l'argent")
                                        end
                                    end
                                end,
                                RMenu:Get("stockage", "main")
                            )
                            RageUI.Button(
                                "Retirer",
                                nil,
                                {},
                                true,
                                function(_, _, S)
                                    if S then
                                        count = KeyboardInput("~b~Combien ?", nil, 25)
                                        count = tonumber(count)
                                        if count ~= nil and count <= self.money[self.money.index] then
                                            if self.money.index == "money" then
                                                TriggerServerEvent("money:Add", count)
                                            else
                                                TriggerServerEvent("black_money:Add", count)
                                            end

                                            TriggerServerEvent(
                                                "stockage:RemoveFromAccount",
                                                self.stockagename,
                                                count,
                                                self.money.index
                                            )
                                            self.money[self.money.index] = self.money[self.money.index] - count
                                        else
                                            RageUI.Popup({message = "~r~Pas assez d'argent dans le coffre"})
                                        end
                                    end
                                end,
                                RMenu:Get("stockage", "main")
                            )
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("storage", "main")) then
                    self:RefreshWeight()
                    RageUI.DrawContent(
                        {header = true, glare = true},
                        function()
                            inventoryFilter.count = 0
                            RageUI.List(
                                "Filtre",
                                inventoryFilter.Label,
                                inventoryFilter.Index,
                                nil,
                                {},
                                true,
                                function(_, Active, Selected, Index)
                                    inventoryFilter.Index = Index
                                    CurrentFilter = inventoryFilter.Filter[Index]
                                    if Selected then
                                        local filter = KeyboardInput("Entrez un filtre", nil, 250)
                                        filter = tostring(filter)
                                        local found = false
                                        for i = 1, #inventoryFilter.Label, 1 do
                                            if inventoryFilter.Label[i] == filter then
                                                CurrentFilter = inventoryFilter.Filter[i]
                                                inventoryFilter.Index = i
                                                found = true
                                            end
                                        end
                                        if tostring(filter) ~= nil and filter ~= "" and found then
                                            CurrentFilter = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            CurrentFilter = nil
                                        else
                                            ShowAboveRadarMessage("Filtre ~r~invalide")
                                        end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Déposer un objet",
                                nil,
                                {},
                                true,
                                function(_, _, Select)
                                end,
                                RMenu:Get("storage", "my_inv")
                            )
                            -- RageUI.CenterButton("~b~↓↓↓ ~s~Argent ~b~↓↓↓", nil, {}, true, function(_, _, _)
                            -- end)
                            -- RageUI.Button("Argent", nil, { RightLabel = self.money.money .. "$" }, true, function(_, _, S)
                            --     if S then
                            --         self.money.index = "money"
                            --     end
                            -- end, RMenu:Get('storage', 'dep_retirer'))
                            -- RageUI.Button("Argent ~r~sale", nil, { RightLabel = self.money.dark_money .. "$" }, true, function(_, _, S)
                            --     if S then
                            --         self.money.index = "dark_money"
                            --     end
                            -- end, RMenu:Get('storage', 'dep_retirer'))
                            RageUI.CenterButton(
                                "~b~↓↓↓ ~s~Objets ~b~↓↓↓",
                                nil,
                                {},
                                true,
                                function(_, _, _)
                                end
                            )

                            for k, v in pairs(self.items) do
                                if CurrentFilter == nil or Items[k].category == CurrentFilter then
                                    inventoryFilter.count = inventoryFilter.count + #v
                                    if #v == 1 then
                                        RageUI.Button(
                                            v[1].label ~= nil and Items[k].label .. " '" .. v[1].label .. "'" or
                                                Items[k].label,
                                            nil,
                                            {RightLabel = 1},
                                            true,
                                            function(_, Active, Selected)
                                                if Selected then
                                                    if Inventory.canReceive(k, 1) then
                                                        Inventory.SelectedItem = v[1]
                                                        AddItemtoInv(Inventory.SelectedItem)
                                                        self:RemoveItem(k, v[1].id, v[1].data)
                                                    end
                                                end
                                            end
                                        )
                                    elseif #v > 0 then
                                        local itemLabelTmp = k
                                        if (Items[k] ~= nil and Items[k].label ~= nil) then
                                            itemLabelTmp = Items[k].label
                                        end

                                        RageUI.Button(
                                            itemLabelTmp,
                                            nil,
                                            {RightLabel = #v .. "→"},
                                            true,
                                            function(_, _, Selected)
                                                if Selected then
                                                    self.Selected = v
                                                end
                                            end,
                                            RMenu:Get("storage", "multi_inventory")
                                        )
                                    end
                                end
                            end

                            if table.count(self.items) == 0 then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                            elseif inventoryFilter.count == 0 then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {},
                                    true,
                                    function()
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("storage", "multi_inventory")) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            if self.Selected == nil then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {},
                                    true,
                                    function()
                                    end
                                )
                            else
                                for i = 1, #self.Selected, 1 do
                                    if self.Selected[i] ~= nil then
                                        RageUI.Button(
                                            self.Selected[i].label ~= nil and
                                                Items[self.Selected[i].name].label ..
                                                    " '" .. self.Selected[i].label .. "'" or
                                                Items[self.Selected[i].name].label,
                                            nil,
                                            {RightLabel = 1},
                                            true,
                                            function(_, _, Selected)
                                                if Selected then
                                                    count = KeyboardInput("~b~Combien ?", nil, 25)
                                                    count = tonumber(count)
                                                    local v = self.Selected
                                                    if
                                                        count ~= nil and count <= #self.Selected and
                                                            Inventory.canReceive(v[i].name, count)
                                                     then
                                                        if count == #v then
                                                            RageUI.GoBack()
                                                        end
                                                        if count == 1 then
                                                            local v = self.Selected
                                                            local itemTable = self.Selected[i]
                                                            AddItemtoInv(itemTable)

                                                            self:RemoveItem(
                                                                self.Selected[i].name,
                                                                self.Selected[i].id,
                                                                self.Selected[i].data
                                                            )
                                                        else
                                                            local itemsObjects = {}
                                                            local v = self.Selected
                                                            local tableCount = #v
                                                            local itemName = v[tableCount].name
                                                            self:TransferToInventory(count, itemName)
                                                            RageUI.GoBack()
                                                        end
                                                    end
                                                end
                                            end,
                                            RMenu:Get("storage", "main")
                                        )
                                    end
                                end
                            end
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("storage", "my_inv_2")) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            indSelected = Inventory.Inventory[nameSec]
                            if IsControlJustPressed(0, Keys["L"]) then
                                local count = KeyboardInput("Combien ? ", nil, 3)
                                count = tonumber(count)
                                local inventory = Inventory.Inventory
                                local currentHoverItem = indSelected[1].name
                                currentStorage:RefreshWeight()
                                if
                                    count ~= nil and #inventory[currentHoverItem] - count >= 0 and
                                        currentStorage:CanAcceptItem(nameSec, count)
                                 then
                                    local itemsObjects = {}
                                    local v = inventory[currentHoverItem]
                                    local _v = v
                                    local tableCount = #v
                                    local itemName = v[tableCount].name
                                    self:TransferToStorage(count, itemName, self.name)
                                    currentStorage:RefreshWeight()
                                    RageUI.GoBack()
                                end
                            end
                            if #indSelected ~= 0 then
                                for i = 1, #indSelected, 1 do
                                    if indSelected[i] ~= nil then
                                        RageUI.Button(
                                            indSelected[i].label ~= nil and
                                                Items[indSelected[i].name].label .. " '" .. indSelected[i].label .. "'" or
                                                Items[indSelected[i].name].label,
                                            "Appuyez sur ~b~L~w~ pour en mettre plusieurs",
                                            {RightLabel = 1},
                                            true,
                                            function(_, _, Selected)
                                                if Selected and currentStorage:CanAcceptItem(indSelected[i].name, 1) then
                                                    items = {}
                                                    local v = indSelected
                                                    local _v = v
                                                    items = {id = v[i].id, name = indSelected[i].name}
                                                    local item = {
                                                        name = indSelected[i].name,
                                                        metadata = v[i].data,
                                                        storage = self.name,
                                                        id = v[i].id,
                                                        label = v[i].label
                                                    }
                                                    currentStorage:RefreshWeight()
                                                    TriggerServerEvent("rage-reborn:DepositStockageItem2", item)
                                                    self:AddItem(item)
                                                    Inventory:RemoveItemToInv(items.id, items.name)
                                                end
                                            end
                                        )
                                    end
                                end
                            else
                                RageUI.GoBack()
                            end
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("storage", "my_inv")) then
                    RageUI.DrawContent(
                        {header = true, glare = false},
                        function()
                            local inventory = Inventory.Inventory
                            if table.count(inventory) == 0 then
                                RageUI.Button(
                                    "Vide",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                            else
                                for k, v in pairs(inventory) do
                                    if #v > 0 then
                                        RageUI.Button(
                                            Items[k].label,
                                            nil,
                                            {RightLabel = #v},
                                            true,
                                            function(_, _, Selected)
                                                if Selected then
                                                    indSelected = v
                                                    nameSec = k
                                                end
                                            end,
                                            RMenu:Get("storage", "my_inv_2")
                                        )
                                    end
                                end
                            end
                        end,
                        function()
                        end
                    )
                end
            end
        end
    end
)
