class_name JumpPad extends Area2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var jumpForce: float = 300.0

func _on_body_entered(body: Node2D):
	if body is Player:
		animatedSprite.play("Jump")
		body.jump(jumpForce)
