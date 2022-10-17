extends KinematicBody

# adapted from setup area, but telling the mesh "Body" to change materials

onready var body = get_node("Body")

#extends MeshInstance

var basic_mat = load("res://materials/BasicTest.tres") #res://materials/multitexturetest01.tres")
#var b2 = load("res://materials/BasicTes2t.tres)")

var b_mat = SpatialMaterial.new()

func _ready():
#	var mat_count = get_surface_material_count()
#	print(mat_count)
#	if mat_count == 1:
#		print("no mat")
#		set_surface_material(0, basic_mat)
#	else:
#		print("yay, has a mat")
	var surface_mat = body.get_surface_material(0)
	if surface_mat == null:
		print("no surface mat")
		b_mat.albedo_color = AutoloadScript.material1_data.colour
		b_mat.next_pass = SpatialMaterial.new()
#		b_mat.next_pass
		body.set_surface_material(0, b_mat) #basic_mat)
		
	else:
		print("yay, has a surface mat")
	
	update_material()
#	update_material2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# first func where i got it working, yay!
# maybe other already knew this, but when I followed these before I couldn't get them to work properly
# so this is here in case I mess up future versions of the function
#func update_material():
#	var new_temp_mat = get_surface_material(0)
#	new_temp_mat.albedo_color = AutoloadScript.material1_data.colour #Color(0, 0, 1) 
#	set_surface_material(0, new_temp_mat)
##	print("updated mat")

func update_material():
	# recreate the material whenever we update
	#primary/base material
	var new_temp_mat = body.get_surface_material(0)
	# set the colour
	new_temp_mat.albedo_color = AutoloadScript.material1_data.colour #Color(0, 0, 1) 
	# change the texture depending on if we have chosen one, or if null
	if AutoloadScript.material1_data.texture != null:
		new_temp_mat.albedo_texture = load(AutoloadScript.material1_data.texture)
	else:
		new_temp_mat.albedo_texture = null
	
	# next pass material. Stackable? How many times can next pass be called? Will check at some point.
	# for getting the next pass mat, if it's already defined in the spatial material?
#	var new_temp_mat_np = new_temp_mat.get_next_pass() #get_surface_material(0).get_next_pass()
#	var new_temp_mat_np = new_temp_mat.get_next_pass()
#	var new_temp_mat_np2 = new_temp_mat.next_pass# = basic_mat#set_next_pass(basic_mat)
#	new_temp_mat.next_pass = b2
	var new_temp_mat_np = SpatialMaterial.new() #new_temp_mat.get_next_pass()
#	new_temp_mat_np.albedo_color = AutoloadScript.material1_data.next_pass_colour #Color(0, 0, 1) 
	if AutoloadScript.material1_data.np_texture != null:
		new_temp_mat_np.albedo_texture = load(AutoloadScript.material1_data.np_texture)
		# only set colour if we have an overlay texture
		new_temp_mat_np.albedo_color = AutoloadScript.material1_data.next_pass_colour #Color(0, 0, 1) 
	else:
		new_temp_mat_np.albedo_texture = null
		new_temp_mat_np.albedo_color = Color(0,0,0,0) 
	#make the next pass texture transparent so we can see the texture underneath
	new_temp_mat_np.flags_transparent = true
	new_temp_mat.set_next_pass(new_temp_mat_np)
	
	# set the material
	body.set_surface_material(0, new_temp_mat)

#func _on_Timer_timeout():
#	update_material()
#	update_material2()


#currently coded into player for ease
func _on_QuitButton_pressed():
	AutoloadScript.goto_scene("res://Scenes/MainMenu.tscn")
