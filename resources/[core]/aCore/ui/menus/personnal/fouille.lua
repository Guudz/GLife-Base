
RMenu.Add('storage', 'fouiller_joueur', RageUI.CreateMenu("Joueur", "~g~Objets disponibles"))
local function CanBeFouilled(ped,id) 
    if IsPlyHandsup(id) then
        return true
    elseif IsPedRagdoll(ped) then
        return true
    else
        return false
    end
end
local currPlayerInv = {}
local accounts = {}
local targetInv = nil
local function Fouiller()
    local closestPly = GetPlayerServerIdInDirection(8.0)
    
    if closestPly ~=  false then
        local player = GetPlayerFromServerId(closestPly)
        local pedT = GetPlayerPed(player)
        if CanBeFouilled(pedT,closestPly) then
            targetInv = closestPly
            TriggerPlayerEvent("RageUI:Popup",closestPly,{message="~r~Vous êtes en train de vous faire fouiller"})
            TriggerServerCallback("getInventoryOtherPPL",function(Inv,Money,black_money)
                currPlayerInv = json.decode(Inv)
                RageUI.Visible(RMenu:Get('storage', 'fouiller_joueur'),true)
            end,closestPly)
        end
    end
end


function Fouiller2(id)
    local closestPly = id
    if closestPly ~=  false then
        local player = GetPlayerFromServerId(closestPly)
        local pedT = GetPlayerPed(player)
        targetInv = closestPly
        TriggerServerCallback("getInventoryOtherPPL",function(Inv,Money,black_money)
            currPlayerInv = json.decode(Inv)
            RageUI.Visible(RMenu:Get('storage', 'fouiller_joueur'),true)
        end,closestPly)
    end
end
Citizen.CreateThread(function()
    while true do
        Wait(1)
    --    HoverPlayer()
            if RageUI.Visible(RMenu:Get('storage', 'fouiller_joueur')) then
                RageUI.DrawContent({ header = true, glare = false }, function()
                    
                    
                    for k , v in pairs(currPlayerInv) do
                        if #v >0 then
                            print(k)
                            RageUI.Button(Items[k].label, nil, {RightLabel = #v}, true, function(_, _, S)
                                if S then
                                    local count = KeyboardInput("Combien?")
                                    if tonumber(count) ~= nil and tonumber(count) <= #v and  Inventory.canReceive(k, tonumber(count)) then
                                        for i = 1 , count , 1 do   
                                            items = v[i]
                                            AddItemtoInv(items)
                                            TriggerPlayerEvent("inventory:removeItem",targetInv,v[i].id,k)
                                            
                                            RageUI.Visible(RMenu:Get('storage', 'fouiller_joueur'),false)
                                        end

                                    end
                                end
                            end)
                        end

                    end
                end, function()
                
                end)

            end
    end
end)


RegisterCommand('+fouille', function()
    Fouiller()
end, false)
RegisterCommand('-fouille', function()
    Fouiller()
end, false)
RegisterCommand('fouille', function()
    Fouiller()
end, false)
RegisterKeyMapping('fouille', 'Fouiller', 'keyboard', 'K')