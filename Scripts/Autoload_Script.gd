extends Node


# global material data, so it cab accessed from anywhere
var material1_data = {
#	colour = null
	# create a default material for the material, this can be replaced with new custom or a loaded material
	# main/base material
	colour = Color(1, 1, 1, 1),
	texture = null,
	# next pass for material
	next_pass_colour = Color(1, 1, 1, 1),
	np_texture = null
}

# array holding the available textures ["texture name","texture path if not null"]
var textures_array = [
	["none", null],
	["camo 01", "res://textures/TexturesCom_Camouflage0002_seamless_S.jpg"],
	["camo 02", "res://textures/TexturesCom_Camouflage0006_seamless_S.jpg"],
	["lines, horizontal", "res://textures/godottexturetestoverlinesh.png"],
	["lines, vertical", "res://textures/godottexturetestoverlinesv.png"],
	["random, ish, test", "res://textures/godottexturetestoverrandomish.png"],
	["stars, large", "res://textures/godottexturetestoverstarslarge.png"],
	["stars, small", "res://textures/godottexturetestoverstarssmall.png"],
	["filler", null],
	["filler", null],
	["filler", null]
]

# Scene change stuff taken from docs as this is a simple project
var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)


#func _process(delta):
#	pass
