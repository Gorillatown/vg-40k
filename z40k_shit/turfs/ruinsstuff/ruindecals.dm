/* 
	Ruin Decals
				*/

/obj/effect/decal/ruinshit
	icon = 'z40k_shit/icons/turfs/ruindecals.dmi'
	anchored = 1

/*
	Rubble Parent
					*/
/obj/effect/decal/ruinshit/rubble
	name = "Rubble"

/*
	Rubble, basically main body of the decorative decal
*/
/obj/effect/decal/ruinshit/rubble/rubblefull
	desc = "Its rubble alright."
	icon_state = "rubblefull"
//	render_source = "*1"

/obj/effect/decal/ruinshit/rubble/rubbleslab
	desc = "Appears theres a slab in your rubble, sir."
	icon_state = "rubbleslab"

/obj/effect/decal/ruinshit/rubble/rubblepillar
	desc = "Who knows where that pillar came from, considering you can't see whats above you."
	icon_state = "rubblepillar"

/obj/effect/decal/ruinshit/rubble/rubbleplate
	desc = "It appears a plate mysteriously made its way into these stones. Wow!"
	icon_state = "rubbleplate"

/obj/effect/decal/ruinshit/rubble/rubbleedge
	desc = "Who knows why you are examining a pile of rubble. But this is exactly what it is."
	icon_state = "rubble"
/obj/effect/decal/ruinshit/rubble/rubbleedge/north
	dir = NORTH
/obj/effect/decal/ruinshit/rubble/rubbleedge/south
	dir = SOUTH
/obj/effect/decal/ruinshit/rubble/rubbleedge/east
	dir = EAST
/obj/effect/decal/ruinshit/rubble/rubbleedge/west
	dir = WEST
/obj/effect/decal/ruinshit/rubble/rubbleedge/northwest
	dir = NORTHWEST
/obj/effect/decal/ruinshit/rubble/rubbleedge/northeast
	dir = NORTHEAST
/obj/effect/decal/ruinshit/rubble/rubbleedge/southwest
	dir = SOUTHWEST
/obj/effect/decal/ruinshit/rubble/rubbleedge/southeast
	dir = SOUTHEAST

/obj/effect/decal/ruinshit/rubble/rubblecorner
	desc = "Its the corner, of rubble. And they say, where theres a corner, theres probably more of it."
	icon_state = "rubblecorner"
/obj/effect/decal/ruinshit/rubble/rubblecorner/north
	dir = NORTH
/obj/effect/decal/ruinshit/rubble/rubblecorner/south
	dir = SOUTH
/obj/effect/decal/ruinshit/rubble/rubblecorner/east
	dir = EAST
/obj/effect/decal/ruinshit/rubble/rubblecorner/west
	dir = WEST


/*
	OVERLAPS - Basically those weird segments that go over rubble for decoration
*/
/obj/effect/decal/ruinshit/rubble/overlap
	desc = "It appears to overlap something, something that is probably not very notable honestly."
	icon_state = "overlap"
/obj/effect/decal/ruinshit/rubble/overlap/north
	dir = NORTH
/obj/effect/decal/ruinshit/rubble/overlap/south
	dir = SOUTH
/obj/effect/decal/ruinshit/rubble/overlap/east
	dir = EAST
/obj/effect/decal/ruinshit/rubble/overlap/west
	dir = WEST

/obj/effect/decal/ruinshit/rubble/overlapdouble
	desc = "Unlike other pieces of rubble, this ones double the rubble trouble."
	icon_state = "overlapdouble"
/obj/effect/decal/ruinshit/rubble/overlapdouble/north
	dir = NORTH
/obj/effect/decal/ruinshit/rubble/overlapdouble/south
	dir = SOUTH
/obj/effect/decal/ruinshit/rubble/overlapdouble/east
	dir = EAST
/obj/effect/decal/ruinshit/rubble/overlapdouble/west
	dir = WEST

/obj/effect/decal/ruinshit/rubble/overlaptriple
	desc = "Theres three perfectly fine pieces of rubble here."
	icon_state = "overlaptriple"
/obj/effect/decal/ruinshit/rubble/overlaptriple/north
	dir = NORTH
/obj/effect/decal/ruinshit/rubble/overlaptriple/south
	dir = SOUTH
/obj/effect/decal/ruinshit/rubble/overlaptriple/east
	dir = EAST
/obj/effect/decal/ruinshit/rubble/overlaptriple/west
	dir = WEST

/obj/effect/decal/ruinshit/rubble/overlapcorner
	desc = "Its the corner, of a overlap. Aren't you glad its not over your lap?"
	icon_state = "overlapcorner"
/obj/effect/decal/ruinshit/rubble/overlapcorner/north
	dir = NORTH
/obj/effect/decal/ruinshit/rubble/overlapcorner/south
	dir = SOUTH
/obj/effect/decal/ruinshit/rubble/overlapcorner/east
	dir = EAST
/obj/effect/decal/ruinshit/rubble/overlapcorner/west
	dir = WEST

/obj/effect/decal/ruinshit/rubble/overlapcornershade
	desc = "This rubble segment has enough shade for something small to chill, like a mouse."
	icon_state = "overlapcornershade"
/obj/effect/decal/ruinshit/rubble/overlapcornershade/north
	dir = NORTH
/obj/effect/decal/ruinshit/rubble/overlapcornershade/south
	dir = SOUTH
/obj/effect/decal/ruinshit/rubble/overlapcornershade/east
	dir = EAST
/obj/effect/decal/ruinshit/rubble/overlapcornershade/west
	dir = WEST

/*
	Assorted Vents
					*/
/obj/effect/decal/ruinshit/vents
	name = "Circular Vent"
	desc = "Normally vents would be important, but you probably won't ever be around long enough to find out why."

/obj/effect/decal/ruinshit/vents/blue
	icon_state = "ventblue"
/obj/effect/decal/ruinshit/vents/red
	icon_state = "ventred"
/obj/effect/decal/ruinshit/vents/orange
	icon_state = "ventorange"
/obj/effect/decal/ruinshit/vents/rusty
	icon_state = "ventrusty"
/obj/effect/decal/ruinshit/vents/rustyalt
	icon_state = "ventrustyalt"

/*
	Big Boy Vent
	It be 64x64
				*/

/obj/effect/decal/ruinshit/bigboyvent
	name = "Large Circular Vent"
	desc = "Sometimes one must vent more than usual, and this seems fully adequate to handle all of it."
	icon = 'z40k_shit/icons/turfs/64x64ruindecals.dmi'
	icon_state = "bigvent"

/obj/structure/geyser/unstable/bigboyventreal
	name = "Large Circular Vent"
	desc = "Sometimes one must vent more than usual, and this seems fully adequate to handle all of it."
	icon = 'z40k_shit/icons/turfs/64x64ruindecals.dmi'
	icon_state = "bigvent"
	density = 0
	anchored = 1

/*
	Some F13 Windows I guess
							*/

/obj/effect/decal/ruinshit/falloutwindow
	name = "Some Bars"
	desc = "GEE THESE LOOK FAMILIAR"
	icon_state = "ruinswindowbroken"
	density = 1

/obj/effect/decal/ruinshit/falloutwindowalt
	name = "Some Bars"
	desc = "GEE THESE LOOK FAMILIAR"
	icon_state = "ruinswindowdestroyed"
	density = 1
