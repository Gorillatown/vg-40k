#define IE_ATK_SELF "attack_self"
#define IE_EQP "equip"
#define IE_FOUND "found"
#define IE_ATK "attack"
#define IE_ATK_OTHER "attack_other"
#define IE_ATK_HAND "attack_hand"

var/global/list/item_artifact_triggers = list(
											IE_ATK_SELF,
											IE_EQP,
											IE_FOUND,
											IE_ATK,
											IE_ATK_OTHER,
											IE_ATK_HAND
											)

var/global/list/item_artifact_effects = list(
										/datum/item_artifact/undroppable,
										/datum/item_artifact/ignite,
										/datum/item_artifact/blind,
										/datum/item_artifact/heal,
										/datum/item_artifact/harm,
										/datum/item_artifact/stone,
										/datum/item_artifact/tele,
										/datum/item_artifact/eating,
										/datum/item_artifact/ominous,
										/datum/item_artifact/fake,
										/datum/item_artifact/hulk,
										/datum/item_artifact/tk,
										/datum/item_artifact/radiate,
										/datum/item_artifact/raise
										)

