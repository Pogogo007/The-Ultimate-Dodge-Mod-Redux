Scriptname UDPlayerCombatDetect extends activemagiceffect  

actor property PlayerRef auto

globalvariable property UDDodgeDynamicPause auto

form property UDLargeEnemyCount auto
form property UDAllEnemyCount auto
form property UDEnemyCountList auto

UDActivationScript property UDActivationQuest auto
UDNPCDodgeAICore property UDNPCDodgeAIQuest auto

int CombatTimerID = 0


;------------------------------------------------------------- Events -------------------------------------------------------------

event OnEffectStart(actor akTarget, actor akCaster)
	addInventoryEventFilter(UDAllEnemyCount)
	if(playerRef.isInCombat() == true)
		registerForSingleUpdate(1)
	endIf
endEvent

event OnUpdate()
	if(playerRef.isInCombat() == false)
		OutCombat()
	else
		registerForSingleUpdate(2)
	endIf
endEvent

event OnItemAdded(form akBaseItem, int aiItemCount, objectReference akItemReference, objectReference akDestContainer)
	registerForSingleUpdate(1)
	removeInventoryEventFilter(UDAllEnemyCount)
	addInventoryEventFilter(UDEnemyCountList)
endEvent


;------------------------------------------------------------- In Functions -------------------------------------------------------------

function OutCombat()
	playerRef.removeItem(UDLargeEnemyCount, 500, true)
	playerRef.removeItem(UDAllEnemyCount, 500, true)
	int LargeEnemyCount= playerRef.getItemCount(UDLargeEnemyCount)
	int AllEnemyCount = playerRef.getItemCount(UDAllEnemyCount)
	UDActivationQuest.reEnemyCheck(AllEnemyCount, LargeEnemyCount)
	removeInventoryEventFilter(UDEnemyCountList)
	addInventoryEventFilter(UDAllEnemyCount)
	if(UDDodgeDynamicPause.getValueInt() == 1)
		UDNPCDodgeAIQuest.MCMDodgeStyleToggle(false)
	endIf
endFunction