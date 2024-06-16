extends VBoxContainer
#extends MarginContainer

# NOTE: exporting these nodes this ways has weird behavior if you try to instantiate multiple Player Statuses in a single scene
# Only the first scene instance will have valid references to whateber you set these exports to in this scene, the others will be as if they were not set
# The way around this is by either setting this scene's children as editable and dragging them to the export panel evey time,
# or by setting these in the _ready function instead. See battle_enemy.gd for an example of this.
@export var health_bar: ProgressBar
@export var deck_status: Label
@onready var bag_button := %"Bag Button"
@export var dice_selected: Label

static var deck_f_string = "Dice: %d/%d"
static var selected_f_string = "Selected: %d/%d"

@export var dice_bag_init: PlayerDataInit
@export var inventory_display: Container 
@onready var display_box_path = preload("res://modules/display_box/display_box.tscn")
@onready var inv_dice_visual = preload("res://modules/inventory/diceinv/inv_die_frame.tscn")
@onready var inv_side_visual = preload("res://modules/inventory/diceinv/inv_dieside_frame.tscn")
@onready var side_name = "Sides"
var inventory_open = false
var inventory

# I wonder if it would be better to have a class for the in-battle dice bag so we can just do .size() for dice remaining as well and then use callbacks for when dice are added or removed...
var dice_remaining: int:
	set (value):
		dice_remaining = value
		deck_status.text = deck_f_string % [dice_remaining, PlayerData.dice_bag.size()]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print("In player status, dice bag BEFORE size is:", PlayerData.dice_bag.size())
	if PlayerData.dice_bag.size() == 0:
		PlayerData.dice_bag = dice_bag_init.dice.duplicate()
	print("In player status, dice bag AFTER size is:", PlayerData.dice_bag.size())
	
	dice_remaining = PlayerData.dice_bag.size()
	health_bar.value = PlayerData.hp
	health_bar.max_value = PlayerData.hp_max
	PlayerData.hp_changed.connect(_on_hp_changed)
	PlayerData.hp_max_changed.connect(_on_hp_max_changed)


func _on_hp_changed(value):
	health_bar.value = value


func _on_hp_max_changed(value):
	health_bar.max_value = value


func _on_hand_of_dice_amount_selected(num):
	dice_selected.text = selected_f_string % [num,PlayerData.dice_choices]


'''func track_inventory():
	var inventory = display_box_path.instantiate()
	
	if inventory.visible == false:
		inventory_display.add_child(inventory)
		
		inventory.make_tab("In Bag", PlayerData.dice_bag, inv_dice_visual)
		inventory.make_tab(side_name, [], inv_side_visual)
		
		inventory.open()
		inventory_open = true
		print("player data bag", PlayerData.dice_bag)
		
	elif inventory.visible == true:
		inventory.queue_free()
		inventory.close()
		inventory_open = false'''
		




func _on_bag_button_toggled(toggled_on):
	print("player status - toggled above")
	if toggled_on:
		print("player status - toggled on")
		inventory = display_box_path.instantiate()
		
		inventory_display.add_child(inventory)
		
		inventory.make_tab("In Bag", PlayerData.dice_bag, inv_dice_visual)
		inventory.make_tab(side_name, [], inv_side_visual)
		
		inventory.open()
		#inventory_open = true
		print("player data bag", PlayerData.dice_bag)
	else:
		print("player status - toggled off")
		inventory.queue_free()
		inventory.close()
		#inventory_open = false
