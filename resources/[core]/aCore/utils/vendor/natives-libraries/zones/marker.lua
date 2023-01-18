Marker = setmetatable({}, Marker)
Marker.Data = {}

function Marker:Add(Pos,Data)
    table.insert( self.Data, {pos=Pos,data=Data})
end
function Marker:Visible(Pos,Visible)
	for i = 1 , #self.Data,1 do
		if self.Data[i].pos == Pos then
			self.Data[i].data.visible = Visible
			break
		end
	end
end
function Marker:Remove(Pos)
	for i = 1 , #self.Data , 1 do
		if self.Data[i].pos == Pos then
			table.remove(self.Data ,i)
			break
		end
	end
end




-- Citizen.CreateThread(function()
-- 	Wait(1000)
-- 	while true do
-- 		Wait(1000)
-- 		for i = 1 ,#Marker.Data , 1 do
-- 			Wait(10)
-- 			local o = Marker.Data[i]
-- 			local t = LocalPlayer().Pos
-- 			if Marker.Data[i].data ~= nil  then
-- 				if GetDistanceBetween3DCoords(o.pos.x, o.pos.y, o.pos.z, t.x,t.y,t.z, true) < 50.0 then
-- 					--Marker.Data[i].data.visible = true
-- 					Marker:Visible(o.pos,true)
-- 				else
-- 					Marker:Visible(o.pos,false)
-- 				end
-- 			end
-- 		end
-- 	end
-- end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for i = 1 ,#Marker.Data , 1 do
			local o = Marker.Data[i]
			local t = LocalPlayer().Pos
			if Marker.Data[i].data ~= nil and Marker.Data[i].data.visible and Marker.Data[i].pos ~= nil then	
				DrawMarker(o.data.type, o.pos.x, o.pos.y, o.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, o.data.scale.x, o.data.scale.y, o.data.scale.z, o.data.color.r, o.data.color.g, o.data.color.b, o.data.color.a, o.data.Up, o.data.Cam, nil, o.data.Rotate, nil, nil, nil)
			end
		end
	end
end)