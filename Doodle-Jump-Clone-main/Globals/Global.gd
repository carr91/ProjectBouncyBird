extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Player
onready var Score = 0
onready var globalMove

onready var width = ProjectSettings.get_setting("display/window/size/width")
onready var height = ProjectSettings.get_setting("display/window/size/height")
onready var centre = Vector2(width/2,height/2)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(centre.x)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
