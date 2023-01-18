

function CreateFacture(account)
    local playerId = GetPlayerServerIdInDirection(8.0)
    if playerId ~= false then
        local _facture = {
            title = KeyboardInput("Nom de la facture","",30),
            montant = tonumber(KeyboardInput("Montant de la facture","",30)),
            playerId = playerId,
            account = account
        }
        _facture.montant = tonumber(_facture.montant)
        if _facture.title ~= nil and _facture.title ~= "" and tonumber(_facture.montant) ~= nil and _facture.montant ~= 0 then
            TriggerServerEvent("facture:send",_facture)
            _facture = {}
        else
            _facture = {}
            RageUI.Popup({message="~r~Facture invalide"})
        end
    else
        RageUI.Popup({message="~r~Aucun joueur proche"})
    end
end
RegisterNetEvent("facture:paied")
AddEventHandler("facture:paied",function()
    RageUI.Popup({message="~g~Facture payé"})
end)

RegisterNetEvent("facture:nopaied")
AddEventHandler("facture:nopaied",function()
    RageUI.Popup({message="~r~Facture non-payé"})
end)


RegisterNetEvent("facture:get")
AddEventHandler("facture:get",function(_facture)
    RageUI.Popup({message="~g~Facture:\n~w~Titre : ~p~".._facture.title.."\n~w~Montant : ~o~".._facture.montant.."$~s~"})
    Wait(400)
    RageUI.Popup({message="~g~E ~w~pour accepter\n~w~Y ~s~pour refuser"})
    if _facture.source == nil then
        _facture.source = GetPlayerServerIdInDirection(5.0)
    end
    KeySettings:Add("keyboard","E",function() 
        if _facture.source == nil then
            _facture.source = GetPlayerServerIdInDirection(5.0)
        end
        __facture = _facture
        dataonWait= {detail="Facture .. " .. __facture.title, price=__facture.montant,fct=function()
            if __facture == nil then __facture = _facture end
            TriggerServerEvent("entreprise:Add",__facture.account,__facture.montant)
            if __facture.source == nil then
                __facture.source = GetPlayerServerIdInDirection(5.0)
            end
            TriggerPlayerEvent("RageUI:Popup",__facture.source,{message="Le citoyen a bien payé la facture"})
            RageUI.Popup({message="~g~Paiement accepté"})
        end}
        KeySettings:Clear("keyboard","E","factureX")

        -- if Inventory.Inventory["bank_card"] == nil then
        --     dataonWait = {}
        --     return ShowNotification("~r~Vous n'avez pas de cartes bancaires")
        -- else
        --     RageUI.Visible(RMenu:Get('personnal', 'choose_card'),true)
        -- end 
        CloseAllMenus()
        TriggerEvent("payWith?")
    end,"factureX")

    KeySettings:Add("keyboard","Y",function() 
        RageUI.Popup({message="~r~Paiement refusé"})
        if _facture.source == nil then
            _facture.source = GetPlayerServerIdInDirection(5.0)
        end
        KeySettings:Clear("keyboard","Y","facture2")
        TriggerPlayerEvent("facture:nopaied",_facture.source)
    end,"facture2")



    Wait(15000)
    _facture = {}
    KeySettings:Clear("keyboard","Y","facture2")
    KeySettings:Clear("keyboard","E","facture")
end)

