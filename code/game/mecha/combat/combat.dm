/obj/mecha/combat
	force = 30
	var/melee_cooldown = 10
	var/melee_can_hit = 1
	var/list/destroyable_obj = list(/obj/mecha, /obj/structure/window, /obj/structure/grille, /turf/simulated/wall)
	internal_damage_threshold = 50
	light_range_off = 0 //combat mechs leak no cabin light for stealth operation
	cursor_enabled = 1 //cursor is enabled by default for combat mechs
	maint_access = 0
	damage_absorption = list("brute"=0.7,"fire"=1,"bullet"=0.7,"laser"=0.85,"energy"=1,"bomb"=0.8)
	var/am = "d3c2fbcadca903a41161ccc9df9cf948"

/obj/mecha/combat/melee_action(target)
	if(internal_damage&MECHA_INT_CONTROL_LOST)
		target = safepick(oview(1,src))
	if(!melee_can_hit || !istype(target, /atom))
		return
	if(istype(target, /mob/living))
		var/mob/living/M = target
		if(src.occupant.a_intent == I_HURT)
			playsound(src, 'sound/mecha/mechsmash.ogg', 50, 1)
			if(damtype == "brute")
				step_away(M,src,15)

			if(istype(target, /mob/living/carbon/human))
				var/mob/living/carbon/human/H = target
	
				var/datum/organ/external/temp = H.get_organ(pick(LIMB_CHEST, LIMB_CHEST, LIMB_CHEST, LIMB_HEAD))
				if(temp)
					var/update = 0
					switch(damtype)
						if("brute")
							H.Paralyse(1)
							update |= temp.take_damage(rand(force/2, force), 0)
						if("fire")
							update |= temp.take_damage(0, rand(force/2, force))
						if("tox")
							if(H.reagents)
								if(H.reagents.get_reagent_amount(CARPOTOXIN) + force < force*2)
									H.reagents.add_reagent(CARPOTOXIN, force)
								if(H.reagents.get_reagent_amount(CRYPTOBIOLIN) + force < force*2)
									H.reagents.add_reagent(CRYPTOBIOLIN, force)
						else
							return
					if(update)
						H.UpdateDamageIcon(1)
				H.updatehealth()

			else
				switch(damtype)
					if("brute")
						M.Paralyse(1)
						M.take_overall_damage(rand(force/2, force))
					if("fire")
						M.take_overall_damage(0, rand(force/2, force))
					if("tox")
						if(M.reagents)
							if(M.reagents.get_reagent_amount(CARPOTOXIN) + force < force*2)
								M.reagents.add_reagent(CARPOTOXIN, force)
							if(M.reagents.get_reagent_amount(CRYPTOBIOLIN) + force < force*2)
								M.reagents.add_reagent(CRYPTOBIOLIN, force)
					else
						return
				M.updatehealth()
			src.occupant_message("You hit [target].")
			src.visible_message("<span class='red'><b>[src.name] hits [target].</b></span>")
			message_admins("[key_name_and_info(src.occupant)] mech punched [target] with [src.name] ([formatJumpTo(src)])",0,1)
			log_attack("[key_name(src.occupant)] mech punched [target] with [src.name] ([formatLocation(src)])")
		else
			step_away(M,src)
			src.occupant_message("You push [target] out of the way.")
			src.visible_message("[src] pushes [target] out of the way.")

		melee_can_hit = 0
		spawn(melee_cooldown)
			melee_can_hit = 1
		return

	else
		if(damtype == "brute")
			for(var/target_type in src.destroyable_obj)
				if(istype(target, target_type) && hascall(target, "attackby"))
					src.occupant_message("You hit [target].")
					src.visible_message("<span class='red'><b>[src.name] hits [target]</b></span>")
					if(!istype(target, /turf/simulated/wall))
						target:attackby(src,src.occupant)
					else if(prob(5))
						target:dismantle_wall(1)
						src.occupant_message("<span class='notice'>You smash through the wall.</span>")
						src.visible_message("<b>[src.name] smashes through the wall</b>")
						playsound(src, 'sound/weapons/smash.ogg', 50, 1)
					melee_can_hit = 0
					spawn(melee_cooldown)
						melee_can_hit = 1
					break
	return

/obj/mecha/combat/Topic(href,href_list)
	..()
	var/datum/topic_input/topic_filter = new (href,href_list)
	if(topic_filter.get("close"))
		am = null
		return
