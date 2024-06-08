extends Button

@export_file("*.tscn") var map_scene_path

@onready var start_menu = %start_menu_panel

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
		
	# Change to map scene once done
	#get_tree().change_scene_to_file(map_scene_path)
	#get_node("/root/Map/BattleMusic").play()
	SoundManager.select_2.play()
	SoundManager.battle_music.play()
	PlayerData.reset()
	start_menu.get_parent_control().visible = false
	#queue_free()
	#get_node("/root/Map").visible = true
	
	get_node("/root/Map").canvas_layer.visible = true
	
	for map_node in get_node("/root/Map/Nodes").get_children():
		if not map_node.disabled:
			map_node.grab_focus()
			break
