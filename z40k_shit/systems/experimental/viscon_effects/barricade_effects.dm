/obj/effect/overlay/viscons/aegisline
	name = "Aegisline"
	desc = "Its a barricade except better"
	icon = 'z40k_shit/icons/obj/barricadesmk2.dmi'
	vis_flags = VIS_INHERIT_ID

/obj/effect/overlay/viscons/aegisline/north
	icon_state = "aegisline_north_overlay"
	plane = ABOVE_HUMAN_PLANE
	layer = SHADOW_LAYER
	pixel_y = 32

/obj/effect/overlay/viscons/aegisline/south
	icon_state = "aegisline_south_overlay"
	plane = OBJ_PLANE
	layer = SIDE_WINDOW_LAYER
	pixel_y = -32

/obj/effect/overlay/viscons/aegisline/west_one
	icon_state = "aegisline_west_overlay1"
	plane = ABOVE_HUMAN_PLANE
	layer = SHADOW_LAYER
	pixel_x = -32

/obj/effect/overlay/viscons/aegisline/west_two
	icon_state = "aegisline_west_overlay2"
	plane = OBJ_PLANE
	layer = SIDE_WINDOW_LAYER
	pixel_x = -5

/obj/effect/overlay/viscons/aegisline/east_one
	icon_state = "aegisline_east_overlay1"
	plane = ABOVE_HUMAN_PLANE
	layer = SHADOW_LAYER
	pixel_x = 32

/obj/effect/overlay/viscons/aegisline/east_two
	icon_state = "aegisline_east_overlay2"
	plane = OBJ_PLANE
	layer = SIDE_WINDOW_LAYER
	pixel_x = 5
