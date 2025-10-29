extends Node2D

func refresh_all():
	for i in get_children():
		i.refresh()
