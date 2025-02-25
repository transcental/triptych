
extends Control

@export var triptych_manager: Node


func _ready() -> void:
	if not triptych_manager:
		push_error("You need to set Triptych Manager in the inspector")
		get_tree().quit()


func _on_level_1_pressed() -> void:
	triptych_manager.next_level()
