			
/datum/action/item_action/warhams/attachment/remove_atch
	name = "Un-attach Attachment"
	button_icon_state = "unattach"

/datum/action/item_action/warhams/attachment/remove_atch/Trigger()
	var/obj/item/weapon/S = target
	S.remove_atch(owner)

/obj/item/weapon/proc/remove_atch(var/mob/user)
	if(!ATCHSYS.attachments.len)
		to_chat(user, "<span class='notice'> [src] appears to be devoid of anything attached to it.</span>")
		return
	else
		var/remove_acc = input(user,"Which attachment do you want to remove?", "", "Cancel") as null|anything in ATCHSYS.attachments
		if(remove_acc != "Cancel")
			var/obj/item/weapon/attachment/ATCH = remove_acc
			ATCHSYS.attachment_handler(ATCH,FALSE,user)
			user.put_in_hands(ATCH) //We remove the accessory picked from contents
			return
