extends Control
@onready var menu = preload("res://Menu/menu.tscn")

func _on_btn_back_button_down() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
