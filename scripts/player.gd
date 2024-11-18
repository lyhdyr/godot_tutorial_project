class_name Player extends CharacterBody2D

@export var speed : float = 100.0 # speed at which the dragon moves
var direction : Vector2 # stores the current direction

# Get the direction vector depending on player input (4 arrows)
func _input(event: InputEvent) -> void:
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")


# Calculate the position depending on direction, speed and delta time
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
