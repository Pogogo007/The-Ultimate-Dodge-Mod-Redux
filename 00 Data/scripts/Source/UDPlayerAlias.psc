Scriptname UDPlayerAlias extends ReferenceAlias

Actor Property PlayerRef Auto

Keyword Property ArmorHeavy Auto

Quest Property MQ101 Auto
Quest Property UDSKSEFunctionsQuest Auto

Spell Property UDPlayerCombatDetectSpell Auto
Spell Property UDPlayerInventoryFlowSpell Auto

GlobalVariable Property UDArmorWeight Auto
GlobalVariable Property UDDodgeStyle Auto
GlobalVariable Property UDSKSEDetect Auto

UDActivationScript Property UDActivationQuest Auto

actor player


;------------------------------------------------------------- Events -------------------------------------------------------------

event OnInit()
	player = PlayerRef
	SKSECheck()
	player.addSpell(UDPlayerCombatDetectSpell, false)
	if(UDDodgeStyle.getValueInt() == 0)
		player.addSpell(UDPlayerInventoryFlowSpell, false)
	endIf
	utility.wait(2)
	if(MQ101.isRunning()) && (MQ101.isStageDone(255) == false)
		UDArmorWeight.setValueInt(0)
		goToState("ArmorRemovedDone")
	else
		ArmorRemoved()
	endIf
endEvent

event OnPlayerLoadGame()
	SKSECheck()
	UDActivationQuest.onLoad()
	player.addSpell(UDPlayerCombatDetectSpell, false)
	if(UDDodgeStyle.getValueInt() == 0)
		player.addSpell(UDPlayerInventoryFlowSpell, false)
	endIf
	ArmorRemoved()
endEvent

event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	if(akBaseObject.hasKeyword(ArmorHeavy))
		int ArmorWeight = UDArmorWeight.getValueInt()
		ArmorWeight = ArmorWeight + 1
		If(ArmorWeight > 4)
			ArmorWeight = 4
		endIf
		UDArmorWeight.setValueInt(ArmorWeight)
		UDActivationQuest.armorCheck()
		UDActivationQuest.weightCheck()
	endIf
endEvent

event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	if(akBaseObject.hasKeyWord(ArmorHeavy))
		int ArmorWeight = UDArmorWeight.getValueInt()
		ArmorWeight = ArmorWeight - 1
		If(ArmorWeight < 0)
			ArmorWeight = 0
		endIf
		UDArmorWeight.setValueInt(ArmorWeight)
		UDActivationQuest.armorCheck()
		UDActivationQuest.weightCheck()
	endIf
endEvent


;------------------------------------------------------------- States -------------------------------------------------------------

state ArmorRemovedDone
	function ArmorRemoved()

	endFunction
endState


;------------------------------------------------------------- In Functions -------------------------------------------------------------

function SKSECheck()
	int Version = UDSKSEDetect.getValueInt()
	int SKSEVersion = SKSE.getVersionRelease()
	if(Version == 2)
		if(SKSEVersion > 0)
			debug.notification("SKSE detected. TUDM is adapting to new changes...")
			UDSKSEDetect.setValueInt(1)
			utility.wait(2)
			debug.notification("Adaptation is complete. Installing MCM Menu....")
			SKSEStartUp()
		else
			debug.notification("No SKSE detected. TUDM will still continue to function.")
			UDSKSEDetect.setValueInt(0)
			SKSEShutDown()
		endIf
	elseIf(Version == 1)
		if(SKSEVersion > 0)

		else
			debug.notification("Missing SKSE. TUDM is adapting to new changes...")
			UDSKSEDetect.setValueInt(0)
			utility.wait(2)
			debug.notification("Adaptation is complete.")
			SKSEShutDown()
		endIf
	elseIf(Version == 0)
		if(SKSEVersion > 0)
			debug.notification("SKSE detected. TUDM is adapting to new changes...")
			UDSKSEDetect.setValueInt(1)
			utility.wait(2)
			debug.notification("Adaptation is complete. Installing MCM Menu....")
			SKSEStartUp()
		endIf
	endIf
endFunction

function ArmorRemoved()
	player.unequipAll()
	UDArmorWeight.setValueInt(0)
	goToState("ArmorRemovedDone")
	debug.messagebox("Re-equip all your armor")
endFunction

function SKSEStartUp()
	if(UDSKSEFunctionsQuest.isRunning() == false)
		UDSKSEFunctionsQuest.start()
	endIf
endFunction

function SKSEShutDown()
	if(UDSKSEFunctionsQuest.isRunning() == true)
		UDSKSEFunctionsQuest.stop()
	endIf
endFunction