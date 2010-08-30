require 'mongoid_session_store'
require "rails"

module MongoidSessionStore
  
  class Railtie < Rails::Railtie
    rake_tasks do
      load "mongoid_session_store/railties/sessions.rake"
    end
          
    initializer "setup mongoid session store" do |app|
      require 'mongoid_session_store/mongoid_store'
      app.config.session_store :mongoid_store
    end  
  end
  
end