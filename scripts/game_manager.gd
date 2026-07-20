extends Node

var score = 0
var max_coins = 11  # Nombre total d'étoiles

@export var reward_scene: PackedScene  # Scène cadeau à configurer dans l'inspecteur

@onready var score_label: Label = $"score label"

func add_point():
	score += 1
	score_label.text = " you collected " + str(score) + " stars."
	
	# Récupère Starx dans le HUD
	var starx_label = get_node_or_null("/root/game/hud/Starx")
	if starx_label:
		starx_label.text = str(score)
	else:
		print("⚠️ Starx introuvable ! Vérifie le chemin /root/game/hud/Starx")
	
	# Affiche la progression
	print("⭐ Étoiles collectées: ", score, "/", max_coins)
	
	# Si toutes les étoiles sont collectées
	if score >= max_coins:
		print("🎁 TOUTES LES ÉTOILES COLLECTÉES ! Chargement du cadeau...")
		
		# Petit délai pour que le joueur voit la dernière étoile
		await get_tree().create_timer(0.5).timeout
		
		# Change de scène avec transition
		var transition = get_node_or_null("/root/game/Transition")
		
		if reward_scene:
			if transition and transition.has_method("change_scene_packed"):
				transition.change_scene_packed(reward_scene, 0.8)
			else:
				get_tree().change_scene_to_packed(reward_scene)
		else:
			print("⚠️ ERREUR: reward_scene n'est pas définie !")
			print("   → Sélectionne game manager et assigne cadeau.tscn dans Reward Scene")

func has_all_coins() -> bool:
	"""Vérifie si toutes les étoiles ont été collectées"""
	return score >= max_coins

func get_coins_count() -> int:
	"""Retourne le nombre d'étoiles collectées"""
	return score
