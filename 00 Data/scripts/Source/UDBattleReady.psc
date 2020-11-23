Scriptname UDBattleReady extends activemagiceffect  

actor property PlayerRef auto

keyword property ArmorHeavy auto

idle property DodgeRollNPC auto

spell property UDRollZeroStaminaDamage auto
spell property UDBattleReadySpell auto
spell property UDSKSEBattleReadySpell auto

globalvariable property UDIFrameR auto
globalvariable property UDIFrameS auto
globalvariable property UDStaminaCostR auto
globalvariable property UDStaminaCostS auto
globalvariable property UDDodgeStyle auto
globalvariable property UDSneakStyle auto
globalvariable property UDSKSEDetect auto
globalvariable property UDNPCIFrameGlobal auto
globalvariable property UDNPCDodgeFrequencyGlobal auto

UDActivationScript property UDActivationQuest auto
UDNPCDodgeAICore property UDNPCDodgeAIQuest auto

actor enemy
actor player
float distance
float dagger = 300.00
float unarmed = 130.00
float shield = 200.00
float onehanded = 350.00
float twohanded = 400.00
float IFrameR
float IFrameS
int chance6
int chance16
int frequency1
int frequency2
int frequency3
int staminacost
int pseudorandom16 = 16
int pseudorandom6 = 6
int StaminaCostR
int StaminaCostS
int NPCIFrame = 0
bool registered = false


;------------------------------------------------------------- Events -------------------------------------------------------------

event OnEffectStart(actor akTarget, actor akCaster)
	enemy = akTarget
	player = PlayerRef
	frequency1 = UDNPCDodgeFrequencyGlobal.getValueInt() + 1
	frequency2 = UDNPCDodgeFrequencyGlobal.getValueInt() + 2
	frequency3 = UDNPCDodgeFrequencyGlobal.getValueInt() + 3
	chance16 = utility.randomint(0, pseudorandom16)
	chance6 = utility.randomint(0, pseudorandom6)
	if(enemy.getCombatState() != 0)
		NPCUpdate()
		registerAnimationEvent()
	endIf
endEvent

event OnAnimationEvent(objectreference akSource, string asEventName)
	goToState("Dodging"+ NPCIFrame)
	if(akSource == player) && (enemy.getCombatState() != 2) && (enemy.getCombatTarget() == player)
		distance = player.getDistance(enemy as objectreference)
		float attackAngle = math.abs(player.getHeadingAngle(enemy as objectreference))
		if(asEventName == "BowDrawing") && (attackAngle <= 5) && (player.hasLOS(enemy))
			C16F2()
		elseif(asEventName == "BowFullDrawn") && (attackAngle <= 7) && (player.hasLOS(enemy))
			C16F3()
		elseif(asEventName == "DodgeMasterSpell") && (distance <= 2100)
			C6F1()
		elseif(asEventName == "DodgeLightningStorm") && (attackAngle <= 5) && (player.hasLOS(enemy))
			C6F3()
		elseif(asEventName == "DodgeSpell") && (distance <= 1100) && (attackAngle <= 5) && (player.hasLOS(enemy))
			C6F3()
		elseif(asEventName == "DodgeCharge") && (attackAngle <= 5)
			C16F3()
		elseif(asEventName == "PowerAttack_Start_end") && (attackAngle <= 35)
			C6F3A()
		elseIf(asEventName == "NextAttackInitiate") && (attackAngle <= 35)
			C6F3A()
		elseIf(asEventName == "NextPowerAttackInitiate") && (attackAngle <= 35)
			C6F3PA()
		endIf
	elseIf(akSource == enemy) && (asEventName == "RollTrigger")
		InvincibleFrameR()
		StaminaDamageR()
	elseIf(akSource == enemy) && (asEventName == "SidestepTrigger")
		InvincibleFrameS()
		StaminaDamageS()
	endIf
	goToState("DodgeDone"+ NPCIFrame)
endEvent

event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if(aeCombatState != 0)
		NPCUpdate()
		registerAnimationEvent()
		int random = utility.randomInt(1, 3)
		registerForSingleUpdate(random)
	elseIf(aeCombatState == 0)
		unregisterAnimationEvent()
	endIf
endEvent

event OnUpdate()
	melee()
endEvent

