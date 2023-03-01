extends Control

#---signal methods

func _on_StartGame_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Ring.tscn")


func _on_Options_pressed() -> void:
	pass # Replace with function body.


func _on_QuitGame_pressed() -> void:
	queue_free()
