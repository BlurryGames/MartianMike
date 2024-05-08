class_name Start extends StaticBody2D

@onready var spawnPosition: Marker2D = $SpawnPosition

func getSpawnPosition()-> Vector2:
	return spawnPosition.global_position
