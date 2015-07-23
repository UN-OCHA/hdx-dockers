#!/usr/bin/python3

import sys
import os
import time
import datetime
import subprocess
import psycopg2
import gzip
from shutil import rmtree,copyfile

#import argparse
#from docopt import docopt

#
APP = 'cps'
#
SRCDIR = '/srv/deploy/cps'
TARGETDIR= SRCDIR + '/HDX-System'
TOMCATDIR = '/srv/tomcat'
APPDIR = TOMCATDIR + '/webapps'
# for deployment (might employ tags - unsuitable for backup)
BRANCH = os.getenv('HDX_CPS_BRANCH')
# for backup
BACKUP_AS = os.getenv('HDX_TYPE')
TS = ''

SQL = dict(
    SUPERUSER  = "cps", HOST = str(os.getenv('HDX_CPSDB_ADDR')), PORT = str(os.getenv('HDX_CPSDB_PORT')), USER = str(os.getenv('HDX_CPSDB_USER')), PASSWORD = str(os.getenv('HDX_CPSDB_PASS')), DB = str(os.getenv('HDX_CPSDB_DB'))
)

# to get the snapshot
RESTORE = dict(
    FROM = 'prod', 
    SERVER = os.getenv('HDX_BACKUP_SERVER'), USER = os.getenv('HDX_BACKUP_USER'), DIR = os.getenv('HDX_BACKUP_BASE_DIR'),
    TMP_DIR = "/tmp/cps-restore",
)
RESTORE['DIR'] = os.getenv('HDX_BACKUP_BASE_DIR') + '/' + RESTORE['FROM']
RESTORE['PREFIX']= RESTORE['FROM'] + '.' + APP
RESTORE['DB_PREFIX'] = RESTORE['PREFIX'] + '.db'
RESTORE['DB_PREFIX_MAIN'] = RESTORE['DB_PREFIX'] + '.' + SQL['DB']

BACKUP = dict(
    AS = BACKUP_AS,
    DIR = '/srv/backup',
)
BACKUP['PREFIX'] = BACKUP['AS'] + '.' + APP
BACKUP['DB_PREFIX'] = BACKUP['PREFIX'] + '.db'
BACKUP['DB_PREFIX_MAIN'] = BACKUP['DB_PREFIX'] + '.' + SQL['DB']

SUFFIX = datetime.datetime.now().strftime('%Y%m%d-%H%M%S')
TODAY = datetime.datetime.now().strftime('%Y%m%d')
CURRPATH = os.getcwd()


def show_usage():
    doc="""
    Usage:

        hdxcpstool CMD [SUBCMD] [OPTIONS]

    Commands, subcommands and options: 
        backup [quiet]- backup cps db, datastore db and filestore
        db
            clean     - empty the database
            get       - get latest snapshot of the database
            restore   - overwrite db content from the latest snapshot of the database
        deploy        - deploy the branch configured as BRANCH
            WIP [tags/tag]- deploy a certain tag
            WIP [branch]  - deploy a certain branch
        pgpass        - create the pgpass entry required to operate on postgres
        restart       - restart ckan service
        restore
            cleanup   - remove temporary folder used for restore
        start         - start ckan service
        stop          - stop ckan service
    """
    print(doc)

def query_yes_no(question, default="yes"):
    """Ask a yes/no question via raw_input() and return their answer.

    "question" is a string that is presented to the user.
    "default" is the presumed answer if the user just hits <Enter>.
        It must be "yes" (the default), "no" or None (meaning
        an answer is required of the user).

    The "answer" return value is True for "yes" or False for "no".
    """
    valid = {"yes": True, "y": True, "ye": True,
             "no": False, "n": False}
    if default is None:
        prompt = " [y/n] "
    elif default == "yes":
        prompt = " [Y/n] "
    elif default == "no":
        prompt = " [y/N] "
    else:
        raise ValueError("invalid default answer: '%s'" % default)

    while True:
        sys.stdout.write(question + prompt)
        choice = input().lower()
        if default is not None and choice == '':
            return valid[default]
        elif choice in valid:
            return valid[choice]
        else:
            sys.stdout.write("Please respond with 'yes' or 'no' "
                             "(or 'y' or 'n').\n")

