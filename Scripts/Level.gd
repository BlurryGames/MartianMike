class_name Level extends Node2D

@onready var start: Start = $Start
@onready var player: Player = null

func _ready()-> void:
	player = get_tree().get_first_node_in_group("Player")
	if player:
		player.global_position = start.getSpawnPosition()
	
	var traps: Array[Node] = get_tree().get_nodes_in_group("Traps")
	for t: Trap in traps:
		t.touchedPlayer.connect(_on_trap_touched_player)

func _process(_delta: float)-> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(_body: Node2D)-> void:
	resetPlayer()

func _on_trap_touched_player()-> void:
	resetPlayer()

func resetPlayer()-> void:
	player.velocity = Vector2.ZERO
	player.global_position = start.getSpawnPosition()
