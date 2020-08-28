/datum/roguelike_effects/hulk
	name = "Muscle Mutations"
	desc = "Makes you some kind of mutant."

/datum/roguelike_effects/hulk/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.hulk_time = world.time + 10
		H.mutations.Add(M_HULK)
		H.update_mutations()		//update our mutation overlays
		H.update_body()
		log_admin("[key_name(H)] has hulked out! ([formatJumpTo(H)])")
		message_admins("[key_name(H)] has hulked out! ([formatJumpTo(H)])")