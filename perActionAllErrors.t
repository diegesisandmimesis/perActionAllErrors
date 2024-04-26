#charset "us-ascii"
//
// perActionAllErrors.t
//
//	A TADS3/adv3 module allowing per-action failure messages for
//	commands involving "all".
//
//
// USAGE
//
//	To define custom failure messages on an action, use the following
//	properties:
//
//		allNotAllowedMsg	actor
//			Used if "all" is used with the action and the
//			action/game doesn't allow "all".
//
//		noMatchForAllMsg	actor
//			Used if "all" is used with the action and no matching
//			objects are in scope.
//
//		noMatchForAllButMsg	actor
//			Used if "all" with exceptions is used with the action
//			and no objects are left after the exceptions are
//			excluded.
//
//		uniqueObjectRequired	actor, txt, matchList
//			Used if the action only accepts a single object
//			and the noun phrase matches more than one (example:
//			>KICK WALLS will usually match the four default
//			walls).
//
//		singleObjectRequired	actor, txt
//			Used if the action only accepts a single object and
//			the noun phrase was a list (example: >KICK ME, FLOOR).
//
//	The value assigned to the property should be a property reference
//	for the actor's parser message object (playerMessages or npcMessages).
//	The message property should be a method that accepts the listed
//	arguments and outputs a double-quoted string.
//
//
// EXAMPLE:
//
//	To block >SMELL ALL with the message "You can only smell one thing
//	at a time" (instead of the stock "'All' cannot be used with that
//	verb."), use something like:
//
//		modify playerMessages
//			cantSmellAll(actor) {
//				"<.parser>{You/He} can only smell one thing
//				at a time.<./parser> ";
//			}
//		;
//
//		modify SmellAction
//			allNotAllowedMsg = &cantSmellAll
//		;
//
//
#include <adv3.h>
#include <en_us.h>

#include "perActionAllErrors.h"

// Module ID for the library
perActionAllErrorsModuleID: ModuleID {
        name = 'Per Action All Errors Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

modify Action
	allNotAllowedMsg = nil
	noMatchForAllMsg = nil
	noMatchForAllButMsg = nil
	uniqueObjectRequiredMsg = nil
	singleObjectRequiredMsg = nil
;
