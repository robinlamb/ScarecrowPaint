extends Navigation


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var purple_scarecrow = preload("res://modelscenes/scarecrow.tscn")
var green_scarecrow = preload("res://modelscenes/greenscarecrow.tscn")
var game_ended = false
var scarecrow_timer_wait_time = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnScarecrow.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func choose_random_spot():
	var random_spot
	var spot_number
	randomize()
	spot_number = randi() % 7
	
	match spot_number:
		0:
			random_spot = $ScarecrowSpawnSpot.transform.origin
		1:
			random_spot = $ScarecrowSpawnSpot2.transform.origin
		2:
			random_spot = $ScarecrowSpawnSpot3.transform.origin
		3:
			random_spot = $ScarecrowSpawnSpot4.transform.origin
		4:
			random_spot = $ScarecrowSpawnSpot5.transform.origin
		5:
			random_spot = $ScarecrowSpawnSpot6.transform.origin
		_:
			random_spot = $ScarecrowSpawnSpot7.transform.origin
	
	return random_spot
	
func spawn_scarecrow(spawn_location):
	if game_ended:
		return
		
	var scarecrow_instance
	randomize()
	var type_scarecrow = randi() % 2
	
	match type_scarecrow:
		0:
			scarecrow_instance = purple_scarecrow.instance()
		1:
			scarecrow_instance = green_scarecrow.instance()
	
	randomize()	
	add_child(scarecrow_instance)
	scarecrow_instance.transform.origin = spawn_location
	
func end_game():
	game_ended = true


func _on_SpawnScarecrow_timeout():
	var place_to_spawn = choose_random_spot()
	spawn_scarecrow(place_to_spawn)
	if scarecrow_timer_wait_time > 1.0:
		scarecrow_timer_wait_time <= .20
	$SpawnScarecrow.set_wait_time(scarecrow_timer_wait_time)
	$SpawnScarecrow.start()
