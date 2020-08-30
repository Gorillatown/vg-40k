/datum/role/job_quest/tzeentch_one
	name = TZEENTCH_CHAMPION
	id = TZEENTCH_CHAMPION
	special_role = TZEENTCH_CHAMPION
//	logo_state = "ig-standard-logo"

/datum/role/job_quest/tzeentch_one/New(var/datum/mind/M, var/datum/faction/fac=null, var/new_id)
	..()

/datum/role/job_quest/tzeentch_one/GetScoreboard()
	var/score_results = ""
	var/cur_num = abs(alignment)
	var/percentage = round(((cur_num/11)*100))

	score_results += "<b>[antag.key]</b> as <b>[antag.name]</b><br>"
	if(percentage <= 100)
		score_results += "<b>Total Percent Complete:</b> <font color='#07fa0c'>[percentage]</font>%."
	else
		score_results += "<b>Total Percent Complete:</b> <font color='#ff0000'>[percentage]</font>%."
	return score_results

/datum/role/job_quest/tzeentch_one/point_handler(var/mob/living/carbon/human/H)
	return

/datum/role/job_quest/tzeentch_one/alignment_handler()
	var/mob/living/our_protagonist = antag.current
	switch(alignment)
		if(1 to INFINITY)
			to_chat(our_protagonist, "<span class='notice'> You reminisce for a moment, dwelling upon whatever comes to mind. A lot of the time you are just spent thinking especially since your wealth, and influence has been dwindling.</span>")
			alignment = 0
		if(0)
			to_chat(our_protagonist, "<span class='notice'> You think back to the stories your father would tell you, of how your lineage was founded by a man of great character. Alas, you don't think you'd ever measure up to the ancestor that claimed this planet. </span>")
			alignment--
		if(-1)
			to_chat(our_protagonist, "<span class='notice'> In your freetime lately, you've been slowly picking through a certain book, considering we are doing nothing; why not get back to something that can take our mind off the present. </span>")
			alignment--
		if(-2)
			to_chat(our_protagonist, "<span class='notice'> Perhaps you should go search under your bed that book; after-all most things get stolen around here, they never search under your bed.</span>")
			alignment--
		if(-3)
			for(var/obj/effect/landmark/lordpsykerbook/ourbook in orange(3,our_protagonist))
				to_chat(our_protagonist, "<span class='notice'>Yes, this is the right place, regardless lets open this book.</span>")
				var/mob/living/carbon/human/H = our_protagonist
				H.attribute_willpower = 11
				H.attribute_sensitivity = 600
				new /obj/item/weapon/psychic_spellbook(ourbook.loc)
				qdel(ourbook)
				alignment--
		if(-4)
			to_chat(our_protagonist, "<span class='notice'> Its a book of psyker powers, warp magic; you've studied it all extensively but you never had it. </span>")
			alignment--
		if(-5)
			to_chat(our_protagonist, "<span class='notice'> Imagine the heights you could achieve with psyker powers, maybe even measure up to your ancestor in martial prowess. </span>")
			alignment--
		if(-6)
			to_chat(our_protagonist, "<span class='notice'> Indeed, you could turn it all around. </span>")
			alignment--
		if(-7)
			to_chat(our_protagonist, "<span class='tzeentch'> Perhaps, we should investigate the southeast, where our family used to reside. </span>")
			alignment--
		if(-8)
			to_chat(our_protagonist, "<span class='notice'> That odd thought just came to mind, perhaps its a sign, you've had that thought several times without warning.</span>")
			alignment--
		if(-9)
			to_chat(our_protagonist, "<span class='notice'> Alas, everytime you've visited the old throne room personally, theres nothing in particular going on there... Other than the usual giant spiders. Perhaps, you should just send more men to investigate, preferably a group of two minimum </span>")
			alignment--
		if(-10)
			if(!SS_Scenario.mask_is_active)
				to_chat(our_protagonist, "<span class='notice'> Send a patrol of at least two to investigate and chart the southeast complex once more, after-all it never hurts to send patrols to insure you've missed no details. You DEFINITELY don't want to go on this task yourself. </span>")
			else
				to_chat(our_protagonist, "<span class='notice'> You feel a certain odd feeling, perhaps today is a turning point for better or worse in your life. Oddly, you feel something out in the wastes calling to you. Now if you sent that patrol, where is it? </span>")
				alignment--
		if(-11) //End
			for(var/obj/item/clothing/mask/gas/artifact/evilmask in our_protagonist.contents)
				var/mob/living/carbon/human/H = our_protagonist
				to_chat(our_protagonist, "<span class='notice'> The mask called to you, and you have answered. Your perception of things opening up, can you truly describe it as power filling you? Its as if your whole being is capable of tapping into so much more. </span>")
				H.attribute_willpower = 15
				H.attribute_sensitivity = 600
				H.psyker_points = 20
