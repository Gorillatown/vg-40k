
/mining_surprise/human
	name="Hidden Complex"
	floortypes = list(
		/turf/simulated/floor/airless=95,
		/turf/simulated/floor/plating/airless=5
	)
	walltypes = list(
		/turf/simulated/wall=100
	)
	spawntypes = list(
		/obj/item/weapon/pickaxe/silver					=4,
		/obj/item/weapon/pickaxe/drill					=4,
		/obj/item/weapon/pickaxe/jackhammer				=4,
		/obj/item/weapon/pickaxe/diamond				=3,
		/obj/item/weapon/pickaxe/drill/diamond			=3,
		/obj/item/weapon/pickaxe/gold					=3,
		/obj/item/weapon/pickaxe/plasmacutter/accelerator			=2,
		/obj/structure/closet/syndicate/resources		=2,
		/obj/item/weapon/melee/energy/sword/pirate		=1,
		/obj/mecha/working/ripley/mining				=1
	)
	complex_max_size=2

	flags = CONTIGUOUS_WALLS | CONTIGUOUS_FLOORS

/mining_surprise/alien_nest
	name="Hidden Nest"
	floortypes = list(
		/turf/unsimulated/floor/asteroid=100
	)

	walltypes = list(
		/turf/unsimulated/mineral/random/high_chance=1
	)

	spawntypes = list(
		/obj/item/clothing/mask/facehugger				=4,
		/obj/mecha/working/ripley/mining				=1
	)
	fluffitems = list(
		/obj/effect/decal/remains/human                 = 5,
		/obj/effect/decal/cleanable/blood/xeno          = 5,
		/obj/effect/decal/mecha_wreckage/ripley			= 1
	)
	complex_max_size=6
	room_size_max=7

	var/const/eggs_left=10 // Per complex
	var/turf/weeds[0] // Turfs with weeds.
	postProcessComplex()
		..()
		var/list/all_floors=list()
		for(var/surprise_room/room in rooms)
			var/list/w_cand=room.GetTurfs(TURF_FLOOR)
			all_floors |= w_cand
			var/egged=0
			while(w_cand.len>0)
				var/turf/weed_turf = pick(w_cand)
				w_cand -= weed_turf
				if(weed_turf.density)
					continue
				if(locate(/obj/effect/alien) in weed_turf)
					continue
				if(weed_turf && !egged)
					new /obj/effect/alien/weeds/node(weed_turf)
					weeds += weed_turf
					break

		for(var/e=0;e<eggs_left;e++)
			var/turf/egg_turf = pick(all_floors)
			if(egg_turf && !(locate(/obj/effect/alien) in egg_turf))
				new /obj/effect/alien/egg(egg_turf)


/datum/map_element/mining_surprise/angie
	name = "Angie's lair"
	desc = "From within this rich soil, the stone gathers moss."

	file_path = "maps/randomvaults/mining/angie_lair.dmm"
