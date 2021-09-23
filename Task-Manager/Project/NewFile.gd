extends Node
var headerOptions = []
var saveMap 
var data = []
var testOptions 
var rootData 
var mainName : String = "Main List"
var listNames = []
var hub


func setList(arg):
	mainName = arg

func addName(arg):
	mainName = arg
	get_parent().get_node("root/name").text = mainName
	listNames.append(str(arg))
	


func _ready():
	hub = get_node("/root/Hub")
	rootLoad()
	loadStarter()
	

func rootLoad():
	headerOptions.clear()
	var new_file = File.new()
	if not new_file.file_exists("res://clipBoard/root.list"):
		headerOptions.append("Groceries")
		headerOptions.append("Laundry")
		headerOptions.append("Debug")
		headerOptions.append("CleanUp")
		headerOptions.append("Dishes")
		headerOptions.append("New Idea")
		headerOptions.append("Excercise")
		headerOptions.append("Eat Food")
		rootSave()
		
		return
	
	new_file.open("res://clipBoard/root.list",File.READ)
	
	headerOptions.append(new_file.get_line())
	headerOptions.append(new_file.get_line())
	headerOptions.append(new_file.get_line())
	headerOptions.append(new_file.get_line())
	headerOptions.append(new_file.get_line())
	headerOptions.append(new_file.get_line())
	headerOptions.append(new_file.get_line())
	headerOptions.append(new_file.get_line())
	new_file.close()
	
func printNames():
	pass

func loadStarter():
	hub.debugTitle("Saving Current List")
	var new_file = File.new()
	if not new_file.file_exists("res://clipBoard/bin.ktc"):
		return
	new_file.open("res://clipBoard/bin.ktc", File.READ)
	mainName = new_file.get_line()
	new_file.close()
	


func LoadNames():

	if mainName == "NO LIST SELECTEcD":
		mainName ="Main List"
		return

	var new_file = File.new()
	if not new_file.file_exists("res://clipBoard/Index.list"):
		addName("Main List")
		mainName = "Main List"
		saveStarter()
		
		Save(get_parent().get_node("root").taskLoader.taskList)
		saveNames()
		Load()
		return
	new_file.open("res://clipBoard/Index.list", File.READ)
	listNames = new_file.get_as_text()
	new_file.close()
	listNames = listNames.split("\n")

	loadStarter()
	get_parent().get_node("root/name").text = mainName
	
func setLoad(arg):
	mainName = arg
	

func Load():
	LoadNames()
	var new_file = File.new()
	if not new_file.file_exists("res://clipBoard/"+mainName+".list"):
		
		return data

	new_file.open("res://clipBoard/"+mainName+".list", File.READ)
	data = new_file.get_as_text()
	new_file.close()
	data = data.split("\n")
	return data

func Save(theTaskList):
	
	var ssaveMap = ""
	if theTaskList.size()!=0:
		for items in theTaskList:
				ssaveMap+= items.header + "\n"
				ssaveMap+= items.date + "\n"
				ssaveMap+= items.status + "\n"

	var new_file = File.new()
	new_file.open("res://clipBoard/"+mainName+".list", File.WRITE)
	new_file.store_line(ssaveMap)
	new_file.close()

func saveStarter():
	hub.debugTitle("Saving Starter List")
	var new_file = File.new()
	new_file.open("res://clipBoard/bin.ktc", File.WRITE)
	new_file.store_line(mainName)
	new_file.close()

func saveNames():
	hub.debugTitle("Saving Array of names to Index")
	var nameMap = ""
	if listNames.size()!= 0:
		for items in listNames:
			if items != "":
				nameMap += items + "\n"
		
	var new_file = File.new()
	new_file.open("res://clipBoard/Index.list",File.WRITE)
	new_file.store_line(nameMap)
	new_file.close()
	
	
func cNames(arg):
	hub.debugTitle("Opening Index and saving it to an array of names")
	var nameMap = ""
	if arg.size()!= 0:
		for items in arg:
			if items != "":
				nameMap += items + "\n"
		
	var new_file = File.new()
	new_file.open("res://clipBoard/Index.list",File.WRITE)
	new_file.store_line(nameMap)
	new_file.close()
	
func rootSave():
	saveMap = ""

	##setmap
	savePresets()
	var new_file = File.new()
	new_file.open("res://clipBoard/root.list", File.WRITE)
	new_file.store_line(saveMap)
	new_file.close()

func savePresets():
	for item in headerOptions:
		saveMap += item + "\n"
	saveMap+=";"
