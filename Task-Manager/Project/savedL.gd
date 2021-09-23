extends Node2D


var 		myName: String = "unset"
var 		type
signal		pressed
var 		newFile
var 		list = []
var 		taskLoader


func _ready():
	newFile = get_node("/root/NewFile")
	taskLoader = get_node("/root/Task")


func pressedd():
	get_parent().get_parent().Scrollpause = false
	get_parent().get_parent().get_node("up").visible = true
	get_parent().get_parent().get_node("down").visible = true
	get_parent().get_parent().get_node("name").visible = true
	var 		memH: 		String = ""
	var			memD: 		String = ""
	var 		memStatus:  String = ""
	var 		other = "Header"
	

	if type == "save":
		get_parent().get_parent().clearBoard()
		myName = get_node("text").text
		get_parent().get_parent().get_node("name").text = myName
		newFile.mainName = myName
		get_parent().newFile.saveStarter()

		get_parent().get_parent().Load(myName)
		emit_signal("pressed")

	if type == "premade":
		var dir = Directory.new()
		dir.remove("res://"+myName+".list")

		get_parent().get_parent().clearBoard()
		myName = get_node("text").text
		get_parent().get_parent().get_node("name").text = myName
		
		newFile.mainName = myName
		newFile.saveStarter()

		for line in list:
			if line != "":
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
					get_parent().get_parent().addTask(memH,memD,memStatus)
					memH = ""
					memD = ""
					memStatus = ""

		get_parent().get_parent().get_node("List").submitPre(myName)
		
		type = "saved"
		
		emit_signal("pressed")
	

	
func destroy():
	get_parent().remove_child(self)
