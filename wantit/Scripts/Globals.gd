extends Node

var nextScene: CaseManager.Location
var selectedCase: CaseManager.Case

var OfficeDialogue: String		# Could be changed to dialogue path type if found out what it is
var OfficeDialogueStart: String
var OfficeDialogueDone: bool = false

var tutorial: PackedScene
var minigame: PackedScene

var portrait: CompressedTexture2D
var npc_icon: CompressedTexture2D
