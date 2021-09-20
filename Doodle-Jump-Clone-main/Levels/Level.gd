extends Node2D

onready var width = Global.width
onready var height = Global.height

var platform :=preload("res://Levels/objects/Platform.tscn")

var platformCount:=20
onready var player:= $Player
onready var platformParent:= $Platforms
var platforms:=[]
onready var treshold=height*.5
onready var platRange = $"Player/PlatformDeleter".position.y - $"Player/PlatformSpawner".position.y
var scrollSpeed=.1
onready var background:Sprite= $"ParallaxBackground/ParallaxLayer/Sprite"

func _ready()-> void:
	OS.center_window()
	player.global_position.y=treshold
	for i in platformCount:
		var inst:= platform.instance()
		inst.global_position.y=platRange/platformCount*i
		inst.global_position.x=rand_x()
		platformParent.add_child(inst)
		platforms.append(inst)
	player.global_position.x=rand_x()
	platforms.back().global_position=player.global_position+Vector2(-10,10)
	
func rand_x()->float:
	return rand_range(Global.centre.x-200, Global.centre.x + 200)
	#return rand_range(28.0, width-28.0)

func moveAll(move):
	pass

func _physics_process(delta:float)-> void:
	for platform in $Player/PlatformDeleter.get_overlapping_bodies():
		platform.position.y = $Player/PlatformSpawner.global_position.y
	pass
		
func move_background(move:float)-> void:
	var ratio :=0.25
	background.global_position.y+=1

func game_over()-> void:
	get_tree().reload_current_scene()
