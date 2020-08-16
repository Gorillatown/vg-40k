/datum/emote/living/carbon/sound/orkscream
	key = "orkscream"
	key_third_person = "orkscreams"
	message = "screams!"
	message_mime = "acts out a scream!"
	emote_type = EMOTE_AUDIBLE
	species_specific = list("Ork" = list('z40k_shit/sounds/orkpain1.ogg', 
										'z40k_shit/sounds/orkpain2.ogg', 
										'z40k_shit/sounds/orkpain3.ogg', 
										'z40k_shit/sounds/orkpain4.ogg'),
							"Ork Nob" = list('z40k_shit/sounds/orkpain1.ogg', 
										'z40k_shit/sounds/orkpain2.ogg', 
										'z40k_shit/sounds/orkpain3.ogg', 
										'z40k_shit/sounds/orkpain4.ogg'),
							"Ork Warboss" = list('z40k_shit/sounds/orkpain1.ogg', 
										'z40k_shit/sounds/orkpain2.ogg', 
										'z40k_shit/sounds/orkpain3.ogg', 
										'z40k_shit/sounds/orkpain4.ogg')
							)
	sound_message = "screams in agony!"

/datum/emote/living/carbon/sound/gretchinscream
	key = "gretscream"
	key_third_person = "gretscreams"
	message = "screams!"
	message_mime = "acts out a scream!"
	emote_type = EMOTE_AUDIBLE
	species_specific = list("Ork Gretchin" = list('z40k_shit/sounds/gretscream1.ogg',
												'z40k_shit/sounds/gretscream2.ogg')
												)
	sound_message = "screams in agony!"
