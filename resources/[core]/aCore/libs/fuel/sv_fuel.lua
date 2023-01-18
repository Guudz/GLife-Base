--[[ Purpose of this script is to attach fuel level to vehicle and not to player ]]

VehicleFuelSynchro = {}

RegisterServerCallback("vehicleFuelSynchro:getVehicleFuelLevel", function(source, callback, vehicleIdentifier)

  if (VehicleFuelSynchro[vehicleIdentifier] == nil) then
    VehicleFuelSynchro[vehicleIdentifier] = 50.0
  end

  vehicleFuelLevel = VehicleFuelSynchro[vehicleIdentifier]

  if (callback ~= nil) then
    callback(vehicleFuelLevel)
  end
end)

RegisterServerCallback("vehicleFuelSynchro:updateVehicleFuelLevel", function(source, callback, vehicleIdentifier, fuelLevel)

  if (VehicleFuelSynchro[vehicleIdentifier] == nil) then
    VehicleFuelSynchro[vehicleIdentifier] = 100.0
  end

  VehicleFuelSynchro[vehicleIdentifier] = fuelLevel

  if (callback ~= nil) then
    callback(VehicleFuelSynchro[vehicleIdentifier])
  end
end)
