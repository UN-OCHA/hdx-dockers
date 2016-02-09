#!/usr/bin/python
"""make it easier to switch upstream."""

import os
import subprocess
import sys

# change according to your needs
UPSTREAMS = {'blue': '10.5.101.24', 'green': '10.5.102.24'}
CFG = '/etc/nginx/conf.d/upstreams.conf'


class UpstreamSwitcher(object):
    """provide tools to swith upstreams."""

    def __init__(self, cfg, upstreams):
        """initializer."""
        self.cfg = cfg
        self.upstreams = upstreams
        self.blue = self.upstreams['blue']
        self.green = self.upstreams['green']
        with open(self.cfg) as f:
            self.content = f.read()

    @property
    def current_upstream(self):
        """figure the current upstream."""
        if self.blue not in self.content:
            if self.green in self.content:
                return 'green'
        if self.green not in self.content:
            if self.blue in self.content:
                return 'blue'

    @property
    def next_upstream(self):
        """figure out the next upstream."""
        if self.current_upstream == 'blue':
            return 'green'
        if self.current_upstream == 'green':
            return 'blue'

    def switch_upstream(self):
        """switch the upstream."""
        content = self.content.replace(self.upstreams[self.current_upstream],
                                       self.upstreams[self.next_upstream])
        with open(self.cfg, 'w') as f:
            f.write(content)

    def setup(self):
        """define the blue and green."""
        q = 'Define the %s (%s): '
        new_blue = raw_input(q % ('blue color', self.upstreams['blue']))
        new_green = raw_input(q % ('green color', self.upstreams['green']))
        new_cfg = raw_input(q % ('configuration file', self.cfg))
        err = '%s has invalid length. reverting to last value.'
        if len(new_blue) < 2:
            print err % 'blue'
            new_blue = self.blue
        if len(new_green) < 2:
            print err % 'green'
            new_green = self.green
        if len(new_cfg) < 2:
            print err % 'configuration file'
            new_cfg = self.cfg
        if new_blue == self.blue and new_green == self.green:
            if new_cfg == self.cfg:
                print 'Nothing to change. Exiting.'
                sys.exit(1)
        else:
            me = os.path.abspath(__file__)
            me_content = []
            new_upstreams_line = ''.join(["UPSTREAMS = {'blue': '", new_blue,
                                          "', 'green': '", new_green, "'}\n"])
            new_cfg_line = ''.join(["CFG = '", self.cfg, "'\n"])
            with open(me) as f:
                for line in f:
                    if line.startswith('UPSTREAMS = '):
                        line = new_upstreams_line
                    if line.startswith('CFG = '):
                        line = new_cfg_line
                    me_content.append(line)
            with open(me, 'w') as f:
                f.write(''.join(me_content))

    def flip(self):
        """perform the actual switch."""
        if not self.current_upstream:
            print '\nUnknown configuration.'
            print "You forgot to manually choose the colors' values?"
            print 'Exiting.\n'
            sys.exit(1)

        msg = '\nSwitching from %s (%s) to %s (%s)\n'
        print msg % (self.current_upstream,
                     self.upstreams[self.current_upstream],
                     self.next_upstream,
                     self.upstreams[self.next_upstream])
        self.switch_upstream()
        subprocess.call(['nginx', '-t'])
        ok_msgs = ('syntax is ok', 'test is successful')
        print '\nAssuming you got "%s" and "%s" above, just type:' % ok_msgs
        print '\n\tnginx -s reload\n'

    def show_usage(self):
        """print out the usage."""
        print '\nUsage:'
        print '\tflip: switch the active color'
        print '\tsetup: configure blue and green addresses'
        print '\tshow: show current configuration\n'

    def show_current_state(self):
        """show current state."""
        print '\nWarning! I cannot tell you what nginx does now.'
        print 'I can only show you nginx config and my config.'

        if self.current_upstream:
            current_ip = self.upstreams[self.current_upstream]
            current_color = self.current_upstream
            print '\nConfigured on: %s (%s)' % (current_ip, current_color)
            print '\t blue:', self.blue
            print '\tgreen:', self.green, '\n'
        else:
            print 'Configuration file does not have infos about blue or green.'
            print 'You need to manually setup that first.'

if __name__ == '__main__':
    opts = sys.argv
    opts.pop(0)
    sw = UpstreamSwitcher(CFG, UPSTREAMS)
    if len(opts):
        if opts[0] == 'flip':
            sw.flip()
        elif opts[0] == 'setup':
            sw.setup()
        elif opts[0] == 'show':
            sw.show_current_state()
        else:
            sw.show_usage()
    else:
        sw.show_current_state()
