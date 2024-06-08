extends CanvasLayer
## Inventory
@onready var inv_dice_visual = preload("res://modules/inventory/diceinv/inv_die_frame.tscn")
@onready var inv_side_visual = preload("res://modules/inventory/diceinv/inv_dieside_frame.tscn")
@onready var side_name = "Sides"

@onready var player_status = %"Player Status"
@onready var inventory = %"Display Box"
@onready var bag_container = %BagContainer
@onready var player_bag_container = %PlayerBagContainer

@export var dice_bag_init: PlayerDataInit

var inventory_open = false
var current_bag

func _ready():
	print("In overlay, dice bag BEFORE size is:", PlayerData.dice_bag.size())
	
	'''if PlayerData.dice_bag.size() == 0:
		PlayerData.dice_bag = dice_bag_init.dice.duplicate(true)'''
	
	print("In overlay, dice bag AFTER size is:", PlayerData.dice_bag.size())
	current_bag = PlayerData.dice_bag.duplicate()
	print("In overlay, current bag size is:", current_bag.size())
	
	player_status.dice_remaining = current_bag.size()
	
	## setup for dice inventory tab
	inventory.make_tab("In Bag", current_bag, inv_dice_visual)
	
	## setup for die sides inventory tab
	inventory.make_tab(side_name, [], inv_side_visual)
	
	## connect dice bag click to open and close inventory
	player_status.bag_button.pressed.connect(track_inventory)
	
	## connect frame clicks to display sides
	inventory.return_clicked.connect(show_sides)
	
## simple function that changes what is displayed on the sides tab
func show_sides(die : Die):
	var side_view
	
	for child in inventory.get_children():
		if child.tabobj_ref.get_tab_title() == side_name:	 #hardcoded cause bro this shit is ass
			side_view = child
	
	if side_view == null:
		return
	else:
		side_view.new_frames(die.sides)
		inventory.current_tab = side_view.get_index()
		
func track_inventory():
	if inventory.visible == false:
		inventory.open()
		inventory_open = true
	elif inventory.visible == true:
		inventory.close()
		inventory_open = false

	
