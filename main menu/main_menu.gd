class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/start_button as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/exit_button as Button
@export var start_level: PackedScene

func _ready(): 
	# Connecte les signaux via code
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	
	# Cache le bouton Exit sur le web (il ne fonctionne pas de toute façon)
	if OS.has_feature("web"):
		exit_button.visible = false

func on_start_pressed() -> void:
	print("🎮 Démarrage du jeu...")
	
	if start_level:
		get_tree().change_scene_to_packed(start_level)
	else:
		print("⚠️ ERREUR: start_level n'est pas défini !")
		print("   → Sélectionne Main_Menu et assigne game.tscn dans Start Level")

func on_exit_pressed() -> void:
	print("👋 Fermeture du jeu...")
	
	# Sur le web, on ne peut pas quitter, alors on retourne au menu
	if OS.has_feature("web"):
		print("⚠️ Impossible de quitter sur navigateur")
		# Optionnel : redirige vers une autre scène
		return
	else:
		get_tree().quit()

# Fonctions pour les connexions faites dans l'éditeur (si elles existent encore)
func _on_start_button_button_down() -> void:
	on_start_pressed()

func _on_exit_button_button_down() -> void:
	on_exit_pressed()
