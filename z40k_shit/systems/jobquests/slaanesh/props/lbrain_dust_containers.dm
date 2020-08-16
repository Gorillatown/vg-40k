/obj/structure/reagent_dispensers/cauldron/barrel/laserbrain_dust
	icon = 'z40k_shit/icons/obj/barrels.dmi'
	icon_state = "barrel_4"
	density = 1

/obj/structure/reagent_dispensers/cauldron/barrel/laserbrain_dust/New() //BARRELS O BLOW
	. = ..()

	reagents.add_reagent(LASERBRAIN_DUST, 1000)
