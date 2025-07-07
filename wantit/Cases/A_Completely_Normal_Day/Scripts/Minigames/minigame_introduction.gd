extends Location

var ziel_input: bool = false

var explanation: Array[Label] 

@onready var explanation_start: Label = $explanation_start
@onready var explanation_connection: Label = $explanation_connection
@onready var explanation_try_start: Label = $explanation_try_start
@onready var explanation_try_start_2: Label = $explanation_try_start2
@onready var explanation_gatter: Label = $explanation_Gatter
@onready var explanation_ziel: Label = $explanation_Ziel
@onready var explanation_end: Label = $explanation_end

@onready var next_button: Button = $next_button
@onready var back_button: Button = $back_button
@onready var end_button: Button = $end_button

@onready var good_job: TextureRect = $Good_job

func _ready() -> void:
	GlobalTimer.add_log_entry("entered scene: minigame_introduction")
	explanation = [
		explanation_start,
		explanation_connection,
		explanation_try_start,
		explanation_try_start_2,
		explanation_gatter,
		explanation_ziel,
		explanation_end
	]

func _process(_delta: float) -> void:
	if explanation_end.visible:
		end_button.show()

func _on_next_button_pressed() -> void:
	
	for x in range(explanation.size() - 1):
		if explanation[x].visible:
			explanation[x].hide()
			explanation[x + 1].show()
			back_button.show()
			if explanation[x] == explanation_connection:
				next_button.hide()
				
			
			if x == (explanation.size() - 2):
				next_button.hide()
			
			break

func _on_back_button_pressed() -> void:
	for x in range(explanation.size()):
		if explanation[x].visible:
			explanation[x].hide()
			explanation[x - 1].show()
			if explanation[x] != explanation_try_start_2:
				next_button.show()
			
			
			if (x - 1) == 0:
				back_button.hide()
				
			break

func _on_logik_gatter_level_introduction_start_1() -> void:
	if explanation_try_start.visible:
		explanation_try_start.hide()
		explanation_try_start_2.show()

func _on_logik_gatter_level_introduction_start_2() -> void:
	if explanation_try_start_2.visible:
			explanation_try_start_2.hide()
			explanation_gatter.show()
			next_button.show()

func _on_end_button_pressed() -> void:
	if ziel_input:
		# text das es geschaft wurde
		explanation_end.text = "Du hast es geschafft das Signal ist beim ZIel angekommen"
		#übergang zum richtigen minispiel
		good_job.show()
		explanation_end.hide()
	else: 
		#text das das signal noch nicht beim ziel ist
		explanation_end.text = "Das Signal ist noch nicht beim Ziel angekommen"

func _on_logik_gatter_level_introduction_ziel_input_false() -> void:
	ziel_input = false

func _on_logik_gatter_level_introduction_ziel_input_true() -> void:
	ziel_input = true

func _on_start_minigame_1_pressed() -> void:
	#GlobalTimer.end_timer("Logik Gatter Mini Games")
	var interaction_item_log_tutorial_complete = Item.new()
	interaction_item_log_tutorial_complete.item_name = "log_tutorial_complete"
	item_found.emit(interaction_item_log_tutorial_complete)
	print("log_tutorial_complete_akwjgerfesuhkjfh")
