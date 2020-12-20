//----------SUIT ARMOR--------------------
/obj/item/clothing/suit/armor/knight_officer
	name = "Heavy Metal Armor"
	desc = "Shiny Heavy Metal Armor, stops things from cleaving your arm off at the elbow."
	icon = 'F_40kshit/icons/obj/clothing/suits.dmi'
	icon_state = "knight_officer" //Check: Its there
	item_state = "knight_officer"//Check: Its there
	body_parts_covered = UPPER_TORSO
	heat_conductivity = SNOWGEAR_HEAT_CONDUCTIVITY
	armor = list(melee = 50, bullet = 40, laser = 40, energy = 25, bomb = 70, bio = 100, rad = 50)
	allowed = list(/obj/item/weapon) 
	var/icon/jersey_overlays = 'icons/mob/uniform_overlays.dmi'

/obj/item/clothing/suit/armor/knight_officer/New()
	..()
	var/number = jersey_numbers[type]++ % 99
	var/first_digit = num2text(round((number / 10) % 10))
	var/second_digit = num2text(round(number % 10))
	var/image/jersey_overlay = image(jersey_overlays, src, "[first_digit]-")
	jersey_overlay.overlays += image(jersey_overlays, src, second_digit)
	jersey_overlay.pixel_y += 2
	dynamic_overlay["[SUIT_LAYER]"] = jersey_overlay
