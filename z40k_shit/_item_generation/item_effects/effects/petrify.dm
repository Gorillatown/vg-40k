/datum/item_artifact/petrify
	name = "Petrification Curse"
	desc = "A curse that turns people to stone, though only breifly."
	charge = 400

/datum/item_artifact/stone/item_act(var/mob/living/M)
	to_chat(M,"<span class='warning'>You suddenly feel very solid!</span>")
	var/obj/structure/closet/statue/S = new /obj/structure/closet/statue(M.loc, M)
	S.timer = 20
	M.drop_item()
	