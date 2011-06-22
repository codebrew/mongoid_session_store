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
  
  test "calling reset session twice does not raise errors" do
    get '/call_reset_session', :twice => "true"
    assert_response :success

    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: "baz"', response.body
  end
  
  test "setting session value after session reset" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']
    session_id = cookies['_session_id']

    get '/call_reset_session'
    assert_response :success
    assert_not_equal [], headers['Set-Cookie']

    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: "baz"', response.body

    get '/get_session_id'
    assert_response :success
    assert_not_equal session_id, response.body
  end
  
  test "getting session value after session reset" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']
    session_cookie = cookies.send(:hash_for)['_session_id']

    get '/call_reset_session'
    assert_response :success
    assert_not_equal [], headers['Set-Cookie']

    cookies << session_cookie # replace our new session_id with our old, pre-reset session_id

    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: nil', response.body, "data for this session should have been obliterated from the database"
  end
  
  test "getting_from_nonexistent_session" do
    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: nil', response.body
    assert_nil cookies['_session_id'], "should only create session on write, not read"
  end

  test "getting session_id" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']
    session_id = cookies['_session_id']

    get '/get_session_id'
    assert_response :success
    assert_equal session_id, response.body, "should be able to read session id without accessing the session hash"
  end

  test "doesnt write session cookie if session_id already exists" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']

    get '/get_session_value'
    assert_response :success
    assert_equal nil, headers['Set-Cookie'], "should not resend the cookie again if session_id cookie already exists"
  end

  test "prevents session fixation" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']

    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: "bar"', response.body
    session_id = cookies['_session_id']
    assert session_id

    reset!

    get '/get_session_value', :_session_id => session_id
    assert_response :success
    assert_equal 'foo: nil', response.body
    assert_not_equal session_id, cookies['_session_id']
  end
   
end