event OnDying(Actor akKiller)
	utility.wait(0.5)
	enemy.removeSpell(UDBattleReadySpell)
endEvent


;------------------------------------------------------------- States -------------------------------------------------------------

state Dodging0
	event OnAnimationEvent (objectreference akSource, string asEventName)
		if(akSource == enemy) && (asEventName == "RollTrigger")
			InvincibleFrameR()
			StaminaDamageR()
		elseIf(akSource == enemy) && (asEventName == "SidestepTrigger")
			InvincibleFrameS()
			StaminaDamageS()
		endIf
	endEvent

	function InvincibleFrameR()
	endFunction

	function InvincibleFrameS()
	endFunction
endState

state DodgeFail0
	function pseudorandom16()
		If(pseudorandom16 > 12)
			pseudorandom16 = pseudorandom16 - 2
		endIf
		chance16 = utility.randomint(0, pseudorandom16)
	endFunction

	function pseudorandom6()
		If(pseudorandom6 > 4)
			pseudorandom6 = pseudorandom6 - 1
		endIf
		chance6 = utility.randomint(0, pseudorandom6)
	endFunction

	event OnAnimationEvent (objectreference akSource, string asEventName)
		if(akSource == enemy) && (asEventName == "RollTrigger")
			InvincibleFrameR()
			StaminaDamageR()
		elseIf(akSource == enemy) && (asEventName == "SidestepTrigger")
			InvincibleFrameS()
			StaminaDamageS()
		endIf
	endEvent

	function InvincibleFrameR()
	endFunction

	function InvincibleFrameS()
	endFunction
endState

state DodgeSuccess0
	function InvincibleFrameR()
	endFunction

	function InvincibleFrameS()
	endFunction
endState

state DodgeDone0
	function InvincibleFrameR()
	endFunction

	function InvincibleFrameS()
	endFunction
endState

state Dodging1
	event OnAnimationEvent (objectreference akSource, string asEventName)
		if(akSource == enemy) && (asEventName == "RollTrigger")
			InvincibleFrameR()
			StaminaDamageR()
		elseIf(akSource == enemy) && (asEventName == "SidestepTrigger")
			InvincibleFrameS()
			StaminaDamageS()
		endIf
	endEvent
endState

state DodgeFail1
	function pseudorandom16()
		If(pseudorandom16 > 12)
			pseudorandom16 = pseudorandom16 - 2
		endIf
		chance16 = utility.randomint(0, pseudorandom16)
	endFunction

	function pseudorandom6()
		If(pseudorandom6 > 4)
			pseudorandom6 = pseudorandom6 - 1
		endIf
		chance6 = utility.randomint(0, pseudorandom6)
	endFunction

	event OnAnimationEvent (objectreference akSource, string asEventName)
		if(akSource == enemy) && (asEventName == "RollTrigger")
			InvincibleFrameR()
			StaminaDamageR()
		elseIf(akSource == enemy) && (asEventName == "SidestepTrigger")
			InvincibleFrameS()
			StaminaDamageS()
		endIf
	endEvent
endState


;------------------------------------------------------------- Chance & Frequency Functions -------------------------------------------------------------

function C16F2()
	if(chance16 <= frequency2)
		float random = utility.randomfloat(0.5, 0.8)
		utility.wait(random)
		BeginDodging()
		goToState("DodgeSuccess"+ NPCIFrame)
		pseudorandom16()
	else
		goToState("DodgeFail"+ NPCIFrame)
		pseudorandom16()
	endIf
endFunction

function C16F3()
	if(chance16 <= frequency3)
		BeginDodging()
		goToState("DodgeSuccess"+ NPCIFrame)
		pseudorandom16()
	else
		goToState("DodgeFail"+ NPCIFrame)
		pseudorandom16()
	endIf
endFunction

function C6F1()
	if(chance6 <= frequency1)
		BeginDodging()
		goToState("DodgeSuccess"+ NPCIFrame)
		pseudorandom6()
	else
		goToState("DodgeFail"+ NPCIFrame)
		pseudorandom6()
	endIf
endFunction

function C6F3()
	if(chance6 <= frequency3)
		BeginDodging()
		goToState("DodgeSuccess"+ NPCIFrame)
		pseudorandom6()
	else
		goToState("DodgeFail"+ NPCIFrame)
		pseudorandom6()
	endIf
