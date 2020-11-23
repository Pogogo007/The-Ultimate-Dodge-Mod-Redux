Scriptname UDPlayerDynamicDodgeGiant extends activemagiceffect  

spell property UDPlayerDynamicDodgingGiantSpell auto
actor property PlayerRef auto
globalvariable property UDDodgeStyle auto
form property UDLargeEnemyCount auto
form property UDAllEnemyCount auto

UDActivationScript property UDActivationQuest auto

actor player
actor enemy

int DodgeStyle
int DodgeID
bool Counted = false


;------------------------------------------------------------- Events -------------------------------------------------------------

event OnEffectStart(Actor akTarget, Actor akCaster)
	enemy = akTarget
	player = PlayerRef
	dodgeStyleCheck()
	PreSpellPlayerDetected()
endEvent

event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	goToState("HitPause")
	if(akAggressor == player)
		player.setAnimationVariableInt("DodgeID", 0)
		DodgeID = 0
		CountCheck()
	endIf
	UDActivationQuest.dodgeSpeedCheck(DodgeID)
	utility.wait(2)
	goToState("HitResume")
endEvent

event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	Counted = true
	CombatEnterCheck()
	unregisterForLOS(enemy, player)
endEvent

event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if(aeCombatState != 0) && (akTarget == player) && (Counted == false)
		Counted = true
		CombatEnterCheck()
	elseIf(aeCombatState == 0) && (Counted == true)
		Counted = false
		CombatOutCheck()
	elseIf(aeCombatState != 0) && (Counted == false) && (akTarget != player) && (enemy.isHostileToActor(player))
		registerForLOS(enemy, player)
	elseIf(aeCombatState == 0) && (Counted == false) && (enemy.isHostileToActor(player))
		unregisterForLOS(enemy, player)
	endIf
endEvent

event OnDying(Actor akKiller)
	goToState("Dying")
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	if(Counted == true)
		player.removeItem(UDLargeEnemyCount, 1, true)
		player.removeItem(UDAllEnemyCount, 1, true)
	endIf
endEvent

event OnUnload()
	if(Counted == true)
		player.removeItem(UDLargeEnemyCount, 1, true)
		player.removeItem(UDAllEnemyCount, 1, true)
		int newLargeEnemyCount= player.getItemCount(UDLargeEnemyCount)
		int newAllEnemyCount = player.getItemCount(UDAllEnemyCount)
		UDActivationQuest.reEnemyCheck(newAllEnemyCount, newLargeEnemyCount)
	endIf
endEvent


;------------------------------------------------------------- States -------------------------------------------------------------

state HitPause
	event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)

	endEvent
endState

state Only1
	event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	endEvent

	event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	endEvent
endState

state Dying
	event OnUpdate()
	endEvent

	function CountCheck()	
	endFunction

	function RemoveSpell()
		DodgeStyle = 0
		DodgeID = 0
		Counted = None
		utility.wait(0.5)
		enemy.removeSpell(UDPlayerDynamicDodgingGiantSpell)
	endFunction
endState


;------------------------------------------------------------- In Functions -------------------------------------------------------------

function DodgeStyleCheck()
	int newDodgeStyle = UDDodgeStyle.getValueInt()
	if(newDodgeStyle == 0) && (DodgeStyle != 0)
		DodgeStyle = 0
		goToState("Giant")
	elseIf(newDodgeStyle != 0) && (DodgeStyle != UDDodgeStyle.getValueInt())
		DodgeStyle = UDDodgeStyle.getValueInt()
		goToState("Only1")
	endIf
endFunction

function CombatEnterCheck()
	player.addItem(UDLargeEnemyCount, 1, true)
	player.addItem(UDAllEnemyCount, 1, true)
	int newLargeEnemyCount= player.getItemCount(UDLargeEnemyCount)
	int newAllEnemyCount = player.getItemCount(UDAllEnemyCount)
	UDActivationQuest.reEnemyCheck(newAllEnemyCount, newLargeEnemyCount)
endFunction

function CombatOutCheck()
	player.removeItem(UDLargeEnemyCount, 1, true)
	player.removeItem(UDAllEnemyCount, 1, true)
	int newLargeEnemyCount= player.getItemCount(UDLargeEnemyCount)
	int newAllEnemyCount = player.getItemCount(UDAllEnemyCount)
	UDActivationQuest.reEnemyCheck(newAllEnemyCount, newLargeEnemyCount)
	utility.wait(0.5)
	RemoveSpell()
endFunction

function CountCheck()
	if(Counted == false)
		Counted = true
		CombatEnterCheck()
	endIf
endFunction

function PreSpellPlayerDetected()
	if(enemy.getCombatState() != 0) && (enemy.isHostileToActor(player)) && (player.isDetectedby(enemy))
		Counted = true
		CombatEnterCheck()
	elseIf(enemy.getCombatState() != 0) && (enemy.isHostileToActor(player)) && (player.isDetectedby(enemy) == false)
		registerForLOS(enemy, player)
	endIf
endFunction

function RemoveSpell()
endFunction