//Bitflag increments
//1 2 4 8 16 32 64 128 256 512 1024
//2048 4096 8192 16384 32768 65535
//131072 262144 524288 1048576 2097152 4194304 8388608

#define RE_ATTACK_SELF "attack_self"
#define RE_EQUIPPED "equipped"
#define RE_FOUND "found"
#define RE_ATTACK_USER "attack_user"
#define RE_ATTACK_TARGET "attack_target"
#define RE_ATTACK_HAND "attack_hand"

var/list/roguelike_effects_triggers = list(
										RE_ATTACK_SELF,
										RE_EQUIPPED,
										RE_FOUND,
										RE_ATTACK_USER,
										RE_ATTACK_TARGET,
										RE_ATTACK_HAND
										)


var/list/roguelike_item_effects = list(
		/datum/roguelike_effects/curses/blind,
		/datum/roguelike_effects/curses/undroppable,
		/datum/roguelike_effects/curses/eating,
		/datum/roguelike_effects/curses/ignite,
		/datum/roguelike_effects/curses/petrify,
		/datum/roguelike_effects/fake,
		/datum/roguelike_effects/harm,
		/datum/roguelike_effects/heal,
		/datum/roguelike_effects/hulk,
		/datum/roguelike_effects/radiate,
		/datum/roguelike_effects/mindswap,
		/datum/roguelike_effects/ominous,
		/datum/roguelike_effects/possess,
		/datum/roguelike_effects/raise,
		/datum/roguelike_effects/telekinesis,
		/datum/roguelike_effects/teleportation,
		)

var/list/roguelike_item_passives = list(
	/datum/roguelike_effects/passives/regen,
	/datum/roguelike_effects/passives/unstunabble
	)
	