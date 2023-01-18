RMenu.Add(
    "essence",
    "main",
    RageUI.CreateMenu(nil, "Actions disponibles", 10, 100, "shopui_title_gasstation", "shopui_title_gasstation")
)

local amount = 1
local price = 0
local baseprice = 1.11
local lastAm = 0
AddEventHandler(
    "playerSpawned",
    function(spawn)
        TriggerServerCallback(
            "GetPriceFuel",
            function(pric)
                baseprice = pric
            end
        )
    end
)
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("essence", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Progress(
                            "Essence (%) (" .. baseprice .. "$/L)",
                            amount,
                            100,
                            nil,
                            false,
                            true,
                            function(_, _, Selected, Color)
                                --        if lastAm - amount > 0 then
                                amount = Color
                                --      end
                            end
                        )
                        price = (amount - lastAm) * baseprice

                        RageUI.Button(
                            "Acheter",
                            nil,
                            {
                                Color = {
                                    BackgroundColor = {37, 41, 91, 25}
                                },
                                RightLabel = price .. "$"
                            },
                            price > 0,
                            function(_, _, Selected)
                                if Selected then
                                    dataonWait = {
                                        price = price,
                                        fct = function()
                                            TriggerServerEvent("essence:buy", amount, 1.23, true)
                                            TriggerEvent("essence:hasBuying", amount)
                                        end
                                    }
                                    TriggerEvent("payWith?")
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end
        end
    end
)
AddEventHandler(
    "essence:OpenMenu",
    function(bool)
        amount = ((GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId())) / 65) * 100)
        amount = math.floor(amount)
        lastAm = amount
        RageUI.Visible(RMenu:Get("essence", "main"), bool)
    end
)

function getVehicleIdentifier(vehicle)
    return GetEntityModel(vehicle) .. "|" .. GetVehicleNumberPlateText(vehicle)
end