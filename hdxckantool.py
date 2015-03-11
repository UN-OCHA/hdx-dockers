#!/usr/bin/python3

import sys
import os
import datetime
import subprocess
import psycopg2
import tarfile
import gzip
from shutil import rmtree

#import argparse
#from docopt import docopt

#
APP = "ckan"
#
BASEDIR = "/srv/ckan"
# for deployment (might employ tags - unsuitable for backup)
BRANCH = str(os.getenv('HDX_CKAN_BRANCH'))
# for backup
BACKUP_AS = os.getenv('HDX_TYPE')
# needed for paster and tests
INI_FILE = "/srv/prod.ini"
TS = ''

SQL = dict(
    SUPERUSER  = "ckan", HOST = "db", USER = "ckan", PASSWORD = "ckan", DB = "ckan",
    USER_DATASTORE = "datastore", DB_DATASTORE = "datastore",
    DB_TEST = "ckan_test", DB_DATASTORE_TEST = "datastore_test"
)

# to get the snapshot
RESTORE = dict(
    FROM = 'prod', 
    SERVER = 'backup.hdx.atman.ro', USER = 'hdx', DIR = '/srv/hdx/backup/prod',
    # SERVER = str(os.getenv('HDX_BACKUP_SERVER')), USER = str(os.getenv('HDX_BACKUP_USER')),
    TMP_DIR = "/tmp/ckan-restore",
)
RESTORE['DIR'] = str(os.getenv('HDX_BACKUP_BASE_DIR')) + '/' + RESTORE['FROM']
RESTORE['PREFIX']= RESTORE['FROM'] + '.' + APP
RESTORE['DB_PREFIX'] = RESTORE['PREFIX'] + '.db'
RESTORE['DB_PREFIX_MAIN'] = RESTORE['DB_PREFIX'] + '.' + SQL['DB']
RESTORE['DB_PREFIX_DATASTORE'] = RESTORE['DB_PREFIX'] + '.' +  SQL['DB_DATASTORE']
RESTORE['FILESTORE_PREFIX'] = RESTORE['PREFIX'] + '.filestore'

BACKUP = dict(
    AS = BACKUP_AS,
    DIR = '/srv/backup',
)
BACKUP['PREFIX'] = BACKUP['AS'] + '.' + APP
BACKUP['DB_PREFIX'] = BACKUP['PREFIX'] + '.db'
BACKUP['DB_PREFIX_MAIN'] = BACKUP['DB_PREFIX'] + '.' + SQL['DB']
BACKUP['DB_PREFIX_DATASTORE'] = BACKUP['DB_PREFIX'] + '.' +  SQL['DB_DATASTORE']
BACKUP['FILESTORE_PREFIX'] = BACKUP['PREFIX'] + '.filestore'

SUFFIX = datetime.datetime.now().strftime('%Y%m%d-%H%M%S')
TODAY = datetime.datetime.now().strftime('%Y%m%d')
CURRPATH = os.getcwd()


