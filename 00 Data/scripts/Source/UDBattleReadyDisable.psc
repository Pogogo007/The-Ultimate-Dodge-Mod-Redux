Scriptname UDBattleReadyDisable extends activemagiceffect  

spell property UDBattleReadySpell auto

event OnEffectStart(Actor akTarget, Actor AkCaster)
	akTarget.removeSpell(UDBattleReadySpell)
endEvent