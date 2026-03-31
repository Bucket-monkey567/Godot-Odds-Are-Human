extends Area3D

const ROT_SPEED = 2

@onready var sfx: AudioStreamPlayer3D = $AudioStreamPlayer3D
var collected := false


func _process(delta):
	rotate_y(deg_to_rad(ROT_SPEED))


func _on_body_entered(body: Node3D) -> void:
	if collected:
		return

	if body.is_in_group("player"):
		collected = true
		
		# stop detecting collisions
		monitoring = false
		
		# hide the coin immediately
		visible = false
		
		# play the pickup sound
		sfx.play()
		
		# wait for sound to finish
		await sfx.finished
		
		# now actually delete the coin
		queue_free()
