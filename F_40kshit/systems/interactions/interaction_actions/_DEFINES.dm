/*
	Instead of istype checks, we will try to swap to defines.
	Issue is I want to handle anything from tentacles, to mantis claws, to deer hooves, to energy tendril whip hands.
	So we use our imagination and make generic defines tied to numbers for cost savings.
*/
#define INTERACTIVE_ORIFACE 1 //A hole to tear things out of
#define INTERACTIVE_JOINTED 2 //Breakable
#define INTERACTIVE_SINGLE_GRAB 3 //Capable of grabbing something alone
#define INTERACTIVE_DOUBLE_GRAB 4 //Needs two things to grab