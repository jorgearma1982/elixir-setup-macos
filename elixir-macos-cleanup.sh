#!/bin/bash

#
# script: elixir-macos-cleanup.sh
#

# vars

# main

echo "Uninstall erlang/elixir dependencies"
brew uninstall autoconf automake readline fop libyaml libxslt libtool unixodbc wxmac

echo "Uninstall asdf and erlang@23"
brew uninstall asdf
brew uninstall erlang@23

echo "Delete asdf directory"
rm -rf $HOME/.asdf
