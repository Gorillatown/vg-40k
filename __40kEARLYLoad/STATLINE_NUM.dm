
//See: human.dm: Line 1174 for where we stick species base attributes onto the mob.
//How it will be done.
//Basically theres the attribute itself, which is given from our base starting val located in species.
//To increase the attribute you do an action that uses a check of the attribute.
//The amount the attribute builds to the next level depends on the action difficulty.

//Basically we are going to have stat increases on a cooldown.

#define ATTR_STRENGTH 		"strength"
#define ATTR_AGILITY 		"agility"
#define ATTR_DEXTERITY 		"dexterity"
#define ATTR_CONSTITUTION 	"constitution"
#define ATTR_WILLPOWER		"willpower"
#define ATTR_SENSITIVITY	"sensitivity"

/datum/mind
	var/datum/job_quest/job_quest = null //Basically do we currently have a job quest attached to us?

/mob/living/carbon/human
	var/list/warp_mutations = list()

/mob
	var/warp_speed = FALSE //We are currently in WARP INDUCED SPEED INCREASE (Aka extra attacks)
	var/soul_blaze_melee = FALSE //Are we currently applying soul blaze?
	var/respawn_modifier = 0 //How much is our respawn delayed cause we died?
	
	var/dodging = FALSE //Are we currently special dodging?
 
/mob/living
	var/stat_increase_cooldown = FALSE //A optional cooldown on stat increases
	var/objuration_mechanicum = FALSE //Causes Gun failures
	var/warp_charges = 0 //Casting CDR/Funtime effects handler. See life.dm Line:149
	var/chaos_tainted = FALSE //Are we currently tainted by chaos?
	var/bumpattacks = FALSE //We currently have bump attacks toggled on?
	
	var/list/spelltree_unlocked_list = list(
		BIOMANCY = 1,
		PYROMANCY	= 1,							
		TELEKINESIS = 1,
		TELEPATHY = 1
		) //Spell trees that are currently unlocked.

	var/soul_blazed = FALSE //We currently appended to?

/*
	Strength
				*/
//What strength is is basically raw muscle man.
//Strength determines force additions in melee(1.5x), and active blocking success chances.
/*

*/
	var/attribute_strength = 1
	var/attribute_strength_natural_limit = 1
	var/attribute_strength_trained_integer = 1

/*
	Agility
			*/
//What agility is is basically how fast something can move.
//Agility determines speed, also partially covers reactions.
//Some movespeed and Parrying and deflecting.
	var/attribute_agility = 1
	var/attribute_agility_natural_limit = 1
	var/attribute_agility_trained_integer = 1
/*
	Dexterity
				*/
//What dexterity is is basically how well something can manipulate things.
//Dexterity also covers reactions. Aka Parrying and Deflecting
	var/attribute_dexterity = 1
	var/attribute_dexterity_natural_limit = 1
	var/attribute_dexterity_trained_integer = 1
/*
	Constitution
				*/
//Constitution is basically how durable something is
//It covers additions to our total health amount (+10 per lvl)
//We train it by doing painful things, or recovering from injuries.
/*Appends: 

*/
	var/attribute_constitution = 1
	var/attribute_constitution_natural_limit = 1
	var/attribute_constitution_trained_integer = 1

/*
	MAGIC SYSTEM SHIT
						*/
/*
Basically unless you already were a psyker, you only unlock things at a certain threshold of warp sensitivity.
|0------------500------------1000|
Nothing	  Small prob	100% unlock

Along with that there is a variable that dictates how much you can cast and how fast.
Going too far up it increases risk of injury, unless you are casting chaos stuff.
The integers are held on the mob.
Willpower will dictate your strain dissipation rate.
Chaos based stuff will cost no strain.

*/
/*
	Willpower
				*/
//Willpower is basically how much resistance we have to magic shit.
//Also how strong we can cast.
//Dictates how many points we can put towards general psyker things.
	var/attribute_willpower = 1
	var/attribute_willpower_natural_limit = 1
	var/attribute_willpower_trained_integer = 1
	var/ticker_to_next_psyker_point = 0
	var/psyker_points = 0
/*
	Sensitivity
				*/
//Sensitivity is basically how much LESS resistance we have to magic shit.
//Also how strong we can cast.
//Dictates how many points we can put towards Chaos based things.
	var/attribute_sensitivity = 1
	var/attribute_sensitivity_natural_limit = 1
	var/attribute_sensitivity_trained_integer = 1
	var/ticker_to_next_chaos_psyker_point = 0
	var/chaos_psyker_points = 0
	