extends Area2D

@export var next_level: PackedScene

func _ready():
	# S'assurer que le signal est bien connecté
	body_entered.connect(_on_body_entered)
	
	# FORCER la configuration des layers
	collision_layer = 0b100  # Layer 3 (le portail est sur le layer 3)
	collision_mask = 0b10    # Mask 2 (détecte le player sur layer 2)
	
	# Vérifier la configuration
	print("🚪 Portail prêt")
	print("   Monitoring: ", monitoring)
	print("   Collision Layer: ", collision_layer)
	print("   Collision Mask: ", collision_mask)
	
	# Activer la détection
	monitoring = true
	monitorable = true

func _on_body_entered(body: Node2D) -> void:
	print("🔍 Quelque chose est entré dans le portail: ", body.name)
	
	# Vérifie si c'est un CharacterBody2D (le player)
	if body is CharacterBody2D:
		print("✅ Player détecté ! Changement de scène...")
		
		if next_level:
			print("🎬 Chargement de la scène: ", next_level.resource_path)
			get_tree().change_scene_to_packed(next_level)
		else:
			print("⚠️ ERREUR: next_level n'est pas défini dans l'inspecteur !")
			print("   → Sélectionne le Portail et assigne victory.tscn dans Next Level")
