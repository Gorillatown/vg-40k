/*
	WEAK CIRCLES
				*/
/obj/effect/overlay/weak_blue_circle
	name = "warp effect"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "weak_blue_circle"
	plane = OBJ_PLANE
	layer = ABOVE_OBJ_LAYER
	pixel_y = -3

/obj/effect/overlay/weak_blue_circle/New(var/mob/M,var/effect_duration)
	..()
	animate(src, alpha = 0, time = effect_duration)
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)

/obj/effect/overlay/weak_green_circle
	name = "warp effect"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "weak_green_circle"
	plane = OBJ_PLANE
	layer = ABOVE_OBJ_LAYER
	pixel_y = -3

/obj/effect/overlay/weak_green_circle/New(var/mob/M,var/effect_duration)
	..()
	animate(src, alpha = 0, time = effect_duration)
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)

/obj/effect/overlay/weak_red_circle
	name = "warp effect"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "weak_red_circle"
	plane = OBJ_PLANE
	layer = ABOVE_OBJ_LAYER
	pixel_y = -3

/obj/effect/overlay/weak_red_circle/New(var/mob/M,var/effect_duration)
	..()
	animate(src, alpha = 0, time = effect_duration)
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)

/*
	SPARKLES
			*/
/obj/effect/overlay/greensparkles
	name = "warp sparkles"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "green_sparkles"
	layer = LIGHTING_LAYER

/obj/effect/overlay/greensparkles/New(var/mob/M,var/effect_duration)
	..()
	animate(src, alpha = 0, time = effect_duration)
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)

/obj/effect/overlay/redsparkles
	name = "warp sparkles"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "red_sparkles"
	layer = LIGHTING_LAYER

/obj/effect/overlay/redsparkles/New(var/mob/M,var/effect_duration)
	..()
	animate(src, alpha = 0, time = effect_duration)
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)

/*
	EFFECTS MARKERS
					*/

/obj/effect/overlay/red_downwards_lines
	name = "warp sparkles"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "red_debuff"
	layer = LIGHTING_LAYER

/obj/effect/overlay/red_downwards_lines/New(var/mob/M,var/effect_duration)
	..()
	animate(src, alpha = 0, time = effect_duration)
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)

/obj/effect/overlay/red_radiating
	name = "warp sparkles"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "red_radiating"
	layer = LIGHTING_LAYER

/obj/effect/overlay/red_radiating/New(var/mob/M,var/effect_duration)
	set waitfor = 0
	..()
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(158, 4, 163))
	var/f1 = filters[filters.len]
	animate(f1,alpha=200,time=10,loop=-1)
	animate(alpha=255,time=10)
	sleep(effect_duration)
	filters -= f1
	M.vis_contents -= src
	qdel(src)

/obj/effect/overlay/upper_blue_glow
	name = "warp sparkles"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "upper_blue_glow"
	layer = LIGHTING_LAYER

/obj/effect/overlay/upper_blue_glow/New(var/mob/M,var/effect_duration)
	..()
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)

/obj/effect/overlay/purple_flame
	name = "psychic flame"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "purple_flame"
	layer = LIGHTING_LAYER

/obj/effect/overlay/purple_flame/New(var/mob/M,var/effect_duration)
	set waitfor = 0
	..()
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(212, 66, 218))
	var/f1 = filters[filters.len]
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(120, 2, 124))
	var/f2 = filters[filters.len]
	sleep(effect_duration)
	filters -= f1
	filters -= f2
	M.vis_contents -= src
	qdel(src)

/obj/effect/overlay/soul_blaze
	name = "psychic flame"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "soul_blaze"
	layer = LIGHTING_LAYER

/obj/effect/overlay/soul_blaze/New(var/mob/M,var/effect_duration)
	set waitfor = 0
	..()
	animate(src, alpha = 0, time = effect_duration)
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=-2, color=rgb(66, 218, 129))
	var/f1 = filters[filters.len]
	sleep(effect_duration)
	filters -= f1
	M.vis_contents -= src
	qdel(src)

/obj/effect/overlay/sunburst
	name = "psychic flame"
	icon = 'z40k_shit/icons/96x96effects.dmi'
	icon_state = "sunburst"
	plane = OBJ_PLANE 
	layer = ABOVE_OBJ_LAYER

/obj/effect/overlay/sunburst/New(var/mob/M,var/effect_duration)
	set waitfor = 0
	..()
	pixel_x = -32
	pixel_y = -32
	animate(src, alpha = 0, time = effect_duration)
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=-2, color=rgb(212, 66, 218))
	var/f1 = filters[filters.len]
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=2, color=rgb(120, 2, 124))
	var/f2 = filters[filters.len]
	sleep(effect_duration)
	filters -= f1
	filters -= f2
	M.vis_contents -= src
	qdel(src)

/obj/effect/overlay/shockwave
	name = "shockwave"
	icon = 'z40k_shit/icons/96x96effects.dmi'
	icon_state = "shockwave"
	plane = OBJ_PLANE
	layer = ABOVE_OBJ_LAYER

/obj/effect/overlay/shockwave/New(var/mob/M,var/effect_duration)
	set waitfor = 0
	..()
	pixel_x = -32
	pixel_y = -32
	animate(src, alpha = 0, time = effect_duration)
	filters += filter(type="drop_shadow", x=0, y=0, size=5, offset=-2, color=rgb(183, 192, 194))
	var/f1 = filters[filters.len]
	sleep(effect_duration)
	filters -= f1
	M.vis_contents -= src
	qdel(src)



/*
	STRONG CIRCLES
					*/
/obj/effect/overlay/strong_green_circle // 10
	name = "strong warp aura"
	icon = 'z40k_shit/icons/32x32effects.dmi'
	icon_state = "strong_green_circle"
	plane = OBJ_PLANE
	layer = ABOVE_OBJ_LAYER
	pixel_y = -3

/obj/effect/overlay/strong_green_circle/New(var/mob/M,var/effect_duration)
	..()
	animate(src, alpha = 0, time = effect_duration)
	spawn(effect_duration)
		M.vis_contents -= src
		qdel(src)