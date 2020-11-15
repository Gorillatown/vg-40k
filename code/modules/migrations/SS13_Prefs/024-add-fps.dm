/datum/migration/sqlite/ss13_prefs/_024
	id = 24
	name = "Add FPS"

/datum/migration/sqlite/ss13_prefs/_024/up()
	if(!hasColumn("client","fps"))
		return execute("ALTER TABLE `client` ADD COLUMN fps INTEGER DEFAULT 0")
	return TRUE

/datum/migration/sqlite/ss13_prefs/_024/down()
	if(hasColumn("client","fps"))
		return execute("ALTER TABLE `client` DROP COLUMN fps")
	return TRUE
