//Role IDs. See: role_datums_defines.dm
//Fugmode shit
#define ORKRAIDER "Ork Raider"
#define IMPERIALGUARDSMEN "Imperial Guardsman"
#define PDF "Planetary Defense Force"
#define HARLEQUIN "Harlequin"
#define SLAANESH_CHAMPION "Slaanesh Champion"
#define TZEENTCH_CHAMPION "Tzeentch Champion"
#define NATIVEANIMAL "Native Animal"
#define ROGUE_PSYKER "Rogue Psyker"
//Ere we go again


//Storymode Shit
#define FREELOADA "Freeloada"
#define ORKMOBBOSS "Mob Boss"
/*
	Imperial Guard Children
							*/
#define IMPERIALGUARDGENERAL "Imperial Guard General"
#define IMPERIALGUARDSERGEANT "Imperial Guard Sergeant"
#define IMPERIALGUARDTROOPER "Imperial Guard Trooper"
#define IGPREACHER "Preacher"
#define IGPSYKER "Psyker"
#define IGCOMMISSAR "Commissar"
#define IGINQUISITOR "Inquisitor"
#define IGWEPSPECIALIST "Weapon Specialist"

/*
	Ork Children
					*/
#define ORK_WARBOSS "Ork Warboss"
#define ORK_NOB "Ork Nob"


//Faction IDs: See: role_datums_defines.dm
#define ORKS "Orks"
#define IMPERIALGUARD "Imperial Guard"
#define PLANETARYDEFFORCE "PlanetaryDefForce"
#define NATIVEANIMALS "NativeAnimals"
#define POI_MODE_CONTROLLER "Mode Scoreboard"

#define isgeneral(H) (H.mind && H.mind.GetRole(IMPERIALGUARDGENERAL))

#define iscommissar(H) (H.mind && H.mind.GetRole(IGCOMMISSAR))

#define isinquisitor(H) (H.mind && H.mind.GetRole(IGINQUISITOR))

#define iswarboss(H) (H.mind && H.mind.GetRole(ORK_WARBOSS))

#define isnob(H) (H.mind && H.mind.GetRole(ORK_NOB))