def get_input(text='what?', lower=True, empty=''):
    sys.stdout.flush()
    if lower:
        text = text + ' (case insensitive)'
    if empty:
        text = text + ' [' + empty +']'
    sys.stdout.write(text + ': ')
    result = input().strip()
    if lower:
        result = result.lower()
    if len(result) == 0:
        result = empty
    return result

def control(cmd):
    line = ["sv", cmd, APP]
    try:
        subprocess.call(line)
    except:
        print(cmd + " failed.")
        exit(1)

def db():
    # db
    #  clean
    #  get snapshot
    #  overwrite from snapshot
    # print opts
    if len(opts) == 0:
        exit(1)
    subcmd = opts.pop(0)
    subcmds = ['clean', 'get', 'restore']
    if subcmd not in subcmds:
        print(subcmd + ' not implemented yet. Exiting.')
        exit(1)
    elif subcmd == 'clean':
        print('Dropping and recreating the database!!!')
        if query_yes_no(' Are you sure?', 'no'):
            db_clean()
        else:
            print("Database is still intact. :)")
            exit(0)
    elif subcmd == 'get':
        db_get_last_backup()
    elif subcmd == 'restore':
        q = 'Are you sure you want to overwrite cps databases? '
        if not query_yes_no(q, default='no'):
            print("Aborting restore operation.")
            exit(0)
        db_get_last_backup()
        # unzip the files
        control('stop')
        for file in os.listdir(RESTORE['TMP_DIR']):
            archive_full_path = os.path.join(RESTORE['TMP_DIR'], file)
            file_full_path = archive_full_path.replace('.gz', '')
            decompress_file(archive_full_path,file_full_path,True)
            if file.startswith(RESTORE['DB_PREFIX'] + '.' + SQL['DB']):
                # restore main db
                db_restore(file_full_path,SQL['DB'])
            else:
                print("I don't know what to do with the file", file)
                print('Skipping...')
        control('start')
    exit(0)

def db_clean(dbcps=SQL['DB']):
    db_drop(dbcps)
    db_create(dbcps)

