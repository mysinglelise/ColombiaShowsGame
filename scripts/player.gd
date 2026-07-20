extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_dead := false
var respawn_timer := 0.0
var spawn_position: Vector2   # position de départ mémorisée

func _ready():
	is_dead = false
	respawn_timer = 0.0
	
	# Sauvegarde la position de spawn EXACTE
	spawn_position = global_position
	
	# Orientation par défaut : regarde à gauche (ouest)
	animated_sprite.flip_h = true


func _physics_process(delta: float) -> void:
	# ----- GESTION DU RESPAWN -----
	if is_dead:
		respawn_timer -= delta
		if respawn_timer <= 0.0:
			respawn()
		return

	# ----- GRAVITÉ -----
	if not is_on_floor():
		velocity += get_gravity() * delta

	# ----- SAUT -----
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# ----- MOUVEMENT HORIZONTAL -----
	var direction := Input.get_axis("move left", "move right")

	# Orientation du sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Vitesse
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func take_damage():
	if is_dead:
		return

	is_dead = true
	Global.lives -= 1
	print("💔 take_damage appelé - Vies restantes:", Global.lives)

	# Mise à jour du HUD
	var hud = get_tree().root.get_node("game/hud")
	if hud:
		hud.load_hearts()

	# Lancement du timer de respawn
	respawn_timer = 1.5


func respawn():
	if Global.lives <= 0:
		die()
		return

	# Respawn propre
	global_position = spawn_position
	velocity = Vector2.ZERO
	modulate = Color.WHITE
	is_dead = false
	respawn_timer = 0.0

	# Orientation cohérente après respawn
	animated_sprite.flip_h = true

	print("✅ Respawn effectué - Vies:", Global.lives)


func die():
	print("💀 GAME OVER")
	Global.lives = Global.max_lives
	get_tree().reload_current_scene()
