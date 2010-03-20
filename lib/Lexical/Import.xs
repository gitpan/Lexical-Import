#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

MODULE = Lexical::Import PACKAGE = Lexical::Import

bool
_glob_has_scalar(SV *gvref)
PREINIT:
	GV *gv;
CODE:
	/*
	 * This function works around the fact that *foo{SCALAR}
	 * autovivifies the scalar slot (perl bug #73666).
	 */
	if(!(SvROK(gvref) && (gv = (GV*)SvRV(gvref)) &&
			SvTYPE((SV*)gv) == SVt_PVGV))
		croak("_glob_has_scalar needs a glob ref");
	RETVAL = isGV_with_GP(gv) && GvSV(gv);
OUTPUT:
	RETVAL
