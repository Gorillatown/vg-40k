/datum/reagent/destroyer_venom
	name = "Flame Venom"
	id = DESTROYER_VENOM
	description = "A rare biocatalyst that causes the victim's blood to boil, generally extracted from a fire scorpion. The reaction is so violent that the victim's body will eventually be torn apart by it."
	reagent_state = REAGENT_STATE_LIQUID
	color = "#13BC5E" // rgb: 19, 188, 94
	overdose_am = REAGENTS_OVERDOSE
	density = 8.15
	specheatcap = 0.16

/datum/reagent/destroyer_venom/on_mob_life(var/mob/living/M)
	if(M.stat == DEAD)
		to_chat(M,"<span class='warning'>Your blood boils.</span>")
		M.gib()
		return
	if(!M) 
		M = holder.my_atom
	M.adjustToxLoss(1)
	M.take_organ_damage(0, 2)
	if(prob(30))
		var/msg = pick("<span class='warning'> You feel a burning sensation in your veins</span>","<span class='warning'> You feel a pressure building up beneath your skin</span>","<span class='warning'> You don't feel too good...</span>","<span class='warning'> Your chest hurts...</span>")
		to_chat(M,"[msg]")
	if(prob(10))
		M.take_organ_damage(20, 0)
		new /obj/effect/gibspawner/blood(M.loc)
		M.visible_message("<span class='warning'>[M]'s skin bursts in a shower of blood!</span>")
	return

