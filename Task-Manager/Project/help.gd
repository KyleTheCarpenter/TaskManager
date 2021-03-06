extends TextureButton


func destroy():
	get_node("menu").visible = false
	get_node("menu/Control").visible = false


func mouseEntered():
	get_parent().killMenus = false
	get_node("menu").visible = true
	get_node("menu/Control").visible = true


func helpTask():
	get_parent().Unpause()
	destroy()
	get_parent().get_node("List").destroySaves()
	get_parent().get_node("List").destroy()
	get_parent().get_node("Preset").visible = false
	get_parent().get_node("Helper/task").visible = true
	get_parent().get_node("Helper/list").visible = false
	get_parent().get_node("Helper/presets").visible = false


func helpList():
	get_parent().Unpause()
	destroy()
	get_parent().get_node("Helper/list/option").text = "Would you like\n to Delete"
	get_parent().get_node("List").destroySaves()
	get_parent().get_node("List").destroy()
	get_parent().get_node("Preset").visible = false
	get_parent().get_node("Helper/task").visible = false
	get_parent().get_node("Helper/list").visible = true
	get_parent().get_node("Helper/presets").visible = false
	
	if (get_parent().newFile.mainName =="Main List"):
		get_parent().get_node("Helper/list/option").text = "Can Not Delete\n Main-List"
	get_parent().get_node("Helper/list/data").text = get_parent().newFile.mainName


func helpPreset():
	get_parent().Unpause()
	destroy()
	get_parent().get_node("List").destroySaves()
	get_parent().get_node("List").destroy()
	get_parent().get_node("Preset").visible = false
	get_parent().get_node("Helper/task").visible = false
	get_parent().get_node("Helper/list").visible = false
	get_parent().get_node("Helper/presets").visible = true


func hideMe():
	get_parent().get_node("Helper/list").visible = false
	get_parent().get_node("Helper/presets").visible = false