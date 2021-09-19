extends Node

class task:
	var header:String
	var date:String
	var status:String
	var id = 42069

var 			taskList = []
var				yLocal = 140
var				pause = false
var				newFile
var focused :task = task.new()
var itemAdded = false
func destroy():
	get_parent().remove_child(self)
func _ready():
	newFile = get_node("/root/NewFile")
	

var jump = 0
func addItem(argHeader,argDate,argStatus):
	var aitem = preload("res://Scenes/Item.tscn").instance()
	get_parent().get_node("/root").add_child(aitem)
	aitem.setDate(argDate)
	aitem.setHeader(argHeader)
	aitem.setStatus(argStatus)
	aitem.connect("submit",self,"saveColor")
	taskList.append(aitem)
	aitem.position.y = taskList[0].position.y +30* jump
	aitem.setNum(str(taskList.size()))
	jump +=1
	newFile.Save(taskList)
	
	
func saveColor():
	newFile.Save(taskList)
	

	
func loadItem():
	get_parent().get_node("root/Helper/list").visible = false
	var 		other:		String = "Header"
	var 		memH: 		String = ""
	var			memD: 		String = ""
	var 		memStatus:  String = ""
	itemAdded = false
	newFile.Load()
	jump = 0	

	for line in newFile.data:
		
		match other:
			"Header": 
				memH = line
				other = "Date"
			"Date" :
				memD = line
				other = "Status"
			"Status":
				memStatus = line
				other = "Header"

		if (memH != "" && memD != "" && memStatus != ""):
			if (memD == "Enter the Time or date "):
				line = "   "
			addItem(memH,memD,memStatus)
			itemAdded = true
			memH = ""
			memD = ""
			memStatus = ""
		
	
		
	
