require 'rubygems'
require 'spec'

$HOST = ENV['ELEPHANT_DRIVER_JT_HOST']
$PORT = ENV['ELEPHANT_DRIVER_JT_PORT'] || 9290

require File.dirname(__FILE__) + '/../lib/elephant-driver'
