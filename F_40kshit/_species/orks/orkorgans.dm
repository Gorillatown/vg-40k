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
		owner.heal_organ_damage(2,2)
		for(var/obj/structure/orktrophybanner/nearby_banners in ork_banners)
			if(get_dist(nearby_banners,owner) < 5)
				owner.heal_organ_damage(4,4)
				break
		
