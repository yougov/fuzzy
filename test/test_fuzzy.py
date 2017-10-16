from __future__ import unicode_literals

import ctypes

import fuzzy


def test_soundex_does_not_mutate_strings():
	phrase = 'FancyFree'
	fuzzy.Soundex(4)(phrase)
	buffer = ctypes.c_char_p(phrase.encode())
	assert buffer.value.decode() == "FancyFree"


def test_DMetaphone():
	m = fuzzy.DMetaphone()
	assert m("mayer") == [b'MR', None]
