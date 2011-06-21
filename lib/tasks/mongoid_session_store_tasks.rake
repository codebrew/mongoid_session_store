namespace :db do
  namespace :mongoid do
    namespace :sessions do
      desc "Clears sessions stored in mongoDB"
      task :clear => :environment do
        ActionDispatch::Session::MongoidStore::Session.destroy_all
      end
    end
  end
end