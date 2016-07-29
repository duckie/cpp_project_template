# This file is here to ensure breathe support on read the docs

from distutils.core import setup

setup(
    name='C++ project template',
    version='0.1.1',
    author='Jean-Bernard Jansen',
    author_email='jeanbernard.jansen@gmail.com',
    packages=[],
    scripts=[],
    url='https://github.com/duckie/cpp_project_template',
    license='LICENSE.txt',
    description='A basic C++ project with all tooling to start a sane development',
    long_description='A basic C++ project with all tooling to start a sane development',
    install_requires=[
        "breathe",
    ],
)
