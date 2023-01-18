---
--- Created by JEANxPLOYEE
--- Storage system for house, inventory, trunks
---

--- Method is used to remove more than 1 qty of a itemName
--- Inside a storageName
RegisterServerEvent("storage:removeItems")
AddEventHandler(
    "storage:removeItems",
    function(storageName, itemName, qty)
    end
)

--- Method is used to remove 1 qty of a itemName
--- Inside a storageName. It used the itemUuid to remove the specific / selected item
RegisterServerEvent("storage:removeItem")
AddEventHandler(
    "storage:removeItem",
    function(storageName, itemName, itemUuid)
    end
)

--- Method is used to add more than 1 qty of a itemName
--- Inside a storageName. Metadata is the array of all metadata arrays for each item.
RegisterServerEvent("storage:addItems")
AddEventHandler(
    "storage:addItems",
    function(storageName, itemName, qty, metadataAsArray)
    end
)

--- Method is used to add 1 qty of a itemName
--- Inside a storageName. It used the itemUuid to add the specific / selected item
RegisterServerEvent("storage:addItem")
AddEventHandler(
    "storage:addItem",
    function(storageName, itemName, metadata)
    end
)

--- Method is used to move more than 1 qty of a itemName
--- from a storageName to an other storageName (Transfert between player)
RegisterServerEvent("storage:moveItems")
AddEventHandler(
    "storage:storage:moveItems",
    function(fromStorageName, itemName, qty, toStorageName)
    end
)

--- Method is used to move  1 qty of a itemName
--- from a storageName to an other storageName (Transfert between player). It used the itemUuid to remove the specific / selected item
RegisterServerEvent("storage:moveItem")
AddEventHandler(
    "storage:storage:moveItem",
    function(fromStorageName, itemName, itemUuid, toStorageName)
    end
)
