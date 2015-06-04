import setuptools
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

setup_params = dict(
    name='Fuzzy',
    version='1.1',
    ext_modules=ext_modules,
    cmdclass=cmdclass,
    description="Fast Python phonetic algorithms",
    maintainer="YouGov, Plc.",
    maintainer_email="dev@yougov.com",
    url="https://bitbucket.org/yougov/fuzzy",
    classifiers=[
        'Development Status :: 4 - Beta',
        'License :: OSI Approved :: MIT License',
        'License :: OSI Approved :: Artistic License',
        'Operating System :: POSIX',
        'Programming Language :: Python :: 2.7',
        'Topic :: Text Processing',
        'Topic :: Text Processing :: General',
        'Topic :: Text Processing :: Indexing',
        'Topic :: Text Processing :: Linguistic',
    ],
    long_description=open('README').read(),
    zip_safe=False,
)

if __name__ == '__main__':
    setuptools.setup(**setup_params)
