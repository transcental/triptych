extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var label = Label.new()
	var cubes = 0
	for child in get_children():
		if child is CharacterBody3D:
			cubes += 1;
			
	var path = scene_file_path
	label.text = "Path: %s Cubes: %s" % [path, cubes]
	add_child(label)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
