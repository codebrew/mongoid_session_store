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
    session[:foo] = "baz"
    head :ok
  end
end
