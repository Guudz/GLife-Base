RegisterNetEvent("stopLights")
AddEventHandler(
    "stopLights",
    function()
        SetArtificialLightsState(true)
        Wait(200)
        SetArtificialLightsState(false)
        Wait(500)
        SetArtificialLightsState(true)
        Wait(200)
        SetArtificialLightsState(false)
        Wait(500)
        SetArtificialLightsState(true)
        Wait(200)
        SetArtificialLightsState(false)
        Wait(500)
        SetArtificialLightsState(true)
        Wait(100)
        SetArtificialLightsState(false)
        Wait(200)
        SetArtificialLightsState(true)
        Wait(50)
        SetArtificialLightsState(false)
        Wait(100)
        SetArtificialLightsState(true)
        Wait(200)
        SetArtificialLightsState(false)
        Wait(50)
        SetArtificialLightsState(true)
    end
)

RegisterNetEvent("startLights")
AddEventHandler(
    "startLights",
    function()
        SetArtificialLightsState(false)
    end
)

RegisterNetEvent("startCooperScenario")
AddEventHandler(
    "startCooperScenario",
    function()
        AddExplosion(2769.85, 1664.73, 41.52, 6, 100.0, true, false, true)
        AddExplosion(2772.65, 1628.16, 41.52, 10, 100.0, true, false, true)

        Wait(500)
        AddExplosion(2769.85 + math.random(10, 20), 1664.73 + math.random(10, 20), 41.52, 23, 100.0, true, false, true)
        AddExplosion(2772.65 + math.random(10, 20), 1628.16 + math.random(10, 20), 41.52, 23, 100.0, true, false, true)
        AddExplosion(2769.85 + math.random(10, 50), 1664.73 + math.random(10, 50), 41.52, 21, 100.0, true, false, true)
        AddExplosion(2772.65 + math.random(10, 50), 1628.16 + math.random(10, 50), 41.52, 21, 100.0, true, false, true)
        AddExplosion(2748.99 + math.random(10, 50), 1663.93 + math.random(10, 50), 41.52, 6, 500.0, true, false, true)
        AddExplosion(2749.13 + math.random(10, 50), 1627.12 + math.random(10, 50), 41.52, 10, 500.0, true, false, true)

        Wait(500)

        AddExplosion(2748.99 + math.random(10, 50), 1663.93 + math.random(10, 50), 41.52, 23, 500.0, true, false, true)
        AddExplosion(2749.13 + math.random(10, 50), 1627.12 + math.random(10, 50), 41.52, 23, 500.0, true, false, true)
        AddExplosion(2748.99 + math.random(10, 50), 1663.93 + math.random(10, 50), 41.52, 21, 500.0, true, false, true)
        AddExplosion(2749.13 + math.random(10, 50), 1627.12 + math.random(10, 50), 41.52, 21, 500.0, true, false, true)
        AddExplosion(2729.59 + math.random(10, 50), 1663.70 + math.random(10, 50), 41.52, 6, 500.0, true, false, true)
        AddExplosion(2728.18 + math.random(10, 50), 1627.22 + math.random(10, 50), 41.52, 10, 500.0, true, false, true)

        Wait(500)

        AddExplosion(2729.59 + math.random(10, 50), 1663.70 + math.random(10, 50), 41.52, 23, 500.0, true, false, true)
        AddExplosion(2728.18 + math.random(10, 50), 1627.22 + math.random(10, 50), 41.52, 23, 500.0, true, false, true)
        AddExplosion(2729.59 + math.random(10, 50), 1663.70 + math.random(10, 50), 41.52, 21, 500.0, true, false, true)
        AddExplosion(2728.18 + math.random(10, 50), 1627.22 + math.random(10, 50), 41.52, 21, 500.0, true, false, true)
        AddExplosion(2704.26 + math.random(10, 50), 1663.50 + math.random(10, 50), 41.52, 6, 500.0, true, false, true)
        AddExplosion(2703.08 + math.random(10, 50), 1627.87 + math.random(10, 50), 41.52, 10, 500.0, true, false, true)

        Wait(500)

        AddExplosion(2704.26 + math.random(10, 50), 1663.50 + math.random(10, 50), 41.52, 23, 500.0, true, false, true)
        AddExplosion(2703.08 + math.random(10, 50), 1627.87 + math.random(10, 50), 41.52, 23, 500.0, true, false, true)
        AddExplosion(2704.26 + math.random(10, 50), 1663.50 + math.random(10, 50), 41.52, 21, 500.0, true, false, true)
        AddExplosion(2703.08 + math.random(10, 50), 1627.87 + math.random(10, 50), 41.52, 21, 500.0, true, false, true)

        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = 2704.26, y = 1663.50, z = 41.52},
            "Voisin inquiet\n J'ai entendu une explosion pres du transformateur!"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = 2704.26, y = 1663.50, z = 41.52},
            "Voisin inquiet\n J'ai entendu une explosion pres du transformateur!"
        )

        Wait(500)

        AddExplosion(2441.11 + math.random(10, 50), 1587.61 + math.random(10, 50), 33.02, 6, 500.0, true, false, true)
        AddExplosion(2441.11 + math.random(10, 50), 1587.61 + math.random(10, 50), 33.02, 10, 500.0, true, false, true)
        AddExplosion(2441.11 + math.random(10, 50), 1587.61 + math.random(10, 50), 33.02, 21, 500.0, true, false, true)
        AddExplosion(2441.11 + math.random(10, 50), 1587.61 + math.random(10, 50), 33.02, 23, 500.0, true, false, true)

        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = 2441.11, y = 1587.61, z = 33.02},
            "Voisin inquiet\n J'ai entendu une explosion pres du transformateur!"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = 2441.11, y = 1587.61, z = 33.02},
            "Voisin inquiet\n J'ai entendu une explosion pres du transformateur!"
        )

        Wait(500)

        local coords = vector3(2269.51, 2970.75, 46.87)

        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            6,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            10,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            21,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            23,
            500.0,
            true,
            false,
            true
        )

        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion pres du transformateur de sandyshore!"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion pres du transformateur de sandyshore!"
        )

        Wait(500)

        local coords = vector3(971.22, 2724.96, 39.28)

        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            6,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            10,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            21,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            23,
            500.0,
            true,
            false,
            true
        )

        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion route 68!"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion route 68!"
        )

        Wait(500)

        local coords = vector3(1864.01, 3771.74, 32.94)

        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            6,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            10,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            21,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            23,
            500.0,
            true,
            false,
            true
        )

        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion a sandyshore!"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion a sandyshore!"
        )

        Wait(500)

        local coords = vector3(268.06, -741.8, 38.99)

        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            6,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            10,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            21,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            23,
            500.0,
            true,
            false,
            true
        )

        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion a place des cubes!"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion a place des cubes!"
        )

        Wait(500)

        local coords = vector3(-47.53, -1060.72, 35.76)

        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            6,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            10,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            21,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            23,
            500.0,
            true,
            false,
            true
        )

        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion au PDM!"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion au PDM!"
        )

        Wait(500)

        local coords = vector3(-1147.72, -781.98, 36.37)

        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            6,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            10,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            21,
            500.0,
            true,
            false,
            true
        )
        AddExplosion(
            coords.x + math.random(10, 50),
            coords.y + math.random(10, 50),
            coords.z,
            23,
            500.0,
            true,
            false,
            true
        )

        TriggerServerEvent(
            "call:makeCall2",
            "police",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion a Vespucci!"
        )
        TriggerServerEvent(
            "call:makeCall2",
            "lssd",
            {x = coords.x, y = coords.y, z = coords.z},
            "Voisin inquiet\n J'ai entendu une explosion a Vespucci!"
        )

        TriggerServerEvent("sv:stopLights")
    end
)

RegisterNetEvent("stopCooperScenario")
AddEventHandler(
    "stopCooperScenario",
    function()
        SetArtificialLightsState(false)
    end
)
