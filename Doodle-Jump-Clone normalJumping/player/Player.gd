extends KinematicBody2D

export var jumpImpulse= 10 * 60
export var gravityImpulse :=8.0 *60
export var spd= 3.0 *60
var dir: =0.0
var playerlocalscore: = 0
var velocity:= Vector2.ZERO
onready var AP = get_node("AnimationPlayer")
signal Bounced(platform)

func _ready():
	Global.Player = self

func _physics_process(delta:float)->void:
	dir=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	velocity.y+=gravityImpulse*delta
	if is_on_floor():
		velocity.y= -jumpImpulse
		AP.play("Jump")
		emit_signal("Bounced", get_slide_collision(0).get_collider())
	if velocity.y*velocity.y < 1 :#ZENITH
		print("ZENITH")
	if velocity.y > -.5* jumpImpulse : #reaching zenith
		$RocketTrail.emitting = false
		pass
	if velocity.y >0: #falling
		AP.play("Flying")
		if $RayCastLeft.is_colliding() or $RayCastRight.is_colliding():
			AP.play("Crouch")
	else:
		pass
	velocity.x=dir *spd
	move_and_slide(velocity, Vector2.UP)


