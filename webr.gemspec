$:.push File.expand_path("../lib", __FILE__)
require 'set'
require 'webr/version'

Gem::Specification.new do |s|
  s.name = 'webr'
  s.version = Webr::VERSION
  s.summary = "Pain-free javascript testing"
  s.description = "Test your javascript with no server, no browser, just pleasure."
  s.authors = ["Daniël van de Burgt"]
  s.email = "secretlymexico@gmail.com"
  s.require_paths = ['lib']
  s.executables = ["webr"]
  s.add_dependency('therubyracer', '0.9.0.beta5')
  s.add_dependency('rednode', '>= 0.1.0')
  s.add_dependency('eventmachine')
  s.add_dependency('optitron')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec')

  s.files = Set.new.tap do |fileset|
    fileset.add 'Rakefile'
    fileset.add 'README.md'
    fileset.add 'webr.gemspec'
    fileset.add 'ext/jasmine/lib/jasmine.js'
    for dir in %w(app bin js lib spec jspec tasks ext/jsdom/lib ext/node-htmlparser/lib ext/request)
      fileset.merge `cd #{dir} && git ls-files`.split("\n").map {|f| "#{dir}/#{f}"}
    end
  end
end
