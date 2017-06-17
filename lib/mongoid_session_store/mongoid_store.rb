module ActionDispatch
  module Session
    class MongoidStore < AbstractStore

      class Session
        include Mongoid::Document
        include Mongoid::Timestamps

        store_in collection: 'sessions'

        identity :type => String

        field :data, :type => String, :default => [Marshal.dump({})].pack("m*")
      end

      # The class used for session storage.
      cattr_accessor :session_class
      self.session_class = Session
      
      SESSION_RECORD_KEY = 'rack.session.record'
      ENV_SESSION_OPTIONS_KEY = Rack::Session::Abstract::ENV_SESSION_OPTIONS_KEY if ::Rails.version >= "3.1"

      private

        def get_session(env, sid)
          unless sid and session = @@session_class.where(:_id => sid).first and safe_unpack(session.data)
            # If the sid was nil or if there is no pre-existing session under the sid or if the session doesn't unpack,
            # force the generation of a new sid and associate a new session associated with the new sid
            # See thread for unpack exception upgrading from 3.0 -> 3.1: https://github.com/rails/rails/issues/2509
            # We handle this by dropping sessions that can't be unpacked.  More elegant patches exist, and we may 
            # investigate those, but we need an immediate fix.
            sid = generate_sid
            session = @@session_class.new(:id => sid)
          end
          env[SESSION_RECORD_KEY] = session
          [sid, unpack(session.data)]
        end

        def set_session(env, sid, session_data, options = nil)
          record = get_session_model(env, sid)
          record.data = pack(session_data)

          # Rack spec dictates that set_session should return true or false
          # depending on whether or not the session was saved or not.
          # However, ActionPack seems to want a session id instead.
          record.save ? sid : false
        end

        def find_session(id)
          @@session_class.find_or_initialize_by(:id => id)
        end

        # def destroy(env)
        #   if sid = current_session_id(env)
        #     find_session(sid).destroy
        #   end
        # end
        
        def destroy(env)
          destroy_session(env, current_session_id(env), {})
        end
        
        def destroy_session(env, session_id, options)
          if sid = current_session_id(env)
            get_session_model(env, sid).destroy
            env[SESSION_RECORD_KEY] = nil
          end

          generate_sid unless options[:drop]
        end

        def get_session_model(env, sid)
          if env[ENV_SESSION_OPTIONS_KEY][:id].nil?
            env[SESSION_RECORD_KEY] = find_session(sid)
          else
            env[SESSION_RECORD_KEY] ||= find_session(sid)
          end
        end

        def pack(data)
          [Marshal.dump(data)].pack("m*")
        end

        def unpack(packed)
          return nil unless packed
          Marshal.load(packed.unpack("m*").first)
        end

        def safe_unpack(packed)
          begin
            unpack(packed)
          rescue => e
            nil
          end
        end
      
    end
  end
end
