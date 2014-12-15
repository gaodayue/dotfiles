# default flags for c project
DEFAULT_C_FLAGS = [
'-Wall',
'--std',
'c99',
'-I',
'.'
]

def FlagsForFile( filename, **kwargs ):
    return {
        'flags': DEFAULT_C_FLAGS,
        'do_cache': True
    }
