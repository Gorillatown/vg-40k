/*
	Within is a disjointed save proc for the potential system.
																*/
/*
You may ask what is this? 
Its basically rewardpoints for doing shit, we do not want to save everything
At the end of the round, maybe in the future there will be more tables etc for persistent chars.
But the preferences menu and other stuff will need cleaned up and such.
*///This needs to be appended to gameticker.dm or the mode end segment.

/datum/interactive_persistence
	var/database/persistdb = ("persistence.sqlite")
	var/client/client
	var/potential = 0
	var/ooc_color = "#002eb8"
	var/persistenceloaded = 0

/*
	We write a new database file and put our table into it.
	Make sure to keep this commented out unless you are writing a new database.
	Basically you just log in and enter the game and the ability to write it is on commands tab.
	Its not all that important compared to char data, so wipe it or add more tables.
	Step by Step instructions for - How to do things the bad way.
	1. Change the above persistdb to something randomly named.
	2. Uncomment the below.
	3. Delete the old persistence.sqlite
	3. Go ingame, click Write_new_database in commands.
	4. Delete the random db from the original change.
	5. Change filename back to persistence.sqlite.

	If you need debugging information, go visit the dbdebugverb.dm file.
*/
/*
/mob/verb/write_new_database()
	var/database/persistdb = ("persistence.sqlite")
	var/database/query/Q = new()
	var/sql={"CREATE TABLE "persistence" (
	`ID`			INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`ckey`			INTEGER UNIQUE,
	`potential`		INTEGER,
	`ooc_color`		TEXT
);"}

	Q.Add(sql)
	Q.Execute(persistdb)

*/

/datum/interactive_persistence/New(client/C)
	client=C
	if(istype(C))
		var/theckey = C.ckey
		var/thekey = C.key
		spawn()
			if(!IsGuestKey(thekey))
				while(!SS_READY(SShumans)) //Basically this stops anything from occurring before humans r loaded
					sleep(1)
				if(load_persistence_sqlite(theckey,C))
					persistenceloaded = 1
				else
					save_persistence_sqlite(theckey,C,FALSE)
					persistenceloaded = 1

/datum/interactive_persistence/proc/save_persistence_sqlite(var/ckey, var/user, var/journeyend = FALSE)
	var/database/query/check = new
	var/database/query/q = new
	if(!ckey)
		message_admins("BAD DATA ALMOST WRITTEN INTO DATABASE, HOLY SHIT WHATS WRONG WITH BYOND.")
		return 0 //Hell no 

	check.Add("SELECT ckey FROM persistence WHERE ckey = ?", ckey)
	if(check.Execute(persistdb))
		if(!check.NextRow())
			q.Add("INSERT into persistence (ckey, potential, ooc_color)\
									 VALUES (?,		?,			?)",\
											ckey, potential, ooc_color)
			if(!q.Execute(persistdb))
				message_admins("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #: [q.Error()] - [q.ErrorMsg()]")
				WARNING("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #:[q.Error()] - [q.ErrorMsg()]")
				return 0
		else
			q.Add("UPDATE persistence SET potential=? ,ooc_color=? WHERE ckey = ?",\
										potential  ,ooc_color,	ckey)
			if(!q.Execute(persistdb))
				message_admins("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #: [q.Error()] - [q.ErrorMsg()]")
				WARNING("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #:[q.Error()] - [q.ErrorMsg()]")
				return 0
	else
		message_admins("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #: [check.Error()] - [check.ErrorMsg()]")
		WARNING("Error in save_persistence_sqlite [__FILE__] ln:[__LINE__] #:[q.Error()] - [q.ErrorMsg()]")
		return 0
	
	if(journeyend)
		to_chat(user, "Your potential increases, your current potential is [potential].")
	return 1


/datum/interactive_persistence/proc/load_persistence_sqlite(var/ckey,var/user)
	var/list/persistence_one = new
	var/database/query/check = new
	var/database/query/q = new

	check.Add("SELECT ckey FROM persistence WHERE ckey = ?", ckey)
	if(check.Execute(persistdb))
		if(!check.NextRow())
			return 0
	else
		message_admins("Error in load_persistence_sqlite [__FILE__] ln:[__LINE__] #: [check.Error()] - [check.ErrorMsg()]")
		WARNING("Error in load_persistence_sqlite [__FILE__] ln:[__LINE__] #:[q.Error()] - [q.ErrorMsg()]")
		return 0
	q.Add("SELECT * FROM persistence WHERE ckey = ?", ckey)
	if(q.Execute(persistdb))
		while(q.NextRow())
			var/list/row = q.GetRowData()
			for(var/a in row)
				persistence_one[a] = row[a]

	potential 	= text2num(persistence_one["potential"]) 
	ooc_color 	= persistence_one["ooc_color"]

	potential 	= sanitize_integer(potential, 0, 1000, initial(potential))
	ooc_color	= sanitize_hexcolor(ooc_color, initial(ooc_color))

	return 1

