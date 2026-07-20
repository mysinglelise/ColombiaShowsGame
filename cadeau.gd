extends Control

# Boutons (dans le VBoxContainer)
@onready var keep_playing_button: Button = $HBoxContainer/VBoxContainer/keep_playing_button
@onready var copy_button: Button = $HBoxContainer/VBoxContainer/copy_button
@onready var strudel_button: Button = $HBoxContainer/VBoxContainer/strudel_button
@onready var exit_button: Button = $HBoxContainer/VBoxContainer/exit_button

# UI
@onready var code_box: TextEdit = $HBoxContainer/code_box
@onready var text_label: Label = $text


func _ready():
	print("🎁 PAGE CADEAU CHARGÉE!")
	print("🔍 Script cadeau._ready() appelé")

	# Connexion des boutons (sans bloquer si un node manque)
	if keep_playing_button:
		keep_playing_button.pressed.connect(on_keep_playing_pressed)
	else:
		push_error("❌ keep_playing_button manquant")

	if copy_button:
		copy_button.pressed.connect(on_copy_pressed)
	else:
		push_error("❌ copy_button manquant")

	if strudel_button:
		strudel_button.pressed.connect(on_strudel_pressed)
	else:
		push_error("❌ strudel_button manquant")

	if exit_button:
		exit_button.pressed.connect(on_exit_pressed)
	else:
		push_error("❌ exit_button manquant")

	# Configuration de la code box
	if code_box:
		code_box.editable = false
		code_box.selecting_enabled = true
	else:
		push_error("❌ code_box manquant")


func on_copy_pressed() -> void:
	print("🖱️ ========== BOUTON COPY CLIQUÉ ==========")

	if not code_box or code_box.text == "":
		print("⚠️ code_box vide ou manquant")
		return

	var code_to_copy := code_box.text
	DisplayServer.clipboard_set(code_to_copy)
	print("📋 Code copié dans le presse-papier")

	await get_tree().create_timer(0.1).timeout

	if DisplayServer.clipboard_get() == code_to_copy:
		copy_button.text = "✓ Copied!"
		print("✅ Copie réussie")
	else:
		copy_button.text = "Press Ctrl+C"
		code_box.select_all()
		print("⚠️ Vérification presse-papier échouée")


func on_strudel_pressed() -> void:
	print("🌐 Ouverture de Strudel...")
	OS.shell_open("https://strudel.cc/")


func on_keep_playing_pressed() -> void:
	print("🎮 Retour au jeu...")
	Global.lives = Global.max_lives
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func on_exit_pressed() -> void:
	print("👋 Fermeture du jeu...")
	get_tree().quit()
