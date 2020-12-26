

//See: human.dm: Line 1174 for where we stick species base stats onto the mob.

//Yes, we have stats. Strength doesn't do much atm.
//It also helps me do some inhand objects that are large with awkward positions.
//Its mostly stat_strength because theres too many vars in the codebase that are already named strength.
//What I will do is I will make the probability proc and everything here, mostly so.
//There is a central location to train up the stat itself.


/*
	DESIGN AS OF 3/5/2020
							*/
/*
	Range - 1 to 30
	Natural Range - 1 to 20
	Normal range - 4 to 12

----Stats Currently Active--- 
	Strength

*/

/*
	Relevant Species Max Table
								*/
/* Species		|Strength|Agility|Dexterity|Constitution|Willpower|Warp Sensitivity|Total:

	Ork Warboss		20		14		14			20			16		120					84
	Ork Nob			16		13		11			17			12		50					68
	Ork				13		12		11			14			8		10					58

	Human			12		12		12			12			12		1000				60

	Space Marine	15		14		16			15			14		1000				74
*/
//Cooldown variable is known as : stat_increase_cooldown.
//Gameplan:
//Basically we have a minimum probability for a stat to increase as long as we are within natural limits of a species.
//The closer we get to the maximum cap the lower the probability modifier gets.
//After that we will swap to a static value before it unlocks a probability modifier for the next tier.
/mob/living/proc/stat_increase(var/chosen_attribute, var/attr_trained_value)
	//if(stat_increase_cooldown > world.time)
	//	return 0
	//Probability our stat increases
	var/increase_probability
	//localvar to dictate we already entered a check... to cut down on checks

	//parameter input variable
	switch(chosen_attribute)
		if(ATTR_STRENGTH) //Maximum cap 20
			attribute_strength_trained_integer += attr_trained_value
			if(attribute_strength <= attribute_strength_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_strength_trained_integer >= 1000)
					attribute_strength += 1 //Increase our strength by 1
					to_chat(src,"<span class = 'good'>You feel stronger.</span>")
					attribute_strength_trained_integer = 0 //Set strength trained integer to nothing
					return 1 //Return true
				if(attribute_strength <= attribute_strength_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_strength_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_strength <= attribute_strength_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_strength_trained_integer/50)
			else
				if(attribute_strength_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_strength_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2
			if(prob(increase_probability)) //If we hit the probability
				attribute_strength += 1 //Increase our strength by 1
				to_chat(src,"<span class = 'good'>You feel stronger.</span>")
				attribute_strength_trained_integer = 0 //Set strength trained integer to nothing
				return 1 //Return true
			else
				return 0
		if(ATTR_AGILITY) //Maximum cap 20
			attribute_agility_trained_integer += attr_trained_value
			if(attribute_agility <= attribute_agility_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_agility_trained_integer >= 1000)
					attribute_agility += 1
					to_chat(src,"<span class = 'good'>You feel a bit faster.</span>")
					attribute_agility_trained_integer = 0 
					return 1
				if(attribute_agility <= attribute_agility_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_agility_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_agility <= attribute_agility_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_agility_trained_integer/50)
			else
				if(attribute_agility_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_agility_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2
			if(prob(increase_probability))
				attribute_agility += 1
				to_chat(src,"<span class = 'good'>You feel a bit faster.</span>")
				attribute_agility_trained_integer = 0
				return 1
			else
				return 0
		if(ATTR_DEXTERITY) //Maximum cap 20
			attribute_dexterity_trained_integer += attr_trained_value
			if(attribute_dexterity <= attribute_dexterity_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_dexterity_trained_integer >= 1000)
					attribute_dexterity += 1
					to_chat(src,"<span class = 'good'> Your coordination seems better.</span>")
					attribute_dexterity_trained_integer = 0
					return 1
				if(attribute_dexterity <= attribute_dexterity_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_dexterity_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_dexterity <= attribute_dexterity_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_dexterity_trained_integer/50)
			else
				if(attribute_dexterity_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_dexterity_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2
			if(prob(increase_probability))
				attribute_dexterity += 1
				to_chat(src,"<span class = 'good'> Your coordination seems better.</span>")
				attribute_dexterity_trained_integer = 0
				return 1
			else
				return 0
		if(ATTR_CONSTITUTION) //Maximum cap 20
			attribute_constitution_trained_integer += attr_trained_value
			if(attribute_constitution <= attribute_constitution_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_constitution_trained_integer >= 1000)
					attribute_constitution += 1
					to_chat(src,"<span class = 'good'> You feel tougher. </span>")
					maxHealth += 10
					health += 10
					attribute_constitution_trained_integer = 0
					return 1
				if(attribute_constitution <= attribute_constitution_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_constitution_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_constitution <= attribute_constitution_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_constitution_trained_integer/50)
			else
				if(attribute_constitution_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_constitution_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2		
			if(prob(increase_probability))
				attribute_constitution += 1
				to_chat(src,"<span class = 'good'> You feel tougher. </span>")
				maxHealth += 10
				health += 10
				attribute_constitution_trained_integer = 0
				return 1
			else
				return 0
		if(ATTR_WILLPOWER) //Maximum cap 20
			attribute_willpower_trained_integer += attr_trained_value
			if(attribute_willpower <= attribute_willpower_natural_limit) //If our stat is lesser than the natural limit
				if(attribute_willpower_trained_integer >= 1000)
					attribute_willpower += 1
					to_chat(src,"<span class='good'>You feel more willful.</span>")
					attribute_willpower_trained_integer = 0
					ticker_to_next_psyker_point += 2
					if(ticker_to_next_psyker_point >= 6)
						to_chat(src,"<span class = 'good'>You feel like you can tap into more power.</span>")
						psyker_points += 1
						ticker_to_next_psyker_point = 0
				if(attribute_willpower <= attribute_willpower_natural_limit-4) //If we are still lesser than 4 away from cap
					increase_probability = round(1+attribute_willpower_trained_integer/100) //increased probability + rounded number(amount we trained to 1000 divided by 100)
				if(attribute_willpower <= attribute_willpower_natural_limit-10) //If we are still lesser than 10 away from cap
					increase_probability = round(10+attribute_willpower_trained_integer/50)
			else
				if(attribute_willpower_trained_integer >= 800) //If we have trained up greater than or equal to 800
					increase_probability = 2
					if(attribute_willpower_trained_integer >= 1000) //If we are over 1000
						increase_probability += 3 //Add another 2				
			if(prob(increase_probability))
				attribute_willpower += 1
				to_chat(src,"<span class='good'>You feel more willful.</span>")
				attribute_willpower_trained_integer = 0
				ticker_to_next_psyker_point += 2
				if(ticker_to_next_psyker_point >= 6)
					to_chat(src,"<span class = 'good'>You feel like you can tap into more power.</span>")
					psyker_points += 1
					ticker_to_next_psyker_point = 0
				return 1
			else
				return 0
		if(ATTR_SENSITIVITY) //Maximum cap 1000
			attribute_sensitivity_trained_integer += attr_trained_value //We put trained value in
			if(attribute_sensitivity <= attribute_sensitivity_natural_limit) //If our stat is lesser than the natural limit		
				attribute_sensitivity += 25
				to_chat(src,"<span class='good'>You feel more in touch with reality.</span>")
				attribute_sensitivity_trained_integer = 0
				ticker_to_next_psyker_point += 1
				ticker_to_next_chaos_psyker_point += 1
				if(ticker_to_next_psyker_point >= 6)
					to_chat(src,"<span class='good'>You feel like you can tap into more power.</span>")
					psyker_points += 1
					ticker_to_next_psyker_point = 0
				if(chaos_tainted)
					if(ticker_to_next_chaos_psyker_point >= 3)
						to_chat(src,"<span class='sinister'>Power courses through you.<s/apn>")
						chaos_psyker_points += 1
						ticker_to_next_chaos_psyker_point = 0
				if(attribute_sensitivity >= 500 && !chaos_tainted)
					if(prob(attribute_sensitivity/250))
						chaos_tainted = TRUE
						to_chat(src,"<span class='sinister'>The Gods of Chaos call to you.</span>")
				return 1
			else
				return 0


	//stat_increase_cooldown = world.time + 50

//Appended in one place
/mob/living/carbon/human/proc/initial_liveattr()

	attribute_strength = species.base_strength
	attribute_strength_natural_limit = species.base_strength_natural_limit
		
	attribute_agility = species.base_agility
	attribute_agility_natural_limit = species.base_agility_natural_limit
		
	attribute_dexterity = species.base_dexterity
	attribute_dexterity_natural_limit = species.base_dexterity_natural_limit
		
	attribute_constitution = species.base_constitution
	attribute_constitution_natural_limit = species.base_constitution_natural_limit
		
	attribute_willpower = species.base_willpower
	attribute_willpower_natural_limit = species.base_willpower_natural_limit
		
	attribute_sensitivity = species.base_sensitivity
	attribute_sensitivity_natural_limit = species.base_sensitivity_natural_limit
	
	attr_modifier_time()

/mob/living/carbon/human/proc/attr_modifier_time()
	var/total_sum = species.RNG_modifier_sum_max //total sum we can have in additional stats from species datum
	var/number_picked = 0 //A variable that holds the number that is rolled, mostly so we can subtract it.
	var/positive_prob = 25 //The number that is used for positive stat modifiers
	var/negative_prob = 3 //The number that is used for a negative stat modifier.
	var/extra_boost = 3 //The probability of a extra boost in stats If you roll the max on a modifier
	
	//Yes, we actually only have 4 main stats. Willpower and Sensitivity are psyker stats.
// STRENGTH-------------------------------------------------
	if(prob(positive_prob)) 
		number_picked = rand(0,total_sum)
		attribute_strength += number_picked
		total_sum -= number_picked
		if((number_picked == total_sum)&&(prob(extra_boost)))
			attribute_strength += rand(0,6)
			extra_boost -= extra_boost
	else if(prob(negative_prob))
		number_picked = rand(0,3)
		attribute_strength -= number_picked

// AGILITY ------------------------------------------------
	if(prob(positive_prob)) 
		number_picked = rand(0,total_sum)
		attribute_agility += number_picked
		total_sum -= number_picked
		if((number_picked == total_sum)&&(prob(extra_boost)))
			attribute_agility += rand(0,6)
			extra_boost -= extra_boost
	else if(prob(negative_prob))
		number_picked = rand(0,3)
		attribute_agility -= number_picked

// DEXTERITY ----------------------------------------------
	if(prob(positive_prob)) 
		number_picked = rand(0,total_sum)
		attribute_dexterity += number_picked
		total_sum -= number_picked
		if((number_picked == total_sum)&&(prob(extra_boost)))
			attribute_dexterity += rand(0,6)
			extra_boost -= extra_boost
	else if(prob(negative_prob))
		number_picked = rand(0,3)
		attribute_dexterity -= number_picked

// CONSTITUTION --------------------- Unlike normal con modifiers, this time they get the extra hp.
	if(prob(positive_prob)) 
		number_picked = rand(0,total_sum)
		attribute_constitution += number_picked
		maxHealth += 10*number_picked
		health += 10*number_picked
		total_sum -= number_picked
		if((number_picked == total_sum)&&(prob(extra_boost)))
			var/extra_special_con = rand(0,6)
			attribute_constitution += extra_special_con
			maxHealth += 10*extra_special_con
			health += 10*extra_special_con
			extra_boost -= extra_boost
	else if(prob(negative_prob))
		number_picked = rand(0,3)
		attribute_constitution -= number_picked

/mob/living/carbon/verb/check_attributes()
	set name = "Check Attributes"
	set category = "IC"
	set desc = "See what attributes you currently have."

	to_chat(src, "<span class='good'>Strength: [attribute_strength].</span>")
	to_chat(src, "<span class='good'>Agility: [attribute_agility].</span>")
	to_chat(src, "<span class='good'>Dexterity: [attribute_dexterity].</span>")
	to_chat(src, "<span class='good'>Constitution: [attribute_constitution].</span>")
	to_chat(src, "<span class='good'>Willpower: [attribute_willpower].</span>")
	to_chat(src, "<span class='bad'>Warp Sensitivity: [attribute_sensitivity].</span>")
