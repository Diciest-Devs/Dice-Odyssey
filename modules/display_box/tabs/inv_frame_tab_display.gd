extends TabBar

@onready var tab: TabBar = $"."
@onready var slots: HFlowContainer = %FrameSlots
@onready var scroll: ScrollContainer = %DisplayScroll

## The Tab object reference
var tabobj_ref : Tab

signal frame_clicked(frame)

func create_tab(tab : Tab):
	self.tabobj_ref = tab
	
## Adds the neccessary slots and Die texture models into our scene
func show_frames(frames : Array, title : StringName) -> void:
	wipe()
	tab.set_tab_title(0, title)
	var frame_visual = tab.get_frame_visual().instantiate()
	## We need this function in order to update the information in the
	## frame_visual to match what is in the frame.
	if(not frame_visual.has_method("update")):
		assert(false,
			"UNIMPLEMENTED METHOD: update()\n
		 		PLEASE IMPLEMENT THIS METHOD TO YOUR FRAME VISUAL")
	## We need this signal in order to notify the parent scene that
	## a frame has been clicked
	elif(not frame_visual.has_signal("frame_clicked")):
		assert(false,
			"UNIMPLEMENTED SIGNAL: frame_clicked\n
		 		PLEASE IMPLEMENT THIS SIGNAL TO YOUR FRAME VISUAL")
	for frame in tabobj_ref.get_frames():	
		slots.add_child(frame_visual)	# Adds scene as a child to slots, the HFlowContainer in Dicebag
		frame_visual.update(frame)		# Adds frame information to scene
		frame_visual.frame_clicked.connect(return_content)
		frame_visual.owner = get_tree().get_current_scene()
		frame_visual = tab.get_frame_visual().instantiate()
		
## Clear current frames being shown
func wipe():
	for child in slots.get_children():
		slots.remove_child(child)
		
## When we want to use the info that a frame emitted from its signal
## We may catch and reemit it up 
func return_content(content):
	frame_clicked.emit(content)
