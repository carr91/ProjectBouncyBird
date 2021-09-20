extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var NotBouncedOn = true
func ChooseOrientation():
	if position.x <= Global.centre.x*.5:
		$Sprite.texture = load("res://assets/Tree/Untitled_Artwork-1 (1).png")
	elif position.x <= Global.centre.x:
		$Sprite.texture = load("res://assets/Tree/Untitled_Artwork-1.png")
	elif position.x >= Global.centre.x and position.x < Global.centre.x*1.5 :
		$Sprite.texture = load("res://assets/Tree/Untitled_Artwork-4.png")
	else:
		$Sprite.texture = load("res://assets/Tree/Untitled_Artwork-3.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.Player.connect("Bounced", self, "_on_Player_Bounced")
	ChooseOrientation()
		
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func replacetotop():
	$Circle.visible = false
	$Circle.restart()
	$Circle.emitting = false
	ChooseOrientation()
	
func collidedWith(body):
	if NotBouncedOn:
		NotBouncedOn = false
		Global.Score += 1
		$Circle.visible = true
		$Circle.amount = Global.Score
		$Circle.emitting = true
		Global.Player.playerlocalscore +=1
		print("you bounced on me", Global.Score)
	pass # Replace with function body.
