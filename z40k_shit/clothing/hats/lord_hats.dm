//------------HELMETS-----------------
/obj/item/clothing/head/lord_hat
	name = "Tall Fancy Hat"
	desc = "Its tall, Its regal, and its a symbol that you will stand up to any challenge... Probably?"
	icon = 'z40k_shit/icons/obj/clothing/hats.dmi'
	icon_state = "lord" //Check: Its there
	item_state = "lord" //Check: Its there
	armor = list(melee = 20, bullet = 10, laser = 20, energy = 10, bomb = 20, bio = 0, rad = 0)
 
/obj/item/clothing/head/lord_hat/equipped(var/mob/user, var/slot, hand_index = 0)
	..()
	update_icon(user)

/obj/item/clothing/head/lord_hat/update_icon(var/mob/living/carbon/human/user)
	if(!istype(user))
		return
	wear_override = new/icon("icon" = 'z40k_shit/icons/mob/lord_hat.dmi', "icon_state" = "lord_hat")
