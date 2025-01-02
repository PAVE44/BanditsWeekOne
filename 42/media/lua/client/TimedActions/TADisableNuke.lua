require "TimedActions/ISBaseTimedAction"

TADisableNuke = ISBaseTimedAction:derive("TADisableNuke");

function TADisableNuke:isValid()
	return true
end

function TADisableNuke:update()
end

function TADisableNuke:start()
    self.character:faceThisObject(self.square:getN())
	self:setActionAnim("Loot")
    self.sound = self.character:playSound("ZSCompProgress")

end

function TADisableNuke:stop()
    self.character:stopOrTriggerSound(self.sound)
	ISBaseTimedAction.stop(self)
end

function TADisableNuke:perform()
    self.character:stopOrTriggerSound(self.sound)
    local emitter = getWorld():getFreeEmitter(5572, 12486, 0)
    emitter:playSound("ZSCompSuccess")
    BWOSquareLoader.nukes = {}
    BWOEmitter.tab = {}

	ISBaseTimedAction.perform(self)
end


function TADisableNuke:new(character, square)
	local o = {}
	setmetatable(o, self)
	self.__index = self

    o.character = character
    o.stopOnWalk = true
    o.stopOnRun = true
    o.maxTime = 600
    o.square = square
	return o
end

return TAHeal;
