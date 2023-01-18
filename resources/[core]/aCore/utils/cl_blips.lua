local Blips = {
    {Pos = {x = -1087.98, y = -824.97, z = 30.25}, sprite = 60, size = 0.6, color = 29, name = "Poste de police"},
    {Pos = {x = -440.43, y = 6019.48, z = 31.49}, sprite = 60, size = 0.6, color = 70, name = "LSSD - Paleto Bay"},
    {Pos = {x = 1856.64, y = 3679.66, z = 33.79}, sprite = 60, size = 0.6, color = 70, name = "LSSD - Sandy Shores"},
    {Pos = {x = 119.47, y = -1308.58, z = 29.71}, sprite = 121, size = 0.6, color = 61, name = "Unicorn"},
    {name="Aéroport", color=3, sprite=90, Pos = {x=-1336.25, y=-3043.99, z=13.9444}},
    {name="Aéroport", color=3, sprite=90, Pos = {x=2044.42, y=4768.07, z=41.0603}},

    {name="Récolte de Pomme", color=9, sprite=514, Pos = {x=363.24,y=6516.56,z=28.28}},
    {name="Traitement de Pomme", color=9, sprite=514, Pos = {x=460.49,y=3568.85,z=33.24}},
    {name="Vente de Pomme", color=9, sprite=514, Pos = {x=1699.13,y=4933.04,z=42.08}},
    {name="Coiffeur", color=59, sprite=71, Pos = {x=137.76,y=-1708.74,z=29.3}},
    {name="Récolte de Raisin", color=7, sprite=514, Pos = {x=-1814.76,y=2151.70,z=117.44}},
    {name="Traitement de Raisin", color=7, sprite=514, Pos = {x=346.44,y=3406.10,z=36.48}},
    {name="Vente de Raisin", color=7, sprite=514, Pos = {x=2874.01,y=4459.11,z=48.52}},

    {name = "Fourrière Nord", color = 21, sprite = 1, size = 0.6, Pos = {x = 1758.28, y = 3328.80, z = 41.36}},
    {name = "Fourrière Sud", color = 21, sprite = 1, size = 0.6, Pos = {x = -360.51, y = -128.17, z = 38.69}},

    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 89.75, y = 2.35, z = 68.31}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1167.02, y = -456.32, z = 66.79}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -386.733, y = 6045.953, z = 31.501}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -284.037, y = 6224.385, z = 31.187}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -284.037, y = 6224.385, z = 31.187}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -135.165, y = 6365.738, z = 31.101}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -110.753, y = 6467.703, z = 31.784}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -94.9690, y = 6455.301, z = 31.784}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 155.4300, y = 6641.991, z = 31.784}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 174.6720, y = 6637.218, z = 31.784}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1703.138, y = 6426.783, z = 32.730}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1735.114, y = 6411.035, z = 35.164}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1702.842, y = 4933.593, z = 42.051}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1967.333, y = 3744.293, z = 32.272}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1821.917, y = 3683.483, z = 34.244}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1174.532, y = 2705.278, z = 38.027}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 540.0420, y = 2671.007, z = 42.177}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 2564.399, y = 2585.100, z = 38.016}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 2558.683, y = 349.6010, z = 108.050}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 2558.051, y = 389.4817, z = 108.660}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1077.692, y = -775.796, z = 58.218}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1139.018, y = -469.886, z = 66.789}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1168.975, y = -457.241, z = 66.641}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 1153.884, y = -326.540, z = 69.245}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 381.2827, y = 323.2518, z = 103.270}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = 236.4638, y = 217.4718, z = 106.840}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x =  157.7698, y = 233.5450, z = 106.450}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -164.568, y = 233.5066, z = 94.919}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -1827.04, y = 785.5159, z = 138.020}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -1409.39, y = -99.2603, z = 52.473}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -1205.35, y = -325.579, z = 37.870}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -1215.64, y = -332.231, z = 37.881}},
    {name = "Distributeur de Billets", color = 2, sprite = 277, size = 0.5, Pos = {x = -2072.41, y = -316.959, z = 13.345}},

    {name = "Banque", color = 2, sprite = 500, size = 0.6, Pos = {x=148.834, y=-1041.858, z=29.374}},
    {name = "Banque", color = 2, sprite = 500, size = 0.6, Pos = {x=-1212.980, y=-332.367, z=37.787}},
    {name = "Banque", color = 2, sprite = 500, size = 0.6, Pos = {x=-2961.582, y=482.627, z=15.703}},
    {name = "Banque", color = 2, sprite = 500, size = 0.6, Pos = {x=-112.202, y=6469.295, z=31.626}},
    {name = "Banque", color = 2, sprite = 500, size = 0.6, Pos = {x=313.187, y=-280.621, z=54.170}},
    {name = "Banque", color = 2, sprite = 500, size = 0.6, Pos = {x=-351.534, y=-51.529, z=49.042}},
    {name = "Pacific Banque", color = 2, sprite = 500, size = 0.6, Pos = {x=247.727, y=224.706, z=106.286}},

    {name = "Fight Club", color = nill, sprite = 311, Pos = {x = -506.78, y = -1728.00, z = 19.27}},
    {name = "FlyWheels Garage", color = 47, sprite = 643, Pos = {x = 1776.74, y = 3327.54, z = 41.43}},
