Scriptname UDSKSEArmorCheckNPC extends activemagiceffect  

keyword property ArmorHeavy auto

globalvariable property UDSKSEDetect auto

spell property UDSKSEBattleReadySpell auto

UDActivationScript property UDActivationQuest auto

actor enemy

int Property kSlotMask30 = 0x00000001 AutoReadOnly ; HEAD
int Property kSlotMask32 = 0x00000004 AutoReadOnly ; BODY
int Property kSlotMask33 = 0x00000008 AutoReadOnly ; Hands
int Property kSlotMask37 = 0x00000080 AutoReadOnly ; Feet


;------------------------------------------------------------- Events -------------------------------------------------------------

event OnEffectStart(actor akTarget, actor akCaster)
	enemy = akTarget
	registerForSingleUpdate(1)
	float MaxSpeedPenalty = UDActivationQuest.MaxSpeedPenaltyOut()
	int newArmorWeight = armorCheckNPC()
	float ArmorWeightPercentage = newArmorWeight / 4
	float SpeedPenalty = ArmorWeightPercentage * MaxSpeedPenalty
	int DodgeID = enemy.getAnimationVariableInt("DodgeID")
	if(DodgeID == 0)
		float DodgeSpeed = 1 - SpeedPenalty
		enemy.setAnimationVariableFloat("DodgeSpeed", DodgeSpeed)
	elseIf(DodgeID == 1)
		float DodgeSpeed = (1 - SpeedPenalty) * 1.647
		enemy.setAnimationVariableFloat("DodgeSpeed", DodgeSpeed)
	endIf
	goToState("End")
endEvent

event OnUpdate()
	registerForSingleUpdate(1)
endEvent


;------------------------------------------------------------- States -------------------------------------------------------------

state End
	event OnUpdate()
		enemy.removeSpell(UDSKSEBattleReadySpell)
	endEvent
endState


;------------------------------------------------------------- Out Functions -------------------------------------------------------------

int function ArmorCheckNPC()
	int ArmorWeight = 0
	if(enemy.getWornForm(kSlotMask30) != none)
		armor head = enemy.getWornForm(kSlotMask30) as armor
		if(head.hasKeyWord(ArmorHeavy))
			ArmorWeight = ArmorWeight + 1
		endIf
	endIf
	if(enemy.getWornForm(kSlotMask32) != none)
		armor body = enemy.getWornForm(kSlotMask32) as armor
		if(body.hasKeyWord(ArmorHeavy))
			ArmorWeight = ArmorWeight + 1
		endIf
	endIf
	if(enemy.getWornForm(kSlotMask33) != none)
		armor hands = enemy.getWornForm(kSlotMask33) as armor
		if(hands.hasKeyWord(ArmorHeavy))
			ArmorWeight = ArmorWeight + 1
		endIf
	endIf
	if(enemy.getWornForm(kSlotMask37) != none)
		armor feet = enemy.getWornForm(kSlotMask37) as armor
		if(feet.hasKeyWord(ArmorHeavy))
			ArmorWeight = ArmorWeight + 1
		endIf
	endIf
	return ArmorWeight
endFunction