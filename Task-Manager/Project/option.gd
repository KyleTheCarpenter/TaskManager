extends Node2D


var 		myType : String = "unset"
var			myName : String = "unset"

func pressedd():
																	#H,D header,Date 
		myName = get_node("text").text 
		if (myType == "H"):
			get_parent().get_node("popUp/dataHeader").text = myName
			get_parent().get_node("popUp").deleteHeaderOnce = true

		elif (myType == "D"):
			get_parent().get_node("popUp/dataDate").text = myName
			get_parent().get_node("popUp").deleteDateOnce = true
