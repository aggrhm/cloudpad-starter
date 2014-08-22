#!/usr/bin/python3

import argparse
import subprocess

def sh(cmd):
    subprocess.call(cmd, shell=True)

def shp(v):
    sh("echo \"=== {}\n\"".format(v))

parser = argparse.ArgumentParser()
parser.add_argument("--core", action="store_true", help="Install core packages")
parser.add_argument("--ruby", help="Ruby download URL")
args = parser.parse_args()

if args.core:
    # update timezone
    shp("Updating timezone...\n")
    sh("echo \"Etc/UTC\" > /etc/timezone")
    sh("dpkg-reconfigure -f noninteractive tzdata")

    # update ssh settings
    sh("echo \"Host *\n\tStrictHostKeyChecking no\n\" >> /root/.ssh/config")

if args.ruby:
    # install ruby
    shp("Installing ruby...\n")
    # install ruby

    sh("curl -L {} | tar -zxf - -C /tmp/".format(args.ruby))
    sh("cd /tmp/ruby-* && ./configure && make && make install")
    sh("gem install bundler")
