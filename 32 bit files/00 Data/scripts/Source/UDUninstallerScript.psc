Scriptname UDUninstallerScript extends activemagiceffect  

spell property UDBattleReadySpell auto
spell property UDCallToArmsSpell auto
spell property UDToArmsSpell auto
spell property UDConfigurationSpell auto
quest property UDActivationQuest auto
quest property UDNPCDodgeAIQuest auto
quest property UDStaminaConfiguration auto
actor property PlayerRef auto
globalvariable property UDNPCDodgeAIGlobal auto

actor player


event onEffectStart(actor akTarget, actor akCaster)
	akTarget.removeSpell(UDBattleReadySpell)
	akTarget.removeSpell(UDCallToArmsSpell)
	akTarget.removeSpell(UDToArmsSpell)
	player = PlayerRef
	debug.notification("Uninstalling The Ultimate Dodge Mod...")
	player.removeSpell(UDBattleReadySpell)
	player.removeSpell(UDCallToArmsSpell)
	player.removeSpell(UDToArmsSpell)
	player.removeSpell(UDConfigurationSpell)
	UDActivationQuest.stop()
	UDNPCDodgeAIQuest.stop()
	UDStaminaConfiguration.stop()
	UDNPCDodgeAIGlobal.SetValueInt(0)
	utility.wait(3)
	debug.notification("Uninstall complete. You may safely remove TUD now")
endEvent