/datum/roguelike_effects/heal
	name = "Healing Effect"
	desc = "An effect that heals."
	cooldown_max = 10

/datum/roguelike_effects/heal/re_effect_act(mob/living/M, obj/item/I)
	..()
	to_chat(M,"<span class='warning'>You feel much better.</span>")
	M.adjustOxyLoss(-25)
	M.heal_organ_damage(25,25)
	M.adjustToxLoss(-25)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		for(var/datum/organ/internal/IN in H.internal_organs)
			if(IN && IN.damage > 0)
				IN.damage = max(0, IN.damage - 4)
			if(IN)
				IN.status &= ~ORGAN_BROKEN
				IN.status &= ~ORGAN_SPLINTED
				IN.status &= ~ORGAN_BLEEDING
		for(var/datum/organ/external/O in H.organs)
			O.status &= ~ORGAN_BROKEN
			O.status &= ~ORGAN_SPLINTED
			O.status &= ~ORGAN_BLEEDING