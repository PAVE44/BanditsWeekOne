local scriptItem = getScriptManager():getItem("Base.CorpseFemale")
if scriptItem then
	scriptItem:DoParam("StaticModel = PA_Corpse")
	scriptItem:DoParam("primaryAnimMask = HoldingTorchRight")
	scriptItem:DoParam("secondaryAnimMask = HoldingTorchLeft")
end

local scriptItem = getScriptManager():getItem("Base.CorpseMale")
if scriptItem then
	scriptItem:DoParam("StaticModel = PA_Corpse")
	scriptItem:DoParam("primaryAnimMask = HoldingTorchRight")
	scriptItem:DoParam("secondaryAnimMask = HoldingTorchLeft")
end
