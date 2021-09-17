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

func moveUp():
	for items in saves:
		items.position.y-=10

func moveDown():
	for items in saves:
		items.position.y+=10
func deleteList():
	print("tring to delete")
	var listof = newFile.listNames
	var oldname = newFile.mainName
	var counter = 0
	for items in listof:
		print("["+str(items)+"]")
		if items == oldname:
			print("deleting" + oldname)
			
			listof.remove(counter)

			newFile.listNames = listof
			newFile.cNames(listof)
			print (str(newFile.listNames.size()))
			var dir = Directory.new()
			dir.remove("res://"+oldname+".list")
			
			newFile.mainName = "List1"
			newFile.saveStarter()
			
			
			newFile.Load()
			get_parent().clearBoard()
			get_parent().Load(newFile.mainName)
		counter+=1
var campingWord = ["Tent","Tarps","Air-Matress","Bed Linens","Pillows"
,"Clothes","Hygiene Supplies","Shoes/Sandals","Lanterns","Lighter/matches","Fire Starter",
"Axe/Hatchet","Wood","Chairs","RatchetStraps/String"]
func _ready():
	camp.name = "Camping-List"
	for items in campingWord:
		camp.add(items)
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
	get_parent().clearBoard()
	print("checking for dupe")
	var matches = false
	for item in newFile.listNames:
		if item == sendoutName:
			print(item)
			matches = true
		
	if matches == false:
		newFile.addName(sendoutName)
	newFile.saveNames()
	newFile.Save(get_parent().taskLoader.taskList)
	
	get_parent().Load(sendoutName)

	destroy()

func submitPre(arg):
	var sendoutName = arg
	get_parent().get_node("name").text = sendoutName
	var matches = false
	print("checking for dupe")
	for item in newFile.listNames:
		if item == sendoutName:
			print(item)
			matches = true
		
	if matches == false:
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
	newFile.LoadNames()
	for item in newFile.listNames:
		
		if item != "" :
			var savedL = preload("res://savedL.tscn").instance()
			savedL.type = "save"
			savedL.get_node("text").text = item
			savedL.connect("pressed",self,"destroySaves")
			add_child(savedL)
			savedL.position.y += 30 * saves.size()
			saves.append(savedL)
			print("madeit")
			
			
func destroySaves():
	for item in saves:
		item.destroy()
	saves.clear()
	get_node("savedList").visible = false
	get_node("premadeList").visible = false
