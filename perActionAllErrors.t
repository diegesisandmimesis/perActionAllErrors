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
//		allNotAllowedMsg
//			Used if "all" is used with the action and the
//			action/game doesn't allow "all".
//
//		noMatchForAllMsg
//			Used if "all" is used with the action and no matching
//			objects are in scope.
//
//		noMatchForAllButMsg
//			Used if "all" with exceptions is used with the action
//			and no objects are left after the exceptions are
//			excluded.
//
//	The value assigned to the property should be a property reference
//	for the actor's parser message object (playerMessages or npcMessages).
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
;

modify EverythingProd
	resolveNouns(resolver, results) {
		local lst;

		if(!resolver.allowAll()) {
			results.allNotAllowed(resolver.action_);
			return([]);
		}
		lst = resolver.getAll(self);
		lst.forEach(function(o) {
			o.flags_ |= AlwaysAnnounce | MatchedAll;
		});
		if(lst.length == 0)
			results.noMatchForAll(resolver.action_);

		return(lst);
	}
;

modify EverythingButProd
	flagAllExcepted(resolver, results) {
		results.noMatchForAllBut(resolver.action_);
	}
;

modify BasicResolveResults
	allNotAllowed(action?) {
		if(action && (action.propType(&allNotAllowedMsg) != TypeNil))
			throw new ParseFailureException(
				action.allNotAllowedMsg);
		else
			inherited();
	}

	noMatchForAll(action?) {
		if(action && (action.propType(&noMatchForAllMsg) != TypeNil))
			throw new ParseFailureException(
				action.noMatchForAllMsg);
		else
			inherited();
	}

	noMatchForAllBut(action?) {
		if(action && (action.propType(&noMatchForAllButMsg) != TypeNil))
			throw new ParseFailureException(
				action.noMatchForAllButMsg);
		else
			inherited();
	}
;

// Modify the subclasses to have the same usage for allNotAllowed().
modify TryAsActorResolveResults
	allNotAllowed(action?) { inherited(); }
	noMatchForAll(action?) { inherited(); }
	noMatchForAllBut(action?) { inherited(); }
	noMatchForListBut(action?) { inherited(); }
;
modify CommandRanking
	allNotAllowed(action?) { inherited(); }
	noMatchForAll(action?) { inherited(); }
	noMatchForAllBut(action?) { inherited(); }
	noMatchForListBut(action?) { inherited(); }
;
