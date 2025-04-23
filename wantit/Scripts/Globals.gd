extends Node

var nextScene: CaseManager.Location
var selectedCase: CaseManager.Case

var OfficeDialogue: String		# Could be changed to dialogue path type if found out what it is
var OfficeDialogueStart: String

var tutorial: PackedScene
var minigame: PackedScene

var CaseGlobals: Node = null # The script for Globals in each Case will be loaded in here. The Globals can be accessed via: Globals.CaseGlobals.<var_name>

var portrait: CompressedTexture2D
var npc_icon: CompressedTexture2D
