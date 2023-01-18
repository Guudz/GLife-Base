--====================================================================================
--  Function APP BANK
--====================================================================================

--[[
      Appeller SendNUIMessage({event = 'updateBankbalance', banking = xxxx})
      à la connection & à chaque changement du compte
--]]
-- ES / ESX Implementation

local bank = 0
function setBankBalance(value)
    if type(value) == "table" and #value > 0 then
        for i = 1, #value, 1 do
            exports["aCore"]:TriggerServerCallback(
                "getBankingAccountsPly2",
                function(val)
                    val = val[1]
                    value[i].number = val.iban
                    value[i].amount = val.amount
                    value[i].label = val.label
                end,
                tonumber(value[i].account)
            )
        end
        while value[#value].amount == nil do
            Wait(1)
            print("Waiting for amounts")
        end
    end
    bank = value
    SendNUIMessage({event = "updateBankbalance", banking = bank})
end

RegisterNUICallback(
    "newCard",
    function(um, cb)
        menuIsOpen = false
        SendNUIMessage({show = false})
        PhonePlayOut()
        cb()
        TriggerEvent("aCore:EditTel")
    end
)
