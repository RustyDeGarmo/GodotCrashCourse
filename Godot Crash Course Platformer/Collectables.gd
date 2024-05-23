extends Node2D

var Cherry = preload("res://Collectables/CherryPickup.tscn")


func _on_timer_timeout():
	var cherryTemp = Cherry.instantiate()
	
	var rng = RandomNumberGenerator.new()
	var randX = rng.randi_range(25, 1300)
	var randY = rng.randi_range(375, 440)
	
	cherryTemp.position = Vector2(randX, randY)
	
	get_node("Cherries").add_child(cherryTemp)
