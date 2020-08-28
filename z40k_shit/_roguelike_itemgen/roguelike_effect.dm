/*
Basically this is a recoding cause the old iteration was kinda shit.
Along with confusing to say the least.

Draft- 8/27/2020 JTGSZ

/------------Variables & Bitflags--------------/
name - A name for the effect to be referenced.
desc - A description of what someone would see when identifying it.
trigger flags - How the effect can get triggered.
max_charges - If we have charges this is how many we get before the effect stops firing
charges - this is how many charges we currently have
effect_strength - this is how strong the effect can be if we use it for the effect
effect_duration - this is how long the effect will last
cooldown_max - the total cooldown peak
cooldown - active tick amount before we are gucci

*-----Trigger Flags-----* - found in _roguelike_effects.dm. Trigger Bitflags
[Basically how the effect can be triggered from the item]
*-----------------------*
	RE_ATTACK_SELF - Calls effects when the item is clicked in the active hand.
	RE_EQUIPPED - Calls effects when the item is equipped.
	RE_FOUND - Calls effects when the item is uncovered in pockets/storage.
	RE_ATTACK_USER - Calls effects when attacking something on the user.
	RE_ATTACK_TARGET - Calls effects when attacking something on the something.
	RE_ATTACK_HAND - Calls effects when clicked

effects flags - How the effects interact with the mob
*----Effects Flags-----*

/------------Procedures------------------------/
re_process() - Its called on process from a subsystem, occurs every 2 seconds. handles cooldowns, and passives
re_effect_act()  - Its called for effects and curses
NOTES: Remember to call if(..()) to check if we are good to go on the children.

/-----------Children--------------------------/
/datum/roguelike_effects/passives - Basically a passive effect that runs every process tick
Notes - Holds a ref to obj and mob gained on equipped, and lost on dropped/unequipped

*/
/obj/item
	//40k APPEND - Roguelike Effects
	var/list/roguelike_effects = null

/datum/roguelike_effects
	var/name = "Roguelike Effects Parent"
	var/desc = "A data storage for effects to be appended to objects without much fuss."
	var/trigger_flags = 0 //Basically this will be the trigger flag
	var/max_charges = 0
	var/charges = 0
	var/effect_strength = 0
	var/effect_duration = 0
	var/cooldown_max = 0
	var/cooldown = 0

/datum/roguelike_effects/proc/add_effect_to_object(var/obj/item/I)
	if(!I.roguelike_effects)
		I.roguelike_effects = list()
	I.roguelike_effects += src

	if(cooldown_max)
		roguelike_process += src
	
/datum/roguelike_effects/proc/re_process()
	cooldown--
	if(cooldown <= 0)
		roguelike_process -= src

/datum/roguelike_effects/proc/re_effect_act(mob/living/carbon/C, obj/item/I)
	if(max_charges > 0)
		charges -= 1
		if(charges <= 0)
			I.roguelike_effects -= src
			return 1
	
	if(cooldown_max)
		if(cooldown > 0)
			return 1
		else
			cooldown = cooldown_max
			roguelike_process += src

