class_name BG extends ParallaxBackground

@onready var sprite: Sprite2D = $ParallaxLayer/Sprite2D

@export var bgTexture: CompressedTexture2D = preload("res://Assets/textures/bg/Blue.png")
@export var scrollSpeed: float = 15.0

func _ready()-> void:
	sprite.texture = bgTexture

func _process(delta: float)-> void:
	sprite.region_rect.position += Vector2(scrollSpeed, scrollSpeed) * delta
	if sprite.region_rect.position >= Vector2(64.0, 64.0):
		sprite.region_rect.position = Vector2.ZERO
