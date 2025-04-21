extends Node

var nextScene: CaseManager.Location
var selectedCase: CaseManager.Case

var OfficeDialogue: String		# Could be changed to dialogue path type if found out what it is
var OfficeDialogueStart: String

# Temporary because of the Cäsar Case
var portrait: CompressedTexture2D

var map_clicked: bool = false
var items_found: int = 0 # Could be resolved by combinig Küche and tatort into one scene

# tbd dont like it
var CrimeScene_visited: bool = false
var verschiebung_found: bool = false
var schluesselwort_found: bool = false
var secret_message_found: bool = false

var had_tutorial: bool = false
var caesar_decrypted: bool = false
var culprit_found: bool = false

var optional_route: bool = false
var Ende: int
