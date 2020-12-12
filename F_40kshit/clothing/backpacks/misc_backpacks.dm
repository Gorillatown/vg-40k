/obj/item/weapon/storage/backpack/brownbackpack
	name = "Brown Backpack"
	desc = "A brown backpack, worn by most residents of the world, issued or not."
	icon = 'F_40kshit/icons/obj/clothing/back.dmi'
	icon_state = "brownbackpack"
	item_state = "brownbackpack"
	species_fit = list("Ork", "Ork Nob", "Ork Warboss")

/obj/item/weapon/storage/backpack/brownbackpack/pdf_trooper/New()
	..()
	new /obj/item/clothing/mask/gas/hecu(src)
	new /obj/item/weapon/cell/lasgunmag(src)
	new /obj/item/weapon/cell/lasgunmag(src)

