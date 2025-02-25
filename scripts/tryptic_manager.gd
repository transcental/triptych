extends Node


## How many windows to create. Each will be assigned to ViewportN where N is the window number.
## Do [b]not[/b] change this if you don't know [b][i]exactly[/i][/b] what you're doing
## @experimental
@export var number_of_windows = 3

var windows = []

var mywin = Window.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().set_embedding_subwindows(false)
	for n in range(1, number_of_windows + 1):
		var win = Window.new()
		add_child(win)
		win.visible = true
		
		win.position = Vector2(1500/n, 1500/n)
		win.title = "Window %s" % n
		win.size = Vector2(1500, 1500)
		windows.append(win)
		
		var vp = get_node("Viewport%s" % n)
		var label = Label.new()
		win.add_child(label)
		label.text = "This is window %s for the tryptic!" % n
		#win.add_child(vp)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