endFunction

function C6F3A()
	if(chance6 <= frequency3)
		AttackDodge()
		goToState("DodgeSuccess"+ NPCIFrame)
		pseudorandom6()
	else
		goToState("DodgeFail"+ NPCIFrame)
		pseudorandom6()
	endIf
endFunction

function C6F3PA()
	if(chance6 <= frequency3)
		PowerAttackDodge()
		goToState("DodgeSuccess"+ NPCIFrame)
		pseudorandom6()
	else
		goToState("DodgeFail"+ NPCIFrame)
		pseudorandom6()
	endIf
endFunction


;------------------------------------------------------------- In Functions -------------------------------------------------------------

function AttackDodge()
	if (player.getEquippedItemType(1) == 0) && (distance <= unarmed)
		BeginDodging()
	elseIf (player.getEquippedItemType(1) == 1) && (distance <= onehanded)
		BeginDodging()
	elseIf (player.getEquippedItemType(1) == 2) && (distance <= dagger)
		BeginDodging()
	elseIf (player.getEquippedItemType(1) == 3) && (distance <= onehanded)
		BeginDodging()
	elseIf (player.getEquippedItemType(1) == 4) && (distance <= onehanded)
		BeginDodging()
	elseIf (player.getEquippedItemType(1) == 5) && (distance <= twohanded)
		BeginDodging()
	elseIf (player.getEquippedItemType(1) == 6) && (distance <= twohanded)
		BeginDodging()
	else
		
	endIf
endFunction

function PowerAttackDodge()
	if(player.getEquippedItemType(1) == 0) && (distance <= unarmed)
		float random = utility.randomfloat(0.2, 0.4)
		utility.wait(random)
		BeginDodging()
	elseIf(player.getEquippedItemType(1) == 1) && (distance <= onehanded)
		float random = utility.randomfloat(0.2, 0.4)
		utility.wait(random)
		BeginDodging()
	elseIf(player.getEquippedItemType(1) == 2) && (distance <= dagger)
		float random = utility.randomfloat(0.1, 0.2)
		utility.wait(random)
		BeginDodging()
	elseIf(player.getEquippedItemType(1) == 3) && (distance <= onehanded)
		float random = utility.randomfloat(0.2, 0.4)
		utility.wait(random)
		BeginDodging()
	elseIf(player.getEquippedItemType(1) == 4) && (distance <= onehanded)
		float random = utility.randomfloat(0.2, 0.4)
		utility.wait(random)
		BeginDodging()
	elseIf(player.getEquippedItemType(1) == 5) && (distance <= twohanded)
		float random = utility.randomfloat(0.3, 0.5)
		utility.wait(random)
		BeginDodging()
	elseIf(player.getEquippedItemType(1) == 6) && (distance <= twohanded)
		float random = utility.randomfloat(0.3, 0.5)
		utility.wait(random)
		BeginDodging()
	endIf
endFunction

function DodgeStyleCheck()
	int newDodgeID
	int oldDodgeID = enemy.getAnimationVariableInt("DodgeID")
 	if(UDDodgeStyle.getValueInt() != 1) && (oldDodgeID != 1)
		enemy.setAnimationVariableInt("DodgeID", 1)
		newDodgeID = 1
	elseIf(UDDodgeStyle.getValueInt() == 1) && (oldDodgeID != 0)
		enemy.setAnimationVariableInt("DodgeID", 0)
		newDodgeID = 0
	endIf
	if(UDSKSEDetect.getValueInt() == 1)
		enemy.addSpell(UDSKSEBattleReadySpell)
	else
		if(newDodgeID == 0)
			enemy.setAnimationVariableFloat("DodgeSpeed", 1)
		else
			enemy.setAnimationVariableFloat("DodgeSpeed", 1.647)
		endIf
	endIf
endFunction

function pseudorandom16()
	if(pseudorandom16 < 24)
		pseudorandom16 = pseudorandom16 + 2
	endIf
	chance16 = utility.randomint(0, pseudorandom16)
endFunction

function pseudorandom6()
	if(pseudorandom6 < 8)
		pseudorandom6 = pseudorandom6 + 1
	endIf
	chance6 = utility.randomint(0, pseudorandom6)
endFunction

