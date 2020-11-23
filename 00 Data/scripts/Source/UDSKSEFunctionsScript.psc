Scriptname UDSKSEFunctionsScript extends Quest  

actor property PlayerRef auto

globalvariable property UDGamepad auto
globalvariable property UDDodgeStyle auto

idle property SneakStartPlayer auto
idle property SneakStopPlayer auto

quest property MQ101 auto

UDActivationScript property UDActivationQuest auto
UDMCMMenuScript property UDMCMMenu auto
UDNPCDodgeAICore property UDNPCDodgeAIQuest auto

int warningcount = 0
int SneakKey
int DodgeToggleKey = 34

bool changedone = false


;------------------------------------------------------------- Events -------------------------------------------------------------

event OnInit()
	if(MQ101.isRunning()) && (MQ101.isStageDone(255) == false)
		NewGame()
	endIf
endEvent

event OnKeyDown(int KeyCode)
	if(playerRef.IsSneaking() == 0) && (playerRef.IsSprinting() == 0) && (KeyCode == SneakKey)
		playerRef.playIdle(SneakStartPlayer)
		ResetSneakEye()
	elseIf(playerRef.IsSneaking() == 1) && (KeyCode == SneakKey)
		playerRef.playIdle(SneakStopPlayer)
		ResetSneakEye()
	elseIf(KeyCode == DodgeToggleKey)
		PreDodgeStyleChange(0)
	endIf
endEvent

event OnKeyUp(int KeyCode, Float HoldTime)
	if(KeyCode == DodgeToggleKey) && (HoldTime < 0.5)
		if(playerRef.getAnimationVariableInt("IsDodging") == 0)
			warningcount = 0
			Stage2DodgeChange()
		else
			Stage2DodgeChange()
			Warning()
		endIf
	elseIf(KeyCode == DodgeToggleKey) && (HoldTime >= 0.5)
		if(changedone == false)
			if(playerRef.isInCombat() == true)
				ChangeCDodgeStyle()
			else
				if(UDDodgeStyle.getValueInt() == 0) && (UDMCMMenu.DodgeLock() == false)
					ChangeDDodgeStyle()
				else
					ChangeCDodgeStyle()
				endIf
			endIf
		else
			changedone = false
		endIf
	endIf
endEvent

event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if(asEventName == "FootLeft")
		if(MQ101.isStageDone(255)) || (MQ101.isRunning() == false)
			unregisterForAnimationEvent(playerRef, "FootLeft")
			if(UDGamepad.getValueInt() == false)
				goToState("normal")
			else
				goToState("gamepad")
			endIf
		endIf
	endIf
endEvent


;------------------------------------------------------------- States -------------------------------------------------------------

state newgame
	event OnKeyDown(int KeyCode)
	endEvent

	event OnKeyUp(int KeyCode, float HoldTime)
	endEvent
endState

state gamepad
	event OnKeyDown(int KeyCode)
		if(KeyCode == DodgeToggleKey)
			PreDodgeStyleChange(0)
		endIf
	endEvent
endState

state warning
	function Warning()

	endFunction
endState

;------------------------------------------------------------- In Functions -------------------------------------------------------------

function ResetSneakEye()
	UI.SetNumber("HUD Menu", "_root.HUDMovieBaseInstance.StealthMeterInstance._alpha", SneakEyeAlpha(IsSneaking(), 100))
endFunction

function SetSneakKey(int newSneakKey)
	UnRegisterForKey(SneakKey)
	SneakKey = newSneakKey
	registerForKey(SneakKey)
endFunction

function SetDodgeToggleKey(int newDodgeToggleKey)
	UnRegisterForKey(DodgeToggleKey)
	DodgeToggleKey = newDodgeToggleKey
	registerForKey(DodgeToggleKey)
endFunction

function NewGame()
	registerForAnimationEvent(playerRef, "FootLeft")
	goToState("newgame")
endFunction

