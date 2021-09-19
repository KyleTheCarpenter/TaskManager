extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func destroy():
	
	get_node("menu").visible = false
	get_node("menu/Control").visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func newList():
	get_parent().Scrollpause = true
	get_parent().get_node("List/premadeList/delete").visible = false
	if get_parent().pause == false:
		get_parent().get_node("List/newList/data").text = "" 
		for items in get_parent().taskLoader.taskList:
			items.visible = false
		get_parent().get_node("name").visible = false
		get_parent().get_node("up").visible = false
		get_parent().get_node("down").visible = false
		get_parent().Scrollpause = true
		get_parent().get_node("List").destroySaves()
		get_parent().get_node("Helper/task").visible = false
		get_parent().get_node("Helper/list").visible = false
		get_parent().get_node("Helper/presets").visible = false
		get_parent().get_node("Preset").visible = false
		get_parent().get_node("List").destroy()
		get_parent().get_node("List/newList").visible = true
		destroy()

func savedList():
	get_parent().Scrollpause = true
	get_parent().get_node("List/premadeList/delete").visible = false
	if get_parent().pause == false:
		for items in get_parent().taskLoader.taskList:
			items.visible = false
		get_parent().Scrollpause = true
		get_parent().get_node("name").visible = false
		get_parent().get_node("up").visible = false
		get_parent().get_node("down").visible = false
		get_parent().get_node("List").destroySaves()
		get_parent().get_node("Helper/task").visible = false
		get_parent().get_node("Helper/list").visible = false
		get_parent().get_node("Helper/presets").visible = false
		get_parent().get_node("Preset").visible = false
		get_parent().get_node("List").destroy()
		get_parent().get_node("List/savedList").visible = true 
		get_parent().get_node("List").openSaves()

		destroy()

func premadeList():
	get_parent().Scrollpause = true
	get_parent().get_node("List/premadeList/delete").visible = false
	if get_parent().pause == false:
		for items in get_parent().taskLoader.taskList:
			items.visible = false
		get_parent().Scrollpause = true
		get_parent().get_node("List").destroySaves()
		get_parent().get_node("name").visible = false
		get_parent().get_node("up").visible = false
		get_parent().get_node("down").visible = false
		get_parent().get_node("Helper/task").visible = false
		get_parent().get_node("Helper/list").visible = false
		get_parent().get_node("Helper/presets").visible = false
		get_parent().get_node("Preset").visible = false
		get_parent().get_node("List").destroy()
		get_parent().get_node("List/premadeList").visible = true
		get_parent().get_node("List").openPremades()
		destroy()

func mouseEntered():
	get_parent().killMenus = false
	if get_parent().pause == false:
		get_node("menu").visible = true
		get_node("menu/Control").visible = true
