# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{numbers_in_words}
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Burns"]
  s.date = %q{2010-04-06}
  s.description = %q{}
  s.email = %q{markthedeveloper@googlemail.com}
  s.extra_rdoc_files = ["lib/numbers_in_words.rb", "lib/numbers_in_words.rb_cyclo.html", "lib/words_in_numbers.rb", "lib/words_in_numbers.rb_cyclo.html"]
  s.files = ["Manifest", "Rakefile", "examples/display_numbers_in_words.rb", "index_cyclo.html", "lib/numbers_in_words.rb", "lib/numbers_in_words.rb_cyclo.html", "lib/words_in_numbers.rb", "lib/words_in_numbers.rb_cyclo.html", "numbers_in_words.rb", "spec/numbers_in_words_spec.rb", "spec/words_in_numbers_spec.rb", "numbers_in_words.gemspec"]
  s.homepage = %q{http://rubygems.org/gems/numbers_in_words}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Numbers_in_words"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{numbers_in_words}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<active_support>, [">= 0"])
    else
      s.add_dependency(%q<active_support>, [">= 0"])
    end
  else
    s.add_dependency(%q<active_support>, [">= 0"])
  end
end
