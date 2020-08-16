//This ones actually pretty simple in comparison to most.
/*
Yes the option is there to scan map elements and just dump a objective into a open turf in them.
Instead we are going to use a object.


*/
//Why is this just a bare object? Probably because other stuff appends itself to lists/etc

var/list/objective_markers = list()
var/list/mcguffin_items = list()
var/list/choosable_jectie_items = typesof(/obj/item/mcguffins)-/obj/item/mcguffins

/obj/jectie_time
	name = "Objective Spawner"
	desc = "Spawns objects that could be objectives."
	icon = 'z40k_shit/icons/abstract_markers.dmi'
	icon_state = "objective_marker"
	alpha = 255
	invisibility = 101
	mouse_opacity = 0

/obj/jectie_time/New()
	..()
	objective_markers += src

/obj/jectie_time/Destroy()
	objective_markers -= src
	..()

/datum/loada_gen/proc/loada_objectivegen()
	var/amount_of_objectives = 6
	if(!objective_markers.len) //This check right heres actually pretty important.
		warning("NO OBJECTIVE MARKERS DETECTED. CONTACT JTGSZ#6921 ASAP.")
	else
		for(var/i=1 to amount_of_objectives)
			var/obj/jectie_time/pick_jectie = pick(objective_markers)

			var/turf/T = get_turf(pick_jectie)
			qdel(pick_jectie)
			
			var/ourobj = pick(choosable_jectie_items)
			var/obj/item/mcguffins/spawned_obj = new ourobj(T)
			mcguffin_items += spawned_obj
			CHECK_TICK

			if(ASS.dd_debug)
				log_startup_progress("Objective[i]: [spawned_obj] placed at X:[T.x], Y:[T.y]")

		for(var/obj/jectie_time/qdeltime in objective_markers)
			qdel(qdeltime) //Time for some cleanup
			CHECK_TICK

/obj/item/mcguffins
	name = "Parent of uselessness"
	desc = "If you see this somethings gone real bad, real fast."
	icon = 'z40k_shit/icons/objective_mcguffins.dmi'

/obj/item/mcguffins/skullcoin
	name = "Skull coin"
	desc = "A spooky coin"
	icon_state = "coin"

/obj/item/mcguffins/imperial_truth
	name = "Imperial Truth"
	desc = "This version contains too much truth about the imperium."
	icon_state = "book_imperial_truth"

/obj/item/mcguffins/silver_emblem
	name = "Silver Emblem"
	desc = "Its silver, and a emblem"
	icon_state = "silver_alt"

/obj/item/mcguffins/goodluckcharm
	name = "Goodluck Charm"
	desc = "Some would say it grants too much luck."
	icon_state = "goodluck"