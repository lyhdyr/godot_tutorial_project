class_name GameManager extends Node2D

var viewport_dim : Vector2 # This will store the viewport size
var offset : float = 0 # An extra we add to the viewport size

@onready var player: Player = %Player # A reference to the Player

const OBSTACLE := preload("res://scenes/obstacle.tscn") # Preloads the Obstacle scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_dim = get_viewport_rect().size # Gets the viewport size (648 x 480)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called every time the Timer reaches timeout
func _on_timer_timeout() -> void:
	var obstacle := OBSTACLE.instantiate()
	
	# The obstacle spawns in a random position outside the viewport
	# HARDCODED VERSION (NOT THE BEST)
	#obstacle.position = Vector2(
		#randf_range(-50, 698), 
		#randf_range(-50, 530)) # The viewport is 648 * 480
	
	# BETTER VERSION
	obstacle.position = Vector2(
		randf_range(player.position.x - viewport_dim.x/2 - offset,  player.position.x + viewport_dim.x/2 + offset), 
		randf_range(player.position.y - viewport_dim.y/2 - offset,  player.position.y + viewport_dim.y/2 + offset))
	#print(str(obstacle.position))
	
	add_child(obstacle)
	
	obstacle.direction = obstacle.position.direction_to(player.position) # The obstacle moves towards the Player!
