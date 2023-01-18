Citizen.CreateThread(
    function()
        while RMenu == nil do
            Wait(1)
        end
        RMenu.Add("banks", "main", RageUI.CreateMenu("Banque", "Catégories disponibles", 10, 100, nil, nil, 240, 147, 43, 1.0))
        -- creata acc
        RMenu.Add(
            "banks",
            "create_acc",
            RageUI.CreateSubMenu(RMenu:Get("banks", "main"), "Banque", "Catégories disponibles", 10, 100)
        )
        RMenu.Add(
            "banks",
            "identity_list3",
            RageUI.CreateSubMenu(RMenu:Get("banks", "create_acc"), "Banque", "Listes des joueurs", 10, 100)
        )
        -- acc lists
        RMenu.Add(
            "banks",
            "list_main",
            RageUI.CreateSubMenu(RMenu:Get("banks", "main"), "Banque", "Listes des comptes", 10, 100)
        )
        RMenu.Add(
            "banks",
            "list_pret",
            RageUI.CreateSubMenu(RMenu:Get("banks", "main"), "Banque", "Action disponibles", 10, 100)
        )
        RMenu.Add(
            "banks",
            "list_pret_1",
            RageUI.CreateSubMenu(RMenu:Get("banks", "list_pret"), "Banque", "Prêts en cours", 10, 100)
        )
        RMenu.Add(
            "banks",
            "list_pret_2",
            RageUI.CreateSubMenu(RMenu:Get("banks", "list_pret"), "Banque", "Prêts terminés", 10, 100)
        )
        RMenu.Add(
            "banks",
            "list_pret_3",
            RageUI.CreateSubMenu(RMenu:Get("banks", "list_pret_1"), "Banque", "Prêts en cours", 10, 100)
        )

        RMenu.Add(
            "banks",
            "gestion_comptes",
            RageUI.CreateSubMenu(RMenu:Get("banks", "list_main"), "Banque", "Gestion du compte", 10, 100)
        )
        RMenu.Add(
            "banks",
            "identity_list",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Listes des joueurs", 10, 100)
        )
        RMenu.Add(
            "banks",
            "historiques",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Historique du compte", 10, 100)
        )
        RMenu.Add(
            "banks",
            "create_card",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Créer une carte", 10, 100)
        )
        RMenu.Add(
            "banks",
            "create_prêt",
            RageUI.CreateSubMenu(RMenu:Get("banks", "gestion_comptes"), "Banque", "Créer un prêt", 10, 100)
        )
        RMenu.Add(
            "banks",
            "identity_list2",
            RageUI.CreateSubMenu(RMenu:Get("banks", "create_card"), "Banque", "Listes des joueurs", 10, 100)
        )

        -- atm
        RMenu.Add("banking", "main_atm", RageUI.CreateMenu(nil, "Actions disponibles", 600, 200))
        RMenu.Add("banking", "manage_account", RageUI.CreateSubMenu(RMenu:Get("banking", "main_atm")))
        RMenu.Add("banking", "deposit_money", RageUI.CreateSubMenu(RMenu:Get("banking", "manage_account")))
    end
)

function EnterBankZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour gérer les comptes en banques")
    KeySettings:Add("keyboard", "E", OpenBankMenu, "BANK")
    KeySettings:Add("controller", 46, OpenBankMenu, "BANK")
end

function ExitBankZone()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard", "E", "BANK")
    KeySettings:Clear("controller", "E", "BANK")
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
    RageUI.GoBack()
end

local function Format(identity)
    local _table = {}
    for i = 1, #identity, 1 do
        _table[identity[i].uuid] = identity[i]
    end
    return _table
end
local function Format2(cards)
    local _table = {}
    for i = 1, #cards, 1 do
        if _table[cards[i].account] == nil then
            _table[cards[i].account] = {}
        end
        table.insert(_table[cards[i].account], cards[i])
    end
    return _table
end
local function Format3(rs)
    local _table = {}
    local table_ = {}
    for i = 1, #rs, 1 do
        if rs[i].type == 0 then
            table.insert(table_, rs[i])
        else
            table.insert(_table, rs[i])
        end
    end
    return _table, table_
end

local Banks = {}
local Identity = {}
local Cards = {}
local History = {}
local Prets = {}
function OpenBankMenu()
    Banks = nil

    TriggerServerCallback(
        "getAllBanks2",
        function(result, _result, dresult, mresult, presult)
            Banks = result
            Identity = Format(_result)
            Cards = Format2(dresult)
            History = mresult
            PretsTermine, PretsCours = Format3(presult)
        end
    )
    while Banks == nil do
        Wait(1)
    end
    RageUI.Visible(RMenu:Get("banks", "main"), true)
end
local filterSearch = {
    search = nil,
    filter = nil,
    minAmount = nil,
    display = {
        name = true,
        label = true,
        amount = false
    },
    Label = {"Montant", "Alphabétique", "Date de création", "Aucun"},
    Index = 4,
    filterASC = true
}
function spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do
        keys[#keys + 1] = k
    end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(
            keys,
            function(a, b)
                return order(t, a, b)
            end
        )
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
local currentBank = nil
local typeCarte = {
    Label = {"Classic", "Gold", "Platinium", "Blackcard"},
    Index = 1,
    total = 1
}
local createCard = {
    uuid = nil
}
local creatingAcc = {
    name = nil
}
function GetBankInfoFromID(id)
    for i = 1, #Banks, 1 do
        if Banks[i].id == id then
            return Banks[i]
        end
    end

    return nil
end
local typePret = {
    amount = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20},
    Index = 1
}
for i = 1, #typePret.amount, 1 do
    typePret.amount[i] = typePret.amount[i] .. "%"
