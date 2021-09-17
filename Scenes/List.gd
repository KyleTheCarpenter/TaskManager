extends Node2D

var saves = []
var newFile
var premadeList = []

class premade:
	var name = "name"
	var list = []

	func add(arg):
		
		list.append(arg)
		list.append("Pack")
		list.append("IDLE")

var camp = premade.new()

func deleteList():
	print("tring to delete")

func _ready():
	camp.name = "Camping-List"
	camp.add("Tent")
	camp.add("Fire Starter")
	newFile = get_node("/root/NewFile")

func destroy():
	if get_node("savedList").visible == true:
		destroySaves()
	get_node("newList").visible = false
	get_node("savedList").visible = false
	get_node("premadeList").visible = false

func submit():
	
	var sendoutName = get_node("newList/data").text
	get_parent().get_node("name").text = sendoutName
	
	newFile.addName(sendoutName)
	newFile.saveNames()
	newFile.Save(get_parent().taskLoader.taskList)
	get_parent().clearBoard()
	get_parent().Load(sendoutName)

	destroy()

func submitPre(arg):
	var sendoutName = arg
	get_parent().get_node("name").text = sendoutName
	
	newFile.addName(sendoutName)
	newFile.saveNames()
	newFile.Save(get_parent().taskLoader.taskList)
	get_parent().clearBoard()
	get_parent().Load(sendoutName)


func openPremades():
	premadeList.clear() 
	
	premadeList.append(camp)
	for item in premadeList:
		var savedL = preload("res://savedL.tscn").instance()
		savedL.type = "premade"
		savedL.list = camp.list
		savedL.get_node("text").text = item.name
		savedL.connect("pressed",self,"destroypreMades")
		add_child(savedL)
		savedL.position.y += 30 * saves.size()
		saves.append(savedL)

func destroypreMades():

	destroySaves()

func openSaves():
	saves.clear()
	for item in newFile.listNames:
		
		if item != "" :
			var savedL = preload("res://savedL.tscn").instance()
			savedL.type = "save"
			savedL.get_node("text").text = item
			savedL.connect("pressed",self,"destroySaves")
			add_child(savedL)
			savedL.position.y += 30 * saves.size()
			saves.append(savedL)
			
			
func destroySaves():
	for item in saves:
		item.destroy()
	saves.clear()
	get_node("savedList").visible = false
	get_node("premadeList").visible = false
