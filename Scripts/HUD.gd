class_name HUD extends Control

func setTimeLabel(value: float)-> void:
	$TimeLabel.text = "TIME: " + str(value)
