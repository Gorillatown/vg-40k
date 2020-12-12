/obj/item/clothing/under/commissar
	name = "commissar uniform"
	desc = "Its a uniform fit for a commissar."
	icon = 'F_40kshit/icons/obj/ig/IGarmorandclothesOBJ.dmi'
	icon_state = "commissar" //Check: Its there
	item_state = "commissar" //Check Its there:
	_color = "commissar"
	species_restricted = list("Human") //Only humans can wear IG stuff for now at least.
	
/obj/item/clothing/under/enginseer_uniform
	name = "Enginseer Outer Plating"
	desc = "Its overly masculine looking despite being mostly machine parts, and solid metal. You are pretty sure it covers a body underneath."
	icon = 'F_40kshit/icons/obj/clothing/uniforms.dmi'
	icon_state = "mech_uniform" //Check: Its there
	item_state = "mech_uniform" //Check Its there:
	_color = "mech_uniform"
	species_restricted = list("Human") //Only humans can wear IG stuff for now at least.
	canremove = 0

/obj/item/clothing/under/seneschal
	name = "Seneschal Clothing"
	desc = "You couldn't call it a uniform, its more like casual ware for someone with a lot of freedom."
	icon = 'F_40kshit/icons/obj/clothing/uniforms.dmi'
	icon_state = "seneschal_coat" //Check: Its there
	item_state = "seneschal_coat" //Check Its there:
	_color = "seneschal_coat"
	species_restricted = list("Human") //Only humans can wear IG stuff for now at least.

/obj/item/clothing/under/harlequin
	name = "mime's outfit"
	desc = "Now it's more colorful."
	icon = 'F_40kshit/icons/obj/clothing/uniforms.dmi'
	icon_state = "harlequin"
	item_state = "mime"
	_color = "mime"
	armor = list(melee = 5, bullet = 5, laser = 5, energy = 5, bomb = 5, bio = 10, rad = 10)
	