/*
	Backpacks
				*/
/obj/item/weapon/storage/backpack/trooperbag
	name = "Standard issue Backpack"
	desc = "A standard issue backpack, maybe one day there will be more to it."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "impbag" //Check: Its there
	item_state = "impbag" //Check: Its there

/obj/item/weapon/storage/backpack/trooperbag/New()
	..()
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/biofoam_injector(src)
	new /obj/item/weapon/reagent_containers/hypospray/autoinjector/biofoam_injector(src)

/obj/item/weapon/storage/backpack/stormtrooperbag
	name = "Stormtrooper Backpack"
	desc = "This backpack looks like one of the finest the imperial guard can offer."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "stormp" //Check: Its there
	item_state = "stormp" //Check: Its there

