Scriptname UDConfigurationScript extends activemagiceffect  

GlobalVariable Property UDSneakStyle auto
GlobalVariable Property UDDodgeStyle auto
GlobalVariable Property UDDodgeSpeedMethod auto
GlobalVariable Property UDMaxSpeedPenalty auto
GlobalVariable Property UDStaminaCostR auto
GlobalVariable Property UDStaminaCostS auto
GlobalVariable Property UDIFrameR auto
GlobalVariable Property UDIFrameS auto
GlobalVariable Property UDNPCDodgeAIGlobal auto
GlobalVariable Property UDNPCIFrameGlobal auto
GlobalVariable Property UDNPCDodgeFrequencyGlobal auto

Message Property UDUltimateDodgeMainMessage auto
Message Property UDGeneralSettingsMainMessage auto
Message Property UDSneakStyleMessage auto
Message Property UDDodgeStyleMessage auto
Message Property UDPlayerSettingsMainMessage auto
Message Property UDDodgeSpeedMethodMessage auto
Message Property UDDodgeSpeedMessage auto
Message Property UDNPCSettingsMainMessage auto
Message Property UDNPCDodgeAIMessage auto
Message Property UDNPCInvincibleFrameMessage auto
Message Property UDNPCDodgingFrequencyMessage auto
Message Property UDDodgeRollSettingsMainMessage auto
Message Property UDStaminaCostRMessage auto
Message Property UDIFrameRMessage auto
Message Property UDSidestepSettingsMainMessage auto
Message Property UDStaminaCostSMessage auto
Message Property UDIFrameSMessage auto

UDActivationScript Property UDActivationQuest auto
UDNPCDodgeAICore Property UDNPCDodgeAIQuest auto

Actor Property PlayerRef Auto

actor player
int StaminaCostR
int StaminaCostS
float IFrameR
float IFrameS
float DodgeSpeed

event OnEffectStart(actor akTarget, actor akCaster)
	player = PlayerRef
	MainConfiguration()
endEvent

function MainConfiguration(int button = 0)
	button = UDUltimateDodgeMainMessage.show()
	if(button == 0)
		GeneralSettingsConfiguration()
	elseIf(button == 1)
		PlayerSettingsConfiguration()
	elseIf(button == 2)
		NPCSettingsConfiguration()
	elseIf(button == 3)
		DodgeRollSettingsConfiguration()
	elseIf(button == 4)
		SidestepSettingsConfiguration()
	elseIf(button == 5)
		
	endIf
endFunction

;------------------------------------------------------------- General Settings -------------------------------------------------------------

function GeneralSettingsConfiguration(int button = 0)
	button = UDGeneralSettingsMainMessage.show()
	if(button == 0)
		SneakStyleConfiguration()
	elseIf(button == 1)
		DodgeStyleConfiguration()
	elseIf(button == 2)

	endIf
endFunction

function SneakStyleConfiguration(int button = 0)
	button = UDSneakStyleMessage.show()
	if(button == 0)
		UDSneakStyle.setValue(0)
		debug.notification("Sneak Style 1 has been selected")
	elseIf(button == 1)
		UDSneakStyle.setValue(1)
		debug.notification("Sneak Style 2 has been selected")
	else

	endIf
endFunction

function DodgeStyleConfiguration(int button = 0)
	button = UDDodgeStyleMessage.show()
	if(button == 0)
		UDDodgeStyle.setValueInt(0)
		debug.notification("Roll + Sidestep has been selected")
		UDNPCDodgeAIQuest.MCMAIUpdate()
		change()
	elseIf(button == 1)
		UDDodgeStyle.setValueInt(1)
		player.setAnimationVariableInt("DodgeID", 0)
		UDActivationQuest.dodgeSpeedCheck(0)
		debug.notification("Dodge Roll has been selected")
		UDNPCDodgeAIQuest.MCMAIUpdate()
		change()
	elseIf(button == 2)
		UDDodgeStyle.setValueInt(2)
		player.setAnimationVariableInt("DodgeID", 1)
		UDActivationQuest.dodgeSpeedCheck(1)
		debug.notification("Sidestep has been selected")
		UDNPCDodgeAIQuest.MCMAIUpdate()
		change()
	else

	endIf
endFunction

;------------------------------------------------------------- Player Settings -------------------------------------------------------------

function PlayerSettingsConfiguration(int button = 0)
	button = UDPlayerSettingsMainMessage.show()
	if(button == 0)
		DodgeSpeedMethodConfiguration()
	elseIf(button == 1)
		DodgeSpeed = UDMaxSpeedPenalty.getValue()
		DodgeSpeedConfiguration()
	elseIf(button == 2)

	endIf
endFunction