def db_list_backups(listonly=True,ts=TODAY,server=RESTORE['SERVER'],directory=RESTORE['DIR'],user=RESTORE['USER'],cpsdb=SQL['DB']):
    if listonly:
        line = ["rsync", '--list-only', user + '@' + server + ':' + directory + '/' + RESTORE['DB_PREFIX'] + '*' + ts + '*' ]
    else:
        line = ["rsync", "-a", "--progress", user + '@' + server + ':' + directory + '/' + RESTORE['DB_PREFIX'] + '*' + ts + '*', RESTORE['TMP_DIR'] + '/']
        # empty the temp dir first.
        if os.path.isdir(RESTORE['TMP_DIR']):
            rmtree(RESTORE['TMP_DIR'])
        os.makedirs(RESTORE['TMP_DIR'], exist_ok=True)
    # print(str(line))
    try:
        if listonly:
            result = subprocess.check_output(line, stderr=subprocess.STDOUT)
        else:
            result = subprocess.call(line, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as exc:
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
        print("Can't find archives from", ts, "or can't connect.")
        print('The error encountered was:')
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
        print(str(exc.output.decode("utf-8").strip()))
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
        q = 'Would you like to search again?'
        if not query_yes_no(q, default='no'):
            print("Aborting restore operation.")
            exit(0)
        return False
    if listonly:
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
        print('Listing backups found:')
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
        result = result.decode("utf-8").rstrip('\n\n')
        print(("Output: \n{}\n".format(result)))
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    return result

def db_get_last_backup():
    list = db_list_backups().split('\n')
    list_db = []
    backup = []
    for line in list:
        print(line)
        name = line.split()[4]
        if name.startswith(RESTORE['DB_PREFIX'] + '.' + SQL['DB']):
            backup.append(name)
    ts = ''
    if len(backup) != 1:
        print("Error. Aborting...")
        exit(0)        
    print('Trying to get for you the following backup:')
    print(backup[0])
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    db_list_backups(False)
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    print('Done. Backup is available in', RESTORE['TMP_DIR'])
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    global TS
    TS = ts

def db_restore(filename='',db=''):
    if not filename or not db:
        print('No filename to restore from or no db found. Aborting...')
        exit(0)
    db_drop(db)
    db_create(db)
    print('Restoring database', db, 'from', filename)
    print('This may take a while...')
    cmd = [ 'pg_restore', '-vOx', '-h', SQL['HOST'], '-p', SQL['PORT'], '-U', SQL['USER'], '-d', db, filename ]
    with open(os.devnull, 'wb') as devnull:
        subprocess.call(cmd, stdout=devnull, stderr=subprocess.STDOUT)

def deploy():
    # get tag/branch
    print("changing dir to "+ SRCDIR)
    os.chdir(SRCDIR)
    print('fetching branch or tag', BRANCH)
    cmd_line = ['git', 'fetch']
    #cmd_line = ['git', 'fetch', 'origin', BRANCH]
    subprocess.call(cmd_line)
    print('hopping onto', BRANCH)
    cmd_line = ['git', 'checkout', BRANCH]
    subprocess.call(cmd_line)
    print("pulling latest changes of ", BRANCH)
    cmd_line = ['git', 'pull', 'origin', BRANCH]
    subprocess.call(cmd_line)
    os.chdir(TARGETDIR)
    print('cleaning', BRANCH)
    cmd_line = ['mvn', 'clean']
    subprocess.call(cmd_line)
    print('compiling', BRANCH)
    cmd_line = ['mvn', 'install', '-Dmaven.test.skip=true']
    subprocess.call(cmd_line)
    if query_yes_no('Deploying ' + BRANCH + '. Are you sure?', 'no'):
        # stop tomcat
        print('stopping', APP)
        control('stop')
        applist = ['ROOT', 'ROOT.war', 'hdx', 'hdx.war', 'cps', 'cps.war']
        for item in applist:
            item = APPDIR + '/' + item
            if os.path.isdir(item):
                rmtree(item)
            if os.path.isfile(item):
                os.remove(item)
        copyfile(TARGETDIR + '/target/hdx.war', APPDIR + '/ROOT.war')
        # start tomcat
        print('done. starting', APP)
        control('start')

def backup(verbose=True):
    backup_db(SQL['DB'], BACKUP['DB_PREFIX'],verbose)

def backup_db(db='', prefix='',verbose=True):
    if not db or not prefix:
        print('backup_db called with empty archive or prefix')
        exit(0)
    # backup main db
    if not os.path.isdir(BACKUP['DIR']):
        print('Backup directory (' + BACKUP['DIR'] + ') does not exists.')
        exit(0)
    archive_name = BACKUP['DIR'] + '/' + prefix + '.' + db + '.' + SUFFIX + '.plsql'
    if verbose:
        sys.stdout.write('Archiving ' + db + ' db under ' + archive_name + '.gz\n')
    sys.stdout.flush()
    try:
        cmd = 'pg_dump -vFt -h ' + SQL['HOST'] + ' -p ' + SQL['PORT'] + ' -U ' + SQL['USER'] + ' -f  ' + archive_name + ' ' + db
        # print(cmd)
        with open(os.devnull, 'wb') as devnull:
            subprocess.call(cmd.split(), stdout=devnull, stderr=subprocess.STDOUT)
    except IOError:
        sys.stdout.write('Error on ' + db + ' db backup... Please try again.\n')
        sys.stdout.flush()
    else:
        if os.path.isfile(archive_name):
            # compress it
            if verbose:
                sys.stdout.write('compressing ' + archive_name + '\n')
                sys.stdout.flush()
            compress_file(archive_name, remove=True)
        else:
            sys.stdout.write(archive_name + ' not found\n')
            sys.stdout.flush()

def decompress_file(f_in='', f_out='',remove=False):
    if not f_in:
        return False
    if not f_out:
        f_out = f_in.replace('.gz', '', 1)
    try:
        with gzip.open(f_in, 'rb') as file_in:
            with open(f_out, 'wb') as file_out:
                file_out.writelines(file_in)        
    except IOError:
        sys.stdout.write('Error compressing ' + f_in + ' ... Please try again.\n')
        sys.stdout.flush()
    else:
        if remove:
            # print(f_in)
            os.remove(f_in)

def compress_file(f_in='', f_out='',remove=False):
    if not f_in:
        return False
    if not f_out:
        f_out = f_in + '.gz'
    try:
        with open(f_in, 'rb') as file_in:
            with gzip.open(f_out, 'wb') as file_out:
                file_out.writelines(file_in)        
    except IOError:
        sys.stdout.write('Error compressing ' + f_in + ' ... Please try again.\n')
        sys.stdout.flush()
    else:
        if remove:
            # print(f_in)
            os.remove(f_in)

def db_test_refresh():
    for dbname in [SQL['DB_TEST'], SQL['DB_DATASTORE_TEST']]:
        db_drop(dbname)
        db_create(dbname)

def db_connect_to_postgres(host=SQL['HOST'], port=SQL['PORT'], dbname='postgres', user=SQL['SUPERUSER']):
    try:
        con=psycopg2.connect(host=host, port=port, database=dbname, user=user)
    except:
        print("I am unable to connect to the database, exiting.")
        exit(2) 
    return con

def db_drop(dbname):
    con = db_connect_to_postgres()
    con.set_isolation_level(0)
    cur = con.cursor()
    drop_db = 'DROP DATABASE IF EXISTS ' + dbname
    # print(drop_db)
    try:
        cur.execute(drop_db)
        print('Database ' + dbname + ' has been dropped.')
    except:
        print("I can't drop database " + dbname)
    finally:
        con.close()

def db_create(dbname, owner=SQL['USER']):
    # list databases
    # SELECT datname FROM pg_database
    # WHERE datistemplate = false;
    con = db_connect_to_postgres()
    con.set_isolation_level(0)
    cur = con.cursor()
    create_db = 'CREATE DATABASE ' + dbname + ' OWNER ' + owner
    options = " ENCODING 'UTF-8' LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8'"
    # print(create_db + options)
    try:
        cur.execute(create_db + options)
        print('Database ' + dbname + ' has been created.')
    except:
        print("I can't create database " + dbname)
        exit(2)
    finally:
        con.close()

def refresh_pgpass():
    pgpass = '/root/.pgpass'
    pgpass_line = ''
    write = False
    correct_line = SQL['HOST'] + ':' + SQL['PORT'] + ':*:' + SQL['SUPERUSER'] + ':' + SQL['PASSWORD']
    # does it exists?
    if os.path.isfile(pgpass):
        with open(pgpass, 'r') as f:
            # get only the first line
            pgpass_line = f.readline().strip()
        # print pgpass_line
        # print correct_line
        if pgpass_line != correct_line:
            print("The pgpass file will be overwritten with:")
            print(correct_line)
            write = True
        else:
            print("The pgpass file has the right content.")
    else:
        write = True

    if write:
        with open(pgpass, 'w') as f:
            f.write(correct_line + '\n')
            print("File overwritten.")
    # change permissions if needed
    if oct(os.stat(pgpass).st_mode)[-3:] != '600':
        os.chmod(pgpass, 0o600)
        print('Permissions were incorrect. Fixed.')
    print('Done.')

def restore_cleanup():
    print('Cleaning up temporary directory used for restore (' + RESTORE['TMP_DIR'] + ')')
    if os.path.isdir(RESTORE['TMP_DIR']):
        rmtree(RESTORE['TMP_DIR'])
    print('Done.')

def exit(code=0):
    if code == 1:
        show_usage()
    os.chdir(CURRPATH)
    sys.exit(code)

def main():
    cmd = opts.pop(0)
    no_subcommands_list = ['restart', 'start', 'status', 'stop']
    if cmd == 'db':
        db()
    elif cmd == 'deploy':
        deploy()
    elif cmd == 'pgpass':
        refresh_pgpass()
    elif cmd == 'backup':
        if len(opts) and opts[0] == 'quiet':
                backup(verbose=False)
        else:
            backup()
    elif cmd == 'restore':
        if len(opts) == 1 and opts[0] == 'cleanup':
            restore_cleanup()
        else:
            exit(1)
    elif cmd in no_subcommands_list:
        if cmd == 'restart':
            control('stop')
            print('Waiting 10 seconds for tomcat to die...')
            time.sleep(10)
            control('start')
        else:
            control(cmd)
    elif cmd == 'bz':
        print('bzzz')
    else:
        exit(1)

if __name__ == '__main__':
    opts=sys.argv
    script=opts.pop(0)
    if len(opts) == 0:
        exit(1)
    main()
