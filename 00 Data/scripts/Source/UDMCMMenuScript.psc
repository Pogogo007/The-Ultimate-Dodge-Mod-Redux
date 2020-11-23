Scriptname UDMCMMenuScript extends SKI_ConfigBase

globalvariable property UDStaminaCostR auto
globalvariable property UDStaminaCostS auto
globalvariable property UDIFrameR auto
globalvariable property UDIFrameS auto
globalvariable property UDDodgeStyle auto
globalvariable property UDArmorWeight auto
globalvariable property UDNPCDodgeAIGlobal auto
globalvariable property UDDodgeSpeedMethod auto
globalvariable property UDMaxSpeedPenalty auto
globalvariable property UDGamepad auto
globalvariable property UDDodgeDynamicPause auto
globalvariable property UDSneakStyle auto

quest property UDActivationQuestUninstall auto
quest property UDNPCDodgeAIQuestUninstall auto
quest property UDConfigurationQuest auto
quest property UDSKSEFunctionsQuestUninstall auto

actor property PlayerRef auto

UDActivationScript property UDActivationQuest auto
UDNPCDodgeAICore property UDNPCDodgeAIQuest auto
UDSKSEFunctionsScript property UDSKSEFunctionsQuest auto

int Set_SneakKey
int Set_DodgeToggleKey
int Set_DodgeKey
int Set_DodgeSpeed
int Set_DodgeFrequency
int Set_DodgeStyle
int Set_DDodgeStyle
int Set_SneakStyle
int Slider_StaminaCostR
int Slider_StaminaCostS
int Slider_InvincibleFrameR
int Slider_InvincibleFrameS
int Slider_DodgeSpeed
int ToggleDodgeLock
int ToggleGamepad
int ToggleNPCDodgeAI
int ToggleNPCInvincibleFrame
int ToggleUninstaller

int SneakStyleIndex = 0
int DodgeStyleIndex = 0
int DDodgeStyleIndex = 0
int DodgeSpeedMethodIndex = 0
int DodgeFrequencyIndex = 2
int DS2Flag
int DS3Flag
int DSMFlag
int DSFlag
int DAFlag
int GPFlag
int SneakKey = 42
int DodgeToggleKey = 34
int StaminaCostR
int StaminaCostS
float InvincibleFrameR
float InvincibleFrameS
float DodgeSpeed = 0.35
bool DodgeLock = false
bool Gamepad = false
bool NPCInvincibleFrame = true
bool NPCDodgeAI = true
bool Uninstaller = false
bool change = false
string[] SneakStyle
string[] DodgeStyle
string[] DDodgeStyle
string[] DodgeSpeedMethod
string[] DodgeFrequency
string DodgeKeyText = "System > Controls > Sneak"

actor player

int DodgeID

event OnInit()
	player = PlayerRef
	StartUp()
endEvent

function StartUp()
	parent.onInit()
	SetKeyMapOptionValue(Set_SneakKey, SneakKey, false)
	UDSKSEFunctionsQuest.setSneakKey(SneakKey)
	SetKeyMapOptionValue(Set_DodgeToggleKey, DodgeToggleKey, false)
	UDSKSEFunctionsQuest.setDodgeToggleKey(DodgeToggleKey)
	SneakStyle = new string[2]
	SneakStyle[0] = "Sneak Style 1"
	SneakStyle[1] = "Sneak Style 2"
	DodgeStyle = new string[3]
	DodgeStyle[0] = "Roll + Sidestep"
	DodgeStyle[1] = "Roll only"
	DodgeStyle[2] = "Sidestep only"
	DDodgeStyle = new string[3]
	DDodgeStyle[0] = "Last used"
	DDodgeStyle[1] = "Roll only"
	DDodgeStyle[2] = "Sidestep only"
	DodgeSpeedMethod = new string[3]
	DodgeSpeedMethod[0] = "Weight Dependent"
	DodgeSpeedMethod[1] = "Armor Dependent"
	DodgeSpeedMethod[2] = "Disable"
	DodgeFrequency = new string[4]
	DodgeFrequency[0] = "Not frequent"
	DodgeFrequency[1] = "Moderate"
	DodgeFrequency[2] = "Frequent"
	DodgeFrequency[3] = "Very frequent"
