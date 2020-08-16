/obj/effect/proc_holder/spell/targeted/mime/smoke
	name = "Smoke"
	desc = "Disappear in a plume of smoke and reform later."
	invocation = "none"
	invocation_type = "none"
	school = "mime"
	panel = "Mime"
	clothes_req = 0
	human_req = 1
	charge_max = 100
	range = -1
	include_user = 1

/obj/effect/proc_holder/spell/targeted/mime/smoke/cast()
	if(!usr) return
	if(!ishuman(usr)) return
	var/mob/living/carbon/human/H = usr
	var/datum/effect/effect/system/bad_smoke_spread/smoke = new /datum/effect/effect/system/bad_smoke_spread()
	smoke.set_up(10, 0, H.loc)
	smoke.start()
	var/obj/effect/effect/bad_smoke/harlequin/harl = new /obj/effect/effect/bad_smoke/harlequin(get_turf(H))
	harl.user = H
	H.loc = harl
	..()

/obj/effect/effect/bad_smoke/harlequin
	var/mob/living/carbon/human/user
	var/can_move = 1

/obj/effect/effect/bad_smoke/harlequin/Destroy()
	user.loc = get_turf(src)
	..()

/obj/effect/effect/bad_smoke/harlequin/relaymove(var/mob/user, direction)
	step(src, direction)
	return