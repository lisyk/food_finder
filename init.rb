###Food Finder###
#
#Launch this Ruby file from the command line
#to get sterted
#

APP_ROOT=File.dirname(__FILE__)

### here are 4 different way to get path to the file ###
# require "#{APP_ROOT}/lib/guide"
# require Fil.join(APP_ROOT, 'lib', 'guide.rb')
# require File.join(APP_ROOT, 'lib', 'guide')

# this is the best way to adjust a path for the file"
#variable $: it is global variable that contain array with

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'guide'

quide=Guide.new('restaurant.txt')
quide.launch!
