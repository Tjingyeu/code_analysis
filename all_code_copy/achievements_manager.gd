extends Node2D



func _ready() -> void:
	Steam.steamInit()
	var SteamRunning = Steam.isSteamRunning()
	
	if !SteamRunning:
		print("steam not running")
		return
	
	print("steam is running")
	
	var id = Steam.getSteamID()
	var usrname = Steam.getFriendPersonaName(id)
	
	print("Username: ",str(usrname))
	setAchievement("first_koi")
	
func setAchievement(achievement):
	var status = Steam.getAchievement(achievement)
	if status["achieved"]:
		print("already unlocked")
		return
	Steam.setAchievement(achievement)
	print("unlocked: ", str(achievement))


func check_00():
	pass

func check_01():
	pass
	
func check_02():
	pass
