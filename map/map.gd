extends Node

const NT = NodeType.NodeType

var map
const margin = 5
var points = []

func _init():
	map = MapTree.new()
	#print(map.map_nodes[0].type)
	for node in map.map_nodes:
		if node != null: #and node.type != NT.ERROR:
			if node.type == NT.ERROR:
				pass
			#print("Node:",node)
			#print("pos:",node.position)
			#print("parents:",node.get_parents())
			#print("children:",node.get_sons())
			#print("type:",node.type)
			#print("depth:",node.depth)
			node.text = str(node.type)
			add_child(node)
	'''
	var i = 0
	for position in map.map_array:
		var node = Node2D.new()
		node.set_position(position) #= position
		node.set_name("node" + str(i))
		points.append(node)
		add_child(node)
		i += 1
	'''
'''
func _draw():
	
	#for position in map.positions:
		#draw_circle(Vector2.ZERO, 4, Color.WHITE_SMOKE)
	for node in map.map_nodes:
		if node != null:
			node.draw_circle(Vector2.ZERO, 4, Color.WHITE_SMOKE)
		#print(point.position)
		
	
	for connection in map.connections:
		connection[0].draw_circle(Vector2.ZERO, 4, Color.WHITE_SMOKE)
		var line = connection[1].position - connection[0].position
		var normal = line.normalized()
		line -= margin * normal
		var colour = Color.BLACK
		connection[0].draw_line(normal*margin, line, colour, 2, true)
	'''

