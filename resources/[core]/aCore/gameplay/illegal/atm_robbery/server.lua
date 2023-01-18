ATMRobberyRecord = {

}


RegisterServerEvent("illegalAtmRobbery:startRoberry")
AddEventHandler("illegalAtmRobbery:startRoberry", function()
  local steam64 = GetPlayerIdentifiers(source)[1]
  ATMRobberyRecord[steam64] = GetGameTimer()
end)


RegisterServerCallback(
  "illegalAtmRobbery:robberyCanStart",
  function(source, callback)
    local steam64 = GetPlayerIdentifiers(source)[1]

    if (ATMRobberyRecord[steam64] == nil) then 
      callback(true)
    -- elseif ((GetGameTimer() - ATMRobberyRecord[source])/1000 > 3600) then 
    --   print((GetGameTimer() - ATMRobberyRecord[source])/1000)
    --   callback(true)
    else 
      callback(false)
    end     
  end
)