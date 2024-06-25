extends Node

@onready var growthTimer = $growthTimer
@onready var moistureTimer = $moistureTimer
@onready var plantSprite = $plantSprite
@onready var moistureProgressBar = $moistureProgressBar

var sproutTexture = load("res://sprites/sprout.png")
var youngPlantTexture = load("res://sprites/young_plant.png")
var plantTexture = load("res://sprites/plant.png")

const MAX_MOISTURE = 30

# initial state
var state = "sprout"

# Called when the node enters the scene tree for the first time.
func _ready():
	plantSprite.texture = sproutTexture
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
	if (state == "sprout"):
		print("stage now youngPlant")
		state = "youngPlant"
	elif (state == "youngPlant"):
		print("stage now plant")
		state = "plant"
	# resume growing
	growthTimer.start()
	
	# set the sprite texture to the correct stage
	plantSprite.texture = _get_texture()

func _get_texture():
	if (state == "sprout"):
		return sproutTexture
	elif (state == "youngPlant"):
		return youngPlantTexture
	else:
		return plantTexture

func _on_moisture_timer_timeout():
	print("Moisture timer timeout")
	growthTimer.paused = true
