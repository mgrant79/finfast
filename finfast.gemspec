# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'finfast/version'
 
Gem::Specification.new do |s|
  s.name              = 'finfast'
  s.version           = Finfast::VERSION
  s.platform          = Gem::Platform::RUBY
  s.authors           = ['Michael Grant']
  s.email             = ['mike.grant@jhu.edu']
  s.homepage          = 'http://79mg.com/'
  s.summary           = %q{Fast Ruby financial math operations}
  s.description       = %q{Fast Ruby financial math operations, using native code}

  # s.rubyforge_project = 'finfast'

  # s.add_runtime_dependency '...', '~> x.y.z'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.files       = Dir.glob('{lib,bin}/**/*.rb') +
  		  Dir.glob('ext/**/*.{c,h,rb}') +
		  %w(README.rdoc)
  s.extensions = ['ext/finfast/extconf.rb']
  s.test_files  = Dir.glob('test/finfast/*_test.rb')
  s.executables = Dir.glob('bin/*').map{|f| File.basename(f)}

  s.rdoc_options = [
    "--main",    "README.rdoc",
    "--title",   "#{s.full_name} Documentation"]
  s.extra_rdoc_files << "README.rdoc"
end

