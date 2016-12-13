return Def.ActorFrame{
	LoadActor("text.png")..{
		InitCommand=function(self)
			self:Center()
			:sleep(0.308):diffusealpha(0):sleep(0.308):diffusealpha(1):sleep(0.308):diffusealpha(0)
		end
	};
}
