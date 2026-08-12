local animator = {}
animator.__index = animator

-- Animation definition, think of it as Roblox's Animation objects.
function animator.new(animfolder,animname,basespeed)
	local self = setmetatable({}, animator)

	self.animfolder = animfolder
	self.name = animname
	self.basespeed = basespeed

	return self
end

-- Playing a specific keyframe on a specific rig
function animator:playkeyframe(rig,keyframe)
	print(rig.Name.." "..self.animfolder.Name.." "..tostring(keyframe))

	-- Data from the keyframe
	local animdata = {
		speed = self.animfolder[keyframe]:GetAttribute("speed"), -- How long it takes for the tween to be completed
		direction = Enum.EasingDirection[self.animfolder[keyframe]:GetAttribute("direction")] -- What easing direction it should use
	}
	
	-- Sine makes movement more alive and the InOut easing direction is recommended for most animations. dzielnica does the exact same.
	local tweeninfo = TweenInfo.new(animdata.speed / self.basespeed,Enum.EasingStyle.Sine,animdata.direction)

	-- Pose detection
	for _,posepart in ipairs(self.animfolder[keyframe]:GetChildren()) do

		if (not posepart:IsA("BasePart")) then
			continue
		end

		local realpart = rig:FindFirstChild(posepart.Name)

		-- Make sure the part exists and isn't a specific important part (like the fucking HumanoidRootPart)
		if (not realpart or (realpart.Name == "HumanoidRootPart")) then
			continue
		end

		-- Finding the weld that will be animated (if it has one to begin with)
		local weld = rig.welds:FindFirstChild(posepart.Name)

		-- If it doesn't, then leave it like the GRE leaving Rais' brother behind
		if (not weld) then
			continue
		end


		-- Calculating the target C0 position
		local parentpose = posepart.Parent[weld.Part0.Name]
		local targetC0 = posepart.CFrame:ToObjectSpace(parentpose.CFrame):Inverse()weld.C1 = CFrame.identity

		-- Finally tweening the C0 to match the target C0 position
		game.TweenService:Create(weld,tweeninfo,{C0 = targetC0}):Play()
	end
	for _,event in ipairs(self.animfolder[keyframe]:GetChildren()) do
		-- Nothing actually fires it, the icon for BindableEvents just looks nice for animation events/markers
		if event:IsA("BindableEvent") then
			local eventdata = {
				name = event:GetAttribute("name"),
				delay = event:GetAttribute("delay"),
				data = event:GetAttribute("data"),
			}
			
			-- Whatever you wanna use for passing the event to the client
		end
	end
end

-- Small testing function in case you think your animation definitions aren't working.
function animator:test()
	print(self)
end

return animator
