/datum/migration/sqlite/ss13_prefs/_023
	id = 23
	name = "tgui_fancy"

/datum/migration/sqlite/ss13_prefs/_023/up()
	if(!hasColumn("client","tgui_fancy"))
		return execute("ALTER TABLE `client` ADD COLUMN tgui_fancy INTEGER DEFAULT 1")
	return TRUE

/datum/migration/sqlite/ss13_prefs/_023/down()
	if(hasColumn("client","tgui_fancy"))
		return execute("ALTER TABLE `client` DROP COLUMN tgui_fancy")
	return TRUE
