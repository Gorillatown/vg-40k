/datum/organ/internal/heart/ork
	name = "Ork Heart"
	parent_organ = LIMB_CHEST
	organ_type = "heart"
	removed_type = /obj/item/organ/internal/heart/ork

/obj/item/organ/internal/heart/ork
	name = "heart"
	icon_state = "heart-on"
	prosthetic_name = "circulatory pump"
	prosthetic_icon = "heart-prosthetic"
	organ_tag = "heart"
	fresh = 6 // Juicy.
	dead_icon = "heart-off"
	organ_type = /datum/organ/internal/heart/ork

/datum/organ/internal/heart/ork/Life()
	if(owner.health < owner.maxHealth)
		owner.health += 5
		
