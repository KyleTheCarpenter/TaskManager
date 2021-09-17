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

func destroy():
	get_parent().remove_child(self)
func _ready():
	newFile = get_node("/root/NewFile")
	


func addItem(argHeader,argDate,argStatus):
	var aitem = preload("res://Scenes/Item.tscn").instance()
	get_node("/root/").add_child(aitem)
	aitem.setDate(argDate)
	aitem.setHeader(argHeader)
	aitem.setStatus(argStatus)
	aitem.connect("submit",self,"saveColor")
	taskList.append(aitem)
	aitem.position.y = taskList.size() * 30+80
	aitem.setNum(str(taskList.size()))
	
	newFile.Save(taskList)
	
	
func saveColor():
	newFile.Save(taskList)
	

	
func loadItem():
	var 		other:		String = "Header"
	var 		memH: 		String = ""
	var			memD: 		String = ""
	var 		memStatus:  String = ""

	newFile.Load()
		

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
			addItem(memH,memD,memStatus)
			memH = ""
			memD = ""
			memStatus = ""
		

	
