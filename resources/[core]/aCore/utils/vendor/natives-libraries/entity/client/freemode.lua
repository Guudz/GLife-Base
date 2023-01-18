---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 28/08/2019 23:38
---

---GenerateFreemodeModel
---@return string
function GenerateFreemodeModel()
    local hash = {"mp_f_freemode_01", "mp_m_freemode_01"}
    return hash[math.random(#hash)]
end

---UpdateEntityFace
---@param Ped any
---@param Table table
---@return void
---@public
function UpdateEntityFace(Ped, Table)
    if (Ped ~= nil) then
        Ped = Ped
    else
        Ped = PlayerPedId()
    end
    if (type(Table) == "table") then
        Table = Table
    else
        error("`Table` is not table")
    end
    local f = false
    local mo = GetEntityModel(PlayerPedId())
    if mo == GetHashKey("mp_m_freemode_01") or mo == GetHashKey("mp_f_freemode_01") then
        f = true
    end
    if (Table ~= nil and f) then
        if Table.face.face ~= nil then
            --    SetPedHeadBlendData(Ped, Character['face'], Character['face'], Character['face'], Character['skin'], Character['skin'], Character['skin'], 1.0, 1.0, 1.0, true)
            --  SetPedHeadBlendData(Ped, Table.face.face, Table.face.face, Table.face.face,Table.face.skin , Table.face.skin , Table.face.skin, 1.0,1.0, 0, false)
            print(Table.face.face)
            SetPedHeadBlendData(
                Ped,
                Table.face.face,
                Table.face.face,
                Table.face.face,
                Table.face.skin,
                Table.face.skin,
                Table.face.skin,
                1.0,
                1.0,
                1.0,
                true
            )
        else
            SetPedHeadBlendData(
                Ped,
                Table.face.mom,
                Table.face.dad,
                0,
                Table.face.mom,
                Table.face.dad,
                0,
                Table.resemblance,
                Table.skinMix,
                0,
                false
            )
        end
        SetPedComponentVariation(Ped, 2, Table.hair.style, 0, 0)
        SetPedHairColor(Ped, Table.hair.color[1], Table.hair.color[2])

        --   Citizen.Wait(100.0)

        SetPedHeadOverlay(Ped, 1, Table.facial.hair.beard.style, Table.facial.hair.beard.opacity)
        SetPedHeadOverlayColor(Ped, 1, 1, Table.facial.hair.beard.color[1], Table.facial.hair.beard.color[2])

        --   Citizen.Wait(100.0)

        SetPedHeadOverlay(Ped, 2, Table.facial.hair.eyebrow.style, Table.facial.hair.eyebrow.opacity)
        SetPedHeadOverlayColor(Ped, 2, 1, Table.facial.hair.eyebrow.color[1], Table.facial.hair.eyebrow.color[2])

        --     Citizen.Wait(100.0)

        SetPedHeadOverlay(Ped, 3, Table.ageing.style, Table.ageing.opacity)

        --   Citizen.Wait(100.0)

        SetPedHeadOverlay(Ped, 8, Table.lipstick.style, Table.lipstick.opacity)
        SetPedHeadOverlayColor(Ped, 8, 1, Table.lipstick.color[1], Table.lipstick.color[2])

        --    Citizen.Wait(100.0)

        SetPedHeadOverlay(Ped, 4, Table.makeup.style, Table.makeup.opacity)

        SetPedHeadOverlayColor(Ped, 4, 1, Table.makeup.color[1], Table.makeup.color[2])

        --   Citizen.Wait(100.0)

        SetPedEyeColor(Ped, Table.eye.style)
        SetPedHeadOverlay(Ped, 0, Table.blemishes.style, Table.blemishes.opacity)

        --   Citizen.Wait(100.0)

        SetPedHeadOverlay(Ped, 6, Table.complexion.style, Table.complexion.opacity)
        SetPedHeadOverlay(Ped, 7, Table.skinAspect.style, Table.skinAspect.opacity)
        SetPedHeadOverlay(Ped, 9, Table.freckles.style, Table.freckles.opacity)

        --  Citizen.Wait(100.0)

        SetPedHeadOverlay(Ped, 10, Table.chestHair.style, Table.chestHair.opacity)
        SetPedHeadOverlayColor(Ped, 10, 1, Table.chestHair.color[1], Table.chestHair.color[2])

        --Citizen.Wait(100.0)

        SetPedFaceFeature(Ped, 0, Table.facial.features.nose.width)
        SetPedFaceFeature(Ped, 1, Table.facial.features.nose.peak.height)
        SetPedFaceFeature(Ped, 2, Table.facial.features.nose.peak.length)
        SetPedFaceFeature(Ped, 3, Table.facial.features.nose.bone.height)
        SetPedFaceFeature(Ped, 4, Table.facial.features.nose.peak.lowering)
        SetPedFaceFeature(Ped, 5, Table.facial.features.nose.bone.twist)
        SetPedFaceFeature(Ped, 6, Table.facial.features.eyebrow.height)
        SetPedFaceFeature(Ped, 7, Table.facial.features.eyebrow.forward)
        SetPedFaceFeature(Ped, 8, Table.facial.features.cheeks.bone.height)
        SetPedFaceFeature(Ped, 9, Table.facial.features.cheeks.bone.width)
        SetPedFaceFeature(Ped, 10, Table.facial.features.cheeks.width)
        SetPedFaceFeature(Ped, 11, Table.facial.features.eye.opening)
        SetPedFaceFeature(Ped, 12, Table.facial.features.lips.thickness)
        SetPedFaceFeature(Ped, 13, Table.facial.features.jaw.bone.width)
        SetPedFaceFeature(Ped, 14, Table.facial.features.jaw.bone.backLength)
        SetPedFaceFeature(Ped, 15, Table.facial.features.chimp.bone.lowering)
        SetPedFaceFeature(Ped, 16, Table.facial.features.chimp.bone.length)
        SetPedFaceFeature(Ped, 17, Table.facial.features.chimp.bone.width)
        SetPedFaceFeature(Ped, 18, Table.facial.features.chimp.hole)
        SetPedFaceFeature(Ped, 19, Table.facial.features.neck.thickness)

        return true
    else
        for k, v in pairs(Table) do
            if tonumber(k) ~= nil and tonumber(k) < 12 and type(v) == "table" then
                SetPedComponentVariation(PlayerPedId(), tonumber(k), tonumber(v.v), tonumber(v.c), 0)
            elseif tonumber(k) ~= nil and tonumber(k) < 12 then
                SetPedComponentVariation(PlayerPedId(), tonumber(k), tonumber(v), 0, 0)
            end
        end
    end
end

---UpdateEntityOutfit
---@param Ped any
---@param Table table
---@return void
---@public
function UpdateEntityOutfit(Ped, Table)
    if (Ped ~= nil) then
        Ped = Ped
    else
        Ped = PlayerPedId()
    end
    if (type(Table) == "table") then
        Table = Table
    else
        error("`Table` is not table")
    end

    if (Table ~= nil and Table.torso ~= nil) then
        --Citizen.Wait(1000)
        SetPedComponentVariation(Ped, 3, Table.torso.id, Table.torso.txt, 0)
        --Citizen.Wait(1000)
        SetPedComponentVariation(Ped, 4, Table.legs.id, Table.legs.txt, 0)
        --Citizen.Wait(1000)
        if Table.body_armor.id ~= -1 then
            SetPedComponentVariation(Ped, 5, Table.backpacks.id, Table.backpacks.txt, 0)
        end
        --Citizen.Wait(1000)
        SetPedComponentVariation(Ped, 6, Table.feet.id, Table.feet.txt, 0)
        --Citizen.Wait(1000)

        SetPedComponentVariation(Ped, 7, Table.accessories.id, Table.accessories.txt, 0)
        -- Citizen.Wait(1000)
        SetPedComponentVariation(Ped, 8, Table.undershirt.id, Table.undershirt.txt, 0)
        --Citizen.Wait(1000)
        if Table.body_armor.id ~= -1 then
            SetPedComponentVariation(Ped, 9, Table.body_armor.id, Table.body_armor.txt, 0)
        end
        --Citizen.Wait(1000)
        SetPedComponentVariation(Ped, 10, Table.texture.id, Table.texture.txt, 0)
        --Citizen.Wait(1000)
        SetPedComponentVariation(Ped, 11, Table.tops.id, Table.tops.txt, 0)
        --  Citizen.Wait(1000)
        if Table.hat.toggle == true then
            SetPedPropIndex(Ped, 0, Table.hat.id, Table.hat.txt, 0)
        else
            ClearPedProp(Ped, 0)
        end
        if Table.glasses.toggle == true then
            SetPedPropIndex(Ped, 1, Table.glasses.id, Table.glasses.txt, 0)
        else
            ClearPedProp(Ped, 1)
        end
        if Table.ears.toggle == true then
            SetPedPropIndex(Ped, 2, Table.ears.id, Table.ears.txt, 0)
        else
            ClearPedProp(Ped, 2)
        end
        if Table.watches.toggle == true then
            SetPedPropIndex(Ped, 6, Table.watches.id, Table.watches.txt, 0)
        else
            ClearPedProp(Ped, 6)
        end
        if Table.bracelets.toggle == true then
            SetPedPropIndex(Ped, 7, Table.bracelets.id, Table.bracelets.txt, 0)
        else
            ClearPedProp(Ped, 7)
        end
    end
end

---UpdateEntityTattoo
---@param Ped any
---@param Table table
---@return void
---@public
function UpdateEntityTattoo(Ped, Table)
    if (Ped ~= nil) then
        Ped = Ped
    else
        Ped = PlayerPedId()
    end
    if (type(Table) == "table") then
        Table = Table
    else
        error("`Table` is not table")
    end

    if (Table ~= nil) then
        currentTattoos = Table
        cleanPlayer()
    end
end

function GenerateEntityFace(Model)
    local colors = math.random(0, 9)

    local haircutFemale = {2, 4, 10, 11, 14, 15, 20, 36}

    if Model == "mp_m_freemode_01" then
        return {
            model = "mp_m_freemode_01",
            face = {mom = 0, dad = 0},
            resemblance = 0.5,
            skinMix = 0.5,
            ageing = {style = 1, opacity = 0.0},
            lipstick = {style = 0, opacity = 0.0, color = {[1] = 0, [2] = 0}},
            eye = {style = 1},
            blemishes = {style = 0, opacity = 0.0},
            complexion = {style = 0, opacity = 0.0},
            freckles = {style = 0, opacity = 0.0},
            skinAspect = {style = 0, opacity = 0.0},
            chestHair = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0},
            makeup = {style = 0, opacity = 0.0, color = {0, 0}},
            hair = {style = 1, color = {[1] = colors, [2] = colors}},
            facial = {
                hair = {
                    beard = {style = 1, color = {[1] = colors, [2] = colors}, opacity = 1.0},
                    eyebrow = {style = 1, color = {[1] = colors, [2] = colors}, opacity = 1.0}
                },
                features = {
                    nose = {
                        width = 0.5,
                        peak = {height = 0.5, length = 0.5, lowering = 0.5},
                        bone = {height = 0.5, twist = 0.5}
                    },
                    eyebrow = {forward = 0.5, height = 0.5},
                    cheeks = {
                        width = 0.5,
                        bone = {height = 0.5, width = 0.5}
                    },
                    eye = {opening = 0.5},
                    lips = {thickness = 0.5},
                    jaw = {
                        bone = {width = 0.5, backLength = 0.5}
                    },
                    chimp = {
                        hole = 0.5,
                        bone = {lowering = 0.5, length = 0.5, width = 0.5}
                    },
                    neck = {thickness = 0.5}
                }
            }
        }
    elseif Model == "mp_f_freemode_01" then
        return {
            model = "mp_m_freemode_01",
            face = {mom = 0, dad = 0},
            resemblance = 0.5,
            skinMix = 0.5,
            ageing = {style = 1, opacity = 0.0},
            lipstick = {style = 0, opacity = 0.0, color = {[1] = 0, [2] = 0}},
            eye = {style = 1},
            blemishes = {style = 0, opacity = 0.0},
            complexion = {style = 0, opacity = 0.0},
            freckles = {style = 0, opacity = 0.0},
            skinAspect = {style = 0, opacity = 0.0},
            chestHair = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0},
            makeup = {style = 0, opacity = 0.0, color = {0, 0}},
            hair = {style = 1, color = {[1] = colors, [2] = colors}},
            facial = {
                hair = {
                    beard = {style = 1, color = {[1] = colors, [2] = colors}, opacity = 0.0},
                    eyebrow = {style = 1, color = {[1] = colors, [2] = colors}, opacity = 1.0}
                },
                features = {
                    nose = {
                        width = 0.5,
                        peak = {height = 0.5, length = 0.5, lowering = 0.5},
                        bone = {height = 0.5, twist = 0.5}
                    },
                    eyebrow = {forward = 0.5, height = 0.5},
                    cheeks = {
                        width = 0.5,
                        bone = {height = 0.5, width = 0.5}
                    },
                    eye = {opening = 0.5},
                    lips = {thickness = 0.5},
                    jaw = {
                        bone = {width = 0.5, backLength = 0.5}
                    },
                    chimp = {
                        hole = 0.5,
                        bone = {lowering = 0.5, length = 0.5, width = 0.5}
                    },
                    neck = {thickness = 0.5}
                }
            }
        }
    else
        return {
            face = {mom = 0, dad = 0},
            resemblance = "0." .. 0,
            skinMix = "0." .. 0,
            ageing = {style = 0, opacity = 0.0},
            lipstick = {style = 0, opacity = 0.0, color = {[1] = 0, [2] = 0}},
            eye = {style = 0},
            blemishes = {style = 0, opacity = 0.0},
            complexion = {style = 0, opacity = 0.0},
            freckles = {style = 0, opacity = 0.0},
            skinAspect = {style = 0, opacity = 0.0},
            chestHair = {style = 0, color = {[1] = 0, [2] = 0}, opacity = 0.0},
            makeup = {style = 4, opacity = 1.0, color = {[1] = 0, [2] = 0}},
            hair = {style = 0, color = {[1] = colors, [2] = colors}},
            facial = {
                hair = {
                    beard = {style = 0, color = {[1] = colors, [2] = colors}, opacity = 0.0},
                    eyebrow = {style = 0, color = {[1] = colors, [2] = colors}, opacity = 1.0}
                },
                features = {
                    nose = {
                        width = 0.5,
                        peak = {height = 0.5, length = 0.5, lowering = 0.5},
                        bone = {height = 0.5, twist = 0.5}
                    },
                    eyebrow = {forward = 0.5, height = 0.5},
                    cheeks = {
                        width = 0.5,
                        bone = {height = 0.5, width = 0.5}
                    },
                    eye = {opening = 0.5},
                    lips = {thickness = 0.5},
                    jaw = {
                        bone = {width = 0.5, backLength = 0.5}
                    },
                    chimp = {
                        hole = 0.5,
                        bone = {lowering = 0.5, length = 0.5, width = 0.5}
                    },
                    neck = {thickness = 0.5}
                }
            }
        }
    end
