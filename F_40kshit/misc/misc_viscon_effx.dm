 
/obj/effect/overlay/critical_hit
	name = "warp effect"
	icon = 'F_40kshit/icons/64x64effects.dmi'
	icon_state = "critical"
	plane = ABOVE_LIGHTING_PLANE
	layer = CHAT_LAYER
	vis_flags = VIS_INHERIT_ID
//	pixel_y = -3

/obj/effect/overlay/critical_hit/New(var/mob/M,var/effect_duration)
	..()
//	var/obj/effect/overlay/critical_layer = new
	M.vis_contents += src
	pixel_y = rand(7,12)
	pixel_x = rand(9,13)
	animate(src, pixel_x = 32, pixel_y = 32 + rand(0,8), alpha = 0, time = effect_duration)
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)