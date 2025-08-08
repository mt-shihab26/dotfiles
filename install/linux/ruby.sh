#!/bin/sh

sudo pacman -S ruby ruby-irb ruby-bundler

bundle config set path 'vendor/bundle'

gem install rails

ruby -v
rails -v
