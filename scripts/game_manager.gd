class_name GameManager extends Node2D

var viewport_area : Vector2 # This will store the viewport size
var spawn_area : Vector2 # Area where obstacles will spawn
var offset : float = 50.0 # An extra we add to the viewport size
var time : int
var stored_delta : float

@onready var player: Player = %Player # A reference to the Player
@onready var label: Label = $CanvasLayer/Label # Time label

const OBSTACLE := preload("res://scenes/obstacle.tscn") # Preloads the Obstacle scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_area = get_viewport_rect().size # Gets the viewport size (648 x 480)
	# It’s better to get it like this because 
	# we might want change the viewport size in the future!

	var max_area = Vector2(
			viewport_area.x + offset, 
			viewport_area.y + offset)
	spawn_area = max_area - viewport_area

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	stored_delta += delta #delta are milliseconds
	if stored_delta >= 1.0: #one second
		time += 1
		stored_delta = 0.0
		label.set_text("%02d:%02d" % [time / 60, time % 60])

# Called every time the Timer reaches timeout
func _on_timer_timeout() -> void:
	var obstacle := OBSTACLE.instantiate()
	
	# The obstacle spawns in a random position outside the viewport
	var random_vec2 := Vector2(randf_range(-1, 1), randf_range(-1, 1))
	obstacle.position = Vector2(
			player.position.x + viewport_area.x/2 * sign(random_vec2.x) + spawn_area.x/2 * random_vec2.x,
			player.position.y + viewport_area.y/2 * sign(random_vec2.y) + spawn_area.y/2 * random_vec2.y)
	
	obstacle.direction = obstacle.position.direction_to(player.position) # The obstacle moves towards the Player!
	add_child(obstacle) # We add the new obstacle to the Game scene
