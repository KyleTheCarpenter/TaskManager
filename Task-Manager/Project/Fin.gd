extends Node2D

func timerDone():
	get_parent().remove_child(self)
	$Timer.stop()
