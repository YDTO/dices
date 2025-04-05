extends Node2D

@export var animation_name: String = "roll"

@onready var dice_sprite := $AnimatedSprite2D
@onready var timer := $Timer
@onready var area := $Area2D

var result: int = -1  # -1 means "not rolled yet"

var is_rolling := false

func _ready():
	randomize()
	area.input_pickable = true
	area.monitoring = false
	dice_sprite.play(animation_name)
	dice_sprite.stop()


func start_roll():
	is_rolling = true
	dice_sprite.play(animation_name)
	timer.stop()  # Reset if already running
	timer.start(2)  # Roll duration


func _on_timer_timeout() -> void:
	dice_sprite.stop()
	timer.stop()  # Reset if already running
	
	# Choose a random frame as result (assumes 6 frames)
	result = randi() % dice_sprite.sprite_frames.get_frame_count(animation_name)
	dice_sprite.frame = result
	is_rolling = false
	get_node("../").check_winner_if_ready()  # This is safe here
	#print("You rolled a:", result + 1)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and not is_rolling:
		start_roll()
