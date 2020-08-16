//I guess this is technically telekinesis
/spell/targeted/devastate
	name = "Devastate"
	desc = "Smite an unlucky adversary with a deadly wave of energy."
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	override_base = "ork"
	abbreviation = "DVST"
	school = "evocation"
	charge_max = 600
	invocation_type = SpI_EMOTE
	invocation = "has Blood red tendrils materialize and lash out!"
	range = 1
	cooldown_min = 300 //100 deciseconds reduction per rank

/spell/targeted/devastate/cast(var/list/targets)
	..()
	var/mob/living/L = holder
	for(var/mob/living/target in targets)
		if(ishuman(target) || ismonkey(target))
			var/mob/living/carbon/C = target
			for(var/i=0 to 4)
				C.take_organ_damage(20,0)
				new /obj/effect/gibspawner/blood(C.loc) //This is going to be absurdly gory...
				new /obj/effect/gibspawner/generic(C.loc)
				step_away(C,L,10)
				sleep(2)
			step_away(C,L,10)
			C.take_organ_damage(20, 0)
			new /obj/effect/gibspawner/blood(C.loc)
			new /obj/effect/gibspawner/generic(C.loc)
			new /obj/effect/gibspawner/generic(get_step(get_turf(C), pick(cardinal)))
			if(C.stat == DEAD)
				C.gib()
