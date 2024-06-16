extends Panel
class_name InvDiesideFrameGlow

## Assigning variables when Scene is created
@onready var element_visual : ColorRect = $GlowElement
@onready var side_type: Label = $GlowType
@onready var side_value: Label = $GlowValue
@onready var side_ref: DieSide
signal frame_clicked(dieside : DieSide)

var glow_power = 1.0
var speed = 4.0
var die_side_duplicate

## Changes label and inventory die texture accordingly
func update(dieside: DieSide):
	die_side_duplicate = dieside.duplicate(true)
	
	side_type.text = die_side_duplicate.element._to_string()
	print("Glow - Original visual color is:", element_visual.color)
	element_visual.color = die_side_duplicate.element.color
	print("Glow - Updated visual color is:", element_visual.color)
	
	side_value.text = str(die_side_duplicate.value)
	side_ref = die_side_duplicate
	
	#get_material().set_shader_parameter("glow_color", side_ref.element.color)

func _process(delta):
	glow_power += delta * speed
	var new_material = get_material().duplicate()
	
	# Change 4.0 to 2.0 for blinking effect
	if glow_power >= 3.0 and speed > 0 or glow_power <= 1.0 and speed < 0:
		speed *= -1.0
	
	new_material.set_shader_parameter("glow_color", side_ref.element.color)
	new_material.set_shader_parameter("glow_power", glow_power)
	
	set_material(new_material)