--    {name = "Locaux FIB", color = 38, sprite = 88, Pos = {x = 113.44, y = -752.13, z = 45.74}},
    {name = "Journaliste", color = 68, sprite = 184, size = 0.5, Pos = {x = -582.75, y = -927.19, z = 36.83}},
    {name = "Prison", color = 0, sprite = 252, Pos = {x = 1854.26, y = 2602.31, z = 45.67}},
    {name = "Taxi", color = 5, sprite= 198, Pos = {x = 909.18, y = -179.6, z = 74.17}},
    {name = "Tabac", color = 2, sprite= 79, Pos = {x = 2010.8, y = 3076.6, z = 47.06}},
    {name = "Golf", color = nill, sprite = 109, Pos = {x = -1312.0, y = 110.49, z = 56.81}},
    {name = "Gouvernement", color = nill, sprite = 419, Pos = {x = -529.18, y = -252.51, z = 35.74}},
    {name = "Terrain de Cross", color = 36, sprite = 512, Pos = {x = 874.67, y = 2356.09, z = 51.69}},
--    {name = "Ponsonbys", color = 64, sprite = 366, Pos = {x = -716.84, y = -156.75, z = 36.98}},
    {name = "Agence immobilière", color = 64, sprite = 492, Pos = {x = -697.51, y = 271.68, z = 83.10}},
    {name = "Fête foraine", color = nill, sprite = 266, Pos = {x = -1825.48, y = -1190.6, z = 14.44}},

    {name = "Zone de pêche", color = 82, sprite = 427, size = 0.55, Pos = {x = 100.34, y = 4042.98, z = 30.0}},
    {name = "Zone de pêche", color = 82, sprite = 427, size = 0.55, Pos = {x = 486.61, y = 3904.81, z = 30.0}},
    {name = "Zone de pêche", color = 82, sprite = 427, size = 0.55, Pos = {x = 869.91, y = 3872.93, z = 30.0}},
    {name = "Zone de pêche", color = 82, sprite = 427, size = 0.55, Pos = {x = 1200.18, y = 3947.33, z = 30.0}},
    {name = "Zone de pêche", color = 82, sprite = 427, size = 0.55, Pos = {x = 1582.86, y = 4142.36, z = 30.0}},
    {name = "Zone de pêche", color = 82, sprite = 427, size = 0.55, Pos = {x = 1987.81, y = 4252.86, z = 30.0}},

    {name = "Vente de poisson", color = nill, sprite = 68, size = 0.5, Pos = {x=1357.10,y=4386.39,z=44.34}},
    {name = "Vente de poisson", color = nill, sprite = 68, size = 0.5, Pos = {x=1529.78,y=3778.16,z=34.51}},
    {name = "Vente de poisson", color = nill, sprite = 68, size = 0.5, Pos = {x=1915.85,y=582.68,z=176.36}},
    {name = "Vente de poisson", color = nill, sprite = 68, size = 0.5, Pos = {x=-800.46,y=-1341.46,z=5.15}},
    {name = "Vente de poisson", color = nill, sprite = 68, size = 0.5, Pos = {x=-184.126,y=6541.67,z=11.09}},

    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 1039.958, y = 2671.134, z = 39.550}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 171.77, y = -1561.59, z = 29.26}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = -65.117, y = -1761.38, z = 29.22}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 2539.685, y = 2594.192, z = 37.944}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 2679.858, y = 3263.946, z = 55.240}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 2005.055, y = 3773.887, z = 32.403}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 1687.156, y = 4929.392, z = 42.078}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 1701.314, y = 6416.028, z = 32.763}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 179.857, y = 6602.839, z = 31.868}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = -2554.996, y = 2334.40, z = 33.078}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = -2096.243, y = -320.286, z = 13.168}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = -724.619, y = -935.1631, z = 19.213}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 265.648, y = -1261.309, z = 29.292}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 1208.951, y = -1402.567, z = 35.224}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 620.843, y = 269.100, z = 103.089}},
    {name = "Station essence", color = 1, sprite = 361, size = 0.45, Pos = {x = 2581.321, y = 362.039, z = 108.468}},

    {name = "Station d'essence | Bateau", color = 5, sprite = 427, size = 0.45, Pos = {x = 3855.96, y = 4465.36, z = 2.7}},
    {name = "Station d'essence | Bateau", color = 5, sprite = 427, size = 0.45, Pos = {x = -802.513, y = -1504.675, z = 1.305}},
    {name = "Station d'essence | Hélicoptères, Avion", color = 5, sprite = 43, size = 0.45, Pos = {x = -1112.407, y = -2883.893, z = 13.946}},
