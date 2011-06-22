require 'test_helper'

class MongoidSessionStoreTest < ActionDispatch::IntegrationTest
  setup do
    ActionDispatch::Session::MongoidStore::Session.destroy_all
  end
        
  test "getting nil session value" do
    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: nil', response.body
  end
end