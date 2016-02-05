#!/usr/bin/python
"""make it easier to switch upstream."""

import subprocess
import sys

# change according to your needs
UPSTREAMS = {'blue': '10.5.101.24', 'green': '10.5.102.24'}


CFG = '/etc/nginx/conf.d/upstreams.conf'


def figure_current_upstream():
    """figure the current upstream."""
    if UPSTREAMS['blue'] not in content:
        if UPSTREAMS['green'] in content:
            return 'green'
    if UPSTREAMS['green'] not in content:
        if UPSTREAMS['blue'] in content:
            return 'blue'


def figure_next_upstream():
    """figure out the next upstream."""
    if current_upstream == 'blue':
        return 'green'
    if current_upstream == 'green':
        return 'blue'


def switch_upstream():
    """switch the upstream."""
    new_content = content.replace(UPSTREAMS[current_upstream],
                                  UPSTREAMS[next_upstream])
    with open(CFG, 'w') as f:
        f.write(new_content)


with open(CFG) as f:
    content = f.read()

current_upstream = figure_current_upstream()
next_upstream = figure_next_upstream()

if not current_upstream:
    print 'Unknown configuration.'
    print "You forgot to manually choose the colors' values?"
    print 'Exiting.'
    sys.exit(1)

print 'Switching from %s (%s) to %s (%s)' % (current_upstream,
                                             UPSTREAMS[current_upstream],
                                             next_upstream,
                                             UPSTREAMS[next_upstream])
switch_upstream()
subprocess.call(['nginx', '-t'])
print 'Assuming you got "ok" above, just type:', 'nginx -s reload'
