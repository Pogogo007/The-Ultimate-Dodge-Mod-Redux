Scriptname UDBattleStart extends activemagiceffect  

spell Property UDBattleReadySpell Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.Addspell(UDBattleReadySpell)
endEvent