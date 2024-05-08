class_name Player extends CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity: float = 400.0
@export var speed: float = 125.0
@export var jumpForce: float = 200.0

func _physics_process(delta: float)-> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500.0:
			velocity.y = 500.0
	
	if Input.is_action_just_pressed("Jump"):
		velocity.y = -jumpForce
	
	var direction: float = Input.get_axis("MoveLeft", "MoveRight")
	velocity.x = direction * speed
	
	move_and_slide()
