#!/usr/bin/env python3

import sys, os

newroot = sys.argv[1]
dirs = sys.argv[2:]

def chmod(f, mode):
    if not os.path.islink(f):
        os.chmod(f, mode)

def isdir(f):
    return (not os.path.islink(f)) and os.path.isdir(f)

def remove(f):
    chmod(f, 0o777)
    if isdir(f):
        for ff in os.listdir(f):
            remove(f + '/' + ff)
        os.rmdir(f)
    else:
        os.unlink(f)

def exists(f):
    return os.path.islink(f) or os.path.exists(f)

def replace(new, old):
    mode = os.lstat(new).st_mode & 0o7777
    chmod(new, 0o777)
    if not exists(old):
        os.rename(new, old)
    elif isdir(old) and isdir(new):
        chmod(old, 0o777)
        new_files = list(os.listdir(new))
        old_files = list(os.listdir(old))
        for f in new_files:
            replace(new + '/' + f, old + '/' + f)
        new_files = set(new_files)
        for f in old_files:
            if f not in new_files:
                remove(old + '/' + f)
    else:
        chmod(old, 0o777)
        remove(old)
        os.rename(new, old)
    chmod(old, mode)

for d in dirs:
    replace(newroot + '/' + d, d)
