extends CharacterBody2D

@onready var characterSprite = $characterSprite

const SPEED = 200.0

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionLR = Input.get_axis("ui_left", "ui_right")
	var directionTD = Input.get_axis("ui_up", "ui_down")

	if directionLR:
		velocity.x = directionLR * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x < 0:
		characterSprite.flip_h = true
	else:
		characterSprite.flip_h = false
		
	if directionTD:
		velocity.y = directionTD * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
