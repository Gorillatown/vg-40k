//--------------BELT----------------
/obj/item/weapon/storage/belt/hospitaller_belt
	name = "Cloth Armor Addition"
	desc = "Its basically cloth that makes your armor look kind of stylish."
	icon_state = "hospitaller_belt"
	item_state = "hospitaller_belt"
	max_combined_w_class = 200
	fits_max_w_class = 5
	body_parts_covered = LOWER_TORSO|LEGS
	armor = list(melee = 30, bullet = 20, laser = 40,energy = 10, bomb = 10, bio = 10, rad = 0)
	w_class = W_CLASS_LARGE
	storage_slots = 7
	can_only_hold = list(/obj/item/weapon/gun/projectile/automatic/boltpistol,
					/obj/item/weapon/chainsword,
					/obj/item/weapon/powersword
					)
	canremove = FALSE

/*
	IMPERIAL GUARD BELTS
						*/

/obj/item/weapon/storage/belt/basicbelt
	name = "Basic Belt"
	desc = "A standard issue belt."
	icon_state = "imperialbelt" //Check: Its there
	item_state = "imperialbelt" //Check: Its there
	w_class = W_CLASS_LARGE
	storage_slots = 14
	can_only_hold = list()