endFunction

event OnConfigOpen()
	SetKeyMapOptionValue(Set_SneakKey, SneakKey, false)
	UDSKSEFunctionsQuest.setSneakKey(SneakKey)
	SetKeyMapOptionValue(Set_DodgeToggleKey, DodgeToggleKey, false)
	UDSKSEFunctionsQuest.setDodgeToggleKey(DodgeToggleKey)
	DodgeStyleIndex = UDDodgeStyle.getValueInt()
	DodgeSpeedMethodIndex = UDDodgeSpeedMethod.getValueInt()
	StaminaCostR = UDStaminaCostR.getValueInt()
	StaminaCostS = UDStaminaCostS.getValueInt()
	DodgeSpeed = UDMaxSpeedPenalty.getValue()
	SneakStyle = new string[2]
	SneakStyle[0] = "Sneak Style 1"
	SneakStyle[1] = "Sneak Style 2"
	DodgeStyle = new string[3]
	DodgeStyle[0] = "Roll + Sidestep"
	DodgeStyle[1] = "Roll only"
	DodgeStyle[2] = "Sidestep only"
	DDodgeStyle = new string[3]
	DDodgeStyle[0] = "Last used"
	DDodgeStyle[1] = "Roll only"
	DDodgeStyle[2] = "Sidestep only"
	DodgeSpeedMethod = new string[3]
	DodgeSpeedMethod[0] = "Weight Dependent"
	DodgeSpeedMethod[1] = "Armor Dependent"
	DodgeSpeedMethod[2] = "Disable"
	DodgeFrequency = new string[4]
	DodgeFrequency[0] = "Not frequent"
	DodgeFrequency[1] = "Moderate"
	DodgeFrequency[2] = "Frequent"
	DodgeFrequency[3] = "Very frequent"
endEvent

event OnOptionMenuOpen(int option)
	if option == Set_DodgeStyle
		SetMenuDialogOptions(DodgeStyle)
		SetMenuDialogStartIndex(DodgeStyleIndex)
		SetMenuDialogDefaultIndex(0)
	endIf
	if option == Set_DDodgeStyle
		SetMenuDialogOptions(DDodgeStyle)
		SetMenuDialogStartIndex(DDodgeStyleIndex)
		SetMenuDialogDefaultIndex(0)
	endIf
	if option == Set_DodgeSpeed
		SetMenuDialogOptions(DodgeSpeedMethod)
		SetMenuDialogStartIndex(DodgeSpeedMethodIndex)
		SetMenuDialogDefaultIndex(0)
	endIf
	if option == Set_DodgeFrequency
		SetMenuDialogOptions(DodgeFrequency)
		SetMenuDialogStartIndex(DodgeFrequencyIndex)
		SetMenuDialogDefaultIndex(2)
	endIf
	if option == Set_SneakStyle
		SetMenuDialogOptions(SneakStyle)
		SetMenuDialogStartIndex(SneakStyleIndex)
		SetMenuDialogDefaultIndex(0)
	endIf
endEvent

