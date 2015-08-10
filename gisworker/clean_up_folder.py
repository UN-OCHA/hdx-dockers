#!/usr/bin/python3
"""
This program will attempt to clean up a folder of files starting with
a specific pattern and being older than HOURS
2015 Serban Teodorescu <teodorescu.serban@gmail.com>
"""


import datetime
import os
import shutil

# path to seach for inode counts
PATH = '/tmp'
PREFIX = 'pre_'
# older than x hours
HOURS = 1
NOW = datetime.datetime.now()

MAXAGE_SECONDS = HOURS * 3600


def is_old_file(filename='filename'):
    """Removes from the folder PATH the files starting with PREFIX
    that are older than HOURS
    """
    file_full_path = os.path.join(PATH, filename)
    modified_time = datetime.datetime.fromtimestamp(os.path.getmtime(file_full_path))
    time_delta = NOW - modified_time
    if time_delta.total_seconds() > MAXAGE_SECONDS:
        return True
    return False


def matches_pattern(filename='filename'):
    if str(filename).startswith(PREFIX):
        return True
    return False


def cleaner():
    """Loop through PATH for older files"""
    cfiles = 0
    cfolders = 0
    for filename in os.listdir(PATH):
        if is_old_file(filename=filename) and matches_pattern(filename=filename):
            file_full_path = os.path.join(PATH, filename)
            if os.path.isfile(file_full_path):
                os.remove(file_full_path)
                cfiles += 1
            elif os.path.isdir(file_full_path):
                shutil.rmtree(file_full_path)
                cfolders += 1
    print('Cleaning', PATH, 'for files older than', HOURS, 'hours that begins with', PREFIX)
    if cfiles:
        print(cfiles, 'files have been removed.')
    else:
        print('No files have been removed.')
    if cfolders:
        print(cfolders, 'folders have been removed.')
    else:
        print('No folders have been removed.')


def main():
    global PATH
    if isinstance(os.getenv('HDX_GIS_TMP'), str):
        PATH=os.getenv('HDX_GIS_TMP')
    cleaner()

if __name__ == '__main__':
    main()