--[[    {name = "Douane EST", color = 38, sprite = 238, Pos = {x = 1444.80, y = 750.21, z = 141.68}},
    {name = "Douane OUEST", color = 38, sprite = 238, Pos = {x = -2760.33, y = 22.72, z = 15.27}},
    {name = "Points fréquentés", color = nill, sprite = 304,  Pos = {x = -644.88, y = 126.16, z = 57.18}},
    {name = "Points fréquentés", color = nill, sprite = 304, Pos = {x = -1077.65, y = 340.86, z = 67.17}},
    {name = "Points fréquentés", color = nill, sprite = 304, Pos = {x = 1069.87, y = -517.76, z = 62.52}},
    {name = "Points fréquentés", color = nill, sprite = 304, Pos = {x = 797.37, y = -1435.86, z = 27.21}},--]]
    {name = "Champ de Weed", color = 2, sprite = 469, Pos = {x = 2226.15, y = 5575.95, z = 53.66}},
    {name = "Yatch", color = 3, sprite = 455, Pos = {x = -2028.01, y = -1036.61, z = 6.70}},
    {name = "Galaxy Club", color = 83, sprite = 614, Pos = {x = 356.18, y = 304.66, z = 103.72}}
}

Citizen.CreateThread(
    function()
        for i = 1, #Blips, 1 do
            local v = Blips[i]
            local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(blip, v.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.size or 0.5)
            SetBlipColour(blip, v.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.name)
            EndTextCommandSetBlipName(blip)
        end
    end
)



