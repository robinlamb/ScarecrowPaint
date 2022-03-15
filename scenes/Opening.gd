extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$btnPlay.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btnPlay_pressed():
	get_tree().change_scene("res://scenes/Farm.tscn")


func _on_btnBack_pressed():
	$Instructions.visible = false
	$btnPlay.grab_focus()


func _on_btnInstructions_pressed():
	$Instructions.visible = true
	$Instructions/btnBack.grab_focus()


func _on_btnCreditsBack_pressed():
	$Credits.visible = false
	$btnPlay.grab_focus()

func _on_btnCredits_pressed():
	$Credits.visible = true
	$Credits/btnCreditsBack.grab_focus()
