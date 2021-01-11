

/mob/living/carbon/human/grabbed_by(mob/living/grabber)
	return ..()

/mob/living/carbon/human/disarmed_by(mob/living/disarmer)
	for(var/obj/item/weapon/gun/G in held_items)
		var/index = is_holding_item(G)
		var/chance = (index == active_hand ? 40 : 20)

		if(prob(chance))
			visible_message("<spawn class=danger>[G], held by [src], goes off during struggle!")
			var/list/turfs = list()
			for(var/turf/T in view())
				turfs += T
			var/turf/target = pick(turfs)
			return G.afterattack(target, src, "struggle" = 1)

	return FALSE

/mob/living/carbon/human/disarm_mob(mob/living/target)
	add_logs(src, target, "disarmed", admin = (src.ckey && target.ckey) ? TRUE : FALSE) //Only add this to the server logs if both mobs were controlled by player

	if(ishuman(target))
		var/mob/living/carbon/human/T = target
		var/datum/organ/external/S = target.get_organ(src.zone_sel.selecting)
		var/shushcooldown = 10 SECONDS
		if(!istype(S))
			return

		if(src.zone_sel.selecting == "mouth" && !(S.status & ORGAN_DESTROYED) && ishuman(target) && !(T.check_body_part_coverage(MOUTH)) && last_shush + shushcooldown <= world.time)
			last_shush = world.time
			T.forcesay("-")
			visible_message("<span class='danger'>[src] places a hand over [target]'s mouth!</span>")
			return

	if(target.disarmed_by(src))
		return
	
	//VG 40k - Disarm Stat modifiers
	//[target] is the person being disarmed, [src] is the mob doing it
	if(prob(25-(attribute_dexterity/4))) //40% miss chance
		var/flavor_msg = flavortown.ftown_string_disarm(target,src,1)
		visible_message("<span class='danger'>[flavor_msg]!</span>")
		playsound(loc, 'sound/weapons/punchmiss.ogg', 25, 1, -1)
		return

	do_attack_animation(target, src)

	if(prob(25-(target.attribute_agility/2))) //True chance of something happening per click is hit_chance*event_chance, so in this case the stun chance is actually 0.6*0.4=24%
		target.apply_effect(4, WEAKEN)
		target.stat_increase(ATTR_AGILITY,10)
		stat_increase(ATTR_DEXTERITY,50)
		new /obj/effect/overlay/critical_hit(target,20)
		var/flavor_msg = flavortown.ftown_string_disarm(target,src,2)
		visible_message("<span class='danger'>[flavor_msg]!</span>")
		playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
		add_logs(src, target, "pushed", admin = (src.ckey && target.ckey) ? TRUE : FALSE) //Only add this to the server logs if both mobs were controlled by player
		return

	var/talked = 0

	//Disarming breaks pulls
	talked |= break_pulls(target)

	//Disarming also breaks a grab - this will also stop someone being choked, won't it?
	talked |= break_grabs(target)

	if(!talked)
		target.drop_item()
		var/flavor_msg = flavortown.ftown_string_disarm(target,src,3)
		visible_message("<span class='danger'>[flavor_msg]!</span>")
	playsound(loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)

/mob/living/carbon/human/proc/get_organ_species(organ)
	var/datum/organ/external/OE
	if(istext(organ))
		OE = get_organ(OE)
	else if(istype(organ, /datum/organ/external))
		OE = organ

	if(!istype(OE))
		return src.species

	return (OE.species || src.species) //Return either organ's species, or mob's species (organ's species is null if it's the same as the mob's)

/mob/living/carbon/human/proc/get_active_arm_organ()
	var/datum/organ/external/hand = get_active_hand_organ()

	return hand.parent //Return the organ to which the hand is attached

//Returns true if organ (which can be a string ID or a reference) has the mutation
/mob/living/carbon/human/proc/organ_has_mutation(organ, mutation)
	var/datum/species/S = get_organ_species(organ)

	if(istype(S))
		return S.default_mutations.Find(mutation)
	else
		return src.mutations.Find(mutation)

/mob/living/carbon/human/get_unarmed_verb()
	if(istype(gloves))
		var/obj/item/clothing/gloves/G = gloves
		if(G.attack_verb_override)
			return G.attack_verb_override

	var/datum/species/S = get_organ_species(get_active_hand_organ())
	return S.attack_verb

/mob/living/carbon/human/get_unarmed_hit_sound()
	if(istype(gloves))
		var/obj/item/clothing/gloves/G = gloves
		return G.get_hitsound_added()
	var/datum/species/S = get_organ_species(get_active_hand_organ())
	return (S.attack_verb == "punches" ? "punch" : 'sound/weapons/slice.ogg')

/mob/living/carbon/human/get_unarmed_miss_sound()
	var/datum/species/S = get_organ_species(get_active_hand_organ())
	return (S.attack_verb == "punches" ? 'sound/weapons/punchmiss.ogg' : 'sound/weapons/slashmiss.ogg')

/mob/living/carbon/human/get_unarmed_damage_type(mob/living/target)
	if(ishuman(target) && istype(gloves, /obj/item/clothing/gloves/boxing/hologlove))
		return HALLOSS
	return ..()

