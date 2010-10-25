# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{webr}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dani\303\253l van de Burgt"]
  s.date = %q{2010-10-25}
  s.default_executable = %q{webr}
  s.description = %q{Magnolia Bookshelf}
  s.email = %q{secretlymexico@gmail.com}
  s.executables = ["webr"]
  s.files = ["app/webr.rb", "bin/webr", "js/jasmine-start.js", "js/webr.js", "lib/webr", "lib/webr/browser.rb", "lib/webr/jasmine", "lib/webr/jasmine/browser.rb", "lib/webr/jasmine/reporter", "lib/webr/jasmine/reporter/base.rb", "lib/webr/jasmine/reporter/console.rb", "lib/webr/jasmine/reporter/html.rb", "lib/webr/jasmine/reporter.rb", "lib/webr/jasmine.rb", "lib/webr/portal.rb", "lib/webr/runtime.rb", "lib/webr.rb", "spec/data", "spec/data/plain.html", "spec/data/script-embedded.html", "spec/data/script-external-onload.html", "spec/data/script-external-onload.js", "spec/data/script-external.html", "spec/data/script-external.js", "spec/data/script-jquery.html", "spec/data/script-jquery.js", "spec/lib", "spec/lib/webr", "spec/lib/webr/browser_spec.rb", "spec/lib/webr/jasmine", "spec/lib/webr/jasmine/browser_spec.rb", "spec/spec_helper.rb", "jspec/jasmine_spec.js", "tasks/spec.rake", "ext/jsdom/lib/jsdom", "ext/jsdom/lib/jsdom/browser", "ext/jsdom/lib/jsdom/browser/domtohtml.js", "ext/jsdom/lib/jsdom/browser/htmlencoding.js", "ext/jsdom/lib/jsdom/browser/htmltodom.js", "ext/jsdom/lib/jsdom/browser/index.js", "ext/jsdom/lib/jsdom/level1", "ext/jsdom/lib/jsdom/level1/core.js", "ext/jsdom/lib/jsdom/level2", "ext/jsdom/lib/jsdom/level2/core.js", "ext/jsdom/lib/jsdom/level2/events.js", "ext/jsdom/lib/jsdom/level2/html.js", "ext/jsdom/lib/jsdom/level3", "ext/jsdom/lib/jsdom/level3/core.js", "ext/jsdom/lib/jsdom/level3/events.js", "ext/jsdom/lib/jsdom/level3/html.js", "ext/jsdom/lib/jsdom/level3/index.js", "ext/jsdom/lib/jsdom.js", "ext/node-htmlparser/lib/node-htmlparser.js", "ext/node-htmlparser/lib/node-htmlparser.min.js", "Rakefile", "README.md", "webr.gemspec", "ext/jasmine/lib/jasmine.js"]
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
