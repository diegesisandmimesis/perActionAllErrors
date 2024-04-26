#charset "us-ascii"
//
// sample.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the perActionAllErrors library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f makefile.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

#include "perActionAllErrors.h"

versionInfo: GameID;
gameMain: GameMainDef
	initialPlayerChar = me
	//allVerbsAllowAll = nil
	inlineCommand(cmd) { "<b>&gt;<<toString(cmd).toUpper()>></b>"; }
	printCommand(cmd) { "\n\t<<inlineCommand(cmd)>> "; }

	showIntro() {
		"Actions to try:\n ";
		"<<printCommand('take all')>> ";
		"<<printCommand('smell all')>> ";
		"<<printCommand('kick walls')>> ";
		"<<printCommand('kick me, floor')>> ";
		"<.p> ";
		"\nIn the room to the north (with the pebble): ";
		"<<printCommand('take all but pebble')>> ";
		"<.p> ";
	}
;

southRoom: Room 'South Room'
	"This is the south room.  There's another room north of here. "
	north = northRoom
;
+me: Person;

northRoom: Room 'North Room'
	"This is the north room.  The south room is, unsurprisingly, south
	of here. "
	south = southRoom
;
+pebble: Thing '(small) (round) pebble' 'pebble'
	"A small, round pebble. "
;

modify playerMessages
	cantSmellAll(actor) {
		"<.parser>{You/He} can only smell one thing at a
		time.<./parser> ";
	}
	nothingToTake(actor) {
		"<.parser>{You/He} can't indulge {your/his} kleptomaniacal
		tendencies at the moment because there's nothing to take. ";
	}
	nothingElseToTake(actor) {
		"<.parser>{You/He} {has} managed to talk {yourself} out
		of taking anything. ";
	}
	cantAttackMulti(actor, txt, matchList) {
		"<.parser>Belligerent as {you/he} {are}, {you/he} can still
		only attack one thing at a time.<./parser> ";
	}
	cantAttackList(actor, txt) {
		"<.parser>That's a list.  {You/He} can't attack a
		list!<./parser> ";
	}
;

modify SmellAction
	allNotAllowedMsg = &cantSmellAll
	actionAllowsAll = nil
;

modify TakeAction
	noMatchForAllMsg = &nothingToTake
	noMatchForAllButMsg = &nothingElseToTake
;

modify AttackAction
	uniqueObjectRequiredMsg = &cantAttackMulti
	singleObjectRequiredMsg = &cantAttackList
;
