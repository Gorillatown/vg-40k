/*
Basically this is a assc list that handles cargo prices
	How it works -
	Basically when people sell things, the type path is entered into the list with a number generated
	It will go down per how much they sell of a object
*/

/datum/market_economy
	var/list/market_economy = list(/obj/item/stack/ore/iron = 0.1,
									/obj/item/stack/ore/glass = 0.1) 

/datum/market_economy/proc/sell_object(atom/movable/O)
	var/payout = market_economy[O.type]
	if(!payout)
		if(istype(O,/obj/item/weapon/gun))
			market_economy[O.type] = rand(100,250)
			return payout
		
		else if(istype(O,/obj/item/weapon))
			market_economy[O.type] = rand(50,100)
			return payout
		
		else if(istype(O,/obj/item/manufacturing_parts))
			market_economy[O.type] = rand(5,30)
			return payout
		
		else if(istype(O,/obj/item/stack))
			var/rand_number_payout = 0.1
			if(istype(O,/obj/item/stack/sheet/mineral)||istype(O,/obj/item/stack/ore)) //If its a mineral sheet pay out
				rand_number_payout = rand(5,10)
			else //If its not fuck you enjoy jackshit idiot
				rand_number_payout = 0.2
			
			market_economy[O.type] = rand_number_payout
			var/obj/item/stack/STKK = O
			
			rand_number_payout = round(rand_number_payout*STKK.amount)
			return rand_number_payout
		
		else if(ismob(O))
			var/slavery_payouts = 0
			
			if(ishuman(O))
				var/mob/living/carbon/human/H = O
				if(H.stat != DEAD)
					slavery_payouts += H.attribute_toughness*25
					slavery_payouts += H.attribute_strength*25
					slavery_payouts -= H.age*5
					slavery_payouts = clamp(slavery_payouts,100,1000)
				if(isork(H))
					slavery_payouts += 50	
				return slavery_payouts
			else if(isanimal(O))
				var/mob/living/simple_animal/SA = O
				if(istype(SA,/mob/living/simple_animal/hostile))
					slavery_payouts += 100
				if(SA.stat != DEAD)
					slavery_payouts += 50
				slavery_payouts += SA.size*25
				return slavery_payouts
		
		else //Doesn't fall into any of the above categories
			market_economy[O.type] = rand(1,20)
	
	else //It already exists in the assc list, thus we reduce the value
		if(istype(O,/obj/item/stack))
			var/obj/item/stack/STKK = O
			var/stack_payout = round(STKK.amount*payout)
			if(payout-1 > 0)
				market_economy[O.type] -= 1
			return stack_payout
		else
			if(payout-3 > 0)
				market_economy[O.type] -= 3
			return payout