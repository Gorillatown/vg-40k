
/mob/living/proc/soul_blaze_append()
	set waitfor = 0
	if(!soul_blazed)
		vis_contents += new /obj/effect/overlay/soul_blaze(src,3 SECONDS)
		soul_blazed = TRUE
		sleep(3 SECONDS)
		adjustFireLoss(40-attribute_constitution)
		soul_blazed = FALSE
	else
		return 0

