/spell/targeted/swap
	name = "Shadows"
	desc = "Move with dizzying speed and leave an image of yourself in your place."
	override_base = "cult" //The area behind tied into the panel we are attached to
	override_icon = 'z40k_shit/icons/buttons/warpmagic.dmi' //Basically points us to a different dmi.
	school = "mime"
	panel = "Mime"
	charge_max = 100
	spell_flags = INCLUDEUSER
	range = 0
	max_targets = 1

//	hud_state = "mime_oath"
//	override_base = "const"

/spell/targeted/swap/cast(list/targets)
	for(var/mob/living/carbon/human/H in targets)
		var/obj/effect/shadow/S = new /obj/effect/shadow(get_turf(H)) //Leaves a shadow in their place.
		S.icon = H.icon
		S.icon_state = H.icon_state
		S.overlays = H.overlays
		S.alpha = H.alpha
		H.dodging = TRUE
		spawn(50)
			H.dodging = FALSE
		spawn(23)
			animate(S, alpha = 0, time = 10)
		H.alpha = 0
		spawn(23) 
			animate(H, alpha = 255, time = 10)
		var/list/posturfs = circlerangeturfs(get_turf(H),4)
		var/turf/destturf = safepick(posturfs)
		H.loc = destturf
		var/area/destarea = get_area(destturf)
		destarea.Entered(H)

/obj/effect/shadow
	name = "shadow"
	icon = 'icons/effects/effects.dmi'
	desc = "A shadow!"
	icon_state = "bhole3"
	density = 0
	anchored = 0

/obj/effect/shadow/New()
	..()
	spawn(1)
		step(src, pick(cardinal))
	spawn(3)
		step(src, pick(cardinal))
	spawn(6)
		step(src, pick(cardinal))
	spawn(9)
		step(src, pick(cardinal))
	spawn(12)
		step(src, pick(cardinal))
	spawn(15)
		step(src, pick(cardinal))
	spawn(18)
		step(src, pick(cardinal))
	spawn(21)
		step(src, pick(cardinal))
	spawn(24)
		step(src, pick(cardinal))
	spawn(27)
		step(src, pick(cardinal))
	spawn(30)
		step(src, pick(cardinal))
	spawn(33) 
		qdel(src)