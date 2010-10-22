# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{webr}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dani\303\253l van de Burgt"]
  s.date = %q{2010-10-22}
  s.default_executable = %q{webr}
  s.description = %q{Magnolia Bookshelf}
  s.email = %q{secretlymexico@gmail.com}
  s.executables = ["webr"]
  s.files = ["app", "app/js", "app/js/dom", "app/js/dom/jsdom", "app/js/dom/jsdom/browser", "app/js/dom/jsdom/browser/domtohtml.js", "app/js/dom/jsdom/browser/htmltodom.js", "app/js/dom/jsdom/browser/index.js", "app/js/dom/jsdom/level1", "app/js/dom/jsdom/level1/core.js", "app/js/dom/jsdom/level2", "app/js/dom/jsdom/level2/core.js", "app/js/dom/jsdom/level2/events.js", "app/js/dom/jsdom/level2/html.js", "app/js/dom/jsdom/level3", "app/js/dom/jsdom/level3/core.js", "app/js/dom/jsdom/level3/events.js", "app/js/dom/jsdom.js", "app/js/htmlparser", "app/js/htmlparser/node-htmlparser.js", "app/js/jasmine", "app/js/jasmine/jasmine-start.js", "app/js/jasmine/jasmine.js", "app/webr.rb", "bin", "bin/webr", "ext", "js", "js/webr.js", "lib", "lib/webr", "lib/webr/browser.rb", "lib/webr/jasmine", "lib/webr/jasmine/reporter", "lib/webr/jasmine/reporter/base.rb", "lib/webr/jasmine/reporter/console.rb", "lib/webr/jasmine/reporter/html.rb", "lib/webr/jasmine/reporter.rb", "lib/webr/jasmine.rb", "lib/webr/portal.rb", "lib/webr/runtime.rb", "lib/webr.rb", "Rakefile", "README.md", "spec", "spec/spec_helper.rb", "tasks", "tasks/spec.rake", "webr.gemspec"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Magnolia Bookshelf}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rednode>, [">= 0.1.0"])
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
      s.add_runtime_dependency(%q<optitron>, [">= 0"])
    else
      s.add_dependency(%q<rednode>, [">= 0.1.0"])
      s.add_dependency(%q<eventmachine>, [">= 0"])
      s.add_dependency(%q<optitron>, [">= 0"])
    end
  else
    s.add_dependency(%q<rednode>, [">= 0.1.0"])
    s.add_dependency(%q<eventmachine>, [">= 0"])
    s.add_dependency(%q<optitron>, [">= 0"])
  end
end
