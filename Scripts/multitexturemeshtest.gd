extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var col_picker_1 = get_node("ColorPicker")
onready var col_picker_2 = get_node("ColorPicker2")

onready var item_list = get_node("ItemList")
onready var item_list_np = get_node("ItemList2")


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# change this to load custom colours that have been saved, but works for now
	# not needed here, as colours are set to white when project starts
#	AutoloadScript.material1_data.colour = col_picker_1.color
#	AutoloadScript.material1_data.next_pass_colour = col_picker_2.color
	#make load texture found in save dat before changing in here
	load_texture_list()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ColorPicker_color_changed(color):
	AutoloadScript.material1_data.colour = color


func _on_ColorPicker2_color_changed(color):
	AutoloadScript.material1_data.next_pass_colour = color


func load_texture_list():
#	var textures_list_to_load = AutoloadScript.textures_array
	if len(AutoloadScript.textures_array) != 0:
		for each_entry in len(AutoloadScript.textures_array): #textures_list_to_load):
			# for base
			item_list.add_item(AutoloadScript.textures_array[each_entry][0])
			var item_list_last_index = item_list.get_item_count()-1
			item_list.set_item_metadata(item_list_last_index, AutoloadScript.textures_array[each_entry][1])
			# for next pass
			item_list_np.add_item(AutoloadScript.textures_array[each_entry][0])
			var item_list_last_index_np = item_list_np.get_item_count()-1
			item_list_np.set_item_metadata(item_list_last_index_np, AutoloadScript.textures_array[each_entry][1])


func _on_ItemList_item_selected(index):
	AutoloadScript.material1_data.texture = item_list.get_item_metadata(index)


func _on_ItemList2_item_selected(index):
	AutoloadScript.material1_data.np_texture = item_list_np.get_item_metadata(index)


func _on_Button_pressed():
	AutoloadScript.goto_scene("res://Scenes/TestArea.tscn")


func _on_QuitButton_pressed():
	AutoloadScript.goto_scene("res://Scenes/MainMenu.tscn")
