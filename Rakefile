require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

#raise "XXXXXXXXXXX" << $LOAD_PATH.inspect

task :default => :test