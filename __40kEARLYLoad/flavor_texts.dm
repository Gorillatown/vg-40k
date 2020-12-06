/*
	Contained within is some lists with flavorful texts so I have more to work with.
	I'm not a madman to make a proc generate a new list of personal flavortexts each time.
	So generally its gonna be [thing1] and then [thing2] at the end.
*/

//Disarm Prob 1: Combat.dm Line:47
	//Beginning: Target | Ending: Attacker
var/list/disarm_flavors_1_t_a = list(
							"attempts to disarm yet misses the shot at",
							"has attempted to disarm",
							"doesn't exist in a reality where they disarm",
							"dexterity is caught lacking in the act of disarming"
							)

	//Beginning: Attacker | Ending: Target
var/list/disarm_flavors1_a_t = list(
							"deftly avoids being disarmed by",
							"doesn't get tripped up by",
							"avoids meeting the ground by the actions of",
							"dodges a reality of being disarmed by",
							"isn't knocked down a few pegs by"
							)

//Disarm Prob 2: Combat.dm Line:59
	//Beginning: Attacker | Ending: Target
var/list/disarm_flavors_2 = list(
							"has pushed",
							"brings down",
							"brings a new perspective of the world above to",
							"trips up",
							"shows they are are dextrous enough to disarm someone to",
							"presents the full clowntown experience to",
							)