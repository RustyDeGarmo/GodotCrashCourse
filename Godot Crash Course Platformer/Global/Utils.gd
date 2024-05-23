extends Node

#change res to users if releasing the game
const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"Gold": Game.Gold
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

func loadGame():
	
	if FileAccess.file_exists(SAVE_PATH) == true:
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if not file.eof_reached():
			var currentLine = JSON.parse_string(file.get_line())
			if currentLine:
				Game.playerHP = currentLine["playerHP"]
				Game.Gold = currentLine["Gold"]
				
