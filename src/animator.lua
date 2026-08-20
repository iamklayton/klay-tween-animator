-- W.I.P version of the total rewrite
local animator = {}
animator.__index = animator

-- Animation definition, think of it as Roblox's Animation objects.
function animator.new(animmodule,animname,basespeed)
	local self = setmetatable({}, animator)

	self.animmodule = require(animmodule)
	self.name = animname
	self.basespeed = basespeed

	return self
end

-- Playing a specific keyframe on a specific rig
function animator:playkeyframe(rig,keyframe,baseC0s)
	print(rig.Name.." "..self.name.." "..tostring(keyframe))
	
	local animdata = {
		direction = nil,
		style = nil,
	}
	-- Finding the variables inside the table because Luau tables are returned in an unpredictable order which ruins the variable-nameless thing
	for _,var in (self.animmodule[self.name][keyframe]) do
		if ((typeof(var) == "EnumItem") and var:IsA("EasingDirection")) then
			animdata.direction = var
		end
		if ((typeof(var) == "EnumItem") and var:IsA("EasingStyle")) then
			animdata.style = var
		end
	end
	
	--print(self.animmodule)
	
	-- Pose loop
	for _,poseweld in (self.animmodule[self.name][keyframe]) do
		if (typeof(poseweld) ~= "table") then
			continue
		end
		
		local k1 = self.animmodule[self.name][keyframe] -- Current keyframe
		local k2 = self.animmodule[self.name][keyframe+1] -- Next keyframe
		local k1time
		local k2time
		local dur -- Duration of the tween
		
		-- Finding the weld that will be animated (if it has one to begin with)
		local weld = rig.welds:FindFirstChild(poseweld[1])

		-- If it doesn't, then leave it behind like the GRE leaving Rais' brother behind
		if (not weld) then
			continue
		end
		
		-- A bunch of duration math stuff idk I was not mentally there when writing this
		for _,var in (k1) do
			if (typeof(var) == "table" and var[1] == weld.Name) then
				k1time = var[3]
			end
		end
		
		if (k2) then
			for _,var in (k2) do
				if (typeof(var) == "table" and var[1] == weld.Name) then
					k2time = var[3]
				end
			end
		end
		
		-- The "keyframe > 1" bit is so you can do instant initial poses (e.g viewmodel arms being at the bottom during the beginning of an equip anim)
		if (k2time and keyframe > 1) then
			dur = k2time - k1time
		else
			dur = k1time
		end
		print(dur)
		
		local tweeninfo = TweenInfo.new(dur * self.basespeed,animdata.style,animdata.direction)
		
		local transform = poseweld[2]
		local baseC0 = baseC0s[weld.Name] -- BaseC0 is from the ORIGINAL position of the C0, NOT from the last keyframe.
		local targetC0 = baseC0 * transform
		
		game.TweenService:Create(weld,tweeninfo,{C0 = targetC0}):Play()
		
		--print(poseweld)
	end
	-- TODO: Animation events
end

-- Small testing function in case you think your animation definitions aren't working.
function animator:test()
	print(self)
end

return animator