function Stage2DodgeChange()
	bool combat = playerRef.isInCombat()
	int DodgeStyle = UDDodgeStyle.getValueInt()
	if(playerRef.getAnimationVariableInt("DodgeID") == 0)
		playerRef.setAnimationVariableInt("DodgeID", 1)
		UDActivationQuest.dodgeSpeedCheck(1)
		if(DodgeStyle == 0) && (combat == 1)
			UDNPCDodgeAIQuest.MCMDodgeStyleToggle(true)
		else
			UDMCMMenu.dodgeStyleToggle(2, combat)
		endIf
	else
		playerRef.setAnimationVariableInt("DodgeID", 0)
		UDActivationQuest.dodgeSpeedCheck(0)
		if(DodgeStyle == 0) && (combat == 1)
			UDNPCDodgeAIQuest.MCMDodgeStyleToggle(true)
		else
			UDMCMMenu.dodgeStyleToggle(1, combat)
		endIf
	endIf
endFunction

function Warning()
	if(warningcount >= 5)
		goToState("warning")
		debug.messageBox("CAUTION: Dodging style toggle key must not be the same key as dodging key and sneaking key!!")
		utility.wait(0.5)
		if(UDGamepad.getValueInt() == 0)
			goToState("normal")
		else
			goToState("gamepad")
		endIf
	endIf
	warningcount += 1
endFunction

function PreDodgeStyleChange(int count)
	utility.wait(0.05)
	if(input.isKeyPressed(DodgeToggleKey))
		if(count == 10)
			DodgeStyleChange()
		else
			int temp = count + 1
			PreDodgeStyleChange2(temp)
		endIf
	endIf
endFunction

function PreDodgeStyleChange2(int count)
	utility.wait(0.05)
	if(input.isKeyPressed(DodgeToggleKey))
		int temp = count + 1
		PreDodgeStyleChange(temp)
	endIf
endFunction

function DodgeStyleChange()
	utility.wait(0.1)
	if(input.isKeyPressed(DodgeToggleKey))
		warningcount = 0
		if(playerRef.isInCombat() == true)
			ChangeCDodgeStyle()
		else
			if(UDDodgeStyle.getValueInt() == 0) && (UDMCMMenu.DodgeLock() == false)
				ChangeDDodgeStyle()
			else
				ChangeCDodgeStyle()
			endIf
		endIf
		changedone = true
	endIf
endFunction

function ChangeCDodgeStyle()
	if(UDDodgeStyle.getValueInt() != 0)
		UDDodgeStyle.setValueInt(0)
		debug.notification("Combat Dodging Style: Roll + Sidestep")
		UDNPCDodgeAIQuest.MCMDodgeStyleRefresh()
		UDMCMMenu.ChangeDodgeStyle(0)
	else
		int dodgeID = playerRef.getAnimationVariableInt("DodgeID")
		UDDodgeStyle.setValueInt(dodgeID + 1)
		debug.notification("Combat Dodging Style: " + dodgestylestring(dodgeID))
		UDNPCDodgeAIQuest.MCMDodgeStyleRefresh()
		UDMCMMenu.ChangeDodgeStyle(dodgeID + 1)
	endIf
endFunction

function ChangeDDodgeStyle()
	if(UDMCMMenu.DDodgeStyle() != 0)
		UDMCMMenu.ChangeDDodgeStyle(0)
		debug.notification("Default Dodging Style: Last Used")
	else
		int dodgeID = playerRef.getAnimationVariableInt("DodgeID")
		UDMCMMenu.ChangeDDodgeStyle(dodgeID+1)
		debug.notification("Default Dodging Style: " + dodgestylestring(dodgeID))
	endIf
endFunction

function gamepad(bool newgamepad)
	if(newgamepad == true)
		goToState("gamepad")
	else
		goToState("normal")
	endIf
endFunction


;------------------------------------------------------------- Out Functions -------------------------------------------------------------

bool function IsSneaking()
	return Game.GetPlayer().isSneaking()
endFunction

float function SneakEyeAlpha(bool visible, float max)
	if visible
		return max
	endif
	return 0
endFunction

string function dodgestylestring(int dodgeID)
	if(dodgeID == 0)
		return "Roll"
	else
		return "Sidestep"
	endIf
endFunction