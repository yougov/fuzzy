/*
	double_metaphone is based on the perl Metaphone module developed
	by Maurice Aubrey and licensed thus:

--------------------------------------------------------------------------------
DESCRIPTION

  This module implements a "sounds like" algorithm developed
  by Lawrence Philips which he published in the June, 2000 issue
  of C/C++ Users Journal.  Double Metaphone is an improved
  version of Philips' original Metaphone algorithm.

COPYRIGHT

  Copyright 2000, Maurice Aubrey <maurice@hevanet.com>.
  All rights reserved.

  This code is based heavily on the C++ implementation by
  Lawrence Philips and incorporates several bug fixes courtesy
  of Kevin Atkinson <kevina@users.sourceforge.net>.

  This module is free software; you may redistribute it and/or
  modify it under the same terms as Perl itself.

--------------------------------------------------------------------------------

*/

#ifndef DOUBLE_METAPHONE__H
#define DOUBLE_METAPHONE__H


typedef struct
{
    char *str;
    int length;
    int bufsize;
    int free_string_on_destroy;
}
metastring;


void
DoubleMetaphone(char *str,
                char **codes);


#endif /* DOUBLE_METAPHONE__H */
