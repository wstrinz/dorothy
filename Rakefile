# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "dorothy"
  gem.homepage = "http://github.com/grantspeelman/dorothy"
  gem.license = "MIT"
  gem.summary = %Q{Dorothy is a z-machine interpreter library}
  gem.description = %Q{Dorothy is a z-machine interpreter library.  It's core is C (taken in part from Frotz), the interface is Ruby.  Ideally this project forms the basis for writing interpreters and other tools.}
  gem.email = "grant.speelman@ubxd.com"
  gem.authors = ["Grant Speelman"]
  gem.executables = ['dorothy']
  gem.extensions = FileList['ext/**/extconf.rb']
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "dorothy #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

CLEAN.include( 'ext/**/*.o', 'ext/**/*.so', 'test/**/*.z?' )
CLOBBER.include( 'pkg', 'doc/api', 'lib/dorothy/version.rb' )

###
### task to compile the extension
###

desc "compile the C extension part of the dorothy library"
task :compile do
  ruby = ($0 =~ /rake(.+)/) ? "ruby#{$1}" : "ruby"
  sh %{cd ext/dorothy/machine && #{ruby} ./extconf.rb && make}
end

###
### the default task
###

task :default => [:clean, :compile, :compile_test_programs, :test]

###
### compile the test programs
###

desc "compile the test programs"
task :compile_test_programs do
  Dir['test/dorothy/programs/*.inf'].each do |f|
    sh %{cd test/dorothy/programs && inform #{File.basename( f )}}
  end

  Dir['test/dorothy/programs/v3/*.inf'].each do |f|
    sh %{cd test/dorothy/programs/v3 && inform -v3 #{File.basename( f )}}
  end
end
