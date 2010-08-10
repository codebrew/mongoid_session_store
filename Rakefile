require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "mongoid_session_store"
    gem.summary = %Q{store rails 3 sessions in mongoDB}
    gem.description = %Q{store rails 3 sessions in mongoDB}
    gem.email = "ryan@gymlogr.com"
    gem.homepage = "http://github.com/ryanfitz/mongoid_session_store"
    gem.authors = ["Ryan Fitzgerald"]
    gem.add_development_dependency "shoulda", ">= 0"
    gem.add_dependency('mongoid',   ">= 2.0.0.beta.16")
    gem.add_dependency('actionpack',   ">= 3.0.0.rc")
    
    gem.files.exclude 'example/**/*'
  
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mongoid_session_store #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
