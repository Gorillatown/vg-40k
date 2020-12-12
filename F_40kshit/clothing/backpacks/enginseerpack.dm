/obj/item/enginseer_powerpack //attached axe is /obj/item/weapon/enginseer_poweraxe
	name = "Powerpack"
	desc = "Its a powerpack, this one attached to a enginseer, instead of a plasgun."
	icon = 'F_40kshit/icons/obj/clothing/back.dmi'
	icon_state = "enginseerpack-axe" //Other state is enginseerpack-noaxe
	item_state = "enginseerpack-axe"
	slot_flags = SLOT_BACK
	w_class = W_CLASS_LARGE
	canremove = 0
	var/axe_out = FALSE
	var/obj/item/weapon/enginseer_poweraxe/our_axe

/obj/item/enginseer_powerpack/New()
	..()
	our_axe = new /obj/item/weapon/enginseer_poweraxe(src)
	our_axe.our_pack = src

/obj/item/enginseer_powerpack/Destroy()
	our_axe = null
	qdel(our_axe)
	..()

/obj/item/enginseer_powerpack/proc/can_use_verbs(mob/user)
	var/mob/living/carbon/human/M = user
	if (M.stat == DEAD)
		to_chat(user, "You can't do that while you're dead!")
		return 0
	else if (M.stat == UNCONSCIOUS)
		to_chat(user, "You must be conscious to do this!")
		return 0
	else if (M.handcuffed)
		to_chat(user, "You can't reach the controls while you're restrained!")
		return 0
	else if(isork(user))
		to_chat(user,"What the hell am I looking at?")
		return 0
	else
		return 1

/obj/item/enginseer_powerpack/update_icon()
	var/mob/living/carbon/human/H = loc

	if(istype(loc,/mob/living/carbon/human))
		if(axe_out) //updates icon stating whether we have the nozzle on or off.
			icon_state = "enginseerpack-noaxe"
			H.update_inv_back()
		else
			icon_state = "enginseerpack-axe"
			H.update_inv_back()


/obj/item/enginseer_powerpack/verb/remove_poweraxe() //pulls the nozzle off the burnapack
	set name = "Remove Poweraxe"
	set category = "Object"
	set src in usr

	var/mob/living/user = usr
	
	if(!can_use_verbs(user))
		return

	detach_poweraxe(user)

/obj/item/enginseer_powerpack/proc/detach_poweraxe(var/mob/user)
	if(!our_axe)
		to_chat(user, "You somehow have no poweraxe, FUCK.")
		return
	else
		user.put_in_hands(our_axe)	
		axe_out = TRUE
		to_chat(user,"<span class='notice'> You pull the poweraxe off the pack.</span>")
		update_icon()

/obj/item/enginseer_powerpack/attackby(var/obj/item/A, mob/user)
	if(A == our_axe)
		user.drop_item(A, src)
		axe_out = FALSE
		update_icon()
		return
	..()

/obj/item/enginseer_powerpack/unequipped(mob/user)
	if(axe_out)
		user.drop_item(our_axe,src)
		axe_out = FALSE
		update_icon()