/mob/living/carbon/human/get_unarmed_damage(var/atom/victim)
	var/datum/species/S = get_organ_species(get_active_hand_organ())

	var/damage = rand(0, S.max_hurt_damage)
	damage += S.punch_damage

	if(mutations.Find(M_HULK))
		damage += 5
	if(organ_has_mutation(get_active_hand_organ(), M_CLAWS) && !istype(gloves))
		damage += 3
		
	if(attribute_strength)
		//40k - STRENGTH DAMAGE MODIFIER
		if(isork(src))
			damage += round(attribute_strength/3)
		else
			damage += round(attribute_strength/6)

	if(attribute_dexterity)
		//40k - DEXTERITY STRENGTH MODIFIER
		damage += round(attribute_dexterity/4)

	if(istype(gloves))
		var/obj/item/clothing/gloves/G = gloves
		damage += G.get_damage_added() //Increase damage by the gloves' damage modifier

		G.on_punch(src, victim)

	return damage

/mob/living/carbon/human/get_unarmed_sharpness(mob/living/victim)
	var/datum/species/S = get_organ_species(get_active_hand_organ())

	var/sharpness = S.punch_sharpness
	if(organ_has_mutation(get_active_hand_organ(), M_CLAWS) && !istype(gloves))
		sharpness = max(sharpness, 1.5)
	if(istype(gloves))
		var/obj/item/clothing/gloves/G = gloves
		sharpness = G.get_sharpness_added()

	return sharpness

/mob/living/carbon/human/proc/get_knockout_chance(mob/living/victim)
	var/base_chance = 8

	base_chance += min(reagents.get_sportiness(),5)
	if(mutations.Find(M_HULK))
		base_chance += 12
	
	if(attribute_strength >= victim.attribute_constitution)
		base_chance += 15

	if(istype(gloves))
		var/obj/item/clothing/gloves/G = gloves
		base_chance += G.bonus_knockout

	base_chance *= victim.knockout_chance_modifier()

	return base_chance

/mob/living/carbon/human/knockout_chance_modifier()
	return 1

/mob/living/carbon/human/after_unarmed_attack(mob/living/target, damage, damage_type, organ, armor)
	var/knockout_chance = get_knockout_chance(target)

	if(attribute_strength >= target.attribute_constitution)
		knockout_chance += ((attribute_dexterity + attribute_strength) - (target.attribute_agility + target.attribute_constitution))
		target.stat_increase(ATTR_CONSTITUTION,50)

	if(prob(knockout_chance))
		visible_message("<span class='danger'>[src] has knocked down \the [target]!</span>")
		new /obj/effect/overlay/critical_hit(target,20)
		target.apply_effect(2, WEAKEN, armor)

	//Hand transplants increase punch damage
	//However, arm transplants are needed to send people flying through punches
	if(attribute_strength >= target.attribute_constitution+7)
		target.visible_message("<span class='danger'>[target] is too weak to withstand the assault!</span>")
		var/the_range = clamp((attribute_strength-(target.attribute_constitution)),1,5)
		target.throw_at(get_edge_target_turf(src,dir),the_range,2)
	
/mob/living/carbon/human/unarmed_attacked(mob/living/attacker, damage, damage_type, zone)
	if(zone == "head")
		var/chance = 0.5 * damage
		if(attacker.mutations.Find(M_HULK))
			chance += 50
		if(attacker.attribute_strength >= attribute_constitution)
			chance += 50
		if(prob(chance))
			knock_out_teeth(attacker)

	if(isrambler(src) && !(attacker == src)) //Redundant check for punching a soul rambler. Kicking is in carbon/human/human_attackhand.dm
		attacker.say(pick("Take that!", "Taste the pain!"))

	..()

/mob/living/carbon/human/proc/perform_cpr(mob/living/target)
	if(target == src)
		return 0
	if(!get_lungs())
		to_chat(src, "<span class='notice'><B>You have no lungs with which to perform CPR!</B></span>")
		return 0
	if(src.species && src.species.flags & NO_BREATHE)
		to_chat(src, "<span class='notice'><B>You don't breathe, so you can't help \the [target]!</B></span>")
		return 0
	if(!hasmouth())
		to_chat(src, "<span class='notice'><B>You don't have a mouth!</B></span>")
		return 0
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(!C.hasmouth())
			to_chat(src, "<span class='notice'><B>They don't have a mouth!</B></span>")
			return 0
	if(src.check_body_part_coverage(MOUTH))
		to_chat(src, "<span class='notice'><B>Remove your [src.get_body_part_coverage(MOUTH)]!</B></span>")
		return 0
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.check_body_part_coverage(MOUTH))
			to_chat(src, "<span class='notice'><B>Remove their [H.get_body_part_coverage(MOUTH)]!</B></span>")
			return 0

	if(!target.cpr_time)
		return 0

	src.visible_message("<span class='danger'>\The [src] is trying perform CPR on \the [target]!</span>")

	target.cpr_time = 0
	if(do_after(src, target, 3 SECONDS))
		target.adjustOxyLoss(-min(target.getOxyLoss(), 7))
		src.visible_message("<span class='danger'>\The [src] performs CPR on \the [target]!</span>")
		to_chat(target, "<span class='notice'>You feel a breath of fresh air enter your lungs. It feels good.</span>")
		to_chat(src, "<span class='warning'>Repeat at least every 7 seconds.</span>")
	target.cpr_time = 1
