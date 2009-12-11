require 'rubygems'
require 'rake'
require 'rake'
require 'rubygems'
require 'rake/rdoctask'
require 'spec/rake/spectask'
 
puts "\nGem: rack-rpx\n\n"
 
task :default => :spec
begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name        = 'rack-rpx'
    s.summary     = 'Rack Middleware for RPX Now Authorization'
    s.email       = 'pedro.delgallego@gmail.com'
    s.homepage    = 'http://github.com/remi/rack-oauth'
    s.description = 'Rack Middleware for RPX Authorization, this rack middleware will make even easier to interact with rpx now'
    s.authors     = ["Pedro Del Gallego"]
    s.files       = FileList['[A-Z]*', '{lib,spec,bin,examples}/**/*']
    %w(rack net/http net/https).each do |gem|
        s.add_dependency gem
    end    
    s.add_development_dependency "rspec", ">= 1.2.9"
    s.extra_rdoc_files = %w( README.rdoc ) 
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rack-rpx #{version}"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end 
