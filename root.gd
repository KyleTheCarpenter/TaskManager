extends Node2D


var introScene
var pointerPopup
var isPopupAlive = false
var yLocal = 70
var pause = false
var newFile
var taskLoader 
var taskHeight = 0
var moved = false
var Scrollpause = false
func _ready():
	newFile = get_node("/root/NewFile")
	taskLoader = get_node("/root/Task")
func _input(event):
	if Scrollpause == false:
		if event.is_action_pressed("scrollUp"):
			moveUp()

		if event.is_action_pressed("scrollDown"):
			moveDown()

func Unpause():
	get_node("name").visible = true
	get_node("up").visible = true
	get_node("down").visible = true
	Scrollpause = false
	pause = false
func checkItemPlacement(item):
	item.visible = true
	if item.position.y < 100:
		item.visible = false
		if item.position.y > 400:
			item.visible = false

func moveDown():
	
	
	taskHeight +=1
	for item in taskLoader.taskList:
		item.position.y-=20
		checkItemPlacement(item)
func moveUp():

	if (taskHeight > 0):
		taskHeight -=1
		for item in taskLoader.taskList:
			item.position.y+=20
			checkItemPlacement(item)




func Load(arg):
	taskHeight = 0
	newFile.mainName = arg
	get_node("name").text = arg
	newFile.saveStarter()
	taskLoader.loadItem()
	
	

func initialLoad():
	taskLoader.loadItem()
	get_node("name").text = newFile.mainName


	
func clearBoard():
	newFile.data = ""
	for items in taskLoader.taskList:
		items.destroy()
		
	taskLoader.taskList.clear()

func submitPresets():
	
	newFile.headerOptions.clear()
	var counter = 1
	while counter < 9:
		newFile.headerOptions.append(get_node("Preset/LineEdit"+str(counter)).text)
		counter+=1
	get_node("Preset").visible = false
	newFile.rootSave()

func presetsPressed():
	if Scrollpause == false:
		Unpause()

		get_node("List").destroy()
		get_node("List").destroySaves()
		get_node("Helper/task").visible =false
		get_node("Helper/list").visible = false
		get_node("Helper/presets").visible = false


		get_node("Preset").visible = true
		var counter = 1
		for item in newFile.headerOptions:
			get_node("Preset/LineEdit"+str(counter)).text = item
			counter+=1

func handleKeyboard():
	if Scrollpause == false:
		get_node("List").destroy()
		get_node("List").destroySaves()
		get_node("Preset").visible = false
		get_node("Helper/task").visible =false
		get_node("Helper/list").visible = false
		get_node("Helper/presets").visible = false
		pause = true
		var newPopUp = preload("res://Scenes/popUp.tscn").instance()
		pointerPopup = newPopUp
		newPopUp.connect("submit", self, "informationInput")
		newPopUp.connect("cancel", self, "canceld")
		get_parent().add_child(newPopUp)
		
func canceld():
	Unpause()
func resetBoard():
	for item in taskLoader.taskList:
		get_parent().remove_child(item)
	taskLoader.taskList.clear()
	taskLoader.loadItem()	
	

func informationInput():
	Unpause()
	isPopupAlive = false
	get_node("Logo/anime").play("add")
	taskLoader.addItem(pointerPopup.sHeader,pointerPopup.sDate,"OFF")
	
	get_parent().remove_child(pointerPopup)

func addTask(argh,argd,argt):
	newFile.saveNames()
	taskLoader.addItem(argh,argd,argt)

	newFile.Save(taskLoader.taskList)

func removeItem(arg):
	for item in taskLoader.taskList:
		if (item.id == arg):
			get_parent().remove_child(item)
			taskLoader.taskList.erase(item)
			newFile.Save(taskLoader.taskList)
			resetBoard()
		

func _process(_delta):
	if (pause):
		get_node("task").visible = false
	elif !pause:
		if isPopupAlive == false:
			isPopupAlive = true
		get_node("task").visible = true
	


