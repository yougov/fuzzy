import setuptools

ext_modules = [
    setuptools.Extension('fuzzy', ['src/fuzzy.pyx', 'src/double_metaphone.c']),
]

params = dict(
    name='Fuzzy',
    use_scm_version=True,
    ext_modules=ext_modules,
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
    setup_requires=[
        'setuptools_scm',
        'cython',
    ],
)

if __name__ == '__main__':
    setuptools.setup(**params)
