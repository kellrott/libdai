
import os
from distutils.core import setup, Extension

LIBDAI_PATH = "/usr/local"
if 'LIBDAI_PATH' in os.environ:
	LIBDAI_PATH = os.environ['LIBDAI_PATH']

setup(
    name='libdai',
    version="1.0",
    url = 'http://libdai.org',
    description = 'A Python wrapper for libDAI, a free/open source C++ library that provides implementations of various (approximate) inference methods for discrete graphical models.',
    ext_modules = [
        Extension(
			"_dai", 
			sources=["dai.i"], 
			libraries=["dai"], 
            library_dirs=[os.path.join(LIBDAI_PATH, 'lib')],
            runtime_library_dirs=[os.path.join(LIBDAI_PATH, 'lib')],
            swig_opts=['-c++', '-I%s' % os.path.join(LIBDAI_PATH, 'include')], 
            include_dirs=[os.path.join(LIBDAI_PATH, 'include')]
        )
    ],
    py_modules=['dai'],
)
