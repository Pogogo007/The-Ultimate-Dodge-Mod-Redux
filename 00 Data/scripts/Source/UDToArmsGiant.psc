Scriptname UDToArmsGiant extends activemagiceffect   

spell Property UDPlayerDynamicDodgingGiantSpell Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.Addspell(UDPlayerDynamicDodgingGiantSpell)
endEvent