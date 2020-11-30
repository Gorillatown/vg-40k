/*
---------------Passives-------------

current_mob and attached_object are cleared in /obj/item/Destroy() too
code\game\objects\items.dm Line: 97

current_mob is gained in 
code\game\objects\items.dm Line: 367 equipped()

current_mob is cleared in 
code\game\objects\items.dm Line: 391 unequipped()
code\game\objects\items.dm Line: 307 dropped()

attached_object is gained on the init proc, the list is init in the ..() call

NOTES:
Remember to handle 	the scenario_process list too.
As thats what calls the process()

*/
/datum/roguelike_effects/passives
	var/mob/living/carbon/current_mob
	var/obj/item/attached_object

/datum/roguelike_effects/passives/add_effect_to_object(var/obj/item/I)
	..()
	attached_object = I
	