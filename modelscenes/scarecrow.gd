extends KinematicBody


var speed = 3
var attack_target_location = Vector3(7.988, 0.0, 7.321)
var path = []
var cur_path_idx = 0
var threshold = .1
var velocity = Vector3.ZERO
onready var nav = get_parent()
onready var look_direction = $LookDirection
var attack = true
var evil_laugh = preload("res://sounds/scarecrowgiantlaughter.ogg")
var hurt = preload("res://sounds/Playersounds - Hurt2.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Armature/Skeleton.physical_bones_start_simulation()
	#$AnimationPlayer.play("growbigger")
	get_target_path(attack_target_location)

	
func move_to_target(target_pos):
	look_direction.look_at(target_pos, Vector3.UP)
	rotate_y(deg2rad(look_direction.rotation.y * speed))
	if global_transform.origin.distance_to(path[cur_path_idx]) < threshold:
		path.remove(0)
	else:
		var direction = path[cur_path_idx] - global_transform.origin
		velocity = direction.normalized() * speed
		move_and_slide(velocity, Vector3.UP)
		
func get_target_path(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attack:
		if path.size() > 0:
			move_to_target(attack_target_location)

func hit(green_paint):
	attack = false
	if green_paint:
		get_tree().call_group("game", "add_points")
		$CollisionShape.queue_free()
		$Armature/Skeleton.physical_bones_start_simulation()
		$Armature/Skeleton/PhysicalBoneroot/BoneAttachment/paint.visible = true
		$Armature/Skeleton/PhysicalBoneroot/BoneAttachment/paint2.visible = true
		$straw.restart()
		$Timer.start()
		$AudioStreamPlayer3D.stream = hurt
		$AudioStreamPlayer3D.play()
	else:
		$AnimationPlayer.play("growbigger")
		$AudioStreamPlayer3D.stream = evil_laugh
		$AudioStreamPlayer3D.play()

func _on_Timer_timeout():
	queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "growbigger":
		get_tree().call_group("enemies", "queue_free")
		get_tree().call_group("game", "end_game")
