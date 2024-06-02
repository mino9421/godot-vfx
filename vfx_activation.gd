extends Node3D

var explosion_particles: Array
var testing_particles: GPUParticles3D

# Called when the node enters the scene tree for the first time.
func _ready():
	explosion_particles = [
		$vfx_explosion_orange/Sparks,
		$vfx_explosion_orange/Flash,
		$vfx_explosion_orange/Fire,
		$vfx_explosion_orange/Smoke
	]
	testing_particles = $vfx_explosion_orange/Sparks
	
	var anim_player = $Pokemons/FireMonIdle/AnimationPlayer
	anim_player.play("FireStarter_Idle")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("activate_vfx"):
		for particle in explosion_particles:
			if particle:
				particle.emitting = true
			else:
				print("Explosion particles not found or in effect.")
