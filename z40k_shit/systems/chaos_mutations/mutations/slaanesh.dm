/////////////////////////////////////////////////////
//--------------SLAANESH MUTATIONS-----------------//
/////////////////////////////////////////////////////

/datum/mutation/slaanesh/mark
	name = "mark of slaanesh"
	desc = "A mark on the forehead that shows fealty to the prince of pleasure, Slaanesh."
	icon_state = "slaanesh_mark"
	overlay = TRUE //Mark can't be easily concealed!

/datum/mutation/slaanesh/tentacles
	name = "tentacle mutation"
	desc = "A gift from lord Slaanesh, a mass of writhing tentacles."

/datum/mutation/slaanesh/tentacles/init_mob(var/mob/living/carbon/human/H)
	..()
	if(!H.u_equip(H.w_uniform))
		qdel(H.w_uniform)
	H.equip_to_slot_if_possible(new /obj/item/clothing/under/tentacles, slot_w_uniform, 1, 1)

/*
/datum/mutation/slaanesh/addiction
	name = "unnatural addiction"
	desc = "An addiction to an unnatural substance."
	icon_state = "blank"

/datum/mutation/slaanesh/addiction/init_mob(var/mob/living/carbon/human/H)
	..()
	var/datum/addiction/severe/A = new /datum/addiction/severe
	A.recovery = 20000 //Basically impossible to recover from even with legecillin. Makes you literally dependant on one of these chemicals.
	A.addictionid = pick("blood", "mercury", "lipozine", "poisonberryjuice", "neurotoxin", "chloromethane")
	A.addictionname = A.addictionid
	if(A.addictionname == "poisonberryjuice") //This is horrible coding practice, but for a simple and functional mutation proc it will have to do.
		A.addictionname = "poison berry juice"
	A.name = "Unnatural Addiction"
	H.addictions.Add(A) */