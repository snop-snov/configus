require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/configus/*_test.rb']
  t.verbose = true
end

#desc "Run unit builder_test.rb"
#task :builder_test do
#  "ruby -I lib:test test/configus/builder_test.rb"
#end

task :default => :test