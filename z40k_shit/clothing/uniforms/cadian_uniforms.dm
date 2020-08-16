
//-----------Uniforms----------------------
/obj/item/clothing/under/ig_guard //Basic Cadian Uniform. 
	name = "guardsman uniform"
	desc = "A standard issue uniform given to Guardsmen of the Imperial Guard."
	icon = 'z40k_shit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "guardsman_under" //Check: its there
	item_state = "guardsman_under"//Check: Its fine
	_color = "guardsman_under"
	has_sensor = 2 //Imperial guards cannot disable sensors, for good or for ill.
	species_restricted = list("Human") //Only humans can wear IG stuff for now at least.