function NPCUpdate()
	dodgeStyleCheck()
	invincibleFrameCheck()
	staminaDamageCheck()
	NPCIFrameCheck()
endFunction

function NPCIFrameCheck()
	NPCIFrame = UDNPCIFrameGlobal.getValueInt()
endFunction

function RegisterAnimationEvent()
	registerForAnimationEvent(player, "BowDrawing")
	registerForAnimationEvent(player, "PowerAttack_Start_end")
	registerForAnimationEvent(player, "DodgeMasterSpell")
	registerForAnimationEvent(player, "DodgeLightningStorm")
	registerForAnimationEvent(player, "DodgeSpell")
	registerForAnimationEvent(player, "DodgeCharge")
	registerForAnimationEvent(player, "NextAttackInitiate")
	registerForAnimationEvent(player, "NextPowerAttackInitiate")
	registerForAnimationEvent(player, "BowFullDrawn")
	registerForAnimationEvent(enemy, "RollTrigger")
	registerForAnimationEvent(enemy, "SidestepTrigger")
endFunction

function UnregisterAnimationEvent()
	unregisterForAnimationEvent(player, "BowDrawing")
	unregisterForAnimationEvent(player, "PowerAttack_Start_end")
	unregisterForAnimationEvent(player, "DodgeMasterSpell")
	unregisterForAnimationEvent(player, "DodgeLightningStorm")
	unregisterForAnimationEvent(player, "DodgeSpell")
	unregisterForAnimationEvent(player, "DodgeCharge")
	unregisterForAnimationEvent(player, "NextAttackInitiate")
	unregisterForAnimationEvent(player, "NextPowerAttackInitiate")
	unregisterForAnimationEvent(player, "BowFullDrawn")
	unregisterForAnimationEvent(enemy, "RollTrigger")
	unregisterForAnimationEvent(enemy, "SidestepTrigger")
endFunction

function melee()
	if(enemy.getCombatState() == 1)
		distance = enemy.getDistance(enemy.getCombatTarget() as objectReference)
		if(distance <= twohanded)
			BeginDodging()
		endIf
		if(frequency1 == 1)
			int random = utility.randomInt(3, 8)
			registerForSingleUpdate(random)
		elseIf(frequency1 == 2)
			int random = utility.randomInt(2, 7)
			registerForSingleUpdate(random)		
		elseIf(frequency1 == 3)
			int random = utility.randomInt(2, 5)
			registerForSingleUpdate(random)
		elseIf(frequency1 == 4)
			int random = utility.randomInt(1, 4)
			registerForSingleUpdate(random)
		endIf
	endIf
endFunction


;------------------------------------------------------------- Dodging Functions -------------------------------------------------------------

function BeginDodging()
	enemy.playIdle(DodgeRollNPC)
	utility.wait(0.4)
	if(chance16 <= frequency3)
		enemy.playIdle(DodgeRollNPC)
	endIf
endFunction

function InvincibleFrameR()
	enemy.setGhost(true)
	utility.wait(IFrameR)
	enemy.setGhost(false)
endFunction

function InvincibleFrameS()
	enemy.setGhost(true)
	utility.wait(IFrameS)
	enemy.setGhost(false)
endFunction

function StaminaDamageR()
	enemy.DamageActorValue("Stamina", StaminaCostR)
	int Stamina = enemy.GetActorValue("Stamina") as int
	if(Stamina == 0)
		enemy.AddSpell(UDRollZeroStaminaDamage, false)
		utility.Wait(3)
		enemy.RemoveSpell(UDRollZeroStaminaDamage)
	endIf
endFunction

function StaminaDamageS()
	enemy.DamageActorValue("Stamina", StaminaCostS)
	int Stamina = enemy.GetActorValue("Stamina") as int
	if(Stamina == 0)
		enemy.AddSpell(UDRollZeroStaminaDamage, false)
		utility.Wait(3)
		enemy.RemoveSpell(UDRollZeroStaminaDamage)
	endIf
endFunction

function InvincibleFrameCheck()
	IFrameR = UDIFrameR.getValue()
	IFrameS = UDIFrameS.getValue()
endFunction

function StaminaDamageCheck()
	StaminaCostR = UDStaminaCostR.getValueInt()
	StaminaCostS = UDStaminaCostS.getValueInt()
endFunction