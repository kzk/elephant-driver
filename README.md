# About

'elephant-driver' is a Ruby library to communicate with Hadoop daemons.

# Notice

Currently, only communicating with JobTracker is supported. Other daemons (TaskTracker, NameNode, DataNode) are not supported yet.

# Requirements

* thfift
* nokogiri

# Setup

This library assumes that you're using CDH3 (Cloudera Distribution for Hadoop, version 3).

You first need to install 'hue-plugins' package at the JobTracker node. Then, the following settings needs to be included in your mapred-site.xml.

```xml
<!-- Enable Hue plugins -->
<property>
  <name>mapred.jobtracker.plugins</name>
  <value>org.apache.hadoop.thriftfs.ThriftJobTrackerPlugin</value>
  <description>Comma-separated list of jobtracker plug-ins to be activated.</description>
</property>
<property>
  <name>jobtracker.thrift.address</name>
  <value>0.0.0.0:9290</value>
</property>
```

# Usage

See spec/ directory for the example usage.

```ruby
@cln = ElephantDriver::Client.new($HOST, $PORT)
@cln.jobs.each { |j|
  j.tasks.each { |t|
    t.counters
  }
}
```
