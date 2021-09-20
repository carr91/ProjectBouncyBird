extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.Player.connect("Bounced", self, "_on_Player_Bounced")
	if position.x <= Global.centre.x:
		print("test")
		self.scale.x = -1
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func replacetotop():
	$Circle.visible = false
	$Circle.restart()
	$Circle.emitting = false
	
func _on_Player_Bounced(body):
	if body == self:
		Global.Score += 1
		$Circle.visible = true
		$Circle.amount = Global.Score
		$Circle.emitting = true
		Global.Player.playerlocalscore +=1
		print("you bounced on me", Global.Score)
	pass # Replace with function body.