--[[local blips = {

    {title="Zone Interdite", colour=1, id=303, size = 0.6, x=-2113.5, y = 3178.75, z= 32.81}
    }
    Citizen.CreateThread(function()
        Citizen.Wait(0)
local bool = true
  if bool then
        for k,v in pairs(blips) do
            zoneblip = AddBlipForRadius(v.x,v.y,v.z, 500.0)
            SetBlipSprite(zoneblip,9)
                          SetBlipColour(zoneblip,1)
                          SetBlipAlpha(zoneblip,75)
                         
        end
         for _, info in pairs(blips) do
             info.blip = AddBlipForCoord(info.x, info.y, info.z)
                         SetBlipSprite(info.blip, info.id)
                         SetBlipDisplay(info.blip, 4)
                         SetBlipScale(info.blip, info.size)
                         SetBlipColour(info.blip, info.colour)
                         SetBlipAsShortRange(info.blip, true)
                         BeginTextCommandSetBlipName("STRING")
                         AddTextComponentString(info.title)
                         EndTextCommandSetBlipName(info.blip)
         end
       bool = false
   end
end)]]--

local blips = {

    {title="Hôpital Los Santos", colour=2, id=61, size = 0.6, x = 308.52, y = -588.19, z = 43.28}
    }
    Citizen.CreateThread(function()
        Citizen.Wait(0)
local bool = true
  if bool then
        for k,v in pairs(blips) do
            zoneblip = AddBlipForRadius(v.x,v.y,v.z, 110.0)
            SetBlipSprite(zoneblip,9)
                          SetBlipColour(zoneblip,2)
                          SetBlipAlpha(zoneblip,75)
                         
        end
         for _, info in pairs(blips) do
             info.blip = AddBlipForCoord(info.x, info.y, info.z)
                         SetBlipSprite(info.blip, info.id)
                         SetBlipDisplay(info.blip, 4)
                         SetBlipScale(info.blip, info.size)
                         SetBlipColour(info.blip, info.colour)
                         SetBlipAsShortRange(info.blip, true)
                         BeginTextCommandSetBlipName("STRING")
                         AddTextComponentString(info.title)
                         EndTextCommandSetBlipName(info.blip)
         end
       bool = false
   end
end)

local blips = {

    {title="LS Custom", colour=5, id=446, size = 0.6, x = -359.95, y = -133.20, z = 38.67}
    }
    Citizen.CreateThread(function()
        Citizen.Wait(0)
local bool = true
  if bool then
        for k,v in pairs(blips) do
            zoneblip = AddBlipForRadius(v.x,v.y,v.z, 110.0)
            SetBlipSprite(zoneblip,9)
                          SetBlipColour(zoneblip,5)
                          SetBlipAlpha(zoneblip,75)
                         
        end
         for _, info in pairs(blips) do
             info.blip = AddBlipForCoord(info.x, info.y, info.z)
                         SetBlipSprite(info.blip, info.id)
                         SetBlipDisplay(info.blip, 4)
                         SetBlipScale(info.blip, info.size)
                         SetBlipColour(info.blip, info.colour)
                         SetBlipAsShortRange(info.blip, true)
                         BeginTextCommandSetBlipName("STRING")
                         AddTextComponentString(info.title)
                         EndTextCommandSetBlipName(info.blip)
         end
       bool = false
   end
end)

local blips = {

    {title="Concessionnaire SUD", colour=4, id=225, size = 0.55, x = -44.93, y = -1097.68, z = 25.42}
    }
    Citizen.CreateThread(function()
        Citizen.Wait(0)
local bool = true
  if bool then
        for k,v in pairs(blips) do
            zoneblip = AddBlipForRadius(v.x,v.y,v.z, 110.0)
            SetBlipSprite(zoneblip,9)
                          SetBlipColour(zoneblip,4)
                          SetBlipAlpha(zoneblip,75)
                         
        end
         for _, info in pairs(blips) do
             info.blip = AddBlipForCoord(info.x, info.y, info.z)
                         SetBlipSprite(info.blip, info.id)
                         SetBlipDisplay(info.blip, 4)
                         SetBlipScale(info.blip, info.size)
                         SetBlipColour(info.blip, info.colour)
                         SetBlipAsShortRange(info.blip, true)
                         BeginTextCommandSetBlipName("STRING")
                         AddTextComponentString(info.title)
                         EndTextCommandSetBlipName(info.blip)
         end
       bool = false
   end
end)    