/datum/job_quest/tzeentch_plot_one
	title = "Retrieving A Heirloom - Crown Quest"

/datum/job_quest/tzeentch_plot_one/main_body()
	our_protagonist = actual_protagonist.current
	switch(alignment)
		if(1 to INFINITY)
			to_chat(our_protagonist, "<span class='notice'> You reminisce for a moment, dwelling upon when things were much more simple. Mostly because you weren't responsible for much.</span>")
			alignment = 0
		if(0)
			to_chat(our_protagonist, "<span class='notice'> You think back to how the last lord always seemed so angry, talking about how everything was taken from him. How things were unfair, things do feel quite unfair. Considering you now have the title of Lord to this failing place, it could be worse though. </span>")
			alignment--
		if(-1)
			to_chat(our_protagonist, "<span class='notice'> It could indeed be a lot worse, you've found you have developed a certain talent over time, although you've taken care to keep it secret. You've taken the time to obtain a book and hone your power in private. </span>")
			alignment--
		if(-2)
			to_chat(our_protagonist, "<span class='notice'> Perhaps you should go search under your bed that book; a refresher couldn't hurt.</span>")
			alignment--
		if(-3)
			for(var/obj/effect/landmark/lordpsykerbook/ourbook in orange(3,our_protagonist))
				to_chat(our_protagonist, "<span class='notice'>Yes, this is the right place, regardless lets open this book.</span>")
				var/mob/living/carbon/human/H = our_protagonist
				H.attribute_willpower = 12
				H.attribute_sensitivity = 600
				H.psyker_points = 2
				new /obj/item/weapon/psychic_spellbook(ourbook.loc)
				qdel(ourbook)
				alignment--
		if(-4)
			to_chat(our_protagonist, "<span class='notice'> You know the gift that has come to you is wrong, perhaps that is why a inquisitor has been lurking. Most people wouldn't know much other than to burn the witch, but you are lord of this ruined moon. </span>")
			alignment--
		if(-5)
			to_chat(our_protagonist, "<span class='notice'> Indeed, you are aware of the dangers. But are they truly dangers? Only a fool couldn't control their power. </span>")
			alignment--
		if(-6)
			to_chat(our_protagonist, "<span class='notice'> Mmm, but we both know that isn't enough to turn the tide in bringing prosperity to this land. Along with that you've been hearing whispers as of late. </span>")
			alignment--
		if(-7)
			to_chat(our_protagonist, "<span class='tzeentch'> Your salvation lies in a place that only exists in memories. </span>")
			alignment--
		if(-8)
			to_chat(our_protagonist, "<span class='notice'> There it is again, you can vaguely recall a oddly less decrepit throne room. You aren't dumb though, clearly its clueing you in.</span>")
			alignment--
		if(-9)
			to_chat(our_protagonist, "<span class='notice'> Alas, everytime you've visited the old throne room yourself, theres nothing in particular going on there... Other than the usual giant spiders. Perhaps, you should just send more men to investigate, preferably a group of two minimum </span>")
			alignment--
		if(-10)
			if(!SS_Scenario.mask_is_active)
				to_chat(our_protagonist, "<span class='notice'> Send a patrol of at least two to investigate and chart once more, after-all it never hurts to reinvestigate to insure you've missed no details. </span>")
			else
				to_chat(our_protagonist, "<span class='notice'> You feel a certain odd feeling, perhaps today is a turning point for better or worse in your life. Oddly, you feel something out in the wastes calling to you. Now if you sent that patrol, where is it? </span>")
				alignment--
		if(-11) //End
			for(var/obj/item/clothing/mask/gas/artifact/evilmask in our_protagonist.contents)
				var/mob/living/carbon/human/H = our_protagonist
				to_chat(our_protagonist, "<span class='notice'> The mask called to you, and you have answered. Your perception of things opening up, can you truly describe it as power filling you? Its as if your whole being is capable of tapping into so much more. </span>")
				H.attribute_willpower = 12
				H.attribute_sensitivity = 600
				H.psyker_points = 12
