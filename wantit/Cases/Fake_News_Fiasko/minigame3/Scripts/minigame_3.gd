extends Minigame

var selected_post: Control
var selected_scrollable_post: post
var statement_counter: int = 0
var level: int = 0
var relevant_posts = []
var wrong_posts = []

func _ready() -> void:
	self.START("fnf_3.1", 11)
	for scrollable_post in %VBoxContainer.get_children():
		scrollable_post.Post_selected.connect(_on_post_selected)
	set_statements()
	set_level()
	check_statement_count()

func _on_post_selected(Post: Control, scrollable_post: post):
	if selected_post != null:
		selected_post.hide()
	
	selected_scrollable_post = scrollable_post
	selected_post = Post
	Post.show()

func set_statements():
	%StatementsMaria.set_text(statement_counter)
	%StatementHonigwald.set_text(statement_counter)

func check_statement_count():
	%Button.disabled = false
	%Button2.disabled = false
	if statement_counter == 0:
		%Button.disabled = true
	elif statement_counter == 5:
		%Button2.disabled = true
		

func button_clicked(num: int):
	statement_counter += num
	set_statements()
	check_statement_count()

func _on_button_pressed() -> void:
	button_clicked(-1)

func _on_button_2_pressed() -> void:
	button_clicked(1)


func _on_check_solution_pressed() -> void:
	check_solution()

func check_solution():
	var answers_correct: bool = true
	if level == 0:
		answers_correct =  check_elements("is_relevant")
	elif level == 1:
		answers_correct = check_elements("is_convincing")
			
	if answers_correct:
		#await DialogueManager ...
		level += 1
		set_level()
	else:
		#await DialogueManager ...
		relevant_posts = relevant_posts.filter(func(item):
			return not wrong_posts.has(item))
		
		for element in wrong_posts:
			element.show()
		wrong_posts = []

func set_level():
	if level == 0:
		%Option1.text = "Relevant"
		%Option2.text = "Irrelevant"
	elif level == 1:
		self.END()
		DialogueManager.show_dialogue_balloon_scene(
			location_dialogue.baloon_type,
			location_dialogue.dialogue_resource,
			"minigame_first_part_completed")
		await DialogueManager.dialogue_ended
		var interaction_item = Item.new()
		interaction_item.item_name = "minigame first part completed"
		item_found.emit(interaction_item)
		%Option1.text = "Glaubwürdig"
		%Option2.text = "Unglaubwürdig"
		for element in %VBoxContainer.get_children():
			print(element)
			element.show()
			if element not in relevant_posts:
				print("removing", element)
				%VBoxContainer.remove_child(element)
		self.START("fnf_3.2", 3)
	else:
		self.END()
		var interaction_item = Item.new()
		interaction_item.item_name = "Minigame3 completed"
		item_found.emit(interaction_item)
		
	relevant_posts = []

func _on_option_1_pressed() -> void:
	if selected_post != null and selected_scrollable_post != null:
		relevant_posts.append(selected_scrollable_post)
		selected_post.hide()
		selected_scrollable_post.hide()

func _on_option_2_pressed() -> void:
	if selected_post != null and selected_scrollable_post != null:
		selected_post.hide()
		selected_scrollable_post.hide()

func check_elements(var_name: String) -> bool:
	var answers_correct = true
	var correct_selections = 0
	for element in %VBoxContainer.get_children():
		if element.get(var_name) and element not in relevant_posts:
			wrong_posts.append(element)
			answers_correct = false
		elif not element.get(var_name) and element in relevant_posts:
			wrong_posts.append(element)
			answers_correct = false
		else:
			correct_selections += 1
	self.TRY(wrong_posts.size(), correct_selections)
	return answers_correct
