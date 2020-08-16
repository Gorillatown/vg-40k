/** Anvil
	Is treated as an item that can not be picked up, pushed, or pulled, unless you are incredibly strong.
	Can place blacksmithing placeholders onto it like a table. Necessary to actually hammer them into shape.
**/

/obj/item/anvil
	name = "anvil"
	desc = "For rounding and crafting objects. Combined with a hammer, you can likely craft some pleasant weapons with this"
	w_class = W_CLASS_GIANT
	icon = 'icons/obj/blacksmithing.dmi'
	icon_state = "anvil"
	impactsound = 'sound/misc/clang.ogg'
	layer = TABLE_LAYER
	flags = TWOHANDABLE | MUSTTWOHAND
	density = 1
	force = 40 //as much as a wielded fireaxe
	throwforce = 40

/obj/item/anvil/can_pickup(mob/living/M)
	if(!..())
		return FALSE
	if(M.attribute_strength >= 13)
		return TRUE

/obj/item/anvil/can_be_pulled(mob/user)
	if(istype(user, /mob/living))
		var/mob/living/L = user
		if(L.attribute_strength >= 11)
			return TRUE
	return FALSE

/obj/item/anvil/check_airflow_movable(n)
	if(n > 1000)
		return TRUE
	return FALSE

/obj/item/anvil/can_be_pushed(mob/living/user)
	return user.attribute_strength >= 10

/obj/item/anvil/attackby(obj/item/W, mob/user, params)
	if(user.drop_item(W, src.loc))
		if(W.loc == src.loc && params)
			W.setPixelOffsetsFromParams(params, user)
			return 1
