Scriptname UDPlayerInventoryFlow extends activemagiceffect  

actor property PlayerRef auto

spell property UDPlayerWeightUpdateSpell auto


;------------------------------------------------------------- Events -------------------------------------------------------------

event OnItemAdded(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	playerRef.addSpell(UDPlayerWeightUpdateSpell, false)
endEvent

event OnItemRemoved(Form akBaseItem, Int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	playerRef.addSpell(UDPlayerWeightUpdateSpell, false)
endEvent