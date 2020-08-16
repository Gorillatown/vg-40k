// You should only modify this file if you're creating new maps or deleting them
// welcome to macro hell

// here's how this works (you don't need to know this):
// each map file (tgstation.dm, test_tiny.dm, etc.) is enclosed in a `#ifndef MAP_OVERRIDE`
// - on a freshly pulled unmodified build: MAP_OVERRIDE is not defined, so
//   whatever map is specified in the .dme is compiled
// - if MAP_OVERRIDE is set to one of the magic numbers corresponding to a map:
//   the abomination below will undefine the MAP_OVERRIDE macro, include the map,
//   then redefine it so that the map specified by the .dme is skipped

#ifdef MAP_OVERRIDE
	#if MAP_OVERRIDE == 0
		#undef MAP_OVERRIDE
		#include "maptestdesert.dm"
		#define MAP_OVERRIDE 0
	#elif MAP_OVERRIDE == 1
		#undef MAP_OVERRIDE
		#include "maptestsnow.dm"
		#define MAP_OVERRIDE 1
	#elif MAP_OVERRIDE == 2
		#undef MAP_OVERRIDE
		#include "desertGulch.dm"
		#define MAP_OVERRIDE 2
	#endif
#endif
