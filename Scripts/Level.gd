class_name Level extends Node2D

@onready var startPosition: Marker2D = $StartPosition

func _process(_delta: float)-> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(body: Node2D)-> void:
	body.velocity = Vector2.ZERO
	body.global_position = startPosition.global_position
