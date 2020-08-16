/obj/complex_vehicle/complex_chassis
	name = "I'm just a parent"
	desc = "Please don't spawn me"

//Base vehicle
/obj/complex_vehicle/complex_chassis/leman_russ
	name = "Leman Russ"
	icon_state = "lemanruss"
	desc = "Its a LEMAN RUSS."
	mainturret = /obj/complex_vehicle/complex_turret/demolisher

/*
	LEMAN RUSS PUNISHER
						*/
/obj/complex_vehicle/complex_chassis/leman_russ/punisher
	name = "Leman Russ"
	desc = "Its a Leman Russ."
	mainturret = /obj/complex_vehicle/complex_turret/punisher
	var/obj/item/device/vehicle_equipment/weaponry/heavybolter/HBOLT
	

/obj/complex_vehicle/complex_chassis/leman_russ/punisher/New()
	..()
	HBOLT = new /obj/item/device/vehicle_equipment/weaponry/heavybolter(src.loc)
	HBOLT.forceMove(src)
	ES.make_it_end(src,HBOLT,TRUE,get_pilot())

/obj/complex_vehicle/complex_turret/punisher
	name = "Punisher Turret"
	desc = "The holder of a gatling gun"
	icon_state = "turret_empty"
	vehicle_zoom = 8
	var/obj/complex_vehicle/complex_turret/PUN

/obj/complex_vehicle/complex_turret/punisher/New()
	..()
	PUN = new /obj/item/device/vehicle_equipment/weaponry/punisher(src.loc)
	PUN.forceMove(src)
	ES.make_it_end(src,PUN,TRUE,get_pilot())

/*
	LEMAN RUSS DEMOLISHER
							*/
/obj/complex_vehicle/complex_chassis/leman_russ/demolisher
	name = "Leman Russ"
	desc = "Its a Leman Russ."
	mainturret = /obj/complex_vehicle/complex_turret/demolisher
	var/obj/item/device/vehicle_equipment/weaponry/heavybolter/HBOLT

/obj/complex_vehicle/complex_chassis/leman_russ/demolisher/New()
	..()
	HBOLT = new /obj/item/device/vehicle_equipment/weaponry/heavybolter(src.loc)
	HBOLT.forceMove(src)
	ES.make_it_end(src,HBOLT,TRUE,get_pilot())

/obj/complex_vehicle/complex_turret/demolisher
	name = "Demolisher Turret"
	desc = "The holder of a large barrel"
	icon_state = "turret_empty"
	vehicle_zoom = 7
	var/obj/complex_vehicle/complex_turret/DEMO

/obj/complex_vehicle/complex_turret/demolisher/New()
	..()
	DEMO = new /obj/item/device/vehicle_equipment/weaponry/demolisher(src.loc)
	DEMO.forceMove(src)
	ES.make_it_end(src,DEMO,TRUE,get_pilot())

/*
	LEMAN RUSS BATTLECANNON
							*/
/obj/complex_vehicle/complex_chassis/leman_russ/battlecannon
	name = "Leman Russ"
	desc = "Its a Leman Russ."
	mainturret = /obj/complex_vehicle/complex_turret/battlecannon
	var/obj/item/device/vehicle_equipment/weaponry/heavybolter/HBOLT

/obj/complex_vehicle/complex_chassis/leman_russ/battlecannon/New()
	..()
	HBOLT = new /obj/item/device/vehicle_equipment/weaponry/heavybolter(src.loc)
	HBOLT.forceMove(src)
	ES.make_it_end(src,HBOLT,TRUE,get_pilot())

/obj/complex_vehicle/complex_turret/battlecannon
	name = "Battlecannon Turret"
	desc = "The turret that holds the battle cannon."
	icon_state = "turret_empty"
	vehicle_zoom = 10
	var/obj/complex_vehicle/complex_turret/BATC

/obj/complex_vehicle/complex_turret/battlecannon/New()
	..()
	BATC = new /obj/item/device/vehicle_equipment/weaponry/battlecannon
	BATC.forceMove(src)
	ES.make_it_end(src,BATC,TRUE,get_pilot())