end
local currentPrets = {}
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("banks", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Comptes",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "list_main")
                        )

                        RageUI.Button(
                            "Prêts",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "list_pret")
                       )

                        RageUI.Button(
                            "Créer un nouveau compte",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "create_acc")
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "list_pret")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "En cours",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "list_pret_1")
                        )

                        RageUI.Button(
                            "Terminé",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "list_pret_2")
                        )
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("banks", "list_pret_1")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i = 1, #PretsCours, 1 do
                            local firstname = "Citoyen"
                            local lastname = "Expulsé"
                            print(json.encode(PretsCours[i]))

                            local bankInfo = GetBankInfoFromID(PretsCours[i].account)

                            if (bankInfo ~= nil and bankInfo.uuid ~= nil and Identity[bankInfo.uuid] ~= nil) then
                                firstname = Identity[bankInfo.uuid].first_name
                                lastname = Identity[bankInfo.uuid].last_name
                            end

                            RageUI.Button(
                                PretsCours[i].label ..
                                    " - " ..
                                        PretsCours[i].amount ..
                                            "/" .. PretsCours[i].base_amount .. "$ | " .. firstname .. " " .. lastname,
                                nil,
                                {RightLabel = PretsCours[i].current .. "/" .. PretsCours[i].total},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        currentPrets = PretsCours[i]
                                    end
                                end,
                                RMenu:Get("banks", "list_pret_3")
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "list_pret_2")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for i = 1, #PretsTermine, 1 do
                            RageUI.Button(
                                PretsTermine[i].label ..
                                    " - " ..
                                        PretsTermine[i].amount ..
                                            "/" ..
                                                PretsTermine[i].base_amount ..
                                                    "$ | " ..
                                                        Identity[GetBankInfoFromID(PretsTermine[i].account).uuid].first_name ..
                                                            " " ..
                                                                Identity[GetBankInfoFromID(PretsTermine[i].account).uuid].last_name,
                                "Nom du compte ~b~" .. GetBankInfoFromID(PretsTermine[i].account).label,
                                {RightLabel = PretsTermine[i].current .. "/" .. PretsTermine[i].total},
                                true,
                                function(_, _, Selected)
                                end
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "list_pret_3")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Payer un prélèvement",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    TriggerServerEvent("bank:oneprets", currentPrets)
                                    currentPrets.amount =
                                        math.floor(
                                        currentPrets.amount -
                                            (currentPrets.base_amount +
                                                ((currentPrets.base_amount / 100) * currentPrets.percent)) /
                                                currentPrets.total,
                                        0
                                    )
                                    currentPrets.current = currentPrets.current + 1
                                    local am = GetBankInfoFromID(currentPrets.account)
                                    am.amount =
                                        math.floor(
                                        am.amount -
                                            (currentPrets.base_amount +
                                                ((currentPrets.base_amount / 100) * currentPrets.percent)) /
                                                currentPrets.total,
                                        0
                                    )
                                    ShowNotification(
                                        "~y~Paiement effectué\n~s~Il reste ~b~" ..
                                            currentPrets.amount .. "$ ~s~à payé\nNouveau solde ~b~" .. am.amount .. "$"
                                    )
                                end
                            end
                        )
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "create_acc")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Nom du compte",
                            nil,
                            {RightLabel = creatingAcc.name},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local name = KeyboardInput("Entrez le nom du compte", nil, 20)
                                    name = tostring(name)
                                    if name ~= nil then
                                        creatingAcc.name = name
                                    end
                                end
                            end
                        )
                        local rightL =
                            creatingAcc.uuid ~= nil and
                            Identity[creatingAcc.uuid].first_name .. " " .. Identity[creatingAcc.uuid].last_name or
                            "N/A"
                        RageUI.Button(
                            "Titulaire",
                            nil,
                            {RightLabel = rightL},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "identity_list3")
                        )

                        RageUI.Button(
                            "Numéro de téléphone du propriétaire",
                            nil,
                            {RightLabel = creatingAcc.number ~= nil and creatingAcc.number or "N/A"},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local name = KeyboardInput("Entrez le numéro de téléphone", nil, 9)
                                    name = tonumber(name)
                                    if name ~= nil then
                                        creatingAcc.number = name
                                    end
                                end
                            end
                        )

                        RageUI.Button(
                            "Créer le compte",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    if creatingAcc.uuid ~= nil and creatingAcc.name ~= nil then
                                        TriggerServerCallback(
                                            "createAccount",
                                            function(result)
                                                ShowNotification("~b~Compte créer")
                                                ShowNotification("~s~Adresse : ~b~" .. result)
                                                ShowNotification("~s~Nom du compte : ~b~" .. creatingAcc.name)
                                                ShowNotification("~s~Titulaire : ~b~" .. rightL)
                                                RageUI.GoBack()
                                                creatingAcc = {}
                                            end,
                                            creatingAcc
                                        )
                                    else
                                        ShowNotification("~r~Vous n'avez pas correctement écris tout les champs.")
                                    end
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "create_card")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.List(
                            "Type de la carte",
                            typeCarte.Label,
                            typeCarte.Index,
                            nil,
                            {},
                            true,
                            function(_, Active, Selected, Index)
                                if typeCarte.Index ~= Index then
                                    typeCarte.Index = Index
                                end
                            end
                        )
                        local rightL = "Aucun"
                        if createCard.uuid ~= nil then
                            rightL = Identity[createCard.uuid].first_name .. " " .. Identity[createCard.uuid].last_name
                        end
                        --print(rightL)
                        RageUI.Button(
                            "Demandeur",
                            nil,
                            {RightLabel = rightL},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "identity_list2")
                        )
                        local rightL2 = "N/A"
                        if createCard.code ~= nil then
                            rightL2 = "****"
                        end
                        RageUI.Button(
                            "Code",
                            nil,
                            {RightLabel = rightL2},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local code = KeyboardInput("Code", nil, 4)
                                    code = tonumber(code)
                                    if code ~= nil then
                                        if code > 999 then
                                            createCard.code = code
                                        else
                                            ShowNotification("~r~Veuillez introduire un code à 4 chiffres")
                                        end
                                    end
                                end
                            end
                        )
                        RageUI.Button(
                            "Créer",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    if createCard.code ~= nil and createCard.uuid ~= nil then
                                        TriggerServerCallback(
                                            "newCard",
                                            function(number, cur)
                                                ShowNotification("La carte a bien été créée")
                                                if Cards[currentBank.id] == nil then
                                                    Cards[currentBank.id] = {}
                                                end
                                                table.insert(
                                                    Cards[currentBank.id],
                                                    {
                                                        type = typeCarte.Label[typeCarte.Index]:lower(),
                                                        uuid = createCard.uuid,
                                                        account = currentBank.id,
                                                        number = number,
                                                        current_ratio = cur
                                                    }
                                                )
                                                local items = {
                                                    name = "bank_card",
                                                    data = {
                                                        name = Identity[currentBank.uuid].first_name ..
                                                            " " .. Identity[currentBank.uuid].last_name,
                                                        type = typeCarte.Label[typeCarte.Index]:lower(),
                                                        uuid = createCard.uuid,
                                                        account = currentBank.id,
                                                        number = number,
                                                        current_ratio = cur,
                                                        code = createCard.code
                                                    }
                                                }
                                                AddItemtoInv(items)
                                                createCard = {}
                                            end,
                                            createCard,
                                            currentBank.id,
                                            typeCarte.Label[typeCarte.Index]:lower()
                                        )
                                    else
                                        ShowNotification("~r~Vous n'avez pas bien remplis tout les champs")
                                    end
                                end
                            end
                        )
                    end,
                    function()
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "identity_list")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in spairs(
                            Identity,
                            function(t, a, b)
                                return t[a].first_name < t[b].first_name
                            end
                        ) do
                            RageUI.Button(
                                v.first_name .. " " .. v.last_name,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        TriggerServerEvent("bank:Add", currentBank.id, v.uuid)
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        currentBank.coowner = v.uuid
                                        ShowNotification(
                                            v.first_name ..
                                                " " .. v.last_name .. " est ajouté en tant que co-propriétaire"
                                        )
                                    end
                                end
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "identity_list3")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in spairs(
                            Identity,
                            function(t, a, b)
                                return t[a].first_name < t[b].first_name
                            end
                        ) do
                            RageUI.Button(
                                v.first_name .. " " .. v.last_name,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        creatingAcc.uuid = v.uuid
                                    end
                                end
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "identity_list2")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        for k, v in spairs(
                            Identity,
                            function(t, a, b)
                                return t[a].first_name < t[b].first_name
                            end
                        ) do
                            RageUI.Button(
                                v.first_name .. " " .. v.last_name,
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                        createCard.uuid = v.uuid
                                    end
                                end
                            )
                        end
                    end
                )
            end
            if RageUI.Visible(RMenu:Get("banks", "historiques")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local v = currentBank
                        for i = 1, #History, 1 do
                            if History[i].src == v.iban or History[i].dest == v.iban then
                                RageUI.CenterButton(
                                    "_________________",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )

                                RageUI.Button(
                                    History[i].src .. " (~r~-" .. History[i].montant .. "$~s~)",
                                    nil,
                                    {RightLabel = History[i].dest .. " (~g~+" .. History[i].montant .. "$~s~)"},
                                    true,
                                    function()
                                    end
                                )

                                RageUI.CenterButton(
                                    History[i].details,
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                            end
                        end
                        RageUI.CenterButton(
                            "_________________",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("banks", "create_prêt")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        RageUI.Button(
                            "Libellé du prêt",
                            nil,
                            {RightLabel = typePret.label == nil and "N/A" or typePret.label},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    typePret.label = tostring(KeyboardInput("Raison du prêt ", nil, 25))
                                end
                            end
                        )

                        RageUI.Button(
                            "Nombre de prélèvement",
                            nil,
                            {RightLabel = typePret.total == nil and "N/A" or typePret.total},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    typePret.total = tonumber(KeyboardInput("Nombre de prélèvement", nil, 25))
                                end
                            end
                        )

                        RageUI.Button(
                            "Montant total du prêt",
                            nil,
                            {RightLabel = typePret.montant == nil and "0$" or typePret.montant .. "$"},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    typePret.montant = tonumber(KeyboardInput("Montant total du prêt ", nil, 25))
                                end
                            end
                        )

                        RageUI.List(
                            "Intérêt",
                            typePret.amount,
                            typePret.Index,
                            nil,
                            {},
                            true,
                            function(_, Active, Selected, Index)
                                if typePret.Index ~= Index then
                                    typePret.Index = Index
                                end
                            end
                        )

                        RageUI.Button(
                            "Valider",
                            typePret.montant ~= nil and
                                math.floor(((typePret.montant / 100) * typePret.Index) + typePret.montant, 2) ..
                                    "$ en " .. typePret.total .. " semaines" or
                                "N/A",
                            {
                                RightLabel = typePret.montant ~= nil and
                                    math.floor(
                                        (((typePret.montant / 100) * typePret.Index) + typePret.montant) /
                                            typePret.total,
                                        2
                                    ) .. "$ par semaines " or
                                    "N/A"
                            },
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    typePret.account = currentBank.id
                                    typePret.cAm =
                                        math.floor(((typePret.montant / 100) * typePret.Index) + typePret.montant, 2)
                                    TriggerServerCallback(
                                        "newPrets",
                                        function(bool)
                                            if bool then
                                                TriggerServerEvent(
                                                    "bankingRemoveFromAccount2",
                                                    "banker",
                                                    typePret.montant
                                                )
                                                TriggerServerEvent(
                                                    "entreprise:Add",
                                                    GetBankInfoFromID(currentBank.id).iban,
                                                    typePret.montant
                                                )
                                                TriggerServerEvent(
                                                    "newTransaction",
                                                    "banker",
                                                    GetBankInfoFromID(currentBank.id).iban,
                                                    typePret.montant,
                                                    "Retrait manuel du banquier"
                                                )
                                                    TriggerServerEvent("bankingSendMoney",GetBankInfoFromID(currentBank.id).iban,typePret.montant,"banker")
                                                ShowNotification("Prêt créer ")
                                                local am = GetBankInfoFromID(currentBank.id)
                                                am.amount = math.floor(am.amount + typePret.montant, 0)
                                                ShowNotification("Nouveau solde ~b~" .. am.amount .. "$")
                                            end
                                        end,
                                        typePret
                                    )
                                end
                            end
                        )
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("banks", "gestion_comptes")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local v = currentBank

                        RageUI.CenterButton(
                            "~y~↓↓↓ ~s~Actions ~y~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                        if v.bloqued == "false" or v.bloqued == 0 or v.bloqued == false then
                            v.bloqued = false
                        elseif v.bloqued == "true" or v.bloqued == 1 or v.bloqued == true then
                            v.bloqued = true
                        end
                        RageUI.Checkbox(
                            not v.bloqued and "Bloquer le compte" or "Débloquer le compte",
                            nil,
                            v.bloqued,
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    v.bloqued = Checked
                                    TriggerServerEvent("bankBlockAcc", Checked, v.id)
                                end
                            end
                        )
                        RageUI.Button(
                            "Cloturer le compte",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local sure = KeyboardInput("Êtes-vous sûr ? (Tapez 'OUI')", nil, 3)
                                    local sure = tostring(sure)
                                    if sure == "OUI" then
                                        TriggerServerEvent("bank:DeleteAccounts", v.id)
                                        TriggerServerCallback(
                                            "getAllBanks2",
                                            function(result, _result, dresult, mresult)
                                                Banks = result
                                                Identity = Format(_result)
                                                Cards = Format2(dresult)
                                                History = mresult
                                            end
                                        )
                                        ShowNotification("Compte ~r~cloturer")
                                        RageUI.GoBack()
                                    end
                                end
                            end
                        )
                        RageUI.Button(
                            "Historique",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "historiques")
                        )
                        local label1 =
                            v.coowner ~= nil and "Modifier le co-propriétaire" or "Ajouter un co-propriétaire"
                        RageUI.Button(
                            label1,
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "identity_list")
                        )

                        RageUI.Button(
                            "Créer une carte",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "create_card")
                        )

                        RageUI.Button(
                            "Prélever",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local amount = KeyboardInput("Montant", nil, 10)
                                    amount = tonumber(amount)
                                    if amount ~= nil then
                                        TriggerServerEvent("bankingRemoveFromAccount2", v.iban, amount)
                                        TriggerServerEvent("entreprise:Add", "banker", amount)
                                        TriggerServerEvent(
                                            "newTransaction",
                                            v.iban,
                                            "banker",
                                            amount,
                                            "Retrait manuel du banquier"
                                        )

                                        table.insert(
                                            History,
                                            {
                                                src = v.iban,
                                                dest = "banker",
                                                montant = amount,
                                                details = "Retrait manuel du banquier"
                                            }
                                        )
                                        v.amount = v.amount - amount
                                        ShowNotification("Vous venez de prélever " .. amount .. "$")
                                    end
                                end
                            end
                        )

                        RageUI.Button(
                            "Envoyer argent",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local amount = KeyboardInput("Montant", nil, 10)
                                    amount = tonumber(amount)
                                    if amount ~= nil then
                                        TriggerServerEvent("bankingRemoveFromAccount2", "banker", amount)
                                        TriggerServerEvent("entreprise:Add", v.iban, amount)
                                        TriggerServerEvent(
                                            "newTransaction",
                                            "banker",
                                            v.iban,
                                            amount,
                                            "Dépot du banquier"
                                        )

                                        table.insert(
                                            History,
                                            {
                                                src = "banker",
                                                dest = v.iban,
                                                montant = amount,
                                                details = "Dépot du banquier"
                                            }
                                        )
                                        v.amount = v.amount + amount
                                        ShowNotification("Vous venez de déposer " .. amount .. "$")
                                    end
                                end
                            end
                        )

                        RageUI.Button(
                            "Créer un prêt",
                            nil,
                            {},
                            true,
                            function(_, _, Selected)
                            end,
                            RMenu:Get("banks", "create_prêt")
                        )

                        RageUI.CenterButton(
                            "~y~↓↓↓ ~s~Informations ~y~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                        RageUI.Button(
                            "Nom du compte",
                            nil,
                            {RightLabel = v.label},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "Numéro de téléphone",
                            "Changez le numéro de téléphone",
                            {RightLabel = v.phone_number ~= nil and v.phone_number or "N/A"},
                            true,
                            function(_, _, Selected)
                                if Selected then
                                    local num = KeyboardInput("Entrez le nouveau numéro de téléphone", nil, 9)
                                    num = tonumber(num)
                                    if num ~= nil then
                                        TriggerServerEvent("bankUpdateNum", num, v.id)
                                    end
                                end
                            end
                        )
                        RageUI.Button(
                            "Propriétaire",
                            nil,
                            {RightLabel = Identity[v.uuid].first_name .. " " .. Identity[v.uuid].last_name},
                            true,
                            function(_, _, Selected)
                            end
                        )
                        if v.coowner ~= nil then
                            RageUI.Button(
                                "Co-propriétaire",
                                nil,
                                {RightLabel = Identity[v.coowner].first_name .. " " .. Identity[v.coowner].last_name},
                                true,
                                function(_, _, Selected)
                                end
                            )
                        end

                        RageUI.Button(
                            "Montant",
                            nil,
                            {RightLabel = v.amount .. "$"},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.Button(
                            "IBAN",
                            nil,
                            {RightLabel = v.iban},
                            true,
                            function(_, _, Selected)
                            end
                        )

                        RageUI.CenterButton(
                            "~y~↓↓↓ ~s~Cartes liées ~y~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )

                        local cards = Cards[v.id]
                        local mid = v.id
                        if cards == nil then
                            RageUI.Button(
                                "Vide",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                end
                            )
                        else
                            for k, v in pairs(cards) do
                                RageUI.CenterButton(
                                    "Carte ~y~" .. v.number .. "",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                                if type(v.current_ratio) == "string" then
                                    v.current_ratio = json.decode(v.current_ratio)
                                end
                                RageUI.Button(
                                    "Type de carte",
                                    nil,
                                    {RightLabel = firstToUpper(v.type)},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                                RageUI.Button(
                                    "Retraits actuel",
                                    nil,
                                    {
                                        RightLabel = firstToUpper(
                                            v.current_ratio.remove .. "/" .. v.current_ratio.maxRemove .. "$"
                                        )
                                    },
                                    true,
                                    function(_, _, Selected)
                                    end
                                )
                                RageUI.Button(
                                    "Dépot actuel",
                                    nil,
                                    {
                                        RightLabel = firstToUpper(
                                            v.current_ratio.deposit .. "/" .. v.current_ratio.maxDeposit .. "$"
                                        )
                                    },
                                    true,
                                    function(_, _, Selected)
                                    end
                                )

                                local accountFirstname = "Citoyen"
                                local accountLastname = "Expulsé"

                                if (v ~= nil and v.uuid ~= nil and Identity[v.uuid] ~= nil) then
                                    accountFirstname = Identity[v.uuid].first_name
                                    accountLastname = Identity[v.uuid].last_name
                                end

                                RageUI.Button(
                                    "Propriétaire",
                                    nil,
                                    {RightLabel = accountFirstname .. " " .. accountLastname},
                                    true,
                                    function(_, _, Selected)
                                    end
                                )

                                RageUI.Checkbox(
                                    not v.bloqued and "Bloquer la carte" or "Débloquer la carte",
                                    nil,
                                    v.bloqued,
                                    {},
                                    function(Hovered, Ative, Selected, Checked)
                                        if Selected then
                                            v.bloqued = Checked
                                            TriggerServerEvent("cardBlock", Checked, v.id)
                                        end
                                    end
                                )

                                RageUI.Button(
                                    "Supprimer cette carte",
                                    nil,
                                    {RightLabel = "❌"},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            TriggerServerEvent("core:DeleteThisCard", mid)
                                            Cards[mid] = nil
                                            RageUI.Refresh()
                                        end
                                    end
                                )
                                RageUI.CenterButton(
                                    "------------------------",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                            end
                        end
                    end,
                    function()
                    end
                )
            end

            if RageUI.Visible(RMenu:Get("banks", "list_main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        local label2 =
                            filterSearch.search == nil and "Rechercher" or
                            "Recherche actuel : ~b~" .. filterSearch.search
                        RageUI.Button(
                            label2,
                            nil,
                            {RightLabel = "🔍"},
                            true,
                            function(_, _, S)
                                if S then
                                    local filter = KeyboardInput("Rechercher", nil, 250)
                                    filter = tostring(filter)
                                    if filter ~= "nil" then
                                        if tostring(filter) ~= nil and filter ~= "" then
                                            filterSearch.search = filter
                                        elseif tostring(filter) == nil and filter == "" then
                                            filterSearch.search = nil
                                        else
                                            filterSearch.search = nil
                                            ShowAboveRadarMessage("Recherche ~r~invalide")
                                        end
                                    else
                                        filterSearch.search = nil
                                        ShowAboveRadarMessage("Recherche ~r~invalide")
                                    end
                                end
                            end
                        )

                        RageUI.Checkbox(
                            "Titulaire du compte",
                            nil,
                            filterSearch.display.name,
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    filterSearch.display.name = Checked
                                end
                            end
                        )
                        RageUI.Checkbox(
                            "Nom du compte",
                            nil,
                            filterSearch.display.label,
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    filterSearch.display.label = Checked
                                end
                            end
                        )
                        RageUI.Checkbox(
                            "Montant du compte",
                            nil,
                            filterSearch.display.amount,
                            {},
                            function(Hovered, Ative, Selected, Checked)
                                if Selected then
                                    filterSearch.display.amount = Checked
                                end
                            end
                        )
                        RageUI.List(
                            "Trier par",
                            filterSearch.Label,
                            filterSearch.Index,
                            nil,
                            {},
                            true,
                            function(_, Active, Selected, Index)
                                if filterSearch.Index ~= Index then
                                    filterSearch.Index = Index

                                    if Index == 1 then
                                        filterSearch.filter = function(t, a, b)
                                            return t[a].amount < t[b].amount
                                        end

                                        filterSearch.filterASC = true
                                    elseif Index == 2 then
                                        filterSearch.filter = function(t, a, b)
                                            return t[a].label < t[b].label
                                        end
                                        filterSearch.filterASC = true
                                    elseif Index == 3 then
                                        filterSearch.filter = function(t, a, b)
                                            return t[a].id < t[b].id
                                        end
                                        filterSearch.filterASC = true
                                    elseif Index == 4 then
                                        filterSearch.filter = nil
                                        filterSearch.filterASC = true
                                    end
                                end
                            end
                        )
                        if filterSearch.filter then
                            RageUI.Checkbox(
                                "Ordre croissant",
                                nil,
                                filterSearch.filterASC,
                                {},
                                function(Hovered, Ative, Selected, Checked)
                                    if Ative then
                                        if Selected then
                                            filterSearch.filterASC = Checked

                                            if filterSearch.Index == 1 then
                                                if Checked then
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[a].amount < t[b].amount
                                                    end
                                                else
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[b].amount < t[a].amount
                                                    end
                                                end
                                            end
                                            if filterSearch.Index == 2 then
                                                if Checked then
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[a].label < t[b].label
                                                    end
                                                else
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[b].label < t[a].label
                                                    end
                                                end
                                            end
                                            if filterSearch.Index == 3 then
                                                if Checked then
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[a].id < t[b].id
                                                    end
                                                else
                                                    filterSearch.filter = function(t, a, b)
                                                        return t[b].id < t[a].id
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            )
                        end

                        --
                        RageUI.CenterButton(
                            "~y~↓↓↓ ~s~Comptes ~y~↓↓↓",
                            nil,
                            {},
                            true,
                            function(_, _, _)
                            end
                        )
                        for k, v in spairs(Banks, filterSearch.filter) do
                            local label = ""
                            --v.label .. " - " .. Identity[v.uuid].first_name .. " " .. Identity[v.uuid].last_name
                            local RLabel = v.iban
                            if Identity[v.uuid] ~= nil then
                                if filterSearch.display.amount then
                                    local amount = false
                                    if v.amount < 0 then
                                        amount = "~r~" .. v.amount .. "$"
                                    else
                                        amount = "~g~" .. v.amount .. "$"
                                    end
                                    RLabel = RLabel .. " " .. amount
                                end

                                if filterSearch.display.label then
                                    label = label .. "" .. v.label .. " - "
                                end

                                if filterSearch.display.name then
                                    label = label .. Identity[v.uuid].first_name .. " " .. Identity[v.uuid].last_name
                                end
                                if
                                    filterSearch.search == nil or
                                        string.match(label:lower(), filterSearch.search:lower())
                                 then
                                    RageUI.Button(
                                        label,
                                        nil,
                                        {RightLabel = RLabel},
                                        true,
                                        function(_, _, Selected)
                                            if Selected then
                                                currentBank = v
                                            end
                                        end,
                                        RMenu:Get("banks", "gestion_comptes")
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
)

local ATM = {
    Accounts = {
        own = {},
        coOwn = {}
    }
}
function UseBankCard()
    local bool, props = IsNearATM()
    if bool then
        local heading = GetEntityHeading(props)
        local pheading = GetEntityHeading(LocalPlayer().Ped)
        if heading - 20 < pheading and heading + 20 > pheading then
            fpxm = CreateObject(GetHashKey("prop_cs_credit_card"), GetEntityCoords(PlayerPedId()), true, 0, 0)
            AttachEntityToEntity(
                fpxm,
                PlayerPedId(),
                GetPedBoneIndex(PlayerPedId(), 57005),
                vector3(0.15, 0.02, 0.02),
                vector3(-200.0, 0.0, -0.0),
                0,
                0,
                0,
                0,
                0,
                1
            )
            doAnim({"amb@prop_human_atm@male@enter", "enter"})
            Citizen.CreateThread(
                function()
                    Wait(1000)
                    DeleteEntity(fpxm)
                end
            )
            local currCARD = Inventory.SelectedItem.data
            ATM.Open(currCARD)
        else
            return ShowNotification("Vous devez regarder en direction de l'~b~ATM")
        end
    else
        ShowNotification("~r~Vous n'êtes pas près d'un ATM")
    end
end

local Atm = {
    {prop = "prop_atm_02"},
    {prop = "prop_atm_03"},
    {prop = "prop_fleeca_atm"},
    {prop = "prop_atm_01"}
}

function IsNearATM()
    local objects = {}
    for _, v in pairs(Atm) do
        table.insert(objects, v.prop)
    end

    local ped = PlayerPedId()
    local list = {}

    for _, v in pairs(objects) do
        local obj =
            GetClosestObjectOfType(
            GetEntityCoords(ped).x,
            GetEntityCoords(ped).y,
            GetEntityCoords(ped).z,
            5.0,
            GetHashKey(v),
            false,
            true,
            true
        )
        local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(obj), true)
        table.insert(list, {object = obj, distance = dist})
    end

    local closest = list[1]
    for _, v in pairs(list) do
        if v.distance < closest.distance then
            closest = v
        end
    end

    local distance = closest.distance
    local object = closest.object

    if distance < 1.8 then
        return true, object
    end
end

local stillNear = true
function ATM.Open(param)
    if IsNearATM() then
        local code = KeyboardInput("Veuillez entrer le code", nil, 4)
        code = tonumber(code)
        if code ~= nil then
            if code == param.code then
                TriggerServerCallback(
                    "getBankingAccountsPly2",
                    function(result)
                        TriggerServerCallback(
                            "getBankingCard",
                            function(_result)
                                if result[1] == nil or _result[1] == nil then
                                    ShowNotification("~r~Compte non reconnu")
                                end
                                TriggerServerCallback(
                                    "getHisto",
                                    function(tresult)
                                        stillNear = true
                                        ATM.Accounts = result[1]
                                        ATM.Cards = param
                                        ATM.History = tresult
                                        if _result[1].bloqued == 1 then
                                            return ShowNotification("~r~La carte est bloquée")
                                        end
                                        if
                                            result[1].bloqued == "true" or result[1].bloqued == 1 or
                                                result[1].bloqued == true
                                         then
                                            return ShowNotification("~r~Le compte est bloqué")
                                        end

                                        ATM.Accounts.todayratio = Inventory.SelectedItem.data.current_ratio

                                        for i = 1, 10, 1 do
                                            Wait(1)
                                            RageUI.GoBack()
                                        end

                                        RageUI.Visible(
                                            RMenu:Get("banking", "main_atm"),
                                            not RageUI.Visible(RMenu:Get("banking", "main_atm"))
                                        )
                                    end,
                                    result[1].iban
                                )
                            end,
                            param.number
                        )
                    end,
                    param.account
                )
            else
                if param.essai == nil then
                    param.essai = 3
                else
                    param.essai = param.essai - 1
                end
                if param.essai == 0 then
                    ShowNotification("~r~Code incorrect \n~o~La carte à été avalée")
                    TriggerServerEvent("mail:AddMail", "banker", "Carte N°" .. param.number .. " avalés", "ATM")
                    Inventory.removeItem(Inventory.SelectedItem.id, Inventory.SelectedItem.name)

                    RageUI.GoBack()
                    RageUI.Refresh()
                else
                    ShowNotification("~r~Code incorrect \n~o~" .. param.essai .. " essai(s) restant(s)")
                end
            end
        end
    end
end

local filter = {"dollar1", "dollar5", "dollar10", "dollar50", "dollar100", "dollar500"}
local am = {1, 5, 10, 50, 100, 500}
local m = {
    dollar1 = {
        index = 1,
        label = {0}
    },
    dollar5 = {
        index = 1,
        label = {0}
    },
    dollar10 = {
        index = 1,
        label = {0}
    },
    dollar50 = {
        index = 1,
        label = {0}
    },
    dollar100 = {
        index = 1,
        label = {0}
    },
    dollar500 = {
        index = 1,
        label = {0}
    }
}

local function GetCurrentMoneySelected()
    local mo = 0
    for k, v in pairs(m) do
        if v.visible then
            p = string.gsub(tostring(k), "dollar", "")
            p = tonumber(p)
            mo = mo + (p * (v.index - 1))
        end
    end

    return mo
end

local function Refresh()
    for k, v in pairs(m) do
        if Inventory.Inventory[k] ~= nil then
            v.visible = true
            v.total = #Inventory.Inventory[k]
            for i = 0, #Inventory.Inventory[k], 1 do
                v.label[i + 1] = i
            end
        else
            v.total = 0
            v.visible = false
        end
    end
end
Citizen.CreateThread(
    function()
        Wait(1500)

        RMenu:Get("banking", "main_atm").Closed = function()
        end

        while true do
            Wait(1)

            if stillNear then
                if RageUI.Visible(RMenu:Get("banking", "main_atm")) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            RageUI.CenterButton(
                                "~b~↓↓↓ Votre compte ~b~↓↓↓",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                end
                            )

                            RageUI.Button(
                                ATM.Accounts.label,
                                "RIB : " .. ATM.Accounts.iban,
                                {RightLabel = ATM.Accounts.amount .. "$"},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        ATM.Selected = ATM.Accounts
                                        RMenu:Get("banking", "manage_account").Subtitle =
                                            ATM.Accounts.label .. " " .. ATM.Accounts.amount .. "$"
                                    end
                                end,
                                RMenu:Get("banking", "manage_account")
                            )
                            RageUI.CenterButton(
                                "~b~↓↓↓ Votre historique ~b~↓↓↓",
                                nil,
                                {},
                                true,
                                function(_, _, Selected)
                                end
                            )
                            for i = 1, #ATM.History, 1 do
                                local History = ATM.History
                                if History[i].src == ATM.Accounts.iban or History[i].dest == ATM.Accounts.iban then
                                    RageUI.CenterButton(
                                        "_________________",
                                        nil,
                                        {},
                                        true,
                                        function(_, _, _)
                                        end
                                    )
                                    RageUI.Button(
                                        History[i].src .. " (~r~-" .. History[i].montant .. "$~s~)",
                                        nil,
                                        {RightLabel = History[i].dest .. " (~g~+" .. History[i].montant .. "$~s~)"},
                                        true,
                                        function()
                                        end
                                    )
                                    RageUI.CenterButton(
                                        History[i].details,
                                        nil,
                                        {},
                                        true,
                                        function(_, _, _)
                                        end
                                    )
                                end

                                RageUI.CenterButton(
                                    "_________________",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                            end
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("banking", "deposit_money")) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            for k, v in pairs(m) do
                                RageUI.List(
                                    Items[k].label .. " (" .. v.total .. "x)",
                                    v.label,
                                    v.index,
                                    nil,
                                    {},
                                    v.visible,
                                    function(_, Active, Selected, Index)
                                        v.index = Index
                                        if Selected then
                                            local ask = KeyboardInput("Combien ? ~r~(MAX " .. v.total .. ")", nil)

                                            ask = tonumber(ask)
                                            if ask ~= nil then
                                                if ask <= v.total then
                                                    v.index = ask + 1
                                                end
                                            end
                                        end
                                    end
                                )
                            end

                            RageUI.Button(
                                "Déposer ",
                                nil,
                                {RightLabel = "~g~" .. GetCurrentMoneySelected() .. "$"},
                                true,
                                function(_, H, S)
                                    if S then
                                        local amount = GetCurrentMoneySelected()
                                        ShowNotification(
                                            "~g~Transaction bancaire en cours~w~\nContact du serveur bancaire"
                                        )

                                        TriggerServerCallback(
                                            "aCore_banking:getRatiosForCard",
                                            function(
                                                cardExist,
                                                maxDeposit,
                                                maxRemove,
                                                maxPayin,
                                                currentDeposit,
                                                currentRemove,
                                                currentPayin)
                                                if (cardExist == false) then
                                                    RageUI.Popup(
                                                        {
                                                            message = "~g~Dépot bancaire\n~s~Cette carte ne semble pas exister"
                                                        }
                                                    )
                                                else
                                                    processDeposit = false

                                                    if (maxDeposit >= currentDeposit + amount) then
                                                        -- Case the account is not reaching the limit
                                                        RageUI.Popup(
                                                            {
                                                                message = "~g~Dépot bancaire\n~s~" .. amount .. "$"
                                                            }
                                                        )
                                                        processDeposit = true
                                                    else
                                                        -- Case the account is reaching the limit
                                                        if (currentDeposit < maxDeposit) then
                                                            amount = maxDeposit - currentDeposit

                                                            RageUI.Popup(
                                                                {
                                                                    message = "~g~Dépot bancaire\n~s~Votre montant est trop gros par rapport a votre limite de carte."
                                                                }
                                                            )
                                                            RageUI.Popup(
                                                                {
                                                                    message = "~g~Dépot bancaire\n~s~ Veuillez ajuster le montant de votre dépot\n~b~(MAX : " ..
                                                                        amount .. "$)~s~"
                                                                }
                                                            )
                                                            processDeposit = false
                                                        else
                                                            RageUI.Popup(
                                                                {
                                                                    message = "~g~Dépot bancaire\n~r~ Limite de dépot dépassée pour aujourd'hui.\nDépot refusé, passez a la banque~s~"
                                                                }
                                                            )
                                                            RageUI.Popup(
                                                                {
                                                                    message = "Vous pouvez déposer plus\n~b~en allant voir votre banquier~s~"
                                                                }
                                                            )
                                                        end
                                                    end

                                                    if (processDeposit == true) then
                                                        ATM.Selected.amount = ATM.Selected.amount + amount
                                                        RMenu:Get("banking", "manage_account").Subtitle =
                                                            ATM.Selected.label .. " " .. ATM.Selected.amount .. "$"

                                                        TriggerServerEvent(
                                                            "aCore_bank:addMoneyToBankAccount",
                                                            ATM.Selected.iban,
                                                            amount
                                                        )

                                                        TriggerServerEvent(
                                                            "aCore_bank:addDepositQuotaToCard",
                                                            ATM.Cards.number,
                                                            amount
                                                        )

                                                        TriggerServerEvent(
                                                            "gcPhone:_internalAddMessage",
                                                            "Banque",
                                                            ATM.Selected.phone_number,
                                                            "Dépot de " ..
                                                                amount .. "$ à partir du compte " .. ATM.Selected.iban,
                                                            false
                                                        )
                                                        TriggerServerEvent("gcPhone:allUpdate")

                                                        local t = {}

                                                        for k, v in pairs(m) do
                                                            if #v.label > 1 then
                                                                t[k] = v
                                                            end
                                                        end
                                                        PayMoney(t)

                                                        for k, v in pairs(m) do
                                                            v.index = 1
                                                        end
                                                        RageUI.GoBack()
                                                    end
                                                end
                                            end,
                                            ATM.Cards.number
                                        )

                                    -- else
                                    --     RageUI.Popup({message="Quotas ~r~atteint\n~s~"..data.deposit.."(~g~+"..amount.. ")~s~/"..data.maxDeposit.."$\n~b~Contactez un banquier"})
                                    -- end
                                    end
                                end
                            )
                        end,
                        function()
                        end
                    )
                end
                if RageUI.Visible(RMenu:Get("banking", "manage_account")) then
                    RageUI.DrawContent(
                        {header = false, glare = false},
                        function()
                            RageUI.Button(
                                "Envoyer de l'argent",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local finish = false
                                        local rib1 = KeyboardInput("RIB du bénéficiaire ?", nil, 255)
                                        local rib2 = KeyboardInput("Confirmez svp", nil, 255)
                                        if rib1 == rib2 then
                                            local amount = KeyboardInput("Montant ? ", nil, 100)
                                            local amount = tonumber(amount)
                                            if amount ~= nil then
                                                if amount <= ATM.Selected.amount then
                                                    TriggerServerCallback(
                                                        "banksExists",
                                                        function(bool)
                                                            if bool then
                                                                TriggerServerEvent(
                                                                    "bankingSendMoney",
                                                                    rib1,
                                                                    amount,
                                                                    ATM.Selected.iban
                                                                )
                                                                RageUI.Popup(
                                                                    {
                                                                        message = "~g~La transaction de $".. amount .. " s'est déroulée avec succès"
                                                                    }
                                                                )
                                                            else
                                                                RageUI.Popup({message = "Le compte n'existe pas"})
                                                            end
                                                            TriggerServerEvent(
                                                                "gcPhone:_internalAddMessage",
                                                                "Banque",
                                                                ATM.Selected.phone_number,
                                                                "Nouveau virement de " ..
                                                                    amount ..
                                                                        "$ vers " ..
                                                                            rib1 ..
                                                                                " à partir du compte " ..
                                                                                    ATM.Selected.iban,
                                                                false
                                                            )
                                                        end,
                                                        rib1
                                                    )
                                                end
                                            end
                                        else
                                            RageUI.Popup({message = "Les deux rib sont différents"})
                                        end
                                    end
                                end
                            )
                            RageUI.Button(
                                "Déposer de l'argent",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        Refresh()
                                    end
                                end,
                                RMenu:Get("banking", "deposit_money")
                            )
                            RageUI.Button(
                                "Retirer de l'argent",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local data = ATM.Selected.todayratio
                                        local amount = KeyboardInput("Combien ?", nil, 255)
                                        local amount = tonumber(amount)

                                        if amount ~= nil then
                                            if amount <= ATM.Selected.amount then
                                                ShowNotification(
                                                    "~g~Transaction bancaire en cours~w~\nContact du serveur bancaire"
                                                )

                                                TriggerServerCallback(
                                                    "aCore_banking:getRatiosForCard",
                                                    function(
                                                        cardExist,
                                                        maxDeposit,
                                                        maxRemove,
                                                        maxPayin,
                                                        currentDeposit,
                                                        currentRemove,
                                                        currentPayin)
                                                        if (cardExist == false) then
                                                            RageUI.Popup(
                                                                {
                                                                    message = "~g~Retrait bancaire\n~s~Cette carte ne semble pas exister"
                                                                }
                                                            )
                                                        else
                                                            processRemoving = false

                                                            if (maxRemove > currentRemove + amount) then
                                                                -- Case the account is not reaching the limit
                                                                RageUI.Popup(
                                                                    {
                                                                        message = "~g~Retrait bancaire\n~s~" ..
                                                                            amount .. "$"
                                                                    }
                                                                )
                                                                processRemoving = true
                                                            else
                                                                -- Case the account is reaching the limit
                                                                if (currentRemove < maxRemove) then
                                                                    amount = maxRemove - currentRemove
                                                                    print(amount)
                                                                    RageUI.Popup(
                                                                        {
                                                                            message = "~g~Retrait bancaire\n~s~Votre montant est trop gros par rapport a votre limite de carte"
                                                                        }
                                                                    )
                                                                    RageUI.Popup(
                                                                        {
                                                                            message = "~g~Retrait bancaire\n~s~ La banque vous donne ~b~" ..
                                                                                amount .. "$.~s~"
                                                                        }
                                                                    )
                                                                    processRemoving = true
                                                                else
                                                                    RageUI.Popup(
                                                                        {
                                                                            message = "~g~Retrait bancaire\n~r~ Limite de retrait dépassée pour aujourd'hui.\nRetrait refusé.~s~"
                                                                        }
                                                                    )
                                                                end
                                                            end

                                                            if (processRemoving == true) then
                                                                RMenu:Get("banking", "manage_account").Subtitle =
                                                                    ATM.Selected.label ..
                                                                    " " .. ATM.Selected.amount .. "$"

                                                                TriggerServerEvent(
                                                                    "aCore_bank:removeMoneyFromBankAccount",
                                                                    ATM.Selected.iban,
                                                                    amount
                                                                )

                                                                TriggerServerEvent(
                                                                    "aCore_bank:addRemoveQuotaToCard",
                                                                    ATM.Cards.number,
                                                                    amount
                                                                )

                                                                TriggerServerEvent(
                                                                    "gcPhone:_internalAddMessage",
                                                                    "Banque",
                                                                    ATM.Selected.phone_number,
                                                                    "Retrait de " ..
                                                                        amount ..
                                                                            "$ à partir du compte " .. ATM.Selected.iban,
                                                                    false
                                                                )
                                                            end
                                                        end
                                                    end,
                                                    ATM.Cards.number
                                                )
                                            else
                                                RageUI.Popup({message = "Montant du compte ~r~insuffisant"})
                                            end
                                        end
                                        ATM.Selected.todayratio = data
                                    end
                                end
                            )
                            RageUI.Button(
                                "Informations",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        local data = ATM.Selected.todayratio
                                        RageUI.Popup(
                                            {
                                                message = "~b~Informations du compte:~s~\nRIB ~b~" ..
                                                    ATM.Selected.iban .. ""
                                            }
                                        )
                                        RageUI.Popup(
                                            {
                                                message = "~b~Informations du quotas:~s~\nDépot ~b~" ..
                                                    data.deposit ..
                                                        "/" ..
                                                            data.maxDeposit ..
                                                                "$\n~s~Retrait ~b~" ..
                                                                    data.remove .. "/" .. data.maxRemove .. "$"
                                            }
                                        )
                                    end
                                end
                            )

                            RageUI.Button(
                                "Demander un nouveau code",
                                nil,
                                {RightLabel = nil},
                                true,
                                function(_, _, Selected)
                                    if Selected then
                                        math.randomseed(GetGameTimer())
                                        local newCode = math.random(1111, 9999)
                                        TriggerServerEvent(
                                            "gcPhone:_internalAddMessage",
                                            "Banque",
                                            ATM.Selected.phone_number,
                                            "Votre nouveau code est " .. newCode,
                                            false
                                        )
                                        TriggerServerEvent("gcPhone:allUpdate")
                                        RageUI.Popup({message = "Réception du ~g~nouveau code~s~ sur votre télephone"})
                                        TriggerServerEvent("newCode", newCode, Inventory.SelectedItem.data.number)
                                        Inventory.SelectedItem.data.code = newCode
                                    --TriggerServerEvent("inventory:editData",Inventory.SelectedItem.id,Inventory.SelectedItem.data)
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
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(1000)
            if RageUI.Visible(RMenu:Get("banking", "main_atm")) then
                stillNear = IsNearATM()

                if not stillNear then
                    RageUI.Visible(RMenu:Get("banking", "main_atm"), false)
                end
            end
        end
    end
)
