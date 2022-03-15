extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var high_score = null
const save_file = "user://scarecrow_paint_high_score.data"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func end_game():
	$BackgroundMusic.playing = false
	$GameOverMusic.playing = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$GameOver.visible = true
	$GameOver/btnPlayAgain.grab_focus()
	$lblScore.visible = false
	$lblMessage.visible = false
	load_high_score()
	if score >= high_score:
		high_score = score
		save_new_high_score()
	$GameOver/lblGameScore.text = "Score: " + str(score)
	$GameOver/lblHighScore.text = "High Score: " + str(high_score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$lblScore.text = "Score: " + str(score)


func _on_btnPlayAgain_pressed():
	get_tree().reload_current_scene()


func add_points():
	score += 10

func save_new_high_score():
	var file = File.new()
	file.open(save_file, File.WRITE)
	file.store_string(str(high_score))
	file.close()
	
func load_high_score():
	var file = File.new();
	
	if file.file_exists(save_file):
		file.open(save_file, File.READ)
		var content = file.get_as_text()
		high_score = int(content)
		file.close()
	else:
		high_score = score
