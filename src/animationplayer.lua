-- W.I.P Anim player
local animationplayer = {}
animationplayer.__index = animationplayer

function animationplayer.new()
	local self = setmetatable({}, animationplayer)
	
	self.playing = false
	self.frame = 1
	self.paused = false -- NOT USED YET
	self.loop = false -- NOT USED YET
	
	self._activethread = nil
	
	return self
end

function animationplayer:play(animationobject,data)
	print(self.frame)
	self.playing = true
	
	-- Yes this is an ugly animation player, no I don't care
	while (self.playing == true) do
		local k1 = animationobject.animmodule[animationobject.name][self.frame] -- Current keyframe
		local k2 = animationobject.animmodule[animationobject.name][self.frame+1] -- Next keyframe
		local k1time
		local k2time
		local dur

		if (not k1) then
			self:stop()
			break
		end

		for _,var in (k1) do
			if (typeof(var) == "table") then
				k1time = var[3]
			end
		end

		if (k2) then
			for _,var in (k2) do
				if (typeof(var) == "table") then
					k2time = var[3]
				end
			end
		end

		if (k2time) then
			dur = k2time - k1time
		else
			dur = k1time
		end

		local adjusteddur = dur * animationobject.basespeed

		animationobject:playkeyframe(data.rig,self.frame,data.baseC0s)
		task.wait(adjusteddur)

		self.frame += 1
	end
end

function animationplayer:stop()
	print("broken")
	self.playing = false
	self.frame = 1
	
	if (self._activethread) then
		task.cancel(self._activethread)
		self._activethread = nil
	end
end

return animationplayer
