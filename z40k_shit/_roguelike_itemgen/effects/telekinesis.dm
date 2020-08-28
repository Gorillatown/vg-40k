/datum/roguelike_effects/telekinesis
	name = "Mind Mutation"
	desc = "Appears to mutate the mind."

/datum/roguelike_effects/telekinesis/re_effect_act(mob/living/M, obj/item/I)
	if(..())
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.mutations.Add(M_TK)
		H.update_mutations()