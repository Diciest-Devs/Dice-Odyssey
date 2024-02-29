extends Node

const SAVEFILE = "user://SAVEFILE.save"
#const SAVEFILE = "user://save_game.dat"

var game_data

'''var game_data = {
	"fullscreen_on": false,
	"vsync_on": false,
	"display_fps": false,
	"max_fps": 0,
	"bloom_on": false,
	"brightness": 1,
	"master_vol": -10,
	"music_vol": -10,
	"sfx_vol": -10,
	"fov": 70,
	"mouse_sens": 0.1,
}'''

# Called when the node enters the scene tree for the first time.
func _ready():
	game_data = {
		"fullscreen_on": false,
		"vsync_on": false,
		"display_fps": false,
		"max_fps": 0,
		"bloom_on": false,
		"brightness": 1,
		"master_vol": -10,
		"music_vol": -10,
		"sfx_vol": -10,
		"fov": 70,
		"mouse_sens": 0.1,
		}
		
	load_data()
	print("pros...")
	print(game_data)
	print("pros2...")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_data():
	if FileAccess.file_exists(SAVEFILE):
		var file = FileAccess.open(SAVEFILE, FileAccess.READ)
		
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		#var game_data = file.get_var()
		var content = file.get_as_text()
		
		file.close()
		
		var game_data = JSON.parse_string(content)
		
		if game_data == null:
			printerr("Can't parse")
			return
		
		#print(file)
	else:
		print("empty file")
		
		'''game_data = {
			"fullscreen_on": false,
			"vsync_on": false,
			"display_fps": false,
			"max_fps": 0,
			"bloom_on": false,
			"brightness": 1,
			"master_vol": -10,
			"music_vol": -10,
			"sfx_vol": -10,
			"fov": 70,
			"mouse_sens": 0.1,
		}'''
		
		save_data()
		
	#file.open(SAVEFILE, File.READ)
	#file = FileAccess.open(SAVEFILE, FileAccess.READ)
	
	#game_data = file.get_as_text()
	#game_data = file.get_var()
	
	#file.close()
	
	#ResourceSaver.save(game_data, SAVEFILE)
	print("opened data")
	
func save_data():
	
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	
	if file == null:
		print(FileAccess.get_open_error())
		return
	
	var json_string = JSON.stringify(game_data, "\t")
	
	file.store_string(json_string)
	#file.store_var(game_data)
	
	file.close()
	print("saved data")
