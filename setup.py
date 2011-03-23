from setuptools import setup
from distutils.extension import Extension
try:
    from Pyrex.Distutils import build_ext
    use_pyrex = True
except ImportError:
    use_pyrex = False

cmdclass = {}
ext_modules = []

if use_pyrex:
    ext_modules = [Extension('fuzzy', ['src/fuzzy.pyx', 'src/double_metaphone.c'])]
    cmdclass.update({ 'build_ext': build_ext })
else:
    ext_modules = [Extension('fuzzy', ['src/fuzzy.c', 'src/double_metaphone.c'])]

setup(
    name        = 'Fuzzy',
    version     = '1.0',
    ext_modules = ext_modules,
    cmdclass    = cmdclass,
    zip_safe    = False
)
