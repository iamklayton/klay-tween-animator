-- Note to anyone who will use this system: Please don't make a play function in here, the animations are meant to be client-sided
-- and this system is meant to give the BARE MINIMUM for Tween animations which means no bloat.
-- So just make the animation playing be done by the client calling PlayKeyframe() within its own play func.
-- This is mostly meant to be used for R6 animations with Welds rather than Motor6Ds, but you should be able to get it working
-- on viewmodels and/or R15 rigs if you use enough force.
-- Mostly meant to be used with Chickynoid, but I tried to make it as universal as possible.
local Animator = {}
Animator.__index = Animator

-- Animation definition, think of it as Roblox's Animation objects.
function Animator.new(animfolder,animname,basespeed)
	local self = setmetatable({}, Animator)
	
	self.animfolder = animfolder
	self.name = animname
	self.basespeed = basespeed -- No actual base speed yet lmao
	
	return self
end

-- TODO: Base animation speed and making the keyframes have their own speed instead of having the same speed
function Animator:PlayKeyframe(rig,keyframe)
	print(rig.Name.." "..self.animfolder.Name.." "..tostring(keyframe))
	
	local tweeninfo = TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.In)
	
	-- Pose detection
	for _,PosePart in ipairs(self.animfolder[keyframe]:GetChildren()) do
		
		if (not PosePart:IsA("BasePart")) then
			continue
		end
		
		local realpart = rig:FindFirstChild(PosePart.Name)

		-- Make sure the part exists and isn't a specific important part (like the fucking HumanoidRootPart)
		if (not realpart or (realpart.Name == "HumanoidRootPart")) then
			continue
		end
		
		-- Finding the weld that will be animated (if it has one to begin with)
		local weld = rig.welds:FindFirstChild(PosePart.Name)
		
		-- If it doesn't, then leave it like the GRE leaving Rais' brother behind
		if (not weld) then
			continue
		end
		
		
		-- Calculating the target C0 position
		local parentPose = PosePart.Parent[weld.Part0.Name]
		local targetC0 = PosePart.CFrame:ToObjectSpace(parentPose.CFrame):Inverse()weld.C1 = CFrame.identity
		
		-- Finally tweening the C0 to match the target C0 position
		game.TweenService:Create(weld,tweeninfo,{C0 = targetC0}):Play()
	end
	-- TODO: Animation event detection
end

-- Small testing function in case you think your animation definitions aren't working.
function Animator:Test()
	print(self)
end

return Animator
