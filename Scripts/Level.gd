class_name Level extends Node2D

@onready var start: Start = $Start
@onready var exit: Exit = $Exit
@onready var deathzone: Area2D = $Deathzone

@export var nextLevel: PackedScene = null

var player: Player = null

func _ready()-> void:
	player = get_tree().get_first_node_in_group("Player")
	if player:
		player.global_position = start.getSpawnPosition()
	
	var traps: Array[Node] = get_tree().get_nodes_in_group("Traps")
	for t: Trap in traps:
		t.touchedPlayer.connect(_on_trap_touched_player)
	
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)

func _process(_delta: float)-> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(_body: Node2D)-> void:
	resetPlayer()

func _on_exit_body_entered(body: Node2D)-> void:
	if body is Player:
		exit.animate()
		player.active = false
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(nextLevel)

func _on_trap_touched_player()-> void:
	resetPlayer()

func resetPlayer()-> void:
	player.velocity = Vector2.ZERO
	player.global_position = start.getSpawnPosition()
