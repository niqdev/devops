from setuptools import setup

setup(
    name='flask-boilerplate',
    version='0.1',
    packages=['application'],
    include_package_data=True,
    install_requires=[
        'flask',
    ],
    setup_requires=[
        'pytest-runner',
    ],
    tests_require=[
        'pytest',
    ],
)
