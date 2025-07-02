extends Location
var columns = 8
var solution = "10100010" + "00000001" + "11100011" + "10100110" + "11100011" + "00000010" + "00100001" + "11001100"

func add_solution_Grid(Grid: GridContainer):
	for i in range(columns * columns):
		var rect = ColorRect.new()
		rect.custom_minimum_size = Vector2(Grid.size.x / columns, Grid.size.y / columns)
		if solution[i] == "1":
			rect.color = Color(224,224,224)
		elif solution[i] == "0":
			rect.color = Color(0, 0, 0)
		Grid.add_child(rect)

func _on_paper_visibility_changed() -> void:
	%SolutionGrid.columns = columns
	add_solution_Grid(%SolutionGrid)
