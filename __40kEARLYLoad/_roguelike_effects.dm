//Bitflag increments
//1 2 4 8 16 32 64 128 256 512 1024
//2048 4096 8192 16384 32768 65535
//131072 262144 524288 1048576 2097152 4194304 8388608

#define RE_ATTACK_SELF 1
#define RE_EQUIPPED 2
#define RE_FOUND 4
#define RE_ATTACK_USER 8
#define RE_ATTACK_TARGET 16
#define RE_ATTACK_HAND 32

var/list/roguelike_effects_triggers = list(
										RE_ATTACK_SELF,
										RE_EQUIPPED,
										RE_FOUND,
										RE_ATTACK_USER,
										RE_ATTACK_TARGET,
										RE_ATTACK_HAND
										)


var/list/roguelike_item_effects = list(
		/datum/roguelike_effects/blind,
		/datum/roguelike_effects/fake,
		/datum/roguelike_effects/eating,
		/datum/roguelike_effects/harm,
		/datum/roguelike_effects/heal,
		/datum/roguelike_effects/hulk,
		/datum/roguelike_effects/ignite,
		/datum/roguelike_effects/radiate,
		/datum/roguelike_effects/mindswap,
		/datum/roguelike_effects/ominous,
		/datum/roguelike_effects/petrify,
		/datum/roguelike_effects/possess,
		/datum/roguelike_effects/raise,
		/datum/roguelike_effects/telekinesis,
		/datum/roguelike_effects/teleportation
		)

var/list/roguelike_item_passives = list(
	/datum/roguelike_effects/passives/regen,
	/datum/roguelike_effects/passives/unstunabble
	)
	