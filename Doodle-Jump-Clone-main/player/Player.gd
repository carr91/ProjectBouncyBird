extends RigidBody2D

export var jumpImpulse= 10 * 60
export var gravityImpulse :=8.0 *60
export var spd= 3.0 *60
var dir: =0.0
var playerlocalscore: = 0
var velocity:= Vector2.ZERO
var jumped:= false
var falling := false
var drag_enabled = false
var startPos = Vector2.ZERO
var impulse_direction:= Vector2.ZERO
var launch_impulse:= Vector2.ZERO
var grabbed = true

onready var AP = get_node("AnimationPlayer")
signal Bounced(platform)
signal released
signal launched


func _ready():
	Global.Player = self

				
func _physics_process(delta:float)->void:
	dir=Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	if velocity.y < 300:
		velocity.y+=gravityImpulse*delta
	if linear_velocity.y<0:
		pass
	if linear_velocity.y>0:
		falling = true
		AP.play("Flying")
	if linear_velocity.y==0 and not grabbed and not jumped:
		AP.play("idle")
	if linear_velocity.y == 0 and falling:
		AP.play("idle")
		falling = false
		jumped = false
	if grabbed:
		$Sprite.look_at($Area2D.global_position)
		$Sprite.rotate(3.14/2)
		
	#if is_on_floor():
	#	dir = 0
	#	if !Input.is_action_pressed("jump") and jumped == false:
	#		AP.play("idle")
			#velocity.y= -jumpImpulse
		#	pass
	#move_and_slide(velocity, Vector2.UP)




func update_launch_impulse():
	return 1 * ($Area2D.global_position- $Sprite.global_position )

func launch(launch_impulse: Vector2):
	jumped = true
	mode = RigidBody2D.MODE_CHARACTER
	apply_impulse(Vector2(), launch_impulse)
	emit_signal("launched", self)
	AP.play("Jump")
	

func _on_Area2D_slingshot_moved(touchPos):
	var xformed_touch_pos = get_viewport().canvas_transform.affine_inverse().xform(touchPos)
	$Sprite.global_position = (xformed_touch_pos - self.global_position).clamped(50) + self.global_position
	launch_impulse = update_launch_impulse()
	
	pass # Replace with function body.


func _on_Area2D_slingshot_released():
	grabbed = false
	position = $Sprite.global_position
	$Sprite.position = Vector2(0,0)
	launch(launch_impulse)
	pass # Replace with function body.


func _on_Area2D_slingshot_grabbed(touchPos):
	grabbed = true
	mode = RigidBody2D.MODE_STATIC
	AP.play("Crouch")
	


func _on_Player_body_entered(body):
	if body.has_method("collidedWith"):
		body.collidedWith(self)
