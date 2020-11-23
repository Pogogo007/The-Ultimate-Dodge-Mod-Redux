Scriptname UDPlayerDynamicDodging extends activemagiceffect  

actor property PlayerRef auto

spell property UDPlayerDynamicDodgingSpell auto
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
		player.setAnimationVariableInt("DodgeID", 1)
		DodgeID = 1
		CountCheck()
		UDActivationQuest.dodgeSpeedCheck(1)
	endIf
	utility.wait(2)
	goToState("HitResume")
endEvent

event OnGainLOS(Actor akViewer, ObjectReference akTarget)
	Counted = true
	CombatEnterCheck()
	unregisterForLOS(enemy, player)
endEvent

event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if(aeCombatState != 0) && (Counted == false) && (akTarget == player)
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
	utility.wait(0.5)
	goToState("Dying")
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	if(Counted == true)
		player.removeItem(UDAllEnemyCount, 1, true)
	endIf
endEvent

event OnUnload()
	if(Counted == true)
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
	event OnEffectFinish(Actor akTarget, Actor akCaster)
	endEvent

	function CountCheck()
	endFunction

	function RemoveSpell()
		DodgeStyle = 0
		DodgeID = 0
		Counted = None
		utility.wait(0.5)
		enemy.removeSpell(UDPlayerDynamicDodgingSpell)
	endFunction
endState


;------------------------------------------------------------- In Functions -------------------------------------------------------------

function DodgeStyleCheck()
	int newDodgeStyle = UDDodgeStyle.getValueInt()
	if(newDodgeStyle == 0) && (DodgeStyle != 0)
		goToState("RollandSidestep")
	elseIf(newDodgeStyle != 0) && (DodgeStyle != UDDodgeStyle.getValueInt())
		DodgeStyle = UDDodgeStyle.getValueInt()
		goToState("Only1")
	endIf
endFunction

function CountCheck()
	if(Counted == false) && (enemy.getCombatState() != 0)
		Counted = true
		CombatEnterCheck()
	endIf
endFunction

function CombatEnterCheck()
	player.addItem(UDAllEnemyCount, 1, true)
	int newLargeEnemyCount= player.getItemCount(UDLargeEnemyCount)
	int newAllEnemyCount = player.getItemCount(UDAllEnemyCount)
	if(newAllEnemyCount == 1)
		UDActivationQuest.reEnemyCheck(newAllEnemyCount, newLargeEnemyCount)
	endIf
endFunction

function CombatOutCheck()
	player.removeItem(UDAllEnemyCount, 1, true)
	int newLargeEnemyCount= player.getItemCount(UDLargeEnemyCount)
	int newAllEnemyCount = player.getItemCount(UDAllEnemyCount)
	UDActivationQuest.reEnemyCheck(newAllEnemyCount, newLargeEnemyCount)
	utility.wait(1)
	RemoveSpell()
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