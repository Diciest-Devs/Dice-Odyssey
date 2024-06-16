extends Control

@onready var tb_controller := %"Textbox Controller"
@onready var start_button := %start_button

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/Map").canvas_layer.visible = false
	start_button.grab_focus()


func _on_start_button_pressed():
	await tb_controller.quick_beat('select difficulty', [], func (from_beat: DialogueBeat, destination_beat: String, from_choice: int):
			match from_choice:
				0: PlayerData.difficulty = PlayerData.Difficulty.NOVICE
				1: PlayerData.difficulty = PlayerData.Difficulty.STANDARD
				2: PlayerData.difficulty = PlayerData.Difficulty.EXPERT
	)
	# Change to map scene once done
	#get_tree().change_scene_to_file(map_scene_path)
	#get_node("/root/Map/BattleMusic").play()
	SoundManager.select_2.play()
	SoundManager.battle_music.play()
	PlayerData.reset()
	visible = false
	#queue_free()
	#get_node("/root/Map").visible = true
	get_node("/root/Map").canvas_layer.visible = true
	for map_node in get_node("/root/Map/Nodes").get_children():
		if not map_node.disabled:
			map_node.grab_focus()
			break
