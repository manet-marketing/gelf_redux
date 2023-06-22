require 'simplecov'
SimpleCov.start
require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha/setup'
require 'webmock/test_unit'
require 'timecop'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'gelf'

class Test::Unit::TestCase
end
