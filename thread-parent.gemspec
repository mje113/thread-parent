# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thread_parent/version'

Gem::Specification.new do |gem|
  gem.name          = 'thread-parent'
  gem.version       = ThreadParent::VERSION
  gem.authors       = ['Mike Evans']
  gem.email         = ['mike@urlgonomics.com']
  gem.description   = %q{Thread parent facilitates keeping a reference to a thread's creating
                         thread through a 'parent' method.  Also will resolve missing thread local
                         variables by walking up the parent chain until they are found.}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/mje113/thread-parent'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.add_dependency 'pry'
end
