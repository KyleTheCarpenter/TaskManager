extends Node2D


var 			id = 69420
var				header = ""
var 			date = ""
var 			status  = "ON"#ON OFF IDLE
signal 			submit

func _ready():
	get_node("circle").play("ON")

func onButtonpressed():
	match status:
		"ON":
			status = "IDLE"
			setStatus(status)
		"IDLE":
			status = "OFF"
			setStatus(status)
		"OFF": 
			status = "ON"
			setStatus(status)
	

func setStatus(arg):
	status = arg
	match arg:
		"ON":
			get_node("circle").play("ON")
		
		"OFF":
			get_node("circle").play("OFF")
		
		"IDLE":
			get_node("circle").play("IDLE")
		
	emit_signal("submit")



func fadeIt():
	get_node("fade").visible = true


func fadeOff():
	get_node("fade").visible = false


func setDate(argS):
	if (argS != "" || argS != " "):
		get_node("date").text = "due " +argS
		date = argS

	if (argS == ""):
		get_node("date").text = " "
		date = " "


func setNum(argS):
	id = int(argS)
	get_node("num").text = argS


func deleteSelf():
	var checkmark = preload("res://Scenes/Fin.tscn").instance()
	get_parent().add_child(checkmark)
	checkmark.position = position
	checkmark.position.x+=300
	get_parent().get_node("root").removeItem(id)
	print("removed ["+str(id)+"]="+header)
	
func destroy():
	get_parent().remove_child(self)

func setHeader(argS):
	get_node("header").text = argS
	header = argS

