local ClotheTenues = {}

function Job:OpenClotheRoom(type)
    --print(type)
    if type == "Job" or type == "Jobs" or type == nil then
        ClotheTenues = Job.Job.work.vestiaire.Tenues

        if Job:Get().name == "police" then
            ClotheTenues = TenueLSPD
        elseif Job:Get().name == "lssd" then
            ClotheTenues = TenueLSSD
        end
    else
        ClotheTenues = Orga.Job.work.vestiaire.Tenues
    end
    RageUI.Visible(RMenu:Get("jobs", "vestiaire"), true)
    RMenu:Get("jobs", "vestiaire").Closed = function()
        for i = 0, 5, 1 do
            ClearPedProp(PlayerPedId(), i)
        end
        RefreshClothes()
    end
end

function isMale()
    if (GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01")) then
        return true
    else
        return false
    end
end
local current = {}
Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            if RageUI.Visible(RMenu:Get("jobs", "vestiaire")) then
                RageUI.DrawContent(
                    {header = false, glare = false},
                    function()
                        for k, v in pairs(ClotheTenues) do
                            RageUI.Button(
                                k,
                                nil,
                                {},
                                true,
                                function(_, Active, Selected)
                                    if Selected then
                                        if Inventory.CanReceive("tenue", 1) then
                                            if isMale() then
                                                local data = {
                                                    torso = v.male["arms"],
                                                    pant = v.male["pants_1"],
                                                    chaus = v.male["shoes_1"],
                                                    unders = v.male["tshirt_1"],
                                                    access = -1,
                                                    tops = v.male["torso_1"],
                                                    pantcolor = v.male["pants_2"],
                                                    chausscolor = v.male["shoes_2"],
                                                    underscolor = v.male["tshirt_2"],
                                                    topcolor = v.male["torso_2"],
                                                    accesscolor = -1,
                                                    bags = v.male["bags_1"],
                                                    bagscolor = v.male["bags_2"],
                                                    glasses = v.male["glasses_1"],
                                                    glassescolor = v.male["glasses_2"],
                                                    chain = v.male["chain_1"],
                                                    chaincolor = v.male["chain_2"],
                                                    mask = v.male["mask_1"],
                                                    maskcolor = v.male["mask_2"],
                                                    hat = v.male["helmet_1"],
                                                    hatcolor = v.male["helmet_2"],
                                                    decals = v.male["decals_1"],
                                                    decalscolor = v.male["decals_2"]
                                                }
                                                local item = {}
                                                item.name = "tenue"
                                                item.data = data
                                                item.label = k
                                                AddItemtoInv(item)
                                                item = {}
                                            else
                                                local data = {
                                                    torso = v.female["arms"],
                                                    pant = v.female["pants_1"],
                                                    chaus = v.female["shoes_1"],
                                                    unders = v.female["tshirt_1"],
                                                    access = -1,
                                                    tops = v.female["torso_1"],
                                                    pantcolor = v.female["pants_2"],
                                                    chausscolor = v.female["shoes_2"],
                                                    underscolor = v.female["tshirt_2"],
                                                    topcolor = v.female["torso_2"],
                                                    accesscolor = -1,
                                                    bags = v.female["bags_1"],
                                                    bagscolor = v.female["bags_2"],
                                                    glasses = v.female["glasses_1"],
                                                    glassescolor = v.female["glasses_2"],
                                                    chain = v.female["chain_1"],
                                                    chaincolor = v.female["chain_2"],
                                                    mask = v.female["mask_1"],
                                                    maskcolor = v.female["mask_2"],
                                                    hat = v.female["helmet_1"],
                                                    hatcolor = v.female["helmet_2"],
                                                    decals = v.female["decals_1"],
                                                    decalscolor = v.female["decals_2"]
                                                }
                                                local item = {}
                                                item.name = "tenue"
                                                item.data = data
                                                item.label = k
                                                AddItemtoInv(item)
                                                item = {}
                                            end
                                            RageUI.Popup({message = "Vous avez reçu une nouvelle tenue"})
                                        end
                                    elseif Active and k ~= current then
                                        current = k
                                        local ped = PlayerPedId()
                                        local data = {}
                                        ClearPedProp(ped, 1)
                                        ClearPedProp(ped, 0)
                                        RefreshClothes()
                                        if not isMale() then
                                            data = {
                                                torso = v.female["arms"],
                                                pant = v.female["pants_1"],
                                                chaus = v.female["shoes_1"],
                                                unders = v.female["tshirt_1"],
                                                access = -1,
                                                tops = v.female["torso_1"],
                                                pantcolor = v.female["pants_2"],
                                                chausscolor = v.female["shoes_2"],
                                                underscolor = v.female["tshirt_2"],
                                                topcolor = v.female["torso_2"],
                                                accesscolor = -1,
                                                bags = v.female["bags_1"],
                                                bagscolor = v.female["bags_2"],
                                                glasses = v.female["glasses_1"],
                                                glassescolor = v.female["glasses_2"],
                                                chain = v.female["chain_1"],
                                                chaincolor = v.female["chain_2"],
                                                mask = v.female["mask_1"],
                                                maskcolor = v.female["mask_2"],
                                                hat = v.female["helmet_1"],
                                                hatcolor = v.female["helmet_2"],
                                                decals = v.female["decals_1"],
                                                decalscolor = v.female["decals_2"]
                                            }
                                        else
                                            data = {
                                                torso = v.male["arms"],
                                                pant = v.male["pants_1"],
                                                chaus = v.male["shoes_1"],
                                                unders = v.male["tshirt_1"],
                                                access = -1,
                                                tops = v.male["torso_1"],
                                                pantcolor = v.male["pants_2"],
                                                chausscolor = v.male["shoes_2"],
                                                underscolor = v.male["tshirt_2"],
                                                topcolor = v.male["torso_2"],
                                                accesscolor = -1,
                                                bags = v.male["bags_1"],
                                                bagscolor = v.male["bags_2"],
                                                glasses = v.male["glasses_1"],
                                                glassescolor = v.male["glasses_2"],
                                                chain = v.male["chain_1"],
                                                chaincolor = v.male["chain_2"],
                                                mask = v.male["mask_1"],
                                                maskcolor = v.male["mask_2"],
                                                hat = v.male["helmet_1"],
                                                hatcolor = v.male["helmet_2"],
                                                decals = v.male["decals_1"],
                                                decalscolor = v.male["decals_2"]
                                            }
                                        end
                                        SetPedComponentVariation(ped, 3, data.torso, data.torsocolor)

                                        SetPedComponentVariation(ped, 4, data.pant, data.pantcolor)

                                        SetPedComponentVariation(ped, 6, data.chaus, data.chausscolor)

                                        SetPedComponentVariation(ped, 11, data.tops, data.topcolor)

                                        SetPedComponentVariation(ped, 3, data.torso, data.torsocolor)

                                        SetPedComponentVariation(ped, 7, data.access, data.accesscolor)

                                        SetPedComponentVariation(ped, 8, data.unders, data.underscolor)

                                        SetPedComponentVariation(ped, 7, data.chain, data.chaincolor)

                                        SetPedComponentVariation(ped, 5, data.bags, data.bagscolor)

                                        SetPedPropIndex(ped, 1, data.glasses, data.glassescolor)

                                        SetPedPropIndex(ped, 0, data.hat, data.hatcolor)

                                        SetPedComponentVariation(ped, 10, data.decals, data.decalscolor)
                                        SetPedComponentVariation(ped, 1, data.mask, data.maskcolor)
                                    end
                                end
                            )
                        end
                    end,
                    function()
                    end
                )
            end
        end
    end
)
