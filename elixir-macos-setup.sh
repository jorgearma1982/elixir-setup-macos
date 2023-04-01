#!/bin/bash

#
# script: elixir-macos-setup.sh
#

# vars

# main

echo
echo "Install gnu programs"
brew install coreutils git curl unzip

echo
echo "Install elixir dependencies"
brew install autoconf automake readline fop libyaml libxslt libtool unixodbc wxmac

echo
echo "Install and configure openssl"
brew install openssl@1.1
brew unlink openssl@2
brew unlink openssl@3
brew link openssl@1.1

echo
echo "Install asdf and erlang/elixir plugins"
brew install asdf
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

echo
echo "Install erlang 23"
brew install erlang@23

echo
echo "Configure erlang 23 for asdf"
mkdir -p ~/.asdf/installs/erlang
cp -r /opt/homebrew/opt/erlang@23/lib/erlang ~/.asdf/installs/erlang/23.3.4.18
asdf reshim erlang 23.3.4.18
asdf global erlang 23.3.4.18

echo
echo "Instala elixir 1.12-otp-23"
asdf install elixir 1.12-otp-23
asdf global elixir 1.12-otp-23

echo
echo "Muestra versión de elixir"
elixir --version
