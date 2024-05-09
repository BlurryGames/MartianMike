class_name Player extends CharacterBody2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var gravity: float = 400.0
@export var speed: float = 125.0
@export var jumpForce: float = 200.0

var active: bool = true

func _physics_process(delta: float)-> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500.0:
			velocity.y = 500.0
	
	var direction: float = 0.0
	
	if active:
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			jump(jumpForce)
		
		direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if direction != 0.0:
		animatedSprite.flip_h = direction < 0.0
	
	velocity.x = direction * speed
	move_and_slide()
	
	updateAnimations(direction)

func jump(force: float)-> void:
	AudioPlayer.playSFX("jump")
	velocity.y = -force

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
