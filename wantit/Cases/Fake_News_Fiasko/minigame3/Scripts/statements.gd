extends Control

@export_enum("Maria", "Honigwald") var Speaker
var Actual_Speaker = ["Maria:", "Honigwald:"]

var statementsMaria = [
	"Ich überprüfe meine Zutaten regelmäßig – jemand muss sie da platziert haben.",
	"Honigwald hat das Gift in meiner Küche platziert, um mein Business zu sabotieren.",
	"Ich habe nie jemanden gebeten, etwas zu fälschen.",
	"Ich war während des gesamten Abends sichtbar im Gastraum, ich hatte keine Gelegenheit, etwas zu manipulieren.",
	"Ich bin persönlich bei jedem betroffenen Gast im Krankenhaus gewesen.",
	"Ich habe ein ungutes Gefühl bei meinem neuen Aushilfskoch – eingestellt über Empfehlung vom Rathaus."
	]
var statementsHonigwald = [
	"Das angebliche Gift stammt aus ihrer eigenen Küche – das war kein Zufall.",
	"Nein! Das war Maria selbst und behauptet jetzt, dass ich es gewesen bin, um mich öffentlich zu ruinieren.",
	"Bitza manipuliert Gäste mit Fake-Bewertungen – so kommt sie an ihre Sterne.",
	"Wer sagt denn, dass sie nicht doch mal kurz in der Küche war? Es gibt keine Beweise für das Gegenteil.",
	"Sie spielt jetzt den Samariter, aber das macht den Schaden nicht ungeschehen.",
	"Jetzt schiebt sie’s auf ihre Leute – typisch!"
]

func _ready() -> void:
	%Speaker.text = Actual_Speaker[Speaker]

func set_text(Statement_num: int):
	var Statement: String
	match Speaker:
		0: Statement = statementsMaria[Statement_num]
		1: Statement = statementsHonigwald[Statement_num]
	%Label.text = Statement
