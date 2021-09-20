""" Detect touch inputs and dispatch signals to the Slingshot node.
"""
extends Area2D

signal slingshot_released
signal slingshot_grabbed
signal slingshot_moved

var touch = false

onready var rest_position = get_parent().get_node("RestPosition")


func _ready():
	visible = true


func _input(event):
	if event is InputEventScreenTouch:
		if not event.is_pressed():
			emit_signal("slingshot_released")
			touch = false

	if event is InputEventScreenDrag:
		if touch:
			emit_signal("slingshot_moved", event.position)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			emit_signal("slingshot_grabbed", event.position)
			touch = true