event OnPageReset(string page)
	DodgeStyleIndex = UDDodgeStyle.getValueInt()
	DodgeSpeedMethodIndex = UDDodgeSpeedMethod.getValueInt()
	StaminaCostR = UDStaminaCostR.getValueInt()
	StaminaCostS = UDStaminaCostS.getValueInt()
	InvincibleFrameR = UDIFrameR.getValue()
	InvincibleFrameS = UDIFrameS.getValue()
	DodgeSpeed = UDMaxSpeedPenalty.getValue()
	if(Uninstaller == false)
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddHeaderOption("General Settings")
		Set_DodgeStyle = AddMenuOption("Combat Dodging Style", DodgeStyle[DodgeStyleIndex], 0)
		if(DodgeStyleIndex != 0) || (DodgeLock == true)
			DSFlag = 1
		else
			DSFlag = 0
		endIf
		Set_DDodgeStyle = AddMenuOption("Default Dodging Style", DDodgeStyle[DDodgeStyleIndex], DSFlag)
		ToggleDodgeLock = AddToggleOption("Lock Default Dodging Style", DodgeLock, 0)
		Set_DodgeToggleKey = AddKeyMapOption("Dodging Style Toggle Key", DodgeToggleKey, 0)
		AddEmptyOption()
		AddHeaderOption("Player Settings")
		ToggleGamepad = AddToggleOption("Gamepad/Controller Compatibility", Gamepad, 0)
		if(Gamepad == false)
			GPFlag = 0
			Set_SneakKey = AddKeyMapOption("Sneak Key", SneakKey, 0)
		else
			GPFlag = 1
			Set_SneakStyle = AddMenuOption("Sneak Style", SneakStyle[SneakStyleIndex], 0)
		endIf
		Set_DodgeKey = AddTextOption("Dodge Key", DodgeKeyText, GPFlag)
		AddEmptyOption()
		Set_DodgeSpeed = AddMenuOption("Dodging Speed Penalty", DodgeSpeedMethod[DodgeSpeedMethodIndex], 0)
		if(DodgeSpeedMethodIndex != 2)
			DSMFlag = 0
		else
			DSMFlag = 1
		endIf
		Slider_DodgeSpeed = AddSliderOption("Speed/Dependent ratio", DodgeSpeed, "{2} ratio", DSMFlag)
		AddEmptyOption()
		AddHeaderOption("NPC Settings")
		ToggleNPCDodgeAI = AddToggleOption("NPC Dodge AI", NPCDodgeAI, 0)
		if(NPCDodgeAI == true)
			DAFlag = 0
		else
			DAFlag = 1
		endIf
		ToggleNPCInvincibleFrame = AddToggleOption("NPC Invincible Frame", NPCInvincibleFrame, DAFlag)
		Set_DodgeFrequency = AddMenuOption("NPC Dodging Frequency", DodgeFrequency[DodgeFrequencyIndex], DAFlag)
		SetCursorPosition(1)
		AddHeaderOption("Dodge Roll")
		if(DodgeStyleIndex != 2)
			DS2Flag = 0
		else
			DS2Flag = 1
		endIf
		Slider_StaminaCostR = AddSliderOption("Stamina Cost", StaminaCostR, "{0}", DS2Flag)
		Slider_InvincibleFrameR = AddSliderOption("Invincible Time Frame", InvincibleFrameR, "{2}s", DS2Flag)
		AddEmptyOption()
		AddHeaderOption("Sidestep")
		if(DodgeStyleIndex != 1)
			DS3Flag = 0
		else
			DS3Flag = 1
		endIf
		Slider_StaminaCostS = AddSliderOption("Stamina Cost", StaminaCostS, "{0}", DS3Flag)
		Slider_InvincibleFrameS = AddSliderOption("Invincible Time Frame", InvincibleFrameS, "{2}s", DS3Flag)
		AddEmptyOption()
		AddHeaderOption("Uninstaller")
		ToggleUninstaller = AddToggleOption("Uninstall TUDM", Uninstaller, 0)
	endIf
endEvent

