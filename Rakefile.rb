require 'rspec/core/rake_task'
require 'rake/clean'

NAME = 'finfast'
SHARED_OBJ_EXT = 'bundle'

# rule to build the extension: this says that the extension should be
# rebuilt after any change to the files in ext
file "lib/#{NAME}/#{NAME}.#{SHARED_OBJ_EXT}" =>
    Dir.glob("ext/#{NAME}/*{.rb,.c}") do
  Dir.chdir("ext/#{NAME}") do
    # this does essentially the same thing
    # as what RubyGems does
    ruby "extconf.rb"
    sh "make"
  end
  cp "ext/#{NAME}/#{NAME}.#{SHARED_OBJ_EXT}", "lib/#{NAME}"
end

# make the :test task depend on the shared object, so it will be built
# automatically before running the tests
task :spec => "lib/#{NAME}/#{NAME}.#{SHARED_OBJ_EXT}"

# use 'rake clean' and 'rake clobber' to
# easily delete generated files
CLEAN.include('ext/**/*{.o,.log,.so,.bundle}')
CLEAN.include('ext/**/Makefile')
CLOBBER.include('lib/**/*.#{SHARED_OBJ_EXT}')

RSpec::Core::RakeTask.new('spec')

desc "Run tests"
task :default => :spec
