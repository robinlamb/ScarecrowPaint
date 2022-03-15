extends Position3D


func _ready():
	$Particles.emitting = true
	
	#$ImpactSound.pitch_scale = rand_range(0.95, 1.05)
	
	#$ColorTween.interpolate_property(material, "emission", Color(0.93, 0.9, 0.89), Color(0.88, 0.55, 0.45), 0.075, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#$ColorTween.interpolate_property(material, "emission", Color(0.88, 0.55, 0.45), Color(0, 0, 0), 0.075, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.075)
	#$ColorTween.interpolate_property(material, "emission_energy", 5, 0, 0.15, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#$ColorTween.interpolate_property($Bullet, "scale", Vector3(1.5, 1.5, 1.5), Vector3(1, 1, 1), 0.15, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#$ColorTween.start()
	
	yield(get_tree(), "idle_frame")
	
	#for i in 5:
	#	spawn_debris(rand_range(1, 5))
