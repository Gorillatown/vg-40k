/datum/item_artifact/shieldwall
	name = "Shield Wall Effect"
	desc = "Generates a wall of shields around the target."
	var/duration = 1200
	New()
		..()
		duration = pick(50,100,300,600,1200,3000)
/datum/item_artifact/shieldwall/item_act(var/mob/living/M)
	for(var/turf/simulated/floor/T in orange(4,M))
		if(get_dist(M,T) == 4)
			var/obj/effect/forcefield/field = new /obj/effect/forcefield(T)
			spawn(duration)
				qdel(field)
