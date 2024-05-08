class_name Player extends CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity: float = 400.0
@export var speed: float = 125.0
@export var jumpForce: float = 200.0

func _ready()-> void:
	var a: bool = true
	var b: bool = false
	var result: bool = !a || b
	print(result)

func _physics_process(delta: float)-> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500.0:
			velocity.y = 500.0
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jumpForce
	
	var direction: float = Input.get_axis("MoveLeft", "MoveRight")
	if direction != 0.0:
		animatedSprite.flip_h = direction < 0.0
	
	velocity.x = direction * speed
	move_and_slide()
	
	updateAnimations(direction)

func updateAnimations(direction: float)-> void:
	if is_on_floor():
		if direction == 0.0:
			animatedSprite.play("Idle")
		else:
			animatedSprite.play("Run")
	else:
		if velocity.y < 0.0:
			animatedSprite.play("Jump")
		else:
			animatedSprite.play("Fall")
