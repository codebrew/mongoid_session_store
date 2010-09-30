# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mongoid_session_store}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Fitzgerald"]
  s.date = %q{2010-08-30}
  s.description = %q{store rails 3 sessions in mongoDB}
  s.email = %q{ryan@gymlogr.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "example/.gitignore",
     "lib/mongoid_session_store.rb",
     "lib/mongoid_session_store/mongoid_store.rb",
     "lib/mongoid_session_store/railtie.rb",
     "lib/mongoid_session_store/railties/sessions.rake",
     "mongoid_session_store.gemspec",
     "test/helper.rb",
     "test/test_mongoid_session_store.rb"
  ]
  s.homepage = %q{http://github.com/ryanfitz/mongoid_session_store}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{store rails 3 sessions in mongoDB}
  s.test_files = [
    "test/helper.rb",
     "test/test_mongoid_session_store.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<mongoid>, [">= 2.0.0.beta.16"])
      s.add_runtime_dependency(%q<actionpack>, ["~> 3.0"])
    else
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<mongoid>, [">= 2.0.0.beta.16"])
      s.add_dependency(%q<actionpack>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<mongoid>, [">= 2.0.0.beta.16"])
    s.add_dependency(%q<actionpack>, ["~> 3.0"])
  end
end

