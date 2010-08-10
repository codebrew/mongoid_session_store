# Be sure to restart your server when you modify this file.

require 'mongoid_session_store/mongoid_store'

# Example::Application.config.session_store :cookie_store, :key => '_example_session'
Example::Application.config.session_store :mongoid_store

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Example::Application.config.session_store :active_record_store
