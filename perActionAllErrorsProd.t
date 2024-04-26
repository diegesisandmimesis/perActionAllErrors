#charset "us-ascii"
//
// perActionAllErrorsProd.t
//
//
#include <adv3.h>
#include <en_us.h>

#include "perActionAllErrors.h"

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

modify SingleNounProd
	resolveNouns(resolver, results) {
		local lst;

		results.beginSingleObjSlot();
		lst = np_.resolveNouns(resolver, results);

		results.endSingleObjSlot();

		if(lst.length() > 1)
			results.uniqueObjectRequired(getOrigText(), lst,
				resolver.action_);

		return(lst);
	}
;

modify EverythingButProd
	flagAllExcepted(resolver, results) {
		results.noMatchForAllBut(resolver.action_);
	}
;

modify SingleNounWithListProd
	resolveNouns(resolver, results) {
		results.singleObjectRequired(getOrigText(), resolver.action_);
		np_.resolveNouns(resolver, results);
		return([]);
	}
;
