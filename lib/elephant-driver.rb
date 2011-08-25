require 'thrift'

# thrift-generated files
$:.unshift File.join(File.dirname(__FILE__), 'elephant-driver', 'thrift')
[
  'common_types',
  'common_constants',
  'hadoop_service_base',
  'jobtracker_types',
  'jobtracker_constants',
  'jobtracker',
].each { |fn|
  require File.join(File.dirname(__FILE__), 'elephant-driver', 'thrift', fn)
}

# library files
[ 'client', 'task', 'job', 'tracker' ].each { |fn|
  require File.join(File.dirname(__FILE__), 'elephant-driver', fn)
}
