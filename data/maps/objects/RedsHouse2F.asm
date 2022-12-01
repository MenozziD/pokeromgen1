RedsHouse2F_Object:
	db $a ; border block

	def_warp_events
	warp_event  7,  1, REDS_HOUSE_1F, 3
IF DEF(_DEBUG)
	warp_event  7,  2, MT_MOON_B2F, 4
	warp_event  7,  3, ROCKET_HIDEOUT_ELEVATOR, 1
	warp_event  7,  4, POKEMON_TOWER_7F, 1
	warp_event  7,  5, SILPH_CO_11F, 4
	
ENDC

	def_bg_events

	def_object_events
	object_event  2,  6, SPRITE_MOM, STAY, UP, 1
	object_event  5,  7, SPRITE_BLUE, STAY, RIGHT, 2, OPP_YOUNGSTER, 13
	object_event  3,  1, SPRITE_MONSTER, WALK, ANY_DIR, 3, MEW, 3
	object_event  0,  5, SPRITE_POKE_BALL, STAY, NONE, 4

	def_warps_to REDS_HOUSE_2F
