# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-rpx}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pedro Del Gallego"]
  s.date = %q{2010-01-14}
  s.description = %q{Rack Middleware for RPX Authorization, this rack middleware will make even easier to interact with rpx now}
  s.email = %q{pedro.delgallego@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "examples/login-app.rb",
     "examples/login-hooks-sapp.rb",
     "examples/views/login.haml",
     "lib/rack-rpx.rb",
     "spec/rack-rpx_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/remi/rack-oauth}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Rack Middleware for RPX Now Authorization}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/rack-rpx_spec.rb",
     "test/test_helper.rb",
     "test/rack_rpx_test.rb",
     "examples/login-app.rb",
     "examples/login-hooks-sapp.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

