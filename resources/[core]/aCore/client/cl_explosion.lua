print('^3-------------------------------------')
print('^1Base Leaks Par SinLoww#2191')
print('^1CREDIT : SL - Développement Et Leak')
print('^5https://discord.gg/q6t6Ct6UJq')
print('^3https://www.youtube.com/c/Glich/videos')
print('^3-------------------------------------')

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end;

Citizen.CreateThread(function()
    Citizen.Wait(0)
    while true do			
        for veh in EnumerateVehicles() do
            local class = GetVehicleClass(veh)
                if class == 15 or class == 16 or veh == 'polmav' then
                    if IsVehicleSeatFree(veh, -1) and IsEntityInAir(veh) then
                        SetEntityAsMissionEntity(veh, 1, 1)
                        vehicleFct.DeleteVehicle(veh)
                    end
                end
        end
        Citizen.Wait(2000)
    end
end)