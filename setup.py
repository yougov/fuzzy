from distutils.core import setup
from distutils.extension import Extension
from Pyrex.Distutils import build_ext

setup(name='fuzzy',
	ext_modules=[
		Extension('fuzzy', ['src/fuzzy.pyx', 'src/double_metaphone.c']),
	],
	cmdclass = {'build_ext' : build_ext}
)
