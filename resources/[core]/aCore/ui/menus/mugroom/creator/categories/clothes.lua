local MenClothes = {
    {
        Name = "RainLayer City",
        Description = " Tenue officiel du serveur RainLayer City",
        Selected = false,
        Value = {
            torso = {id = 0, txt = 0},
            undershirt = {id = 15, txt = 0},
            tops = {id = 31, txt = 0},
            legs = {id = 4, txt = 0},
            body_armor = {id = 0, txt = 0},
            backpacks = {id = 0, txt = 0},
            texture = {id = 0, txt = 0},
            feet = {id = 8, txt = 0},
            accessories = {id = 0, txt = 0},
            mask = {toggle = false, id = 0, txt = 0},
            hat = {toggle = true, id = 6, txt = 0},
            glasses = {toggle = false, id = -1, txt = 0},
            ears = {toggle = false, id = -1, txt = 0},
            watches = {toggle = false, id = -1, txt = 0},
            bracelets = {toggle = false, id = -1, txt = 0}
        }
    }
}

local FemaleClothes = {
    {
        Name = "Cool",
        Description = " ",
        Selected = false,
        Value = {
            torso = {id = 4, txt = 0},
            undershirt = {id = 2, txt = 0},
            tops = {id = 36, txt = 0},
            legs = {id = 25, txt = 6},
            body_armor = {id = 0, txt = 0},
            backpacks = {id = 0, txt = 0},
            texture = {id = 0, txt = 0},
            feet = {id = 49, txt = 0},
            accessories = {id = 0, txt = 0},
            mask = {toggle = false, id = 0, txt = 0},
            hat = {toggle = true, id = -1, txt = 0},
            glasses = {toggle = true, id = 8, txt = 0},
            ears = {toggle = false, id = -1, txt = 0},
            watches = {toggle = true, id = 16, txt = 0},
            bracelets = {toggle = false, id = -1, txt = 0}
        }
    }
}

local SelectedClothes = {
    mp_m_freemode_01 = {
        Index = 0
    },
    mp_f_freemode_01 = {
        Index = 0
    }
}

local function SelectedClothesWithModel()
    if (GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01")) then
        return MenClothes
    else
        return FemaleClothes
    end
end

local function EquipedClothesBadge(Index, Key)
    if (Key == Index) then
        return {RightBadge = RageUI.BadgeStyle.Clothes}
    else
        return {}
    end
end

function CreatorMenuClothes(indexCharacter, createPlayer)
    RageUI.DrawContent(
        {header = true, instructionalButton = true},
        function()
            for k, v in pairs(SelectedClothesWithModel()) do
                RageUI.Button(
                    v.Name,
                    v.Description,
                    EquipedClothesBadge(SelectedClothes[createPlayer.Model].Index, k),
                    true,
                    function(Hovered, Active, Selected)
                        if Selected then
                            SelectedClothes[createPlayer.Model].Index = k
                            local Entity = PlayerPedId()
                            UpdateEntityOutfit(Entity, v.Value)
                            if not (isPlayingAnimSelectedClothes(Entity)) then
                                OnSelectedClothes(v.Value)
                            end
                        end
                    end
                )
            end
        end,
        function()
        end
    )
end
