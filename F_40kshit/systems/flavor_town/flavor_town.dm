/*
	Basically this datum will be able to re-arrange shit via a proc call without us having to refactor
	Params. So we can have more fun messages.

	Basically we have variables in the datum itself so we can format string lists contained within
	The datum more thoroughly without a compiler error.

	The receiver is passed, then the deliverer.
	the decider is a define tied to a number located in _Flavortown_Defines.dm
	All Defines will start with FTOWN_LABEL to avoid issues with naming.

	These files will look particularly nasty as we need constants in a define.
	So all the strings will have to be held in 
	
*/
/datum/flavortown

/datum/flavortown/proc/ftown_string_disarm(var/bitch,var/aggressor,var/decider)
	//var/the_string = ""
	var/list/disarm_string

	switch(decider)
		//Disarm Prob 1: Combat.dm Line:47 - Failures
			//Beginning: Attacker [src] | Ending: Recipient [target]
		if(1)
			disarm_string = list(
			"[aggressor] attempts to disarm [bitch] yet misses the mark",
			"[aggressor] has attempted to disarm [bitch]",
			"[aggressor] doesn't exist in a reality where they disarm [bitch]",
			"[aggressor]'s dexterity is caught lacking in the act of disarming [bitch]",
			"[bitch] luckily avoids being disarmed by [aggressor]",
			"[bitch] avoids being humiliated by [aggressor]",
			"[bitch] luckily doesn't get acquainted with the ground",
			"[bitch] isn't in a reality where [aggressor] disarms them",
			"[bitch] fails to be knocked down by [aggressor]")
		//Disarm Prob 2: Combat.dm Line:59 - Knockdown Aka Best Result
			//Beginning: Attacker [src] | Ending: Recipient [target]
		if(2)
			disarm_string = list(
			"[aggressor] has pushed [bitch]",
			"[aggressor] brings down [bitch]",
			"[aggressor] brings a new perspective of the world above to [bitch]",
			"[aggressor] trips up [bitch]",
			"[aggressor] shows they are are dextrous enough to disarm someone to [bitch]",
			"[aggressor] shows the meaning of clowntown experience to [bitch]",
			"[bitch] experiences a show of skill by [aggressor]")
		//Disarm: Hand Knockouts Combat.dm Line:
			//Beginning: Attacker [src] | Ending: Recipient [target]
		if(3)
			disarm_string = list(
			"[aggressor] has disarmed [bitch]",
			"[bitch] has the things in their hands slapped out by [aggressor]",
			"[aggressor] frees [bitch]'s hands",
			"[aggressor] lightens the load for [bitch]")

	return pick(disarm_string)