end

function GenerateEntityOutfit(Model)
    if Model == "mp_m_freemode_01" then
        return {
            torso = {id = 0, txt = 0},
            undershirt = {id = 0, txt = 0},
            tops = {id = 0, txt = math.random(1, 2)},
            body_armor = {id = 0, txt = 0},
            backpacks = {id = 0, txt = 0},
            texture = {id = 0, txt = 0},
            feet = {id = 12, txt = math.random(3, 4)},
            legs = {id = 15, txt = math.random(9, 12)},
            accessories = {id = 0, txt = 0},
            mask = {toggle = false, id = 0, txt = 0},
            hat = {toggle = true, id = -1, txt = 0},
            glasses = {toggle = true, id = -1, txt = 0},
            ears = {toggle = true, id = -1, txt = 0},
            watches = {toggle = true, id = -1, txt = 0},
            bracelets = {toggle = true, id = -1, txt = 0}
        }
    elseif Model == "mp_f_freemode_01" then
        return {
            torso = {id = 4, txt = 0},
            undershirt = {id = 15, txt = 0},
            tops = {id = 32, txt = math.random(1, 2)}, -- Shirt overlay
            body_armor = {id = 0, txt = 0},
            backpacks = {id = 0, txt = 0},
            texture = {id = 0, txt = 0},
            feet = {id = 3, txt = 0},
            legs = {id = 4, txt = math.random(1, 3)},
            accessories = {id = 0, txt = 0},
            mask = {toggle = false, id = 0, txt = 0},
            hat = {toggle = true, id = -1, txt = 0},
            glasses = {toggle = true, id = -1, txt = 0},
            ears = {toggle = true, id = -1, txt = 0},
            watches = {toggle = true, id = -1, txt = 0},
            bracelets = {toggle = true, id = -1, txt = 0}
        }
    else
        return {
            torso = {id = 4, txt = 0},
            undershirt = {id = 15, txt = 0},
            tops = {id = 32, txt = 0}, -- Shirt overlay
            body_armor = {id = 0, txt = 0},
            backpacks = {id = 0, txt = 0},
            texture = {id = 0, txt = 0},
            feet = {id = 3, txt = 0},
            legs = {id = 4, txt = 0},
            accessories = {id = 0, txt = 0},
            mask = {toggle = false, id = 0, txt = 0},
            hat = {toggle = true, id = -1, txt = 0},
            glasses = {toggle = true, id = -1, txt = 0},
            ears = {toggle = true, id = -1, txt = 0},
            watches = {toggle = true, id = -1, txt = 0},
            bracelets = {toggle = true, id = -1, txt = 0}
        }
    end
end

-- TODO tonnio implemented you systems
function GenerateEntityTattoo(Model)
    return {
        head = {dictionary = 0, style = 0},
        neck = {dictionary = 0, style = 0},
        torso = {
            back = {dictionary = 0, style = 0},
            chest = {dictionary = 0, style = 0},
            belly = {dictionary = 0, style = 0}
        },
        arm = {
            left = {dictionary = 0, style = 0},
            right = {dictionary = 0, style = 0}
        },
        leg = {
            left = {dictionary = 0, style = 0},
            right = {dictionary = 0, style = 0}
        }
    }
end

function UpdatePlayerPedFreemodeCharacter(Entity, Model, Face, Outfit, Tattoo)
    local hash = Model
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(500)
        print("model loading", hash)
    end
    SetPlayerModel(PlayerId(), hash)
    SetPedDefaultComponentVariation(PlayerPedId())
    SetEntityAsMissionEntity(PlayerPedId(), true, true)
    SetModelAsNoLongerNeeded(PlayerPedId())

    Entity = PlayerPedId()
    UpdateEntityFace(Entity, Face)
    UpdateEntityOutfit(Entity, Outfit)
    UpdateEntityTattoo(Entity, Tattoo)
    return true
end