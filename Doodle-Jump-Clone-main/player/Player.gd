extends KinematicBody2D

export var jumpImpulse= 4 * 60
export var gravityImpulse :=8.0 *60
export var spd= 3.0 *60
var dir: =0.0
var velocity:= Vector2.ZERO
onready var AP = get_node("AnimationPlayer")
func _physics_process(delta:float)->void:
	dir=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	velocity.y+=gravityImpulse*delta
	if is_on_floor():
		velocity.y= -jumpImpulse
		AP.play("Jump")
		$Particles2D.emitting = true
	if velocity.y > -.5* jumpImpulse :
		$Particles2D.emitting = false
	if velocity.y >0:
		AP.play("Flying")
		if $RayCast2D.is_colliding():
			AP.play("Crouch")
	else:
		pass
	velocity.x=dir *spd
	move_and_slide(velocity, Vector2.UP)
