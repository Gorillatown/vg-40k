/*
	The second part of our character persistence series
	Basically these are tied to individual characters one creates based on name honestly.
	Issues: People making characters with new names or adding single letters
			Too many character name swaps
*/

/datum/interactive_persistence_character
	var/charname = "NULL" //Name of the character
	var/impurity = 0 //How many times the character has done impure things.
