class_name Obstacle extends Area2D

var direction : Vector2
var speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = randf_range(100, 300) # Random speed to add variety

# Calculates position based on speed, direction and delta time
func _physics_process(delta: float) -> void:
	position += direction * speed * delta

# Destroys the obstacle when timeout is reached
func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	print("Game over!")
	get_tree().reload_current_scene()
