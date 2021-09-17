extends Node
var headerOptions = []
var saveMap 
var data = []
var testOptions 
var rootData 
var mainName : String = "List1"
var listNames = []



func setList(arg):
	mainName = arg

func addName(arg):
	mainName = arg
	get_parent().get_node("root/name").text = mainName
	listNames.append(str(arg))
	


func _ready():
	rootLoad()
	loadStarter()

func rootLoad():
	headerOptions.clear()
	var new_file = File.new()
	if not new_file.file_exists("res://root.list"):
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
	
	new_file.open("res://root.list",File.READ)
	
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
	var new_file = File.new()
	if not new_file.file_exists("res://Index.list"):
		return
	new_file.open("res://bin.ktc", File.READ)
	mainName = new_file.get_line()
	new_file.close()
	


func LoadNames():

	
	var new_file = File.new()
	if not new_file.file_exists("res://Index.list"):
		addName("List1")
		mainName = "List1"
		saveStarter()
		saveNames()
		get_parent().get_node("root").taskLoader.addItem("add a task","or start a new list","ON")
		Save(get_parent().get_node("root").taskLoader.taskList)
		Load()
		return
	new_file.open("res://Index.list", File.READ)
	listNames = new_file.get_as_text()
	listNames = listNames.split("\n")

	new_file.close()

	loadStarter()
	get_parent().get_node("root/name").text = mainName
	
func setLoad(arg):
	mainName = arg
	

func Load():
	LoadNames()
	var new_file = File.new()
	if not new_file.file_exists("res://"+mainName+".list"):
		return data
	new_file.open("res://"+mainName+".list", File.READ)
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
	new_file.open("res://"+mainName+".list", File.WRITE)
	new_file.store_line(ssaveMap)
	new_file.close()

func saveStarter():
	var new_file = File.new()
	new_file.open("res://bin.ktc", File.WRITE)
	new_file.store_line(mainName)
	new_file.close()

func saveNames():
	
	var nameMap = ""
	if listNames.size()!= 0:
		for items in listNames:
			if items != "":
				nameMap += items + "\n"
		
	var new_file = File.new()
	new_file.open("res://Index.list",File.WRITE)
	new_file.store_line(nameMap)
	new_file.close()
	
	
func cNames(arg):
	
	var nameMap = ""
	if arg.size()!= 0:
		for items in arg:
			if items != "":
				nameMap += items + "\n"
		
	var new_file = File.new()
	new_file.open("res://Index.list",File.WRITE)
	new_file.store_line(nameMap)
	new_file.close()
	
func rootSave():
	saveMap = ""

	##setmap
	savePresets()
	var new_file = File.new()
	new_file.open("res://root.list", File.WRITE)
	new_file.store_line(saveMap)
	new_file.close()

func savePresets():
	for item in headerOptions:
		saveMap += item + "\n"
	saveMap+=";"