event OnOptionMenuAccept(int option, int index)
	if(option == Set_DodgeSpeed)
		DodgeSpeedMethodIndex = index
		SetMenuOptionValue(Set_DodgeSpeed, DodgeSpeedMethod[DodgeSpeedMethodIndex], false)
		if(DodgeSpeedMethodIndex == 0)
			SetMenuOptionValue(Set_DodgeSpeed, "Weight Dependent", false)
			UDDodgeSpeedMethod.setValueInt(DodgeSpeedMethodIndex)
			UDActivationQuest.DodgeSpeedMethod(DodgeSpeedMethodIndex)
			UDActivationQuest.weightCheck()
			ForcePageReset()
			change = true
		elseIf(DodgeSpeedMethodIndex == 1)
			SetMenuOptionValue(Set_DodgeSpeed, "Armor Dependent", false)
			UDDodgeSpeedMethod.setValueInt(DodgeSpeedMethodIndex)
			UDActivationQuest.DodgeSpeedMethod(DodgeSpeedMethodIndex)
			UDActivationQuest.armorCheck()
			ForcePageReset()
			change = true
		elseIf(DodgeSpeedMethodIndex == 2)
			SetMenuOptionValue(Set_DodgeSpeed, "Disable", false)
			UDDodgeSpeedMethod.setValueInt(DodgeSpeedMethodIndex)
			UDActivationQuest.DodgeSpeedMethod(DodgeSpeedMethodIndex)
			DodgeID = player.getAnimationVariableInt("DodgeID")
			if(DodgeID == 0)
				DodgeSpeed = 1
			elseIf(DodgeID == 1)
				DodgeSpeed = 1.647
			endIf
			player.setAnimationVariablefloat("DodgeSpeed", DodgeSpeed)
			ForcePageReset()
			change = true
		endIf
	endIf
	if(option == Set_DodgeFrequency)
		DodgeFrequencyIndex = index
		SetMenuOptionValue(Set_DodgeFrequency, DodgeFrequency[DodgeFrequencyIndex], false)
		if(DodgeFrequencyIndex == 0)
			SetMenuOptionValue(Set_DodgeFrequency, "Not frequent", false)
			change = true
		elseIf(DodgeFrequencyIndex == 1)
			SetMenuOptionValue(Set_DodgeFrequency, "Moderate", false)
			change = true
		elseIf(DodgeFrequencyIndex == 2)
			SetMenuOptionValue(Set_DodgeFrequency, "Frequent", false)
			change = true
		elseIf(DodgeFrequencyIndex == 3)
			SetMenuOptionValue(Set_DodgeFrequency, "Very frequent", false)
			change = true
		endIf
	endIf
	if(option == Set_DodgeStyle)
		DodgeStyleIndex = index
		self.SetMenuOptionValue(Set_DodgeStyle, DodgeStyle[DodgeStyleIndex], false)
		UDDodgeDynamicPause.setValueInt(0)
		if(DodgeStyleIndex == 0)
			SetMenuOptionValue(Set_DodgeStyle, "Roll + Sidestep", false)
			UDDodgeStyle.setValueInt(0)
			ForcePageReset()
			UDNPCDodgeAIQuest.MCMAIUpdate()
			change = true
		elseIf(DodgeStyleIndex == 1)
			SetMenuOptionValue(Set_DodgeStyle, "Roll only", false)
			UDDodgeStyle.setValueInt(1)
			player.setAnimationVariableInt("DodgeID", 0)
			UDActivationQuest.dodgeSpeedCheck(0)
			ForcePageReset()
			UDNPCDodgeAIQuest.MCMAIUpdate()
			change = true
		elseIf(DodgeStyleIndex == 2)
			SetMenuOptionValue(Set_DodgeStyle, "Sidestep only", false)
			UDDodgeStyle.setValueInt(2)
			player.setAnimationVariableInt("DodgeID", 1)
			UDActivationQuest.dodgeSpeedCheck(1)
			ForcePageReset()
			UDNPCDodgeAIQuest.MCMAIUpdate()
			change = true
		endIf
	endIf
	if(option == Set_DDodgeStyle)
		DDodgeStyleIndex = index
		self.SetMenuOptionValue(Set_DDodgeStyle, DDodgeStyle[DDodgeStyleIndex], false)
		UDDodgeDynamicPause.setValueInt(0)
		if(DDodgeStyleIndex == 0)
			SetMenuOptionValue(Set_DDodgeStyle, "Last used", false)
			UDActivationQuest.DDodgeStyle(0)
		elseIf(DDodgeStyleIndex == 1)
			SetMenuOptionValue(Set_DDodgeStyle, "Roll only", false)
			UDActivationQuest.DDodgeStyle(1)
			if(player.getCombatState() == 0)
				player.setAnimationVariableInt("DodgeID", 0)
				UDActivationQuest.dodgeSpeedCheck(0)
			endIf
		elseIf(DDodgeStyleIndex == 2)
			SetMenuOptionValue(Set_DDodgeStyle, "Sidestep only", false)
			UDActivationQuest.DDodgeStyle(2)
			if(player.getCombatState() == 0)
				player.setAnimationVariableInt("DodgeID", 1)
				UDActivationQuest.dodgeSpeedCheck(1)
			endIf
		endIf
	endIf
	if(option == Set_SneakStyle)
		SneakStyleIndex = index
		self.SetMenuOptionValue(Set_SneakStyle, SneakStyle[SneakStyleIndex], false)
		if(SneakStyleIndex == 0)
			SetMenuOptionValue(Set_SneakStyle, "Sneak Style 1", false)
		elseIf(SneakStyleIndex == 1)
			SetMenuOptionValue(Set_SneakStyle, "Sneak Style 2", false)
		endIf
		UDSneakStyle.setValue(SneakStyleIndex)
	endIf
