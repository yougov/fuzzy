# cython: c_string_type=unicode, c_string_encoding=ascii

import re


cdef extern from "string.h":
    int strlen(char *s)


cdef extern from "ctype.h":
    int toupper(int c)


cdef extern from "stdlib.h":
    void * malloc(int i)
    void free(void * buf)


_nysiis_suffix_map = {
    'IX': 'IC',
    'EX': 'EC',
    'YE': 'Y',
    'EE': 'Y',
    'IE': 'Y',
    'DT': 'D',
    'RT': 'D',
    'RD': 'D',
    'NT': 'D',
    'ND': 'D'
}

_nysiis_transforms = {
    'AY':  'Y',
    'DG':  'G',
    'E':   'A',
    'EY':  'Y',
    'GHT': 'GT',
    'K':   'C',
    'KN':  'N',
    'I':   'A',
    'IY':  'Y',
    'O':   'A',
    'OY':  'Y',
    'PH':  'F',
    'SH':  'S',
    'SCH': 'S',
    'U':   'A',
    'UY':  'Y',
    'WR':  'R',
    'YW':  'Y'
}

_nysiis_trans_not_first = {
    'AH': 'A',
    'AW': 'A',
    'EH': 'A',
    'EV': 'AF',
    'EW': 'A',
    'HA': 'A',
    'HE': 'A',
    'HI': 'A',
    'HO': 'A',
    'HU': 'A',
    'IH': 'A',
    'IW': 'A',
    'M':  'N',
    'OH': 'A',
    'OW': 'A',
    'Q':  'G',
    'UH': 'A',
    'UW': 'A',
    'Z':  'S'
}

_nysiis_trans_middle = {
    'Y': 'A'
}

_non_AZ = re.compile('[^A-Z]')

def nysiis(s):
    cdef int i, start, stop
    cdef char *suffix
    cdef char *first

    # Normally we would strip out Roman numerals and name suffixes,
    # but we are not going to use this for person names.

    # Strip out anything non-alpha
    s = _non_AZ.sub('', s.upper())
    start, stop = 0, len(s)

    first = ''
    if stop:
        foo = s[0]
        first = foo


    # Find index without trailing SZs
    i = stop
    while i and s[i-1] in 'SZ':
        i = i - 1
    stop = i


    # Initial MAC -> MC, PF -> F
    if s[:3] == 'MAC':
        s = 'MC' + s[3:]
        stop = stop - 1
    elif s[:2] == 'PF':
        start = 1


    # Translate 2-character suffix elements
    suffix = ''
    while (stop - start) > 2:
        x = s[stop-2:stop]

        if x in _nysiis_suffix_map:
            y = _nysiis_suffix_map[x] + suffix
            suffix, stop = y, stop - 2
        else:
            break

    s = s[start:stop] + suffix


    # Build a list of adjacent components while performing transformations
    r = []
    i = start = 0
    stop = len(s)
    while i < stop:
        remain = stop-i # number of letters including this one

        app = ''

        for l in 3, 2, 1:
            if remain >= l:
                x = s[i:i+l]
                if x in _nysiis_transforms:
                    app = _nysiis_transforms[x]
                    break

                elif i > start:
                    if x in _nysiis_trans_not_first:
                        app = _nysiis_trans_not_first[x]
                        break

                    elif i < (stop-1) and x in _nysiis_trans_middle:
                        app = _nysiis_trans_middle[x]
                        break



        if app:
            r.extend(app)
            i = i + l
        else:
            r.append(s[i])
            i = i + 1
        #print i, s, app, l, r


    # Remove trailing vowels
    stop = len(r)
    while stop and r[stop-1] in 'AEIOU':
        stop = stop - 1

    # If first char of original string is a A vowel, use it
    if first in 'AEIOU':
        if r:
            r[0] = first
        else:
            r = [first]

    # Filter out repeated characters
    q, last = [], ''
    for x in r[:stop]:
        if x == last:
            continue

        q.append(x)
        last = x

    return ''.join(q)


cdef class Soundex:
    cdef int size
    cdef char *map

    def __init__(self, size):
        self.size = size
        self.map = "01230120022455012623010202"

    def __call__(self, s):
        cdef char *cs
        cdef int ls
        cdef int i
        cdef int written
        cdef char *out
        cdef char c

        written = 0

        out = <char *>malloc(self.size + 1)
        cs = s
        ls = strlen(cs)
        for i from 0<= i < ls:
            c = cs[i]
            if c >= 97 and c <= 122:
                c = c - 32
            if c >= 65 and c <= 90:
                if written == 0:
                    out[written] = c
                    written = written + 1
                elif self.map[c - 65] != 48 and (written == 1 or
                            out[written - 1] != self.map[c - 65]):
                    out[written] = self.map[c - 65]
                    written = written + 1
            if written == self.size:
                break
        for i from written <= i < self.size:
            out[i] = 48
        out[self.size] = 0

        pout = out
        free(out)

        return pout


cdef extern from "double_metaphone.h":
    void DoubleMetaphone(char *str, char **codes)


cdef class DMetaphone:
    cdef int size

    def __init__(self, size=0):
        self.size = size or 99999

    def __call__(self, s):
        cdef char *cs
        cdef char **out
        cdef bytes o1
        cdef bytes o2
        out = <char **>malloc(sizeof(char *) * 2)
        cs = s
        DoubleMetaphone(cs, out)
        o1 = out[0]
        o2 = out[1]
        if out[0] != NULL:
            free(out[0])
        if out[1] != NULL:
            free(out[1])

        free(out)

        if o1 == o2:
            o2 = None

        return [o1 and o1[:self.size] or None, o2 and o2[:self.size] or None]
