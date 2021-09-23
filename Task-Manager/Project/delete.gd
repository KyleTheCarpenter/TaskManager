extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func openMenu(): #Sets Menu to Visible and resets the textfield
	get_node("data").text = ""
	visible = true

func closeMenu(): #sets the Menu to non-Visible
	visible = false


func deleteButtonPressed():	#deletes the preload in the textfield
	var selected = get_node("data").text
	deletePreload(selected) #deletePreload  start StackTrace #1



func deletePreload(argPreload): #deletePreload @ #1
					#deletes argPreload in Index
					
	if argPreload != "": 

		var 			tempArrayOfLoadedPreloads = []
		var 			pIndexFILE = File.new()
		var 			counter = 0
		var				matched = false
		
		pIndexFILE.open("res://clipBoard/pIndex.ktc", File.READ)
		tempArrayOfLoadedPreloads = pIndexFILE.get_as_text()
		pIndexFILE.close()
		tempArrayOfLoadedPreloads = tempArrayOfLoadedPreloads.split("\n")
		
		for loadedPreload in tempArrayOfLoadedPreloads: #if the files Match make matched true
			if loadedPreload == argPreload:
				matched = true
				tempArrayOfLoadedPreloads.remove(counter)
				get_parent().get_parent().get_parent().get_node("Logo/anime").play("del") #lol
			counter +=1


		if matched == false:
			return
		var temp = ""		
		get_parent().get_parent().preNames = tempArrayOfLoadedPreloads
		for loadedPreload in tempArrayOfLoadedPreloads:
			if loadedPreload!= "" :
				temp+=loadedPreload+"\n"
			pIndexFILE.open("res://clipBoard/pIndex.ktc", File.WRITE)
			pIndexFILE.store_line(temp)
			pIndexFILE.close()
		
		var dir = Directory.new()
		dir.remove("res://clipBoard/"+argPreload+".plist")

	get_parent().get_parent().destroypreMades() #destroypreMades Start StackTrace #2




