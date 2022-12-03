RedsHouse2F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, RedsHouse2FTrainerHeaders
	ret

RedsHouse2FTrainerHeaders:
	def_trainers
RedsHouse2FTrainerHeader0:
	;trainer EVENT_BEAT_LORELEIS_ROOM_TRAINER_0, 0 LoreleiBeforeBattleText, LoreleiEndBattleText, LoreleiAfterBattleText
	trainer 1, 0, SgaBeforeBattleText, SgaEndBattleText, SgaAfterBattleText
RedsHouse2FTrainerHeader1:
	trainer 2, 1, MewBeforeBattleText, MewEndBattleText, MewEndBattleText
	db -1 ; end

RedsHouse2F_TextPointers:
	dw RedsHouse2FSoText
	dw RedsHouse2FSgaText
	dw RedsHouse2FMewText
	dw RedsHouse2FPokeText
	text_end ; unused

RedsHouse2FSoText:
	text_asm
	ld hl, SoGameText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	farcall SurfingPikachuMinigame
	jp TextScriptEnd
.done
	ld hl, SoWakeUpText
	call PrintText
	jp TextScriptEnd

SoGameText:
	text_far _SoGameText
	text_end

SoWakeUpText:
	text_far _SoWakeUpText
	text_end

RedsHouse2FSgaText:
	text_asm
	ld hl, SgaWakeUpText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .cancel
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB
	jr z, .NoParty
	ld hl, RedsHouse2FTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd
.NoParty
	ld hl, NoPartyText
	call PrintText
.cancel
	ld hl, SgaAfterBattleText
	call PrintText
	jp TextScriptEnd

SgaWakeUpText:
	text_far _SgaWakeUpText
	text_end

SgaBeforeBattleText:
	text_far _SgaBeforeBattleText
	text_end

SgaEndBattleText:
	text_far _SgaEndBattleText
	text_end

SgaAfterBattleText:
	text_far _SgaAfterBattleText
	text_end

NoPartyText:
	text_far _NoPartyText
	text_waitbutton
	text_end

RedsHouse2FMewText:
	text_asm
	CheckEvent EVENT_GOT_POKEDEX
	jr z, .NoParty
	ld hl, RedsHouse2FTrainerHeader1
	call TalkToTrainer
.NoParty
	ld hl, MewBeforeBattleText
	call PrintText
	jp TextScriptEnd

MewBeforeBattleText:
	text_far _MewBeforeBattleText
	text_end

MewEndBattleText:
	text_far _MewEndBattleText
	text_end

RedsHouse2FPokeText:
	text_asm
	ld hl, PokeText
	call PrintText
	CheckEvent EVENT_GOT_POKEDEX
	jr z, .cancel
	lb bc, MASTER_BALL, 5
	call GiveItem
	jr nc, .cancel
	;ld b, FLAG_SET
	;predef FlagActionPredef
	ld a, SFX_GET_ITEM_2
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	;jp TextScriptEnd
.cancel
	jp TextScriptEnd

PokeText:
	text_far _PokeText
	text_end