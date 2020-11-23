Scriptname UDNPCDodgeAICore extends Quest  

actor property PlayerRef auto

globalvariable property UDNPCDodgeAIGlobal auto
globalvariable property UDDodgeStyle auto
globalvariable property UDDodgeDynamicPause auto

spell property UDCallToArmsSpell auto
spell property UDCallToArmsDispelSpell auto
spell property UDBattleStartDispelSpell auto
spell property UDPlayerCombatDetectSpell auto
spell property UDPlayerInventoryFlowSpell auto


;------------------------------------------------------------- Events -------------------------------------------------------------

event OnUpdate()
	playerRef.addSpell(UDCallToArmsDispelSpell, false)
	playerRef.addspell(UDBattleStartDispelSpell, false)
	playerRef.removespell(UDPlayerCombatDetectSpell)
	playerRef.removespell(UDPlayerInventoryFlowSpell)
	utility.wait(0.5)
	playerRef.addspell(UDPlayerCombatDetectSpell, false)
	playerRef.addspell(UDPlayerInventoryFlowSpell, false)
	playerRef.removeSpell(UDCallToArmsDispelSpell)
	playerRef.removespell(UDBattleStartDispelSpell)
	BattleReady()
endEvent

;------------------------------------------------------------- In Functions -------------------------------------------------------------

function BattleReady()
	playerRef.addSpell(UDCallToArmsSpell, false)
	utility.wait(1)
	playerRef.removeSpell(UDCallToArmsSpell)
endFunction

function MCMAIUpdate()
	int DodgeStyle = UDDodgeStyle.getValueInt()
	int DodgeAI = UDNPCDodgeAIGlobal.getValueInt()
	if(DodgeAI == 0) && (DodgeStyle == 0)
		goToState("AIDisabled")
	elseIf(DodgeAI == 1) && (DodgeStyle == 0)
		goToState("AllEnabled")
	elseIf(DodgeAI == 0) && (DodgeStyle != 0)
		goToState("AllDisabled")
	elseIf(DodgeAI == 1) && (DodgeStyle != 0)
		goToState("DynamicDisabled")
	endIf
	UDDodgeDynamicPause.setValueInt(0)
endFunction

function MCMDodgeStyleRefresh()
	registerForSingleUpdate(0.1)
endFunction

function MCMDodgeStyleToggle(bool combat)	
	if(playerRef.getAnimationVariableInt("IsDodging") == 0)
		if(combat == true)
			if(UDNPCDodgeAIGlobal.getValueInt() == 1)
				goToState("DynamicDisabled")
			else
				goToState("AllDisabled")
			endIf
			UDDodgeDynamicPause.setValueInt(1)
		else
			MCMAIUpdate()
		endIf
		registerForSingleUpdate(0.1)
	endIf
endFunction

;------------------------------------------------------------- States -------------------------------------------------------------

state AIDisabled
	function BattleReady()
		playerRef.addSpell(UDCallToArmsSpell, false)
		playerRef.addspell(UDBattleStartDispelSpell, false)
		utility.wait(1)
		playerRef.removeSpell(UDCallToArmsSpell)
		playerRef.removespell(UDBattleStartDispelSpell)
	endFunction
endState

state DynamicDisabled
	function BattleReady()
		playerRef.addSpell(UDCallToArmsSpell, false)
		playerRef.addspell(UDCallToArmsDispelSpell, false)
		utility.wait(1)
		playerRef.removeSpell(UDCallToArmsSpell)
		playerRef.removeSpell(UDCallToArmsDispelSpell)
	endFunction
endState

state AllDisabled
	function BattleReady()
		playerRef.addSpell(UDCallToArmsDispelSpell, false)
		playerRef.addSpell(UDBattleStartDispelSpell, false)
		utility.wait(1)
		playerRef.removeSpell(UDCallToArmsDispelSpell)
		playerRef.removeSpell(UDBattleStartDispelSpell)
	endFunction
endState