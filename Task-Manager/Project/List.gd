extends Node2D

var saves = []
var newFile
var premadeList = []
var premades = []
var preNames = []
var hub
class premade:
	var name = "name"
	var list = []

	func add(arg,arg2):
		list.append(arg)
		list.append(arg2)
		list.append("IDLE")

	func addFull(argHeader,argDate):
		list.append(argHeader)
		list.append(argDate)
		list.append("IDLE")



func SaveAsPreload():
	hub.debugTitle("Saving as Preload")
	hub.debug(str(newFile.mainName),".plist saved")
	var ssaveMap = ""
	for items in get_parent().taskLoader.taskList:
		ssaveMap+=items.header+"\n"
		ssaveMap+=items.date+"\n"
		ssaveMap+=items.status+"\n"

	var new_file = File.new()
	new_file.open("res://clipBoard/"+newFile.mainName+".plist", File.WRITE)
	new_file.store_line(ssaveMap)
	new_file.close()

	#save its name to the list
	preNames.append(newFile.mainName)
	var names = ""
	for item in preNames:
		if item != "":
			names+=item+"\n"
	var new_file2 = File.new()
	
	hub.debug("Saving Preload to pIndex" ," ")
	new_file2.open("res://clipBoard/pIndex.ktc", File.WRITE)
	new_file2.store_line(names)
	new_file2.close()
	get_parent().get_node("Logo/anime").play("pre")


func LoadPremadeList():
	hub.debugTitle("Opening pIndex and saving to Array")
	var new_file = File.new()

	new_file.open("res://clipBoard/pIndex.ktc", File.READ)
	var tempdata = new_file.get_as_text()
	new_file.close()
	tempdata = tempdata.split("\n")
	preNames = tempdata


func AddPremades(argName):
	hub.debugTitle("Loading Premades into Viewing List")
	var temp = premade.new()
	temp.name = argName
	
	#load in data

	var tempList = []
	if argName == "":
		return
	var new_file = File.new()

	new_file.open("res://clipBoard/"+argName+".plist",File.READ)
	tempList = new_file.get_as_text()
	new_file.close()
	tempList = tempList.split("\n")


	#info is in tempList

	#now parse it and make a list
	var memH = ""
	var memD = ""
	var other = "Header"
	
	for items in tempList:
		match other:
			"Header":
				memH = items
				other = "Date"
			"Date":
				memD = items
				other = "Status"
			"Status": 
				other = "Header"
		if (memH!= "" && memD !=""):
			temp.add(memH,memD)
			memH = ""
			memD = ""
	var fail = false
	for item in premades:
		if item.name == temp.name:
			fail = true
	if (fail == false):
		premades.append(temp)








func moveUp():
	if get_node("savedList").visible == true || get_node("premadeList").visible == true:
		for items in saves:
			items.position.y-=10

func moveDown():
	if get_node("savedList").visible == true|| get_node("premadeList").visible == true:
		for items in saves:
			items.position.y+=10

func deleteList():
	hub.debugTitle("List Delete")
	
	if newFile.mainName == "Main List":
		return
	var listof = newFile.listNames
	var oldname = newFile.mainName
	var counter = 0
	for items in listof:
		print("["+str(items)+"]")
		if items == oldname:
			print("deleting" + oldname)
			hub.debug("Deleting",str(newFile.mainName))

			listof.remove(counter)
			get_parent().get_node("Logo/anime").play("del")
			newFile.listNames = listof
			newFile.cNames(listof)
			print (str(newFile.listNames.size()))
			var dir = Directory.new()
			if oldname!= "Main List":
				dir.remove("res://clipBoard/"+oldname+".list")
			if (get_parent().taskLoader.taskList.size()== 0):

				newFile.mainName = "Main List"
				newFile.listNames = []
			newFile.mainName = "Main List"
			newFile.saveStarter()
			
			
			newFile.Load()
			get_parent().clearBoard()
			get_parent().Load(newFile.mainName)
		counter+=1

func _ready():
	hub = get_node("/root/Hub")
	var dir = Directory.new()
	var path = OS.get_executable_path().get_base_dir().plus_file("clipBoard")
	dir.make_dir(path)
	LoadPremadeList()
	
	
	newFile = get_node("/root/NewFile")

	
func destroy():
	
	if get_node("savedList").visible == true || get_node("premadeList").visible == true :
		destroySaves()
		
		get_parent().pause = false
	get_node("newList").visible = false
	get_node("savedList").visible = false
	get_node("premadeList").visible = false

func _input(event):
	if get_node("newList").visible == true:
		if get_parent().isPopupAlive == true:
			if event.is_action_pressed("enter"):
				submit()
				
	if get_node("savedList").visible == true || get_node("premadeList").visible == true :
		if event.is_action_pressed("scrollUp"):
				moveUp()
		
		if event.is_action_pressed("scrollDown"):
				moveDown()	

func _on_cancel_pressed():
	
	if get_parent().Scrollpause == true:
		for items in get_parent().taskLoader.taskList:
			items.visible = true
			
		get_parent().get_node("name").visible = true
		get_parent().get_node("up").visible = true
		get_parent().get_node("down").visible = true
		get_parent().pause = false
		get_parent().Scrollpause = false
		

func submit():
	get_parent().pause = false
	get_parent().Scrollpause = false
	for items in get_parent().taskLoader.taskList:
		items.visible = true
	get_parent().get_node("name").visible = true
	get_parent().get_node("up").visible = true
	get_parent().get_node("down").visible = true
	if get_node("newList/data").text != "":
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
			get_parent().get_node("Logo/anime").play("add")
			newFile.saveNames()
			newFile.Save(get_parent().taskLoader.taskList)
		
		if matches:
			get_parent().get_node("Logo/anime").play("dupe")
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
		get_parent().get_node("Logo/anime").play("add")
	newFile.saveNames()
	newFile.Save(get_parent().taskLoader.taskList)
	get_parent().clearBoard()
	get_parent().Load(sendoutName)


func openPremades():
	premadeList.clear() 
	LoadPremadeList()
	premades.clear()
	for item in preNames:

		AddPremades(item)
	for items in premades:
		premadeList.append(items)
	for item in premadeList:
		var savedL = preload("res://Scenes/savedL.tscn").instance()
		savedL.type = "premade"
		savedL.list = item.list
		savedL.get_node("text").text = item.name
		savedL.connect("pressed",self,"destroypreMades")
		if (item.name!= ""):
			add_child(savedL)
			savedL.position.y += 30 * saves.size()
			saves.append(savedL)

func destroypreMades():
	get_parent().Unpause()
	destroySaves()

func openSaves():
	saves.clear()
	newFile.LoadNames()
	for item in newFile.listNames:
		
		if item != "" :
			var savedL = preload("res://Scenes/savedL.tscn").instance()
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
