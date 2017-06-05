import ctypes

import fuzzy

def test_soundex_does_not_mutate_strings():
	phrase = 'FancyFree'
	fuzzy.Soundex(4)(phrase)
	buffer = ctypes.c_char_p(phrase)
	assert buffer.value == "FancyFree"