function DodgeSpeedMethodConfiguration(int button = 0)
	button = UDDodgeSpeedMethodMessage.show()
	if(button == 0)
		UDDodgeSpeedMethod.setValueInt(0)
		UDActivationQuest.DodgeSpeedMethod(0)
		UDActivationQuest.weightCheck()
		debug.notification("Dodge Speed: weight dependent, has been selected")
		change()
	elseIf(button == 1)
		UDDodgeSpeedMethod.setValueInt(1)
		UDActivationQuest.DodgeSpeedMethod(1)
		UDActivationQuest.armorCheck()
		debug.notification("Dodge Speed: armor dependent, has been selected")
		change()
	elseIf(button == 2)
		UDDodgeSpeedMethod.setValueInt(2)
		UDActivationQuest.DodgeSpeedMethod(2)
		int DodgeID = player.getAnimationVariableInt("DodgeID")
		if(DodgeID == 0)
			DodgeSpeed = 1
		elseIf(DodgeID == 1)
			DodgeSpeed = 1.647
		endIf
		player.setAnimationVariablefloat("DodgeSpeed", DodgeSpeed)
		debug.notification("Dodge speed variation has been disabled")
		change()
	else
	
	endIf
endFunction

function DodgeSpeedConfiguration(int button = 0)
	button = UDDodgeSpeedMessage.show()
	if(button == 0)
		DodgeSpeed = DodgeSpeed - 0.05
		if(DodgeSpeed < 0)
			DodgeSpeed = 0
		else
			DodgeSpeedConfiguration()
		endIf
	elseIf(button == 1)
		DodgeSpeed = DodgeSpeed + 0.05
		if(DodgeSpeed > 0.50)
			DodgeSpeed = 0.50
		else
			DodgeSpeedConfiguration()
		endIf
	elseIf(button == 2)

	endIf
	UDMaxSpeedPenalty.setValue(DodgeSpeed)
	UDActivationQuest.maxSpeedPenaltyCheck(DodgeSpeed)
	UDActivationQuest.weightCheck()
	UDActivationQuest.armorCheck()
	debug.notification("Current max speed penalty & speed penalty ratio: " + DodgeSpeed)
	change()
endFunction

;------------------------------------------------------------- NPC Settings -------------------------------------------------------------

function NPCSettingsConfiguration(int button = 0)
	button = UDNPCSettingsMainMessage.show()
	if(button == 0)
		NPCDodgeAIConfiguration()
	elseIf(button == 1)
		NPCInvincibleFrameConfiguration()
	elseIf(button == 2)
		NPCDodgingFrequencyConfiguration()
	elseIf(button == 3)

	endIf
endFunction

function NPCDodgeAIConfiguration(int button = 0)
	bool DodgeAI = UDNPCDodgeAIGlobal.getValueInt() as bool
	button = UDNPCDodgeAIMessage.show()
	if(button == 0)
		if(DodgeAI == 0)
			UDNPCDodgeAIGlobal.setValue(1)
			debug.notification("NPC Dodge AI has been enabled")
			change()
		else
			UDNPCDodgeAIGlobal.setValue(0)
			debug.notification("NPC Dodge AI has been disabled")
			change()
		endIf
	elseIf(button == 1)

	endIf
endFunction

function NPCInvincibleFrameConfiguration(int button = 0)
	bool NPCIFrame = UDNPCIFrameGlobal.getValueInt() as bool
	button = UDNPCInvincibleFrameMessage.show()
	if(button == 0)
		if(NPCIFrame == 0)
			UDNPCIFrameGlobal.setValueInt(1)
			debug.notification("NPC Invincible Frame has been enabled")
			change()
		else
			UDNPCIFrameGlobal.setValueInt(0)
			debug.notification("NPC Invincible Frame has been disabled")
			change()
		endIf
	elseIf(button == 1)

	endIf
endFunction

function NPCDodgingFrequencyConfiguration(int button = 0)
	button = UDNPCDodgingFrequencyMessage.show()
	if(button == 0)
		UDNPCDodgeFrequencyGlobal.setValueInt(0)
		debug.notification("NPC Dodging Frequency: Not Frequent")
		change()
	elseIf(button == 1)
		UDNPCDodgeFrequencyGlobal.setValueInt(1)
		debug.notification("NPC Dodging Frequency: Moderate")
		change()
	elseIf(button == 2)
		UDNPCDodgeFrequencyGlobal.setValueInt(2)
		debug.notification("NPC Dodging Frequency: Frequent")
		change()
	elseIf(button == 3)
		UDNPCDodgeFrequencyGlobal.setValueInt(3)
		debug.notification("NPC Dodging Frequency: Very Frequent")
		change()
	endIf
endFunction

;------------------------------------------------------------- Dodge Roll Settings -------------------------------------------------------------

function DodgeRollSettingsConfiguration(int button = 0)
	button = UDDodgeRollSettingsMainMessage.show()
	if(button == 0)
		StaminaCostR = UDStaminaCostR.getValueInt()
		StaminaRConfiguration()
	elseIf(button == 1)
		IFrameR = UDIFrameR.getValueInt()
		IFrameRConfiguration()
	elseIf(button == 2)

	endIf
