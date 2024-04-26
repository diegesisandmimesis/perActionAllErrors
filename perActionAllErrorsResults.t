#charset "us-ascii"
//
// perActionAllErrorsResults.t
//
//
#include <adv3.h>
#include <en_us.h>

#include "perActionAllErrors.h"

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

	uniqueObjectRequired(txt, matchList, action?) {
		if(action && (action.propType(&uniqueObjectRequiredMsg) != TypeNil))
			throw new ParseFailureException(
				action.uniqueObjectRequiredMsg,
				txt.toLower().htmlify(), matchList);
		else
			inherited(txt, matchList);
	}

	singleObjectRequired(txt, action?) {
		if(action && (action.propType(&singleObjectRequiredMsg) != TypeNil))
			throw new ParseFailureException(
				action.singleObjectRequiredMsg,
				txt.toLower().htmlify());
		else
			inherited(txt);
	}
;

// Modify the subclasses to have the same usage for allNotAllowed().
modify TryAsActorResolveResults
	allNotAllowed(action?) { inherited(); }
	noMatchForAll(action?) { inherited(); }
	noMatchForAllBut(action?) { inherited(); }
	noMatchForListBut(action?) { inherited(); }
	uniqueObjectRequired(txt, matchList, action?)
		{ inherited(txt, matchList); }
	singleObjectRequired(txt, action?) { inherited(txt); }
;
modify CommandRanking
	allNotAllowed(action?) { inherited(); }
	noMatchForAll(action?) { inherited(); }
	noMatchForAllBut(action?) { inherited(); }
	noMatchForListBut(action?) { inherited(); }
	uniqueObjectRequired(txt, matchList, action?)
		{ inherited(txt, matchList); }
	singleObjectRequired(txt, action?) { inherited(txt); }
;

modify ActorResolveResults
	uniqueObjectRequired(txt, matchList, action?) {
		inherited(txt, matchList);
	}
	singleObjectRequired(txt, action?) { inherited(txt); }
;
