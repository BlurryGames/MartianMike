class_name AuidioPlayer extends Node

var hurtSound: AudioStreamWAV = preload("res://Assets/audio/hurt.wav")
var jumpSound: AudioStreamWAV = preload("res://Assets/audio/jump.wav")

func playSFX(sfxName: String)-> void:
	var stream: AudioStream =  null
	if sfxName == "hurt":
		stream = hurtSound
	elif sfxName == "jump":
		stream = jumpSound
	else:
		print("Invalid FFX name")
		return
	
	var audioStreamPlayer: AudioStreamPlayer = AudioStreamPlayer.new()
	audioStreamPlayer.stream = stream
	audioStreamPlayer.name = "SFX"
	
	add_child(audioStreamPlayer)
	
	audioStreamPlayer.play()
	
	await audioStreamPlayer.finished
	audioStreamPlayer.queue_free()