endFunction

function StaminaRConfiguration(int button = 0)
	button = UDStaminaCostRMessage.show()
	if(button == 0)
		StaminaCostR = StaminaCostR- 5
		if(StaminaCostR < 0)
			StaminaCostR = 0
		else
			StaminaRConfiguration()
		endIf
	elseIf(button == 1)
		StaminaCostR = StaminaCostR - 1
		if(StaminaCostR < 0)
			StaminaCostR = 0
		else
			StaminaRConfiguration()
		endIf
	elseIf(button == 2)
		StaminaCostR = StaminaCostR + 1
		if(StaminaCostR > 50)
			StaminaCostR = 50
		else
			StaminaRConfiguration()
		endIf
	elseIf(button == 3)
		StaminaCostR = StaminaCostR + 5
		if(StaminaCostR > 50)
			StaminaCostR = 50
		else
			StaminaRConfiguration()
		endIf
	elseIf(button == 4)

	endIf
	UDStaminaCostR.setValueInt(StaminaCostR)
	UDActivationQuest.staminaCostRCheck(StaminaCostR)
	debug.notification("Current stamina cost for dodge roll: " + StaminaCostR)
	if(UDDodgeStyle.getValueInt() == 1)
		change()
	endIf
endFunction

function IFrameRConfiguration(int button = 0)
	button = UDIFrameRMessage.show()
	if(button == 0)
		IFrameR = IFrameR - 0.05
		if(IFrameR < 0)
			IFrameR = 0
		else
			IFrameRConfiguration()
		endIf
	elseIf(button == 1)
		IFrameR = IFrameR + 0.05
		if(IFrameR > 0.80)
			IFrameR = 0.80
		else
			IFrameRConfiguration()
		endIf
	elseIf(button == 2)

	endIf
	UDIFrameR.setValue(IFrameR)
	UDActivationQuest.invincibleFrameRCheck(IFrameR)
	debug.notification("Current invincible time frame for dodge roll: " + IFrameR)
	if(UDDodgeStyle.getValueInt() == 1)
		change()
	endIf
endFunction

;------------------------------------------------------------- Sidestep Settings -------------------------------------------------------------

function SidestepSettingsConfiguration(int button = 0)
	button = UDSidestepSettingsMainMessage.show()
	if(button == 0)
		StaminaCostS = UDStaminaCostS.getValueInt()
		StaminaSConfiguration()
	elseIf(button == 1)
		IFrameS = UDIFrameS.getValueInt()
		IFrameSConfiguration()
	elseIf(button == 2)

	endIf
endFunction

function StaminaSConfiguration(int button = 0)
	button = UDStaminaCostSMessage.show()
	if(button == 0)
		StaminaCostS = StaminaCostS - 5
		if(StaminaCostS < 0)
			StaminaCostS = 0
		else
			StaminaSConfiguration()
		endIf
	elseIf(button == 1)
		StaminaCostS = StaminaCostS - 1
		if(StaminaCostS < 0)
			StaminaCostS = 0
		else
			StaminaSConfiguration()
		endIf
	elseIf(button == 2)
		StaminaCostS = StaminaCostS + 1
		if(StaminaCostS > 50)
			StaminaCostS = 50
		else
			StaminaSConfiguration()
		endIf
	elseIf(button == 3)
		StaminaCostS = StaminaCostS + 5
		if(StaminaCostS > 50)
			StaminaCostS = 50
		else
			StaminaSConfiguration()
		endIf
	elseIf(button == 4)
		
	endIf
	UDStaminaCostS.setValueInt(StaminaCostS)
	UDActivationQuest.staminaCostSCheck(StaminaCostS)
	debug.notification("Current stamina cost for sidestep: " + StaminaCostS)
	if(UDDodgeStyle.getValueInt() != 1)
		change()
	endIf
endFunction

function IFrameSConfiguration(int button = 0)
	button = UDIFrameSMessage.show()
	if(button == 0)
		IFrameS = IFrameS - 0.05
		if(IFrameS < 0)
			IFrameS = 0
		else
			IFrameSConfiguration()
		endIf
	elseIf(button == 1)
		IFrameS = IFrameS + 0.05
		if(IFrameS > 0.50)
			IFrameS = 0.50
		else
			IFrameSConfiguration()
		endIf
	elseIf(button == 2)

	endIf
	UDIFrameS.setValue(IFrameS)
	UDActivationQuest.invincibleFrameSCheck(IFrameS)
	debug.notification("Current invincible time frame for sidestep: " + IFrameS)
	if(UDDodgeStyle.getValueInt() != 1)
		change()
	endIf
endFunction

function change()
	UDNPCDodgeAIQuest.MCMDodgeStyleRefresh()
endFunction