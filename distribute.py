#!/usr/bin/python

import os
import sys
import argparse

USER_FILES = os.listdir(os.path.expanduser('~/'))
CONF_FILES = os.listdir('./files/')

def cli():
    """
    initialize CLI interface
    """
    parser = argparse.ArgumentParser(description='Distribute your dot files.')
    parser.add_argument('-u', '--user', dest='distrib_user', action='store_true',
                        help='distribute conf files for this user')
    parser.add_argument('-r', '--root', dest='distrib_root', action='store_true',
                        help='distribute conf files for root user')

    args = parser.parse_args()

    return args, parser

def conf_file_conflicts(conf):
    if conf in USER_FILES:
        print 'won\'t sync "%s"' % conf
        return True
    else:
        return False

def link(path):
    conf_abs_path = os.path.join(os.getcwd(), 'files', path)
    system_abs_path = os.path.join(os.path.expanduser('~/'), path)
    os.symlink(conf_abs_path, system_abs_path)

def sync():
    for cf in CONF_FILES:
        if not conf_file_conflicts(cf):
           link(cf)

def application(conf):
    """ application logic """

    #if not conf.distrib_root and not conf.distrib_user:
    #    raise Exception('Specify at least one user to distribute configuration for.')

    sync()

def main():
    """ entry point, wrapper """

    conf, parser = cli()

    try:
        application(conf)
    except Exception as ex:
        parser.error('Error during execution: %s' % ex)


if __name__ == '__main__':
    main()

