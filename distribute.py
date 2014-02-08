#!/usr/bin/python
"""
Script for distribution of configuration from current git repo
"""
import os
import re
import os.path as osp
import sys
import argparse

REPO = os.path.dirname(os.path.abspath(__file__))

class RulesParser(object):
    def __init__(self):
        self.file_path = osp.join(REPO, 'rules.txt')
        self.file = open(self.file_path, 'r')

    def parse(self):
        """
        return list of custom copy rules:
            [('source', 'dest'), ...]
        """
        rules = []
        prefixes = []
        lines = self.file.readlines()
        for line in lines:
            if line and not re.match('^[\s#]+', line):
                sline = line.split('   ')
                rules.append(sline[1].strip())
                prefixes.append(sline[0].strip())
        return rules, prefixes

RULES, PREFIXES = RulesParser().parse()

def starts_with_l(string, prefixes):
    """ does at least one prefix matches string? """
    for prefix in prefixes:
        if string.startswith(prefix):
            return True
    return False

def get_all_files(path):
    """
    return all configuration files from this repo
    they can't match custom prefixes
    """
    response = []
    print "CONFIGURATION FILES:"
    for top, dirs, files in os.walk(path):
        for nm in files:
            conf = os.path.join(top, nm)
            pl = len(path)
            prefix = conf[pl+1:]
            if not starts_with_l(prefix, PREFIXES):
                response.append(prefix)
                print conf
    print
    return response

CONF_FILES = get_all_files(os.path.join(REPO, 'files'))

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
    if osp.exists(osp.join(osp.expanduser('~/'), conf)):
        print 'won\'t sync "%s"' % conf
        return True
    else:
        return False

def link(path):
    conf_abs_path = os.path.join(REPO, 'files', path)
    system_abs_path = os.path.join(os.path.expanduser('~/'), path)
    print "%s -> %s" % (system_abs_path, conf_abs_path)
    try:
        os.symlink(conf_abs_path, system_abs_path)
    except OSError:
        print 'Can\'t link files!'
        #raise Exception('Can\'t link files!')


def sync():
    for cf in CONF_FILES + RULES:
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

