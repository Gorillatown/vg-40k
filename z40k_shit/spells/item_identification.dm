/spell/aoe_turf/identify
	name = "Identify"
	desc = "This is the ability to identify items. It takes a while between uses"

	school = "transmutation"
	charge_max = 600
	spell_flags = 0
	invocation_type = SpI_NONE
	range = 0

	hud_state = "wiz_charge"

/spell/aoe_turf/identify/cast(var/list/targets, mob/user)
	for(var/turf/T in targets)
		for(var/obj/item/I in T)
			if(I.roguelike_effects?.len)
				for(var/datum/roguelike_effects/RE in I.roguelike_effects)
					if(istype(RE,/datum/roguelike_effects/curses))
						to_chat(user, "<span class='bad'> You've spotted curse [RE.name] on the object.</span>")
						if(prob(25))
							to_chat(user, "<span class='bad'> [RE.desc].</span>")
					else
						to_chat(user, "<span class='good'> You've spotted effect [RE.name] on the object.</span>")
						if(prob(25))
							to_chat(user, "<span class='good'> [RE.desc].</span>")
					if(prob(50))
						for(var/trigger in RE.trigger_effects)
							switch(trigger)
								if(RE_ATTACK_SELF)
									to_chat(user,"<span class='average'> You recognize that it triggers on being handled actively.</span>")
								if(RE_EQUIPPED)
									to_chat(user,"<span class='bad'> You recognize that it triggers on being equipped.</span>")
								if(RE_FOUND)
									to_chat(user,"<span class='bad'> You recognize that it triggers on being discovered.</span>")
								if(RE_ATTACK_USER)
									to_chat(user,"<span class='bad'> You recognize that it triggers on hitting another person.</span>")
								if(RE_ATTACK_TARGET)
									to_chat(user,"<span class='bad'> You recognize that it triggers on hitting another person.</span>")
								if(RE_ATTACK_HAND)
									to_chat(user,"<span class='bad'> You recognize that it triggers on being touched by a hand.</span>")

								
							



