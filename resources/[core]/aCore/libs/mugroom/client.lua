local function GenerateGamemodeContent()
    return {
        Model = GenerateFreemodeModel(),
        Position = {x = 399.9, y = -998.7, z = -100.0, heading = 180.086},
        mp_f_freemode_01 = {
            Face = GenerateEntityFace("mp_f_freemode_01"),
            Outfit = GenerateEntityOutfit("mp_f_freemode_01"),
            Tattoo = GenerateEntityTattoo("mp_f_freemode_01"),
            Identity = {}
        },
        mp_m_freemode_01 = {
            Face = GenerateEntityFace("mp_m_freemode_01"),
            Outfit = GenerateEntityOutfit("mp_m_freemode_01"),
            Tattoo = GenerateEntityTattoo("mp_m_freemode_01"),
            Identity = {}
        }
    }
end
PlyGroup = "user"
RegisterNetEvent("spawnhandler:LoadCharacter")

AddEventHandler(
    "spawnhandler:CharacterSelector",
    function(Skins, Identity, Jobs, Users)
        Citizen.CreateThread(
            function()
                LoadingPrompt("Chargement de vos personnages.", 3)
            end
        )

        Selector.LoadContent(Skins, Identity, Jobs, Users)
    end
)

AddEventHandler(
    "spawnhandler:CharacterCreator",
    function(Table)
        Citizen.CreateThread(
            function()
                local _Generating = GenerateGamemodeContent()
                LoadingPrompt("Chargement de la création de personnage.", 3)

                local PlayerPed = PlayerPedId()
                local loadedCharacter = false
                local selectedModel = _Generating.Model

                TriggerEvent("mugroom:updatePlayerData", _Generating)

                loadedCharacter =
                    UpdatePlayerPedFreemodeCharacter(
                    PlayerPed,
                    selectedModel,
                    _Generating[selectedModel].Face,
                    _Generating[selectedModel].Outfit,
                    _Generating[selectedModel].Tattoo
                )

                while not loadedCharacter do
                    Citizen.Wait(0)
                end

                SetCoords(PlayerPed, _Generating.Position)
                FreezePlayer(PlayerId(), true)

                ClearPlayerWantedLevel(PlayerId())
                ClearPedTasksImmediately(PlayerPed)
                RemoveLoadingPrompt()
                local interiorID = GetInteriorAtCoordsWithType(vector3(399.9, -998.7, -100.0), "v_mugshot")
                LoadInterior(interiorID)
                SetOverrideWeather("EXTRASUNNY")
                SetWeatherTypePersist("EXTRASUNNY")

                while not IsInteriorReady(interiorID) do
                    Citizen.Wait(0)
                end
            end
        )
        Creator.LoadContent()
    end
)
isLoaded = false
AddEventHandler(
    "spawnhandler:LoadCharacter",
    function(Skins, Identity, Jobs, Users)
        Citizen.CreateThread(
            function()
                LoadingPrompt("Chargement du personnage...", 4)
                SetMyIdentity(Identity)
                local loadedCharacter = false
                local PlayerPed = PlayerPedId()
                PlySkin = json.decode(Skins[1].face)
                currentTattoos = json.decode(Skins[1].tattoo)
                loadedCharacter =
                    UpdatePlayerPedFreemodeCharacter(
                    PlayerPed,
                    Skins[1].model,
                    json.decode(Skins[1].face),
                    json.decode(Skins[1].outfit),
                    json.decode(Skins[1].tattoo)
                )
                TriggerEvent("status:Spawned", Users[1].food, Users[1].thirst)
                while not loadedCharacter do
                    Citizen.Wait(0)
                    --print("sorry im waiting")
                end
                LocalPlayer().FarmLimit = Users[1].farm_limit
                LocalPlayer().Strength = Users[1].strength
                LocalPlayer().InventoryPrefix = Users[1].id
                PlyGroup = Users[1].group
                PlyUUID = Users[1].uuid
                TriggerEvent("es:activateMoney", Users[1].money)
                TriggerEvent("es:activateBlackMoney", Users[1].black_money)
                XNL_SetInitialXPLevels(tonumber(Users[1].xp))
                Job:Set(Jobs[1].name, Jobs[1].rank)
                setOldF(Users[1].limit_farm)
                PlyUuid = Users[1].uuid
                --  SetFarmLimit(Users[1].limit_farm)
                Orga:Set(Jobs[1].orga, Jobs[1].orga_rank)

                ClearPlayerWantedLevel(PlayerId())
                ClearPedTasksImmediately(PlayerPed)
                if Users[1].position == nil then
                    Users[1].position = json.encode({x = -1041.58, y = -2744.09, z = 21.36})
                end
                SetCoords(PlayerPedId(), json.decode(Users[1].position))
                StartEverything()
                PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
                RageUI.Popup(
                    {
                        message = "Vous venez d'être téléporté à votre dernière position"
                    }
                )
            end
        )
        DoScreenFadeIn(500)
        while not IsScreenFadedIn() do
            Citizen.Wait(0)
        end
        LocalPlayer().isBussy = false
        Citizen.Wait(5000)
        RemoveLoadingPrompt()

        isLoaded = true
    end
)
