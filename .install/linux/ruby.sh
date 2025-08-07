#!/bin/sh

sudo pacman -S ruby ruby-irb ruby-bundler

gem install rails

ruby -v
rails -v