endEvent

event OnOptionHighlight(int option)
	if(option == Set_DodgeKey)
		SetInfoText("Dodge Key cannot be set through MCM but can be done through vanilla control configuration. \nSneak Key in the control configuration is treated as Dodge Key.")
	elseIf(option == Set_DodgeToggleKey)
		SetInfoText("When ROLL + SIDESTEP is selected, option selected will not be changed. \nWhen either ROLL or SIDESTEP is seleceted, it will changed to one another. \nIf it is toggled during non-combat state, default dodging style will change except when LAST USED is selected. \nIf held, it will switch between ROLL + SIDESTEP (or LAST USED) to either dodging style or the other way round. \n WARNING: Do not bind this key to dodge key or to sneak key. Default: G")
	elseIf(option == Set_DodgeSpeed)
		SetInfoText("Method of calculating dodge speed. Default: Weight Dependent \nWeight Dependent: only subjected to speed reduction when above 50% \nArmor Dependent: only subjected to speed reduction for every heavy armor worn")
	elseIf(option == Set_DodgeFrequency)
		SetInfoText("The chance of NPC dodging an attack. Default: Frequent")
	elseIf(option == Set_DodgeStyle)
		SetInfoText("The dodging style that will be used in combat. Default: Roll + Sidestep \nChanging it during combat requires some time for it to take into affect for other NPC.")
	elseIf(option == Set_DDodgeStyle)
		SetInfoText("The dodging style that will be used in non-combat situation. Default: Last used")
	elseIf(option == Slider_StaminaCostR)
		SetInfoText("The cost of stamina for dodge roll. Default: 20")
	elseIf(option == Slider_StaminaCostS)
		SetInfoText("The cost of stamina for sidestep. Default: 10")
	elseIf(option == Slider_InvincibleFrameR)
		SetInfoText("The invincible time frame for dodge roll. Default: 0.40s")
	elseIf(option == Slider_InvincibleFrameS)
		SetInfoText("The invincible time frame for sidestep. Default: 0.25s")
	elseIf(option == Slider_DodgeSpeed)
		SetInfoText("The maximum dodge speed reduction and dodge speed reduction ratio. Default: 0.35 ratio")
	elseIf(option == ToggleDodgeLock)
		SetInfoText("Overwrite any default dodging style option with LAST USED and prevent it from changing when using the dodging style toggle key to switch dodging style while in non-combat state, combat dodging style will switch instead")
	elseIf(option == ToggleNPCDodgeAI)
		SetInfoText("Enable/Disable NPC Dodge AI")
	elseIf(option == ToggleNPCInvincibleFrame)
		SetInfoText("Enable/Disable NPC dodging invincible frame")
	elseIf(option == ToggleUninstaller)
		SetInfoText("Uninstall The Ultimate Dodge Mod. \nMake sure you are in an interior when toggling this with no NPC around including follower.")
	elseIf(option == ToggleGamepad)
		SetInfoText("Enable = Disable alternative key for sneaking \nDisable = Enable alternative key for sneaking")
	endIf
endEvent

event OnOptionDefault(int option)
	if(option == Slider_StaminaCostR)
		StaminaCostR = 20
		SetSliderOptionValue(Slider_StaminaCostR, StaminaCostR, "{0}", false)
	elseif(option == Slider_StaminaCostS)
		StaminaCostS = 10
		SetSliderOptionValue(Slider_StaminaCostS, StaminaCostS, "{0}", false)
	elseIf(option == Slider_InvincibleFrameR)
		InvincibleFrameR = 0.400000
		SetSliderOptionValue(Slider_InvincibleFrameR, InvincibleFrameR, "{2}s", false)
		UDIFrameR.setValue(InvincibleFrameR)
	elseIf(option == Slider_InvincibleFrameS)
		InvincibleFrameS = 0.250000
		SetSliderOptionValue(Slider_InvincibleFrameS, InvincibleFrameS, "{2}s", false)
		UDIFrameS.setValue(InvincibleFrameS)
	elseIf(option == Slider_DodgeSpeed)
		DodgeSpeed = 0.350000
		SetSliderOptionValue(Slider_DodgeSpeed, DodgeSpeed, "{2} ratio", false)
	endIf
