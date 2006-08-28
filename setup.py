from setuptools import setup
from distutils.extension import Extension
from Pyrex.Distutils import build_ext

setup(
    name        = 'Polimetrix-Fuzzy',
    version     = '1.0',
    ext_modules = [Extension('fuzzy', ['src/fuzzy.pyx', 'src/double_metaphone.c'])],
    cmdclass    = {'build_ext' : build_ext}
)
