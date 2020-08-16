
/*
	Day/Night based Lighting
*/
/obj/machinery/light/day_and_night
	name = "time based lighting"

/obj/machinery/light/day_and_night/spawn_breaking()
	return

/obj/machinery/light/day_and_night/New()
	..()
	day_and_night_lights += src

/obj/machinery/light/day_and_night/Destroy()
	day_and_night_lights -= src
	..()

/obj/machinery/light/day_and_night/industrial_orange
	icon_state = "lhetube1"
	spawn_with_bulb = /obj/item/weapon/light/tube/industrial_orange

/*
	Industrial Orange - Tube
*/

/obj/machinery/light/industrial_orange
	icon_state = "lhetube1"
	spawn_with_bulb = /obj/item/weapon/light/tube/industrial_orange

/obj/machinery/light/industrial_orange/spawn_breaking()
	return

/obj/machinery/light/industrial_orange/broken
	icon_state = "lhetube-broken" //for the mapper
	spawn_with_bulb = /obj/item/weapon/light/tube/industrial_orange/broken


/obj/machinery/light/industrial_orange/burned
	icon_state = "lhetube-burned" //for the mapper
	spawn_with_bulb = /obj/item/weapon/light/tube/industrial_orange/burned

/obj/item/weapon/light/tube/industrial_orange
	name = "industrial light tube"
	desc = "A high efficiency cheap, orange industrial light"
	base_state = "hetube"
	starting_materials = list(MAT_GLASS = 300, MAT_IRON = 60)
	brightness_range = 7
	brightness_power = 2
	brightness_color = "#ffc070"
	cost = 2

/obj/item/weapon/light/tube/industrial_orange/broken
	status = LIGHT_BROKEN

/obj/item/weapon/light/tube/industrial_orange/burned
	status = LIGHT_BURNED

/*
	Red Small Light - Bulb
*/

/obj/machinery/light/small/redbulb
	icon_state = "lbulb1"
	fitting = "bulb"
	desc = "A small lighting fixture."
	spawn_with_bulb = /obj/item/weapon/light/bulb/red

/obj/machinery/light/small/redbulb/spawn_breaking()
	return

/obj/item/weapon/light/bulb/red
	name = "high efficiency light bulb"
	desc = "An efficient light used to reduce strain on the station's power grid."
	base_state = "hebulb"
	brightness_range = 5
	brightness_power = 3
	brightness_color = "#dd0000"
	cost = 1
	starting_materials = list(MAT_GLASS = 150, MAT_IRON = 30)

/obj/item/weapon/light/bulb/red/broken
	status = LIGHT_BROKEN

/obj/item/weapon/light/bulb/red/burned
	status = LIGHT_BURNED

/*
	Green Small Light
*/

/obj/machinery/light/small/greenbulb
	icon_state = "lbulb1"
	fitting = "bulb"
	desc = "A small lighting fixture."
	spawn_with_bulb = /obj/item/weapon/light/bulb/green

/obj/machinery/light/small/greenbulb/spawn_breaking()
	return

/obj/item/weapon/light/bulb/green
	name = "high efficiency light bulb"
	desc = "An efficient light used to reduce strain on the station's power grid."
	base_state = "hebulb"
	brightness_range = 3
	brightness_power = 3
	brightness_color = "#0afd01"
	cost = 1
	starting_materials = list(MAT_GLASS = 150, MAT_IRON = 30)

/obj/item/weapon/light/bulb/green/broken
	status = LIGHT_BROKEN

/obj/item/weapon/light/bulb/green/burned
	status = LIGHT_BURNED