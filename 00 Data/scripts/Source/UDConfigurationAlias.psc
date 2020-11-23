Scriptname UDConfigurationAlias extends ReferenceAlias  

actor property PlayerRef auto

spell property UDUninstallerSpell auto
spell property UDConfigurationSpell auto

event OnInit()
	if(SKSE.getVersionRelease() > 0)
		playerRef.removeSpell(UDUninstallerSpell)
		playerRef.removeSpell(UDConfigurationSpell)
	else

		playerRef.addSpell(UDUninstallerSpell, false)
		playerRef.addSpell(UDConfigurationSpell, false)
	endIf
endEvent

event OnPlayerLoadGame()
	if(SKSE.getVersionRelease() > 0)
		playerRef.removeSpell(UDUninstallerSpell)
		playerRef.removeSpell(UDConfigurationSpell)
	else
		playerRef.addSpell(UDUninstallerSpell, false)
		playerRef.addSpell(UDConfigurationSpell, false)
	endIf
endEvent