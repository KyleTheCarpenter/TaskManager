extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var selected = ""
func openMenu():
	get_node("data").text = ""
	visible = true

func closeMenu():
	visible = false

func sendInfo():
	selected = get_node("data").text
	deletePreload(selected)



func deletePreload(item): 
	if item != "":
		var names = [""]
		var new_file = File.new()
		var new_file2 = File.new()
		var counter = 0
		new_file2.open("res://clipBoard/pIndex.ktc", File.READ)
		names = new_file2.get_as_text()
		new_file2.close()
		names = names.split("\n")
		var matched = false
		for items in names:
			if items == item:
				matched = true
				print("Matched "+items)
				names.remove(counter)
				get_parent().get_parent().get_parent().get_node("Logo/anime").play("del")
			counter +=1
		if matched == false:
			return
		var temp = ""		
		get_parent().get_parent().preNames = names
		for itemz in names:
			if itemz!= "" :
				print("saving"+itemz)
				temp+=itemz+"\n"

		new_file.open("res://clipBoard/pIndex.ktc", File.WRITE)
		new_file.store_line(temp)
		
		new_file.close()
		
		var dir = Directory.new()
		dir.remove("res://clipBoard/"+item+".plist")

	get_parent().get_parent().destroypreMades()
	
	#deleted then saved the name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
