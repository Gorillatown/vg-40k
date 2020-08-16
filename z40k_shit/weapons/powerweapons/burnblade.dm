/obj/item/weapon/powersword/burning
	name = "Burning Blade"
	desc = "A Loi Pattern Burning Blade. Initially a malfunctioning power sword, the overheating of the blade has been put to use in combat. Good at burning heretics."
	icon_state = "burningblade0"
	base_state = "burningblade"
	force = 15
	activeforce = 45
	throwforce = 25

/obj/item/weapon/powersword/burning/attack(mob/living/M, mob/user)
	..()
	if(active)
		M.fire_stacks += 2
		M.IgniteMob()
		M.take_organ_damage(0, 10) //Yes, this is additional fire damage since it is a burning blade. But also notice how this ignores armor.