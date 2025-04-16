extends Node2D

var HintArr := []

func _ready() -> void:
	var dir = DirAccess.open("user://")
	dir.make_dir("Assets")
	
	for Hint in CaseManager.Hints:
		add_Hint(Hint)
	
	HintArr = %Hinweise.get_children()
	connect_hints()
	
	screenshot()

func add_Hint(Hint: CaseManager.Hint):
	var newHint = Sprite2D.new()
	newHint.position = Hint.HintPos
	newHint.texture = Hint.HintTexture
	%Hinweise.add_child(newHint)
	
func connect_hints():
	$Line2D.clear_points()
	var CurvedLine = Curve2D.new()
	for i in HintArr.size():
		var HintPos : Vector2 = HintArr[i].position
		var inPoint: Vector2
		if i < HintArr.size() - 1:
			inPoint = 0.2 * (HintPos + HintArr[i + 1].position)
		else:
			inPoint = 0.2 * (HintPos + HintArr[i - 1].position)
		CurvedLine.add_point(HintPos, inPoint)
	var CurvedArr = CurvedLine.get_baked_points()
	for point in CurvedArr:
		$Line2D.add_point(point)

func screenshot():
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("user://Assets/Hinweistafel.png")
	%"Back Button".visible = true
