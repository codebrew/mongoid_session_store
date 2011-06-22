class SessionsController < ApplicationController
  def no_session_access
    head :ok
  end

  def set_session_value
    raise "missing session!" unless session
    session[:foo] = params[:foo] || "bar"
    head :ok
  end

  def get_session_value
    render :text => "foo: #{session[:foo].inspect}"
  end

  def get_session_id
    render :text => "#{request.session_options[:id]}"
  end

  def call_reset_session
    session[:foo]
    reset_session
    reset_session if params[:twice]
    session[:foo] = "baz"
    head :ok
  end

  def renew
    env["rack.session.options"][:renew] = true
    session[:foo] = "baz"
    head :ok
  end

  def rescue_action(e) raise end
end