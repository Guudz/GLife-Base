-- EDIT ELEVATOR COORDS / TELEPORTER COORDS HERE
local asc1 = vector3(-1096.333, -850.42, 18.001)
local asc2 = vector3(-1096.324,-850.201,22.039)
local asc3 = vector3(-1096.248,-850.204,25.828)
local asc4 = vector3(-1096.256,-850.175,29.757)
local asc5 = vector3(-1095.953,-850.642,33.361)
local asc6 = vector3(-1096.218,-850.208,37.243)
local ascm3 = vector3(-1096.081,-850.467,12.687)
local ascm2 = vector3(-1096.075,-850.597,9.277)
local ascm1 = vector3(-1096.106,-850.554,3.884)

-- EDIT PED HEADING HERE
local rota = 35.0

RMenu.Add('casino_enter', 'casino', RageUI.CreateMenu("", "",0,100,"shopui_title_casino", "shopui_title_casino"))

-- EDIT MENU TITLE HERE
RMenu:Get('casino_enter', 'casino'):SetSubtitle("~b~Ascenseur")

function showAsc(flag)
    RageUI.Visible(RMenu:Get('casino_enter', 'casino'), flag)
end

-- EDIT EACH TAB TITLE HERE, FOR EACH "Rageui.Button" LINE
RageUI.CreateWhile(1.0, true, function()
    if RageUI.Visible(RMenu:Get('casino_enter', 'casino')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()           
            RageUI.Button("~o~[6]~s~ Helipad", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),asc6.x,asc6.y,asc6.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

            RageUI.Button("~o~[5]~s~ Bureau Capitaine", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),asc5.x,asc5.y,asc5.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

            RageUI.Button("~o~[4]~s~ Centre d'opération", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),asc4.x,asc4.y,asc4.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

            RageUI.Button("~o~[3]~s~ Salle de Briefing et Gym", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),asc3.x,asc3.y,asc3.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

            RageUI.Button("~o~[2]~s~ Cafétéria", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),asc2.x,asc2.y,asc2.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

            RageUI.Button("~o~[L]~s~ Hall d'entrée", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),asc1.x,asc1.y,asc1.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

            RageUI.Button("~o~[-3]~s~ Armurerie et Garage", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),ascm3.x,ascm3.y,ascm3.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

            RageUI.Button("~o~[-2]~s~ Pièce à conviction", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),ascm2.x,ascm2.y,ascm2.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

            RageUI.Button("~o~[-1] ~s~ Cellules et interrogatoires", "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                if (Hovered) then

                end
                if (Active) then

                end
                if (Selected) then
                    DoScreenFadeOut(500)
                    Citizen.Wait(500)
                    SetEntityCoords(GetPlayerPed(-1),ascm1.x,ascm1.y,ascm1.z)
                    SetEntityHeading(GetPlayerPed(-1), rota)
                    DoScreenFadeIn(500)
                    Citizen.Wait(500)
                end
            end)

        end, function()
            ---Panels
        end)
    else
		Citizen.Wait(1000)
	end
end, 1)

fols = true
lwin = false

-- INIT AS DIST=10, TO PREVENT LONG WAIT IN CASE YOU SPAWN INSIDE VESPUCCI PD
dAsc1 = 10
dAsc2 = 10
dAsc3 = 10
dAsc4 = 10
dAsc5 = 10
dAsc6 = 10
dAsc7 = 10
dAsc8 = 10
dAsc9 = 10

-- CHECK COORDS, OPEN MENU IF PED IS IN A 1.5 RADIUS WITHIN ELEVATOR, ELSE IT FREEZES THE LOOP DEPENDING ON DISTANCE
Citizen.CreateThread(function()
    while true do 
        if dAsc1 < 1.5  then
            fols = false 
            showAsc(true)
        elseif dAsc2 < 1.5 then
            fols = false
            showAsc(true)
        elseif dAsc3 < 1.5 then
            fols = false
            showAsc(true)
        elseif dAsc4 < 1.5 then
            fols = false
            showAsc(true)
        elseif dAsc5 < 1.5 then
            fols = false
            showAsc(true)
        elseif dAsc6 < 1.5 then
            fols = false
            showAsc(true)
        elseif dAsc7 < 1.5 then
            fols = false
            showAsc(true)
        elseif dAsc8 < 1.5 then
            fols = false
            showAsc(true)
        elseif dAsc9 < 1.5 then
            fols = false
            showAsc(true)
		-- IF OUTSIDE COORDS, THEN CLOSE MENU
        elseif not fols then
            fols = true
            showAsc(false)
        elseif lwin then
            Wait(duree)
        end
        Wait(0)
    end
end)

-- CHECK IF PLAYER IS NEAR VESPUCCI PD, ONLY CHECK ONE ELEVATOR, OTHER ONES NOT NEEDED
Citizen.CreateThread(function()
    while true do

        local playerCoords = GetEntityCoords(GetPlayerPed(-1))

        dAsc1 = #(playerCoords-asc1)
        dAsc2 = #(playerCoords-asc2)
        dAsc3 = #(playerCoords-asc3)
        dAsc4 = #(playerCoords-asc4)
        dAsc5 = #(playerCoords-asc5)
        dAsc6 = #(playerCoords-asc6)
        dAsc7 = #(playerCoords-ascm3)
        dAsc8 = #(playerCoords-ascm2)
        dAsc9 = #(playerCoords-ascm1)

		-- PLAYER IS INSIDE VESPUCCI PD
        if dAsc1 < 50 then
            lwin = false
        end
		
		-- PLAYER IS OUTSIDE VESPUCCI PD
        if dAsc1 > 50 then
            duree = 3000
			lwin = true
			
			-- INCREASE WAIT TIME DEPENDING ON DISTANCE, USED LINE 238
            if dAsc1 > 200 then
                if dAsc1 > 500 then
                    duree = 30000
                    Wait(30000)
                else
                    duree = 15000
                    Wait(15000)
                end
            else
                Wait(3000)
            end
        end

        Wait(1000)
    end
end)