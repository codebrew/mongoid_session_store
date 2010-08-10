require File.expand_path(File.dirname(__FILE__) + '/helper')

class TestMongoidSessionStore < Test::Unit::TestCase
  def setup
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
  
  should "probably rename this file and start testing for real" do
    flunk "hey buddy, you should probably rename this file and start testing for real"
  end
end
