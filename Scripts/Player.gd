class_name Player extends CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

func _process(_delta: float)-> void:
	if Input.is_action_just_pressed("MoveRight"):
		animatedSprite.play("Run")
