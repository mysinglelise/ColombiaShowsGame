extends CanvasLayer

var coins = 0

func _ready():
	$Starx.text = str(coins)
	# Force la taille à 0 au démarrage
	$HeartsEmpty.size.x = 0
	$HeartsEmpty.custom_minimum_size.x = 0
	load_hearts()
	
func _on_coin_collected():
	coins = coins + 1
	$Starx.text = str(coins)
	
func load_hearts():
	var heart_width = 53
	
	print("🔴 load_hearts - Vies: ", Global.lives, "/", Global.max_lives)
	
	# Taille des cœurs pleins
	$HeartsFull.size.x = Global.lives * heart_width
	
	# Taille des cœurs vides
	$HeartsEmpty.size.x = (Global.max_lives - Global.lives) * heart_width
	
	# Position des cœurs vides - FIX ICI ⬇️
	# Les cœurs vides commencent JUSTE après les cœurs pleins
	$HeartsEmpty.position.x = 148 + (Global.lives * heart_width)  # ⬅️ Position fixe + décalage
	
	print("   HeartsFull.size.x = ", $HeartsFull.size.x)
	print("   HeartsEmpty.size.x = ", $HeartsEmpty.size.x)
	print("   HeartsEmpty.position.x = ", $HeartsEmpty.position.x)
	
	# Cache complètement si toutes les vies sont pleines
	$HeartsEmpty.visible = (Global.lives < Global.max_lives)
