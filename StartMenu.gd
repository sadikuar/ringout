#---tool
#---class_name
extends Control
#--- docstring

#---signals

#---enums

#---constants

#---preloaded scripts and scenes

#---exported variables

#---public variables

#---private variables

#---onready variables


#---optional built-in virtual _init method

#---built-in virtual _ready method

#---remaining built-in virtual methods

#---public methods

#---private methods

#---inner classes

#---signal methods

func _on_StartGame_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Ring.tscn")


func _on_Options_pressed() -> void:
	pass # Replace with function body.


func _on_QuitGame_pressed() -> void:
	queue_free()
