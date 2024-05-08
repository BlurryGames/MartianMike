class_name Level extends Node2D

@onready var start: Start = $Start
@onready var exit: Exit = $Exit
@onready var hud: HUD = $UILayer/HUD
@onready var uiLayer: UILayer = $UILayer
@onready var deathzone: Area2D = $Deathzone

@export var nextLevel: PackedScene = null
@export var levelTime: float = 5.0
@export var isFinalLevel: bool = false

var player: Player = null
var timerNode: Timer = null
var timeLeft: float = 0.0
var win: bool = false

func _ready()-> void:
	player = get_tree().get_first_node_in_group("Player")
	if player:
		player.global_position = start.getSpawnPosition()
	
	var traps: Array[Node] = get_tree().get_nodes_in_group("Traps")
	for t: Trap in traps:
		t.touchedPlayer.connect(_on_trap_touched_player)
	
	exit.body_entered.connect(_on_exit_body_entered)
	deathzone.body_entered.connect(_on_deathzone_body_entered)
	
	timeLeft = levelTime
	hud.setTimeLabel(timeLeft)
	
	timerNode = Timer.new()
	timerNode.name = "LevelTimer"
	timerNode.wait_time = 1.0
	timerNode.timeout.connect(_on_level_timer_timeout)
	add_child(timerNode)
	timerNode.start()

func _process(_delta: float)-> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()

func _on_deathzone_body_entered(_body: Node2D)-> void:
	resetPlayer()

func _on_exit_body_entered(body: Node2D)-> void:
	if body is Player:
		if isFinalLevel or nextLevel:
			exit.animate()
			player.active = false
			win = true
			await get_tree().create_timer(1.5).timeout
			if isFinalLevel:
				uiLayer.showWinScreen(true)
			else:
				get_tree().change_scene_to_packed(nextLevel)

func _on_trap_touched_player()-> void:
	resetPlayer()

func _on_level_timer_timeout()-> void:
	if not win:
		timeLeft -= 1
		if timeLeft < 0.0:
			resetPlayer()
			timeLeft = levelTime
		hud.setTimeLabel(timeLeft)

func resetPlayer()-> void:
	player.velocity = Vector2.ZERO
	player.global_position = start.getSpawnPosition()
