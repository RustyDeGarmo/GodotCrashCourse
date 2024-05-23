extends Node2D

var frog = preload("res://frog.tscn")

func _on_timer_timeout():
	var frogTemp = frog.instantiate()
	
	var rng = RandomNumberGenerator.new()
	var randX = rng.randi_range(25, 1300)
	var randY = rng.randi_range(0, 440)
	
	frogTemp.position = Vector2(randX, randY)
	
	get_node("Frogs").add_child(frogTemp)
