extends KinematicBody2D

export var speed = 400
export var disable_movements = false

var screen_size = null

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not disable_movements:
		var velocity = Vector2.ZERO
		if Input.is_action_pressed("Move right"):
			velocity.x += 1
		if Input.is_action_pressed("Move left"):
			velocity.x -= 1
		if Input.is_action_pressed("Move up"):
			velocity.y -= 1
		if Input.is_action_pressed("Move down"):
			velocity.y += 1
		
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
	
		move_and_collide(velocity * delta)
		position.x = clamp(position.x, $Sprite.get_rect().size.x / 2, screen_size.x - $Sprite.get_rect().size.x / 2)
		position.y = clamp(position.y, $Sprite.get_rect().size.y / 2, screen_size.y - $Sprite.get_rect().size.y / 2)
