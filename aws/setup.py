from setuptools import setup

setup(
    name='aws',
    packages=['app'],
    include_package_data=True,
    install_requires=[
        'flask',
    ]
)
