extends Area2D

var disable_movements = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.disabled = true
	var player = get_parent()
	
	if player != null:
		disable_movements = player.disable_movements


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not disable_movements:
		if Input.is_action_pressed("Punch 1"):
			$CollisionShape2D.disabled = false
			$AnimatedSprite.play()


func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = true
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0


func _on_Hand_body_entered(body):
	# Hit countdown has not started or has finished
	if body.get_time_left() == 0:
		body.position.x += 10 # Apply position change to player
		body.health -= 10 # Reduce player health
		body.start_hit_countdown() # Start countdown again
	
	if body.health == 0:
		body.queue_free()
	