endEvent

event OnOptionSliderOpen(int option)
	if(option == Slider_StaminaCostR)
		SetSliderDialogStartValue(StaminaCostR)
		SetSliderDialogDefaultValue(20)
		SetSliderDialogRange(0, 50)
		SetSliderDialogInterval(1)
	elseif(option == Slider_StaminaCostS)
		SetSliderDialogStartValue(StaminaCostS)
		SetSliderDialogDefaultValue(10)
		SetSliderDialogRange(0, 50)
		SetSliderDialogInterval(1)
	elseIf(option == Slider_InvincibleFrameR)
		SetSliderDialogStartValue(InvincibleFrameR)
		SetSliderDialogDefaultValue(0.400000)
		SetSliderDialogRange(0.00000, 0.800000)
		SetSliderDialogInterval(0.050000)
	elseIf(option == Slider_InvincibleFrameS)
		SetSliderDialogStartValue(InvincibleFrameS)
		SetSliderDialogDefaultValue(0.250000)
		SetSliderDialogRange(0.00000, 0.500000)
		SetSliderDialogInterval(0.050000)
	elseIf(option == Slider_DodgeSpeed)
		SetSliderDialogStartValue(DodgeSpeed)
		SetSliderDialogDefaultValue(0.350000)
		SetSliderDialogRange(0.000000, 0.500000)
		SetSliderDialogInterval(0.050000)
	endIf
endEvent

event OnOptionSliderAccept(int option, float value)
	if(option == Slider_StaminaCostR)
		StaminaCostR = value as int
		SetSliderOptionValue(Slider_StaminaCostR, StaminaCostR, "{0}", false)
		UDStaminaCostR.setValueInt(StaminaCostR)
		UDActivationQuest.staminaCostRCheck(StaminaCostR)
		change = true
	elseif(option == Slider_StaminaCostS)
		StaminaCostS = value as int
		SetSliderOptionValue(Slider_StaminaCostS, StaminaCostS, "{0}", false)
		UDStaminaCostS.setValueInt(StaminaCostS)
		UDActivationQuest.staminaCostSCheck(StaminaCostS)
		change = true
	elseIf(option == Slider_InvincibleFrameR)
		InvincibleFrameR = value
		SetSliderOptionValue(Slider_InvincibleFrameR, InvincibleFrameR, "{2}s", false)
		UDIFrameR.setValue(InvincibleFrameR)
		UDActivationQuest.invincibleFrameRCheck(InvincibleFrameR)
		change = true
	elseIf(option == Slider_InvincibleFrameS)
		InvincibleFrameS = value
		SetSliderOptionValue(Slider_InvincibleFrameS, InvincibleFrameS, "{2}s", false)
		UDIFrameS.setValue(InvincibleFrameS)
		UDActivationQuest.invincibleFrameSCheck(InvincibleFrameS)
		change = true
	elseIf(option == Slider_DodgeSpeed)
		DodgeSpeed = value
		SetSliderOptionValue(Slider_DodgeSpeed, DodgeSpeed, "{2} ratio", false)
		UDMaxSpeedPenalty.setValue(DodgeSpeed)
		UDActivationQuest.maxSpeedPenaltyCheck(DodgeSpeed)
		UDActivationQuest.weightCheck()
		UDActivationQuest.armorCheck()
		change = true
	endIf
endEvent