def show_usage():
    doc="""
    Usage:

        hdxckantool CMD [SUBCMD] [OPTIONS]

    Ckan ini file, if not added as last option, defaults to /srv/prod.ini

    Commands, subcommands and options: 
        backup [quiet]- backup ckan db, datastore db and filestore
        db
            clean     - empty the databases (ckan and datastore)
            set-perms - restore permissions on datastore side
            get       - get latest snapshot of the databases (ckan and datastore)
            restore   - overwrite db content from the latest snapshot of the databases
            WIP         restore   - overwrite db content from a snapshot
                [db1 db2] - restore on what local db? (default: ckan and datastore)
                [-u user] - restore using what user? (default: ckan)
        deploy        - just deploy
            test      - deploy then run tests
        filestore
           restore    - overwrite the filestore content from the latest filestore backup
              clean   - remove filestore content first
        less compile  - compiles less resource defined in prod.ini
        pgpass        - create the pgpass entry required to operate on postgres
        plugins       - reinstall plugins (in develop mode for now)
        reindex       - run solr reindex
            [fast]    - run a fast, multicore solr reindex
            [refresh] - only refresh index (do not remove index prior to reindexing)
        restart       - restart ckan service
        restore
            cleanup   - remove temporary folder used for restore
        start         - start ckan service
        stop          - stop ckan service
        sysadmin
            enable    - make a user sysadmin
            disable   - revoke a user's sysadmin privileges 
        test          - run nose tests with WARNING loglevel
            DEBUG     - run nose tests with DEBUG loglevel
            INFO      - run nose tests with INFO loglevel
            CRITICAL  - run nose tests with CRITICAL loglevel
        tracking      - update tracking summary
        user
            add       - add user
            delete    - remove user
            search    - search username list for pattern
            show      - show details for a user
            list      - list users
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
    line = ["sv", cmd, 'ckan']
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
    subcmds = ['clean', 'set-perms', 'get', 'restore']
    if subcmd not in subcmds:
        print(subcmd + ' not implemented yet. Exiting.')
        exit(1)
    elif subcmd == 'clean':
        print('Dropping and recreating databases!!!')
        if query_yes_no(' Are you sure?', 'no'):
            db_clean()
        else:
            print("Databases are still intact. :)")
            exit(0)
    elif subcmd == 'set-perms':
        db_set_perms()
    elif subcmd == 'get':
        db_get_last_backups()
    elif subcmd == 'restore':
        q = 'Are you sure you want to overwrite ckan databases? '
        if not query_yes_no(q, default='no'):
            print("Aborting restore operation.")
            exit(0)
        db_get_last_backups()
        # unzip the files
        control('stop')
        for file in os.listdir(RESTORE['TMP_DIR']):
            archive_full_path = os.path.join(RESTORE['TMP_DIR'], file)
            file_full_path = archive_full_path.replace('.gz', '')
            decompress_file(archive_full_path,file_full_path,True)
            if file.startswith(RESTORE['DB_PREFIX'] + '.' + SQL['DB']):
                # restore main db
                db_restore(file_full_path,SQL['DB'])
            elif file.startswith(RESTORE['DB_PREFIX'] + '.' + SQL['DB_DATASTORE']):
                # restore datastore db
                db_restore(file_full_path,SQL['DB_DATASTORE'])
                # restore permissions on datastore db
                db_set_perms()
            else:
                print("I don't know what to do with the file", file)
                print('Skipping...')
        control('start')
        # server = get_input('Backup server (hostname/IP)', False, RESTORE['SERVER'])
        # directory = get_input('Backup directory (no trailing slash)', False, RESTORE['DIR'])
        # user = get_input('Backup user', False, RESTORE['USER'])
        # main_prefix = get_input('Main db prefix', False, BACKUP['DB_PREFIX'] + '.' + SQL['DB'])
        # datastore_prefix = get_input('Datastore db prefix', False, BACKUP['DB_PREFIX'] + '.' + SQL['DB_DATASTORE'])
        # filestore_prefix = get_input('Filestore prefix', False, BACKUP_FILESTORE_PREFIX)
        # print('Current restore config:')
        # print('Backup server: ' + server)
        # print('Backup directory: ' + directory)
        # print('Backup user: ' + user)
        # print('Backup prefix for ckan db: ' + main_prefix)
        # print('Backup prefix for datastore db: ' + datastore_prefix)
        # # print 'Backup prefix for filestore archive: ' + filestore_prefix
        # if not query_yes_no('Is this ok?', default='yes'):
        #     print("Let's try again, shall we? Aborting...")
        #     exit(0)
        # backup = dict(server=server, directory=directory, user=user, ckandb=main_prefix, datastoredb=datastore_prefix)
        # q = 'Do you want to restore the latest available backup?'
        # if query_yes_no(q, default='yes'):
        #     print("This is the last backup:")
        #     db_list_backups(**backup)
        #     q = 'Do I proceed with the restore?'
        #     if query_yes_no(q, default='no'):
        #         db_restore()
        #     else:
        #         print("Aborting...")
        # else:
        #     while True:
        #         q = 'What is the date of the desired restore?(YYYYMMDD)'
        #         ts = get_input(q)
        #         if db_list_backups(ts=ts,**backup):
        #             break


    exit(0)

def db_clean(dbckan=SQL['DB'],dbdatastore=SQL['DB_DATASTORE']):
    for dbname in [dbckan, dbdatastore]:
        print('db_drop(' + dbname + ')')
        db_drop(dbname)
    db_set_perms()

def db_set_perms():
    con = db_connect_to_postgres(dbname=SQL['DB_DATASTORE'])
    cur = con.cursor()
    query_list=[
        'REVOKE CREATE ON SCHEMA public FROM PUBLIC;',
        'REVOKE USAGE ON SCHEMA public FROM PUBLIC;',
        'GRANT CREATE ON SCHEMA public TO ' + SQL['USER'] + ';',
        'GRANT USAGE ON SCHEMA public TO ' + SQL['USER'] + ';',
        'GRANT CREATE ON SCHEMA public TO ' + SQL['USER'] + ';',
        'GRANT USAGE ON SCHEMA public TO ' + SQL['USER'] + ';',
        'REVOKE CONNECT ON DATABASE ' + SQL['DB'] + ' FROM ' + SQL['USER_DATASTORE'] + ';',
        'GRANT CONNECT ON DATABASE ' + SQL['DB_DATASTORE'] + ' TO ' + SQL['USER_DATASTORE'] + ';',
        'GRANT USAGE ON SCHEMA public TO ' + SQL['USER_DATASTORE'] + ';',
        'GRANT SELECT ON ALL TABLES IN SCHEMA public TO ' + SQL['USER_DATASTORE'] +';',
        'ALTER DEFAULT PRIVILEGES FOR USER ' + SQL['USER'] + ' IN SCHEMA public GRANT SELECT ON TABLES TO ' + SQL['USER_DATASTORE'] + ';'
    ]
    try:
        print('restoring proper permissions on db', SQL['USER_DATASTORE'])
        for query in query_list:
            # print(query)
            cur.execute(query)
        con.commit()
    except:
        print("Failed to set proper permissions. Exiting.")
        exit (2)
    finally:
        con.close()

    print("Datastore permissions have been reset to default.")

def db_list_backups(listonly=True,ts=TODAY,server=RESTORE['SERVER'],directory=RESTORE['DIR'],user=RESTORE['USER'],ckandb=SQL['DB'],datastoredb=SQL['DB_DATASTORE']):
    print(server)
    print(directory)
    print(RESTORE['DB_PREFIX'])
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

def db_get_last_backups():
    list = db_list_backups().split('\n')
    list_db = []
    list_db_datastore = []
    for line in list:
        name = line.split()[4]
        # print(name)
        if name.startswith(RESTORE['DB_PREFIX'] + '.' + SQL['DB']):
            list_db.append(name)
        elif name.startswith(RESTORE['DB_PREFIX'] + '.' +  SQL['DB_DATASTORE']):
            list_db_datastore.append(name)
    # print(list_db)
    # print(list_db_datastore)
    backup = []
    ts = ''
    for db_name in list_db:
        # print(db_name)
        ts = db_name.split('.')[4]
        for db_datastore_name in list_db_datastore:
            # print(db_datastore_name)
            if db_datastore_name.endswith(ts + '.plsql.gz'):
                backup.append(db_name)
                backup.append(db_datastore_name)
                break
        else:
            continue
        break
    if len(backup) != 2:
        print("Can't figure out a pair of main ckan db and datastore db having the same timestamps. Aborting...")
        exit(0)        
    print('Trying to get for you the following backups:')
    print(backup[0])
    print(backup[1])
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    db_list_backups(False,ts)
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    print('Done. Backups are available in', RESTORE['TMP_DIR'])
    print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    global TS
    TS = ts

    # list = db_list_backups().split('\n')
    # backups = []
    # # I get only the newer two backups
    # for item in list:
    #     backups.append(item.split()[4])
    # backup1= backups.pop(0)
    # for backup in backups:
    #     if backup1.split('.')[4] == backup.split('.')[4]:
    #         print('Last two backups have different timestamps = not good. Aborting...')
    #         exit(0)
    # ts = backup1.split('.')[4]
    # print('Trying to get for you the following backups:')
    # print(backup1)
    # print(backup2)
    # print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    # db_list_backups(False,ts)
    # print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    # print('Done. Backups are available in', RESTORE['TMP_DIR'])
    # print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
    # global TS
    # TS = ts

def db_restore(filename='',db=''):
    if not filename or not db:
        print('No filename to restore from or no db found. Aborting...')
        exit(0)
    db_drop(db)
    db_create(db)
    print('Restoring database', db, 'from', filename)
    print('This may take a while...')
    cmd = [ 'pg_restore', '-vOx', '-h', SQL['HOST'], '-U', SQL['USER'], '-d', db, filename ]
    with open(os.devnull, 'wb') as devnull:
        subprocess.call(cmd, stdout=devnull, stderr=subprocess.STDOUT)

    # ts='latest'):
    # if ts == 'latest':
    #     ts = TODAY
    # server = get_input('Backup server (hostname/IP)', False)
    # if len(server) == 0:
    #     server = RESTORE['SERVER']
    # directory = get_input('Backup directory (no trailing slash)', False)
    # if len(directory) == 0:
    #     directory = '/srv/hdx/backup/prod'
    # user = get_input('Backup user', False)
    # if len(user) == 0:
    #     user = 'hdx'
    # line = ["rsync", '--list-only', user + '@' + server + ':' + directory + '/prod.ckan.db*' + ts + '*' ]
    # try:
    #     aha = subprocess.call(line)
    #     print(aha)
    # except:
    #     print(" failed.")
    #     exit(1)

    # print("in db restore")
    # print(ts)
    # exit(0)

def filestore_restore(ts=TODAY,server=RESTORE['SERVER'],directory=RESTORE['DIR'],user=RESTORE['USER'],clean=False):
    # print('This doesn\'t do anything right now...')
    # exit(0)
    line = ["rsync", "-a", "--progress", user + '@' + server + ':' + directory + '/' +  RESTORE['FILESTORE_PREFIX'] + '*' + ts + '*', RESTORE['TMP_DIR'] + '/']
    # if os.path.isdir(RESTORE['TMP_DIR']):
    #     for the_file in os.listdir(RESTORE['TMP_DIR']):
    #         file_path = os.path.join(RESTORE['TMP_DIR'], the_file)
    #         try:
    #             # if os.path.isfile(file_path):
    #             os.unlink(file_path)
    #         except Exception as e:
    #             print(e)
    #     #rmtree(RESTORE['TMP_DIR'])
    # else:
    os.makedirs(RESTORE['TMP_DIR'], exist_ok=True)
    print('Getting the filestore archive...')
    try:
        result = subprocess.call(line, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as exc:
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
        print("Can't find archive from", ts, "or can't connect.")
        print('The error encountered was:')
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
        print(str(exc.output.decode("utf-8").strip()))
        print('+++++++++++++++++++++++++++++++++++++++++++++++++++++')                                                                                                   
        # q = 'Would you like to get anothr backup?'
        # if not query_yes_no(q, default='no'):
        #     print("Aborting restore operation.")
        #     exit(0)
        print('try another timestamp')
        return False
    print('Done.')
    tfilename =  os.path.join(RESTORE['TMP_DIR'], os.listdir(RESTORE['TMP_DIR'])[0])
    if tarfile.is_tarfile(tfilename):
        if clean:
            filestore_dir = '/srv/filestore'
            for root, dirs, files in os.walk(filestore_dir, topdown=False):  
                for item in files:
                    try:
                        os.remove(os.path.join(root,item))
                    except Exception as e:
                        print(e)
                        print('error removing ' + item)
                if root != filestore_dir:
                    try:
                        os.rmdir(root)
                    except Exception as e:
                        print(e)
                        print('error removing ' + root)

                        # for the_file in os.listdir(filestore_dir):
            #     file_path = os.path.join(filestore_dir, the_file)
            #     try:
                    # if os.path.isfile(file_path):
                    # os.unlink(file_path)
                # except Exception as e:
                #     print(e)
            # rmtree('/srv/filestore')
            # os.makedirs('/srv/filestore', exist_ok=True)
            # exit(0)
        tfile = tarfile.open(tfilename, 'r:gz')
        print('Restoring filestore from ' + tfilename )
        print('It will take a while...')
        try:
            tfile.extractall('/srv')
        except:
            print('some error occured. bailing out...')
            exit(0)
    else:
        print(tfilename + ' is not a valid archive.')
        exit(0)
    print('Fixing permissions on filestore')
    for root, dirs, files in os.walk('/srv/filestore'):  
      for item in dirs:  
        os.chown(os.path.join(root, item), 33, 33)
        os.chmod(os.path.join(root, item), 1274)
      for item in files:
        os.chown(os.path.join(root, item), 33, 33)
        os.chmod(os.path.join(root, item), 1230)
    print('All done! Please do not forget to remove the archives in ' + RESTORE['TMP_DIR'])

def deploy():
    control('stop')
    print("changing dir to "+ BASEDIR)
    os.chdir(BASEDIR)
    #print('fetching branch or tag', BRANCH)
    #cmd_line = ['git', 'fetch', 'origin', BRANCH]
    print('fetching branches and tags')
    cmd_line = ['git', 'fetch']
    subprocess.call(cmd_line)
    print('hopping onto', BRANCH)
    cmd_line = ['git', 'checkout', BRANCH]
    subprocess.call(cmd_line)
    print("pulling latest changes of ", BRANCH)
    cmd_line = ['git', 'pull', 'origin', BRANCH]
    subprocess.call(cmd_line)
    print('done. starting', APP)
    control('start')
    if (len(opts) != 0) and (opts[0] == 'test'):
        tests()

def tests():
    db_test_refresh()
    os.chdir(BASEDIR)
    # get hdx plugin list
    dirs = sorted(os.listdir('.'))
    for dirname in dirs:
        if dirname.startswith('ckanext-hdx_'):
            print("++++++++++++++++++++++++++++++++++++++++++++++++++++")
            print("Running tests for plugin", dirname)
            tests_nose(dirname)

def backup(verbose=True):
    backup_db(SQL['DB'], BACKUP['DB_PREFIX'],verbose)
    backup_db(SQL['DB_DATASTORE'],BACKUP['DB_PREFIX'],verbose)
    backup_filestore(verbose)

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
        cmd = 'pg_dump -vFt -h db -U ckan -f ' + archive_name + ' ' + db
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

def backup_filestore(verbose=True):
    # backup filestore
    if not os.path.isdir(BACKUP['DIR']):
        print('Backup directory (' + BACKUP['DIR'] + ') does not exists.')
        exit(0)
    filestore_archive = BACKUP['DIR'] + '/' + BACKUP['FILESTORE_PREFIX'] + '.' + SUFFIX +'.tar'
    if verbose:
        sys.stdout.write('Archiving filestore under ' + filestore_archive + '\n')
        sys.stdout.flush()
    try:
        tar = tarfile.open(filestore_archive, 'w')
        tar.add('/srv/filestore', arcname='filestore')
    except IOError:
        sys.stdout.write('Filestore content changed while I was reading it... Please try again.\n')
        sys.stdout.flush()
        exit(0)
    else:
        tar.close()
        if verbose:
            sys.stdout.write('compressing ' + filestore_archive + '\n')
            sys.stdout.flush()
        if os.path.isfile(filestore_archive):
            # compress it
            compress_file(filestore_archive, remove=True)
        else:
            sys.stdout.write(filestore_archive + 'not found\n')
            sys.stdout.flush()
            exit(0)

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

def db_connect_to_postgres(host=SQL['HOST'], dbname='postgres', user=SQL['SUPERUSER']):
    try:
        con=psycopg2.connect(host=host, database=dbname, user=user)
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
    correct_line = SQL['HOST'] + ':5432:*:' + SQL['SUPERUSER'] + ':' + SQL['PASSWORD']
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

def reinstall_plugins():
    path = '/srv/ckan'
    cmd = ['python', 'setup.py']
    if len(opts) == 1:
        if opts.pop(0) in ['dev', 'develop']:
            cmd.append('develop')
    if len(cmd) == 2:
        cmd.append('install')
    for item in os.listdir(path):
        fullpath = os.path.join(path,item)
        if os.path.isdir(fullpath):
            if item.startswith('ckanext-'):
                print('Reinstalling plugin: ', item)
                if os.path.isfile(os.path.join(fullpath, 'setup.py')):
                    os.chdir(fullpath)
                    with open(os.devnull, 'wb') as devnull:
                        subprocess.call(cmd, stdout=devnull, stderr=subprocess.STDOUT)

def restore_cleanup():
    print('Cleaning up temporary directory used for restore (' + RESTORE['TMP_DIR'] + ')')
    if os.path.isdir(RESTORE['TMP_DIR']):
        rmtree(RESTORE['TMP_DIR'])
    print('Done.')

def solr_reindex():
    valid_subcommands = ['fast', 'refresh']
    cmd = ['paster', 'search-index']
    cmd_suffix = ['rebuild', '-c', INI_FILE]
    while len(valid_subcommands) > 0:
        if len(opts) > 0:
            subcmd = opts.pop(0)
        else:
            break
        if subcmd in valid_subcommands:
            if subcmd == 'fast':
                cmd_suffix.pop(0)
                cmd_suffix.insert(0, 'rebuild_fast')
            if subcmd == 'refresh':
                cmd.append('-r')
            valid_subcommands.remove(subcmd)
    cmd.extend(cmd_suffix)
    os.chdir(BASEDIR)
    subprocess.call(cmd)

def less_compile():
    cmd = ['paster', 'custom-less-compile', '-c', INI_FILE]
    os.chdir(BASEDIR)
    subprocess.call(cmd)

def sysadmin():
    if len(opts) == 0:
        exit(1)
    subcmd = opts.pop(0)
    subcmds = ['enable', 'disable', 'list']
    if subcmd not in subcmds:
        print(subcmd + ' not implemented yet. Exiting.')
        exit(1)
    if subcmd == 'list':
        sysadmins_list()
        exit(0)
    if len(opts) == 0:
        print('No user has been specified. Exiting.')
        exit(1)
    user = opts.pop(0)
    if not user_exists(user):
        print('User ' + user + ' has not been found.')
        exit(1)
    if subcmd == 'enable':
        sysadmin_enable(user)
    else:
        sysadmin_disable(user)

def sysadmin_enable(user):
    if is_sysadmin(user):
        print('User ' + user + ' is already sysadmin.')
        exit(0)
    cmd = ['paster', 'sysadmin', 'add', user, '-c', INI_FILE]
    os.chdir(BASEDIR)
    subprocess.call(cmd)
    exit(0)

def sysadmin_disable(user):
    if not is_sysadmin(user):
        print('User ' + user + ' is not sysadmin.')
        exit(0)
    cmd = ['paster', 'sysadmin', 'remove', user, '-c', INI_FILE]
    os.chdir(BASEDIR)
    subprocess.call(cmd)
    print('User ' + user + " has been (hopefully) made sysadmin (paster doesn't return anything useful)")
    exit(0)

def sysadmins_list():
    con = db_connect_to_postgres(dbname=SQL['DB'])
    con.set_isolation_level(0)
    cur = con.cursor()
    query = "select name,fullname,email,state,sysadmin from public.user where sysadmin='True' order by name asc;"
    try:
        cur.execute(query)
        con.commit()
        rows = cur.fetchall()
    except:
        print("I can't query that")
        exit(2)
    finally:
        con.close()

    user_pretty_list(rows)
    exit(0)

def is_sysadmin(user):
    con = db_connect_to_postgres(dbname=SQL['DB'])
    con.set_isolation_level(0)
    cur = con.cursor()
    query = "select sysadmin from public.user where name='" + user + "';"
    try:
        cur.execute(query)
        con.commit()
        rows = cur.fetchall()
    except:
        print("I can't query that")
        exit(2)
    finally:
        con.close()
    if len(rows) == 1:
        sysadmin = rows[0][0]
        if sysadmin:
            return True
    return False

def tracking_update():
    cmd = ['paster', 'tracking', 'update', '-c', INI_FILE]
    os.chdir(BASEDIR)
    subprocess.call(cmd)

def tests_nose(dirname):  
    plugin = dirname.replace('ckanext-', '')
    xunit_file = '--xunit-file=' + dirname + '/ckanext/' + plugin + '/tests/nose_results.xml'
    pylons = '--with-pylons=' + dirname + '/test.ini.sample'
    tests = dirname + '/ckanext/' + plugin + '/tests'
    #test_call = ['nosetests', '-ckan', '--with-xunit', xunit_file, '--nologcapture', pylons, tests]
    loglevel = 'WARNING'
    if len(opts) == 1:
        if opts.pop(0) in ['DEBUG', 'INFO', 'CRITICAL']:
            loglevel = opts.pop(0)
    test_call = ['nosetests', '-ckan', '--with-xunit', xunit_file, '--logging-level', loglevel, pylons, tests]
    os.chdir(BASEDIR)
    subprocess.call(test_call)

def users():
    if len(opts) == 0:
        exit(1)
    subcmd = opts.pop(0)
    subcmds = ['add', 'delete', 'list', 'search', 'show']
    if subcmd not in subcmds:
        print(subcmd + ' not implemented yet. Exiting.')
        exit(1)
    if subcmd == 'list':
        users_list()
        exit(0)
    if len(opts) == 0:
        print('No user has been specified. Exiting.')
        exit(1)
    user = opts.pop(0)
    if subcmd == 'add':
        if user_exists(user):
            print('User ' + user + ' already exists.')
        else:
            user_add(user)
    elif subcmd == 'delete':
        if not user_exists(user):
            print('User ' + user + ' has not been found.')
        else:
            user_delete(user)
    elif subcmd == 'show':
        if not user_exists(user):
            print('User ' + user + ' has not been found.')
        else:
            user_show(user)
    elif subcmd == 'search':
        user_search(user)
    exit(0)

def users_list():
    con = db_connect_to_postgres(dbname=SQL['DB'])
    con.set_isolation_level(0)
    cur = con.cursor()
    query = "select name,fullname,email,state,sysadmin from public.user order by name asc;"
    try:
        cur.execute(query)
        con.commit()
        rows = cur.fetchall()
    except:
        print("I can't query that")
        exit(2)
    finally:
        con.close()

    user_pretty_list(rows)

def user_show(user):
    con = db_connect_to_postgres(dbname=SQL['DB'])
    con.set_isolation_level(0)
    cur = con.cursor()
    query = "select name,fullname,email,state,sysadmin from public.user where name='" + user + "';"
    try:
        cur.execute(query)
        con.commit()
        rows = cur.fetchall()
    except:
        print("I can't query that")
        exit(2)
    finally:
        con.close()

    user_pretty_list(rows)

def user_search(user):
    con = db_connect_to_postgres(dbname=SQL['DB'])
    con.set_isolation_level(0)
    cur = con.cursor()
    query = "select name,fullname,email,state,sysadmin from public.user where name like '%" + user + "%';"
    try:
        cur.execute(query)
        con.commit()
        rows = cur.fetchall()
    except:
        print("I can't query that")
        exit(2)
    finally:
        con.close()
    if len(rows) == 0:
        print('No users were found searching for ' + user)
        exit(0)
    user_pretty_list(rows)

def user_add(user):
    email = get_input('Email')
    password = get_input('Password', lower=False)
    cmd = ['paster', 'user', 'add', user, 'email=' + email, 'password=' + password, '-c', INI_FILE]
    os.chdir(BASEDIR)
    with open(os.devnull, 'wb') as devnull:
        subprocess.call(cmd, stdout=devnull, stderr=subprocess.STDOUT)
    if user_exists(user):
        print('New user has been created:')
        user_show(user)
    else:
        print('I could not create the user ' + user)
    exit(0)

def user_delete(user):
    if is_sysadmin(user):
        sysadmin_disable(user)
    cmd = ['paster', 'user', 'remove', user, '-c', INI_FILE]
    os.chdir(BASEDIR)
    subprocess.call(cmd)

def user_pretty_list(userlist):
    for row in userlist:
        print('+++++++++++++++++++++++++++++++++++++++++++++++')
        (username, displayname, email, state, is_sysadmin) = row
        print('User: ' + str(username))
        print('Full Name: ' + str(displayname))
        print('Email: ' + str(email))
        print('State: ' + str(state))
        print('Sysadmin: ' + str(is_sysadmin))
    print('+++++++++++++++++++++++++++++++++++++++++++++++')
    if len(userlist) > 1:
        print('Got a total of ' + str(len(userlist)) + ' users.')

def user_exists(user):
    con = db_connect_to_postgres(dbname=SQL['DB'])
    con.set_isolation_level(0)
    cur = con.cursor()
    query = "select name,fullname,email,state,sysadmin from public.user where name='" + user + "';"
    try:
        cur.execute(query)
        con.commit()
        rows = cur.fetchall()
    except:
        print("I can't query that")
        exit(2)
    finally:
        con.close()

    if len(rows) == 1:
        return True
    else:
        return False

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
    elif cmd in no_subcommands_list:
        control(cmd)
    elif cmd == 'reindex':
        solr_reindex()
    elif cmd == 'filestore':
        if len(opts) and opts[0] == 'restore':
            if len(opts) > 1 and opts[1] == 'clean':
                filestore_restore(clean=True)
            else:
                filestore_restore()
    elif cmd == 'plugins':
        reinstall_plugins()
    elif cmd == 'restore':
        if len(opts) == 1 and opts[0] == 'cleanup':
            restore_cleanup()
        else:
            exit(1)
    elif cmd == 'less':
        if len(opts) == 1 and opts[0] == 'compile':
            less_compile()
        else:
            exit(1)
    elif cmd == 'sysadmin':
        sysadmin()
    elif cmd == 'test':
        tests()
    elif cmd == 'tracking':
        tracking_update()
    elif cmd == 'user':
        users()
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
