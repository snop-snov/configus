require 'bundler/setup'
Bundler.require

require 'minitest/autorun'
require 'minitest/spec'

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

test_path = File.expand_path("..", __FILE__)
Dir["#{test_path}/fixtures/*.rb"].each do |file|
  require file
end