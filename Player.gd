extends KinematicBody2D

var health = 100

export var speed = 400
export var disable_movements = false

var screen_size = null

var punching = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hand/HandHitBox.disabled = true
	
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not disable_movements:
		if Input.is_action_just_pressed("Punch 1"):
			punching = true
			$PlayerSprite.speed_scale = 2
			$PlayerSprite.play("punching")
			$Hand/HandHitBox.disabled = false
		
		if not punching:
			var velocity = Vector2.ZERO
			if Input.is_action_pressed("Move right"):
				velocity.x += 1
			if Input.is_action_pressed("Move left"):
				velocity.x -= 1
			if Input.is_action_pressed("Move up"):
				velocity.y -= 1
			if Input.is_action_pressed("Move down"):
				velocity.y += 1
				
			if velocity.x < 0:
				$PlayerSprite.flip_h = true
				if $PlayerHitBox.position.x < 0:
					flip_collision_shapes()
			elif velocity.x > 0:
				if $PlayerHitBox.position.x > 0:
					flip_collision_shapes()

				$PlayerSprite.flip_h = false
			
			if velocity.length() > 0:
				$PlayerSprite.speed_scale = 2
				$PlayerSprite.play("running")
				velocity = velocity.normalized() * speed
			else:
				$PlayerSprite.speed_scale = 0.5
				$PlayerSprite.play("idle")
	
			move_and_collide(velocity * delta)
		
		# Binds player to the viewport's size
		position.x = clamp(position.x, $PlayerHitBox.shape.extents.x, screen_size.x - $PlayerHitBox.shape.extents.x)
		position.y = clamp(position.y, $PlayerHitBox.shape.extents.y, screen_size.y - $PlayerHitBox.shape.extents.y)

func start_hit_countdown():
	$HitCountdown.start()
	
func get_time_left():
	return $HitCountdown.get_time_left()
	
func flip_collision_shapes():
	$PlayerHitBox.position.x *= -1
	$Hand.scale.x *= -1


func _on_Hand_body_entered(body):
		# Hit countdown has not started or has finished
	if body.get_time_left() == 0:
		body.position.x += 10 # Apply position change to player
		body.health -= 10 # Reduce player health
		body.start_hit_countdown() # Start countdown again
	
	if body.health == 0:
		body.queue_free()


func _on_PlayerSprite_animation_finished():
	if $PlayerSprite.animation == "punching":
		$PlayerSprite.frame = 0
		$Hand/HandHitBox.disabled = true
		punching = false
