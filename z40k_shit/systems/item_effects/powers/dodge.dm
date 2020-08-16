/datum/item_power/dodge
	name = "Unnatural Agility"
	desc = "Uses the psychic powers of divination to dodge all projectiles."
	var/charge = 10

/datum/item_power/dodge/init(var/obj/O)
	O.verbs.Add(/datum/item_power/dodge/proc/verb_act,/datum/item_power/dodge/proc/chargeup)
	return

/datum/item_power/dodge/proc/verb_act()
	set category = "item"
	set name = "Unnatural Agility"
	set src in usr

	var/mob/living/carbon/human/U = usr
	if(charge > 10)
		charge -= 10
		to_chat(U, "<span class='warning'> Glimpses of the future flood your mind as the powers of the warp expand your mind...</span>")
		U.dodging = TRUE
		spawn(150) 
			U.dodging = FALSE
	else
		to_chat(U, "<span class='warning'> Not eneough energy!</span>")

/datum/item_power/dodge/proc/chargeup() //Dealing with chaos comes at a price...
	set category = "item"
	set name = "Charge Agility"
	set desc = "Pay the price in blood for more power..."
	set src in usr

	var/mob/living/carbon/human/U = usr
	if(charge < 20)
		charge += 5
		U.adjustBruteLoss(pick(5,10,15))
		to_chat(U, "<span class='warning'> Your blood flows out and the daemon hungrily consumes your life force as a price for more power.")

