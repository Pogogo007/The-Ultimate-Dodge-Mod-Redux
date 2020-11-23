Scriptname UDDisableDynamicDodgeScript extends activemagiceffect  

spell property UDPlayerDynamicDodgingSpell auto
spell property UDPlayerDynamicDodgingGiantSpell auto

event OnEffectStart(Actor akTarget, Actor AkCaster)
	akTarget.removeSpell(UDPlayerDynamicDodgingSpell)
	akTarget.removeSpell(UDPlayerDynamicDodgingGiantSpell)
endEvent