Scriptname UDNPCDodgeAI extends ReferenceAlias  

UDNPCDodgeAICore property UDNPCDodgeAIQuest auto

event OnInit()
	UDNPCDodgeAIQuest.MCMAIUpdate()
	registerForSingleUpdate(1)
endEvent

event OnUpdate()
	UDNPCDodgeAIQuest.battleReady()
	registerForSingleUpdate(4)
endEvent