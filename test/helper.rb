require 'rubygems'
require 'test/unit'
require 'shoulda'

require 'mongoid'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

Mongoid.configure do |config|
  name = "mongoid_test"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  # config.logger = nil
  # config.slaves = [
    # Mongo::Connection.new(host, 27018, :slave_ok => true).db(name)
  # ]
end

require 'mongoid_session_store'

class Test::Unit::TestCase
end
