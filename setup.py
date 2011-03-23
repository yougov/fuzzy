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
    description = "Fast Python phonetic algorithms",
    license     = "MIT",
    maintainer  = "chmullig",
    maintainer_email = "chmullig@gmail.com",
    url         = "https://bitbucket.org/yougov/fuzzy",
    classifiers = [
        'Development Status :: 4 - Beta',
        'License :: OSI Approved :: MIT License',
        'Operating System :: POSIX',
        'Programming Language :: Python :: 2.4',
        'Programming Language :: Python :: 2.5',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Topic :: Text Processing',
        'Topic :: Text Processing :: General',
        'Topic :: Text Processing :: Indexing',
        'Topic :: Text Processing :: Linguistic',
        ],
    long_description = open('README').read(),
    zip_safe    = False,
)
