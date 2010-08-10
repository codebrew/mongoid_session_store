require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  fixtures :all
  
  def setup
    # Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
    ActionDispatch::Session::MongoidStore::Session.delete_all
  end
  
  test "set session value" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']
    session_id = cookies['_session_id']
  end
  
  test "setting and getting session value with" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']

    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: "bar"', response.body

    get '/set_session_value', :foo => "baz"
    assert_response :success
    assert cookies['_session_id']

    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: "baz"', response.body

    get '/call_reset_session'
    assert_response :success
    assert_not_equal [], headers['Set-Cookie']
  end
  
  test "getting nil session value" do
    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: nil', response.body
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

  test "getting from nonexistent session" do
    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: nil', response.body
    assert_nil cookies['_session_id'], "should only create session on write, not read"
  end

  test "getting session id" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']
    session_id = cookies['_session_id']

    get '/get_session_id'
    assert_response :success
    assert_equal session_id, response.body, "should be able to read session id without accessing the session hash"
  end

  test "doesnt write session cookie if session id is already exists" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']

    get '/get_session_value'
    assert_response :success
    assert_equal nil, headers['Set-Cookie'], "should not resend the cookie again if session_id cookie is already exists"
  end

  test "prevents_session_fixation" do
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

  test "test allows session fixation" do
    get '/set_session_value'
    assert_response :success
    assert cookies['_session_id']

    get '/get_session_value'
    assert_response :success
    assert_equal 'foo: "bar"', response.body
    session_id = cookies['_session_id']
    assert session_id

    reset!

    get '/set_session_value', :_session_id => session_id, :foo => "baz"
    assert_response :success
    assert_equal session_id, cookies['_session_id']

    get '/get_session_value', :_session_id => session_id
    assert_response :success
    assert_equal 'foo: "baz"', response.body
    assert_equal session_id, cookies['_session_id']
  end
    
end
