.. image:: https://img.shields.io/pypi/v/Fuzzy.svg
   :target: https://pypi.org/project/Fuzzy

.. image:: https://img.shields.io/pypi/pyversions/Fuzzy.svg

.. image:: https://img.shields.io/travis/yougov/fuzzy/master.svg
   :target: http://travis-ci.org/yougov/fuzzy


Fuzzy is a python library implementing common phonetic algorithms quickly.
Typically this is in string similarity exercises, but they're pretty versatile.

It uses C Extensions (via Cython) for speed.

The algorithms are:

* `Soundex <http://en.wikipedia.org/wiki/Soundex>`_
* `NYSIIS <http://en.wikipedia.org/wiki/NYSIIS>`_
* `Double Metaphone <http://en.wikipedia.org/wiki/Metaphone>`_ Based on Maurice
  Aubrey's C code from his perl implementation.

Usage
=====

The functions are quite easy to use!

>>> import fuzzy
>>> soundex = fuzzy.Soundex(4)
>>> soundex('fuzzy')
'F200'
>>> dmeta = fuzzy.DMetaphone()
>>> dmeta('fuzzy')
['FS', None]
>>> fuzzy.nysiis('fuzzy')
'FASY'

Performance
===========

Fuzzy's Double Metaphone was ~10 times faster than the pure python
implementation by  `Andrew Collins <http://www.atomodo.com/code/double-metaphone>`_
in some recent `testing <http://chmullig.com/2011/03/pypy-testing/>`_.
Soundex and NYSIIS should be similarly faster. Using iPython's timeit::

  In [3]: timeit soundex('fuzzy')
  1000000 loops, best of 3: 326 ns per loop

  In [4]: timeit dmeta('fuzzy')
  100000 loops, best of 3: 2.18 us per loop

  In [5]: timeit fuzzy.nysiis('fuzzy')
  100000 loops, best of 3: 13.7 us per loop


Distance Metrics
================

We recommend the `Python-Levenshtein <http://code.google.com/p/pylevenshtein/>`_
module for fast, C based string distance/similarity metrics. Among others
functions it includes:

 * `Levenshtein <http://en.wikipedia.org/wiki/Levenshtein_distance>`_ edit distance
 * `Jaro <http://en.wikipedia.org/wiki/Jaro_distance>`_ distance
 * `Jaro-Winkler <http://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance>`_ distance
 * `Hamming distance <http://en.wikipedia.org/wiki/Hamming_distance>`_

In testing it's been several times faster than comparable pure python
implementations of those algorithms.
