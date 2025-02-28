extends Node


## How many windows to create. Each will be assigned to ViewportN where N is the window number.
## Do [b]not[/b] change this if you don't know [b][i]exactly[/i][/b] what you're doing
## @experimental
@export var number_of_windows = 3

var current_level = 0
var windows = []

const LEVEL_DIR = "res://scenes/levels"


func _ready() -> void:
	get_viewport().set_embedding_subwindows(false)
	for n in range(1, number_of_windows + 1):
		var win = Window.new()
		add_child(win)
		win.visible = true
		
		win.position = Vector2(3000, 3000) / n
		win.title = "Window %s" % n
		win.size = Vector2(1500, 1500)
		windows.append(win)
		
		#var label = Label.new()
#
		#label.text = "This is window %s for the tryptic!" % n
		
		var vp = SubViewport.new()
		#vp.add_child(label)
		win.add_child(vp)
		
		var sprite = Sprite2D.new()
		sprite.centered = false
		sprite.texture = vp.get_texture()
		win.add_child(sprite)


func next_level(override: int = -1) -> void:
	var level = override
	if level == -1:
		level = current_level + 1

	
	# Append new levels
	var level_dir = DirAccess.open("%s/%s" % [LEVEL_DIR, level])
	var new_levels = []
	if level_dir:
		var files = level_dir.get_files()
		for file in files:
			print("Found file: %s" % file)
			new_levels.append(file)
	else:
		push_warning("Level %s not found - end of game?" % level)
		return

	for i in windows.size():
		var win: Window = windows[i]
		var vp = win.get_child(0)
		var children = vp.get_children()
		var scenes = []
		
		# Delete old levels from the nodes
		for child in children:
			if child is Node:
				scenes.append(child)

		if scenes.size() == windows.size():
			for scene in scenes:
				vp.remove_child(scene)
		elif level == 0:
			pass
		elif override != -1 :
			push_warning("How did we get here.....")
		else:
			push_warning("Prior scenes not found - assuming non existent. (This should only happen in a manual debug override)")
			
		if new_levels.size() == windows.size():
			var path = "%s/%s/%s" % [LEVEL_DIR, level, new_levels[i]]
			print("Window: %s | Screen: %s" % [i, path])
			var scene = load(path)
			var instance = scene.instantiate()
			
			vp.add_child(instance)
		else:
			push_error("There aren't enough scenes for level %s" % level)
	

	current_level = level
