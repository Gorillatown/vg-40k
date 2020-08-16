//Miscellaneous procs in life.dm that did not directly belong in one of the .dm

/mob/living/carbon/human/calculate_affecting_pressure(var/pressure)
	..()
	var/pressure_difference = abs( pressure - ONE_ATMOSPHERE )
	var/list/clothing_items = list(head, wear_mask, wear_suit, w_uniform, gloves, shoes)

	//mainly used in horror form, but other things work as well
	var/species_difference = 0
	if(species)
		species_difference = species.pressure_resistance

	var/body_parts_protected = 0
	for(var/obj/item/equipment in clothing_items)
		if(equipment && equipment.pressure_resistance >= pressure_difference)
			body_parts_protected |= equipment.body_parts_covered
	pressure_difference = max(pressure_difference - species_difference,0)
	pressure_difference *= (1 - ((return_cover_protection(body_parts_protected))**5)) // if one part of your suit's not up to scratch, we can assume the rest of the suit isn't as effective.
	if(pressure > ONE_ATMOSPHERE)
		return ONE_ATMOSPHERE + pressure_difference
	else
		return ONE_ATMOSPHERE - pressure_difference

//This proc returns a number made up of the flags for body parts which you are protected on. (such as HEAD, UPPER_TORSO, LOWER_TORSO, etc. See setup.dm for the full list)
/mob/living/carbon/human/get_heat_protection_flags(temperature) //Temperature is the temperature you're being exposed to.
	var/thermal_protection_flags = 0
	//Handle normal clothing
	if(head)
		if(head.max_heat_protection_temperature && head.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= head.body_parts_covered
	if(wear_suit)
		if(wear_suit.max_heat_protection_temperature && wear_suit.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= wear_suit.body_parts_covered
	if(w_uniform)
		if(w_uniform.max_heat_protection_temperature && w_uniform.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= w_uniform.body_parts_covered
	if(shoes)
		if(shoes.max_heat_protection_temperature && shoes.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= shoes.body_parts_covered
	if(gloves)
		if(gloves.max_heat_protection_temperature && gloves.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= gloves.body_parts_covered
	if(wear_mask)
		if(wear_mask.max_heat_protection_temperature && wear_mask.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= wear_mask.body_parts_covered

	return thermal_protection_flags

/mob/living/carbon/human/get_thermal_protection_flags()
	var/thermal_protection_flags = 0
	if(head)
		thermal_protection_flags |= head.body_parts_covered
	if(wear_suit)
		thermal_protection_flags |= wear_suit.body_parts_covered
	if(w_uniform)
		thermal_protection_flags |= w_uniform.body_parts_covered
	if(shoes)
		thermal_protection_flags |= shoes.body_parts_covered
	if(gloves)
		thermal_protection_flags |= gloves.body_parts_covered
	if(wear_mask)
		thermal_protection_flags |= wear_mask.body_parts_covered

	return thermal_protection_flags

/mob/living/carbon/human/get_heat_protection(var/thermal_protection_flags) //Temperature is the temperature you're being exposed to.
	if(M_RESIST_HEAT in mutations)
		return 1
	return get_thermal_protection(thermal_protection_flags)

/mob/living/carbon/human/get_cold_protection()

	if(M_RESIST_COLD in mutations)
		return 1 //Fully protected from the cold.

	var/thermal_protection = 0.0

	if(head)
		thermal_protection += head.return_thermal_protection()
	if(wear_suit)
		thermal_protection += wear_suit.return_thermal_protection()
	if(w_uniform)
		thermal_protection += w_uniform.return_thermal_protection()
	if(shoes)
		thermal_protection += shoes.return_thermal_protection()
	if(gloves)
		thermal_protection += gloves.return_thermal_protection()
	if(wear_mask)
		thermal_protection += wear_mask.return_thermal_protection()

	var/max_protection = get_thermal_protection(get_thermal_protection_flags())
	return min(thermal_protection,max_protection)

/mob/living/carbon/human/proc/get_covered_bodyparts()
	var/covered = 0

	if(head)
		covered |= head.body_parts_covered
	if(wear_suit)
		covered |= wear_suit.body_parts_covered
	if(w_uniform)
		covered |= w_uniform.body_parts_covered
	if(shoes)
		covered |= shoes.body_parts_covered
	if(gloves)
		covered |= gloves.body_parts_covered
	if(wear_mask)
		covered |= wear_mask.body_parts_covered

	return covered

/mob/living/carbon/human/proc/randorgan()
	var/randorgan = pick(organs_by_name)
	return randorgan

/mob/living/carbon/human/earprot()
	return is_on_ears(/obj/item/clothing/ears/earmuffs) || is_on_ears(/obj/item/device/radio/headset/headset_earmuffs)

/mob/living/carbon/human/proc/has_reagent_in_blood(var/reagent_name,var/amount = -1)
	if(!reagents || !ticker)
		return 0
	return reagents.has_reagent(reagent_name,amount)

var/list/cover_protection_value_list = list()

proc/return_cover_protection(var/body_parts_covered)
	var/true_body_parts_covered = body_parts_covered
	true_body_parts_covered &= ~(IGNORE_INV|BEARD) // these being covered doesn't particularly matter so no need for them here
	if(cover_protection_value_list["[true_body_parts_covered]"])
		return cover_protection_value_list["[true_body_parts_covered]"]
	else
		var/total_protection = 0
		for(var/body_part in BODY_PARTS)
			if (body_part & true_body_parts_covered)
				total_protection += BODY_COVER_VALUE_LIST["[body_part]"]
		cover_protection_value_list["[true_body_parts_covered]"] = total_protection
		return total_protection
