local HasAlreadyEnteredMarker = false
local LastZone                = nil
local ActionMsg               = nil
Zone = setmetatable({}, Blips)
Zone.Data = {}


function Zone:Add(Pos,Enter,Exit,i,range)
    table.insert( self.Data, {Pos=Pos,Enter=Enter,Exit=Exit,i=i,range=range} )
end
function Zone:Remove(Pos)
	for i = 1 ,#self.Data,1 do
		if self.Data[i].Pos == Pos then
			self.Data[i].Exit()
			table.remove(self.Data,i)
			break
		end
	end
end


function Zone:RemoveFromName(Name)
	for i = 1 ,#self.Data,1 do
		if self.Data[i].Name == Name then
			self.Data[i].Exit()
			table.remove(self.Data,i)
			break
		end
	end
end


Citizen.CreateThread(function()
	Wait(1500)
	while true do
		Wait(0)
        local coords      = LocalPlayer().Position
		local isInMarker  = false
		local currentZone = nil
        local self = Zone
        local totalNo = 0
        for i = 1 , #self.Data,1 do
			v = self.Data[i]
			if v.Pos ~= nil then
				if(GetDistanceBetween3DCoords(coords.x,coords.y,coords.z, v.Pos.x, v.Pos.y, v.Pos.z, false) < v.range) then
					isInMarker  = true
					currentZone = i
					LastZone    = i
				else
					totalNo = totalNo + 1
				end
			end

		end
		local i =currentZone
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
	--		--print("entering zone ", self.Data[i].i, self.Data[i].range)
			self.Data[i].Enter(self.Data[i].i)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			
			self.Data[LastZone].Exit()
		end

	end
end)


Hint = setmetatable({}, Hint)

function Hint:RemoveAll()
    ActionMsg = nil
end


function Hint:Set(txt)
    ActionMsg = txt
end


Citizen.CreateThread(function()
    while true do
        Wait(1)
        if ActionMsg ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(ActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
        end
    end
end)