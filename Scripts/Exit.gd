class_name Exit extends Area2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

func animate()-> void:
	animatedSprite.play("default")