event OnOptionSelect(int option)
	if(option == ToggleNPCInvincibleFrame)
		NPCInvincibleFrame = !NPCInvincibleFrame
		SetToggleOptionValue(ToggleNPCInvincibleFrame, NPCInvincibleFrame, false)
		change = true
	elseIf(option == ToggleNPCDodgeAI)
		NPCDodgeAI = !NPCDodgeAI
		SetToggleOptionValue(ToggleNPCDodgeAI, NPCDodgeAI, false)
		UDNPCDodgeAIGlobal.setValueInt(NPCDodgeAI as int)
		ForcePageReset()
		UDNPCDodgeAIQuest.MCMAIUpdate()
		change = true
	elseIf(option == ToggleGamepad)
		Gamepad = !Gamepad
		SetToggleOptionValue(ToggleGamepad, Gamepad, false)
		UDGamepad.setValueInt(Gamepad as int)
		UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.StealthMeterInstance._alpha",100)
		UDSKSEFunctionsQuest.gamepad(Gamepad)
		ForcePageReset()
	elseIf(option == ToggleDodgeLock)
		DodgeLock = !DodgeLock
		SetToggleOptionValue(ToggleDodgeLock, DodgeLock, false)
		if(DodgeLock == true)
			UDActivationQuest.DDodgeStyle(0)
		else
			UDActivationQuest.DDodgeStyle(DDodgeStyleIndex)
			bool combat = playerRef.isInCombat()
			if(DDodgeStyleIndex == 1) && (combat == false)
				player.setAnimationVariableInt("DodgeID", 0)
				UDActivationQuest.dodgeSpeedCheck(0)
			elseIf(DDodgeStyleIndex == 2) && (combat == false)
				player.setAnimationVariableInt("DodgeID", 1)
				UDActivationQuest.dodgeSpeedCheck(1)
			endIf
		endIf
		ForcePageReset()
	elseIf(option == ToggleUninstaller)
		Uninstaller = !Uninstaller
		SetToggleOptionValue(ToggleUninstaller, Uninstaller, false)
		UDActivationQuestUninstall.stop()
		UDNPCDodgeAIQuestUninstall.stop()
		UDConfigurationQuest.stop()
		UDSKSEFunctionsQuestUninstall.stop()
		UDNPCDodgeAIGlobal.SetValueInt(0)
		debug.messageBox("You may remove The Ultimate Dodge Mod now")
		ForcePageReset()
	endIf
endEvent

event OnOptionKeyMapChange(int option, int KeyCode, string ConflictControl, string ConflictName)
	if(option == Set_SneakKey)
		SneakKey = KeyCode
		SetKeyMapOptionValue(Set_SneakKey, SneakKey, false)
		UDSKSEFunctionsQuest.setSneakKey(SneakKey)
	elseIf(option == Set_DodgeToggleKey)
		DodgeToggleKey = KeyCode
		SetKeyMapOptionValue(Set_DodgeToggleKey, DodgeToggleKey, false)
		UDSKSEFunctionsQuest.setDodgeToggleKey(DodgeToggleKey)
	endIf
endEvent

event OnConfigClose()
	if(change == true)
		UDNPCDodgeAIQuest.MCMDodgeStyleRefresh()
		change = false
	endIf
endEvent

function DodgeStyleToggle(int StyleID, bool combat)
	DodgeStyleIndex = UDDodgeStyle.getValueInt()
	if(DodgeStyleIndex != 0)
		DodgeStyleIndex = styleID
		UDDodgeStyle.setValueInt(styleID)
		debug.notification("Combat Dodging Style: " + dodgestylestring(styleID))
	elseIf(DodgeStyleIndex == 0) && (DDodgeStyleIndex != 0) && (combat == false) && (DodgeLock == false)
		ChangeDDodgeStyle(styleID)
		debug.notification("Default Dodging Style: " + dodgestylestring(styleID))
	endIf
	if(combat == true)
		UDNPCDodgeAIQuest.MCMDodgeStyleToggle(true)
	endIf
endFunction

function ChangeDodgeStyle(int StyleID)
	DodgeStyleIndex = styleID
endFunction

function ChangeDDodgeStyle(int StyleID)
	DDodgeStyleIndex = styleID
	UDActivationQuest.DDodgeStyle(styleID)
endFunction


;------------------------------------------------------------- Out Functions -------------------------------------------------------------

int function DodgeStyle()
	return DodgeStyleIndex
endFunction

int function DDodgeStyle()
	return DDodgeStyleIndex
endFunction

int function DodgeSpeedMethod()
	return DodgeSpeedMethodIndex
endFunction

bool function LastUsedDodgeStyle()
	if(DDodgeStyleIndex == 0)
		return true
	else
		return false
	endIf
endFunction

bool function DodgeLock()
	return DodgeLock
endFunction

string function dodgestylestring(int styleID)
	if(styleID == 1)
		return "Roll"
	else
		return "Sidestep"
	endIf
endFunction