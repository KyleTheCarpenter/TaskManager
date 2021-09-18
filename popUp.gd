extends Node2D

signal submit
var			sDate	: String = ""
var 		sHeader : String = ""
var  	    dateOptions = ["Tomorrow","Morning","MidDay","Tonight","Whenever"]
var			optionList = []


func _ready():
	loadOptions()
	get_parent().get_node("root").newFile.rootLoad()
	
func _input(event):
	if event.is_action_pressed("enter"):
		if get_node("dataHeader").text != "":
			submitPressed()	
	

func clearOptions():
	for item in optionList:
		get_parent().remove_child(item)
	optionList.clear()


func addOption(identifier,item):
	var option = preload("res://Scenes/option.tscn").instance()
	get_parent().add_child(option)
	option.myType = identifier
	option.get_node("text").text = item
	option.position.y += 31* optionList.size()
	optionList.append(option)
	if option.myType == "D":
		option.get_node("date").visible = true

func loadOptions():
	for item in get_parent().get_node("/root/NewFile").headerOptions:
		addOption("H",item)
	for item in dateOptions:
		addOption("D",item)
		
		

func submitPressed():
	clearOptions()
	get_parent().get_node("root").pause = false
	sDate = get_node("dataDate").text
	sHeader = get_node("dataHeader").text
	emit_signal("submit")
	
var deleteHeaderOnce = false
var deleteDateOnce = false

		 

func mouseEntered():
		if (deleteHeaderOnce == false):
			get_node("dataHeader").text = ""
			deleteHeaderOnce = true


func mouseEnteredDate():

		if (deleteDateOnce == false):
			get_node("dataDate").text = ""
			deleteDateOnce = true

			
func exitOut():
	clearOptions()
	get_parent().get_node("root").pause = false
	get_parent().get_node("root").isPopupAlive= false
	
	get_parent().remove_child(self)

