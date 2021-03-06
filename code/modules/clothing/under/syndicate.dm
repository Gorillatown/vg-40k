/obj/item/clothing/under/syndicate
	name = "tactical turtleneck"
	desc = "A non-descript, slightly suspicious piece of civilian clothing."
	icon_state = "syndicate"
	item_state = "bl_suit"
	_color = "syndicate"
	species_fit = list(VOX_SHAPED, GREY_SHAPED, INSECT_SHAPED)
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

//We want our sensors to be off, sensors are not tactical
/obj/item/clothing/under/syndicate/New()
	..()
	sensor_mode = 0

/obj/item/clothing/under/syndicate/combat
	name = "combat turtleneck"

/obj/item/clothing/under/syndicate/holomap
	name = "tactical holosuit"
	desc = "It's been fitted with some holographic localization devices. A measure the Syndicate judged necessary to improve teamwork among operatives."

/obj/item/clothing/under/syndicate/holomap/New()
	..()

/obj/item/clothing/under/syndicate/commando/New()
	..()

/obj/item/clothing/under/syndicate/tacticool
	name = "\improper Tacticool turtleneck"
	desc = "Just looking at it makes you want to buy an SKS, go into the woods, and -operate-."
	icon_state = "tactifool"
	item_state = "bl_suit"
	_color = "tactifool"
	species_fit = list(VOX_SHAPED, GREY_SHAPED, INSECT_SHAPED)
	siemens_coefficient = 1

/obj/item/clothing/under/syndicate/executive
	name = "syndicate executive suit"
	desc = "A snappy black suit worn by syndicate executives. The shirt is either a tacky red or soaked in blood. Or possibly both."
	icon_state = "exec"
	_color = "exec"
	species_fit = list(GREY_SHAPED)
