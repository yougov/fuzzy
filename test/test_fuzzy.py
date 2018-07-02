# coding: utf-8

from __future__ import unicode_literals

import pytest
import ctypes

import fuzzy


def test_soundex_does_not_mutate_strings():
	phrase = 'FancyFree'
	fuzzy.Soundex(4)(phrase)
	buffer = ctypes.c_char_p(phrase.encode())
	assert buffer.value.decode() == "FancyFree"


@pytest.mark.xfail(reason="issue #14")
def test_soundex_result():
	phrase = 'FancyFree'
	res = fuzzy.Soundex(4)(phrase)
	assert res == 'F521'


@pytest.mark.xfail(reason="issue #14")
def test_soundex_Test():
	assert fuzzy.Soundex(8)('Test') == 'T23'


@pytest.mark.xfail(reason="issue #14")
def test_soundex_non_ascii():
	assert fuzzy.Soundex(8)('Jéroboam') == 'J615'


def test_DMetaphone():
	m = fuzzy.DMetaphone()
	assert m("mayer") == [b'MR', None]
