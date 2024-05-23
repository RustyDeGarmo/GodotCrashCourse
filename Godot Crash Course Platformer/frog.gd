extends CharacterBody2D

var SPEED = 50

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
@onready var animatedSprite = get_node("AnimatedSprite2D")

func _ready():
	animatedSprite.play("Idle")

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if chase == true:
		if animatedSprite.animation != "Death":
			animatedSprite.play("Jump")
		
		player = $"../../Player/Player"
		
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			animatedSprite.flip_h = true
		else:
			animatedSprite.flip_h = false
		velocity.x = direction.x * SPEED
	else: # chase is false
		if animatedSprite.animation != "Death":
			animatedSprite.play("Idle")
			velocity.x = 0
	
	move_and_slide()


#PlayerDetection Area2d connections
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		

	

#FrogDeath Area2d connections. 
#The frog dies when the player jumps on it's head
func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()

#PlayerCollision Area2d connection. 
#If the frog runs into the player the player takes damage and the frog dies
func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 3
		death()

func death():
	Game.Gold += 5
	Utils.saveGame()
	
	chase = false
	animatedSprite.play("Death")
	await animatedSprite.animation_finished
	self.queue_free()
