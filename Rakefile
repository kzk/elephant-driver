require 'rake'
require 'rake/testtask'
require 'rake/clean'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "elephant-driver"
    gemspec.summary = "Ruby libray for managing Hadoop clusters"
    gemspec.author = "Kazuki Ohta"
    gemspec.email = "kazuki.ohta@gmail.com"
    #gemspec.homepage = "http://.../"
    gemspec.has_rdoc = false
    gemspec.require_paths = ["lib"]
    gemspec.add_dependency "thrift", "~> 0.7.0"
    gemspec.add_dependency "nokogiri", ">= 1.5.0"
    gemspec.test_files = Dir["test/**/*.rb", "test/**/*.sh"]
    gemspec.files = Dir["bin/**/*", "lib/**/*", "test/**/*.rb"]
    gemspec.executables = []
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

############################

require 'spec/rake/spectask'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
  t.spec_files = FileList['spec/*_spec.rb']
end

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = FileList['spec/*_spec.rb']
  t.rcov = true
  t.rcov_opts = ['--exclude', 'examples']
end

# task :default => :spec

############################

task "thrift_gen" do
  system "rm -f common.thrift jobtracker.thrift"
  system "wget https://raw.github.com/cloudera/hue/master/desktop/libs/hadoop/java/if/common.thrift"
  system "wget https://raw.github.com/cloudera/hue/master/desktop/libs/hadoop/java/if/jobtracker.thrift"
  system "mv common.thrift lib/elephant-driver/thrift/"
  system "mv jobtracker.thrift lib/elephant-driver/thrift/"
  system "mkdir -p tmp"
  system "thrift --gen rb -o tmp lib/elephant-driver/thrift/common.thrift"
  system "thrift --gen rb -o tmp lib/elephant-driver/thrift/jobtracker.thrift"
  system "mv tmp/gen-rb/* lib/elephant-driver/thrift"
  system "rm -fR tmp"
end

VERSION_FILE = "lib/elephant-driver/version.rb"

file VERSION_FILE => ["VERSION"] do |t|
  version = File.read("VERSION").strip
  File.open(VERSION_FILE, "w") {|f|
    f.write <<EOF
module ElephantDriver

VERSION = '#{version}'

end
EOF
  }
end

task :default => [VERSION_FILE, :build]
