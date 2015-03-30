require 'simplecov'

module SimpleCov::Configuration
  def clean_filters
    #@filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_profile 'test_frameworks'
end

ENV['COVERAGE'] && SimpleCov.start do
  add_filter 'test/'
end

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

PROJECT_DIR = File.expand_path('../../', __FILE__)
TEST_DIR    = File.join(PROJECT_DIR, 'test')

$LOAD_PATH << File.expand_path('lib', PROJECT_DIR)
$LOAD_PATH << File.expand_path('lib', TEST_DIR)

require 'storage'

class Test::Unit::TestCase
end
