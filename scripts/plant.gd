extends Node

@onready var growthTimer = $growthTimer
@onready var moistureTimer = $moistureTimer
@onready var plantSprite = $plantSprite
@onready var moistureProgressBar = $moistureProgressBar

const MAX_MOISTURE = 30
# technically not a constant because of load() I think, but should be used as one
var States = {
	SPROUT = {
		Texture = load("res://sprites/sprout.png")
	},
	SHOOT = {
		Texture = load("res://sprites/young_plant.png")
	},
	PLANT = {
		Texture = load("res://sprites/plant.png")
	}
}

# initial state
var state = States.SPROUT

# Called when the node enters the scene tree for the first time.
func _ready():
	plantSprite.texture = state.Texture
	growthTimer.start()
	moistureTimer.start(MAX_MOISTURE)
	moistureProgressBar.max_value = MAX_MOISTURE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		moistureTimer.start(MAX_MOISTURE)
		growthTimer.paused = false
		print("Watered plant")
	moistureProgressBar.value = moistureTimer.time_left

func _on_growth_timer_timeout():
	print("Growth timer timeout")
	# grow one stage
	if (state == States.SPROUT):
		print("stage now shoot")
		state = States.SHOOT
	elif (state == States.SHOOT):
		print("stage now plant")
		state = States.PLANT
	# resume growing
	growthTimer.start()
	
	# set the sprite texture to the correct stage
	plantSprite.texture = state.Texture

func _on_moisture_timer_timeout():
	print("Moisture timer timeout")
	growthTimer.paused = true
