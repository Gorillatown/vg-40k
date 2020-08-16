/mob/living/carbon/human
	var/relationships[0]

/datum/relationships

	var/list/players = list()

	var/relationships_mates = list()
	var/relationships_siblings = list()
	var/relationships_uncles_aunts_nephews_nieces = list()
	var/relationships_cousins = list()
	var/relationships_parents_children = list()


/datum/relationships/proc/make_relationships()

	var/list/tier_common = list()
	var/list/tier_uncommon = list()
	var/list/tier_somewhat_rare = list()
	var/list/tier_super_rare = list()

	spawn(20 SECONDS)
		for(var/mob/living/carbon/human/H in player_list)
	
			players += H
			var/job_string = H.mind.assigned_role
			var/datum/job/muh_job = job_master.GetJob(job_string)
			//ar/datum/job/muh_job = H.mind.assigned_role

			//tiers include women and children
			switch(muh_job.relationship_chance)
				if(HUMAN_COMMON)
					tier_common += H
				if(HUMAN_UNCOMMON)
					tier_uncommon += H
				if(HUMAN_SOMEWHAT_RARE)
					tier_somewhat_rare += H
				if(HUMAN_SUPER_RARE)
					tier_super_rare += H

		//form common relationships
		form_relationships(tier_common, tier_common, 1)
		form_relationships(tier_uncommon, tier_uncommon, 1)
		form_relationships(tier_somewhat_rare, tier_somewhat_rare, 1)
		form_relationships(tier_super_rare, tier_super_rare, 1)
		//form uncommon relationships
		form_relationships(tier_common, tier_uncommon, 0)
		form_relationships(tier_uncommon, tier_somewhat_rare, 0)
		form_relationships(tier_somewhat_rare, tier_super_rare, 0)

/datum/relationships/proc/form_relationships(var/list/list1, var/list/list2, var/common = 1)
	var/probability = 0
	if(players.len)
		if(common)
			probability = 100/players.len/2
		else
			probability = 100/players.len/4

		for(var/mob/living/carbon/human/H in list1) //Formerly players in both lists
			for(var/mob/living/carbon/human/HH in list2)
				if(prob(probability))
					create_relationship(H,HH)

		spawn(5 SECONDS)
			print_to_mind()
	else
		return 0


/datum/relationships/proc/create_relationship(var/mob/living/carbon/human/mob1, var/mob/living/carbon/human/mob2)
	var/mob1_age = mob1.age //Mob 1's age
	var/mob2_age = mob2.age //Mob 2's age
	var/difference = abs(mob1_age - mob2_age) //difference is absolute number of m1 age minus m2 age

	if(difference <= 15) //if 15 is greater than or equal to the difference
		if(mob1_age >= 16 && mob2_age >= 16) //if mob1's age is greater than or equal to 16 and mob 2's age is greater than or equal to 16
			if(prob(50))
				return add_relationship(mob1, mob2, "mates")
			else if(prob(30))
				return add_relationship(mob1, mob2, "siblings")
			else
				return add_relationship(mob1, mob2, "cousins")
		else
			if(prob(75))
				return add_relationship(mob1, mob2, "uncle/aunt/nephew/niece")
			else
				return add_relationship(mob1, mob2, "cousins")

	else if(difference >= 16)
		if(prob(75))
			return add_relationship(mob1, mob2, "parent/child")
		else
			return add_relationship(mob1, mob2, "cousins")


/datum/relationships/proc/add_relationship(var/mob/living/carbon/human/mob1, var/mob/living/carbon/human/mob2, var/relationship)

	var/list/ref = list()

	switch(relationship)
		if("mates")
			ref = relationships_mates
		if("siblings")
			ref = relationships_siblings
		if("uncle/aunt/nephew/niece")
			ref = relationships_uncles_aunts_nephews_nieces
		if("cousins")
			ref = relationships_cousins
		if("parent/child")
			ref = relationships_parents_children

	if(mob1 in ref || mob2 in ref)
		return

	ref += mob1
	ref += mob2

	var/mob1_gender = mob1.gender
	var/mob2_gender = mob2.gender

	switch (relationship) // just in case we mistyped
		if("mates")
			if(mob1_gender == mob2_gender)
				if(prob(10)) //Sorry, theres different people but no unstandard marriage in this grimdark universe.
					mob1.relationships[mob2.real_name] = "Lover"
					mob2.relationships[mob1.real_name] = "Lover"
					return 1
				else
					return 0
			else
				if(mob1_gender == MALE && mob2_gender == FEMALE)
					mob1.relationships[mob2.real_name] = "Wife"
					mob2.relationships[mob1.real_name] = "Husband"
					mob1.real_name = "[mob1.first_name]" + " " + "[mob2.last_name]"
				else
					mob1.relationships[mob2.real_name] = "Husband"
					mob2.relationships[mob1.real_name] = "Wife"
					mob2.real_name = "[mob2.first_name]" + " " + "[mob1.last_name]"		
				return 1
	
		if("siblings") //ONII CHAN
			if(prob(5))
				mob1.relationships[mob2.real_name] = mob2_gender == FEMALE ? "Girlfriend" : "Boyfriend"
				mob2.relationships[mob1.real_name] = mob1_gender == FEMALE ? "Girlfriend" : "Boyfriend"
			else
				mob1.relationships[mob2.real_name] = mob2_gender == FEMALE ? "Sister" : "Brother"
				mob2.relationships[mob1.real_name] = mob1_gender == FEMALE ? "Sister" : "Brother"
				if(prob(20))
					mob1.real_name = "[mob1.first_name]" + " " + "[mob2.last_name]"
			return 1
		if("cousins")
			mob1.relationships[mob2.real_name] = "Cousin"
			mob2.relationships[mob1.real_name] = "Cousin"
			return 1
		if("uncle/aunt/nephew/niece")
			mob1.relationships[mob2.real_name] = mob2_gender == FEMALE ? "Niece" : "Nephew"
			mob2.relationships[mob1.real_name] = mob1_gender == FEMALE ? "Aunt" : "Uncle"
			return 1
		if("parent/child")
			mob1.relationships[mob2.real_name] = mob2_gender == FEMALE ? "Daughter" : "Son"
			mob2.relationships[mob1.real_name] = mob1_gender == FEMALE ? "Mother" : "Father"
			mob1.real_name = "[mob1.first_name]" + " " + "[mob2.last_name]"
			return 1

/datum/relationships/proc/print_to_mind()
	for(var/mob/living/carbon/human/H in players)
		for(var/mob/living/carbon/human/HH in H.relationships)
			to_chat(H.mind.current, "<B><span class='average'>[HH.real_name] is your [H.relationships[HH.real_name]]</span></B>.")
			H.mind.store_memory("<B>[HH.real_name] is your [H.relationships[HH.real_name]].</B>")
