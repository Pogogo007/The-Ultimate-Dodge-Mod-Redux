Scriptname UDToArms extends activemagiceffect  

spell Property UDPlayerDynamicDodgingSpell Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.Addspell(UDPlayerDynamicDodgingSpell)
endEvent