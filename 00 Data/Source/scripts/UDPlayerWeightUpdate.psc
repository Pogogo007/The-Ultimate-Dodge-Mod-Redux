Scriptname UDPlayerWeightUpdate extends activemagiceffect  

actor property PlayerRef auto

spell property UDPlayerWeightUpdateSpell auto

UDActivationScript property UDActivationQuest auto

event OnEffectStart(actor akTarget, actor akCaster)
	utility.wait(0.5)
	UDActivationQuest.weightCheck()
	playerRef.removeSpell(UDPlayerWeightUpdateSpell)
endEvent