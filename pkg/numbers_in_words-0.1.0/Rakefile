require 'rubygems'
require 'rake'
require 'echoe'
require 'metric_fu'
Echoe.new('numbers_in_words','0.1.0') do |e|
  e.description = "#in_words method for integers and #in_numbers for strings"
  e.summary = "Example: 123.in_words #=> \"one hundred and twenty three\", \"seventy-five point eight\".in_numbers #=> 75.8"
  e.url = "http://rubygems.org/gems/numbers_in_words"
  e.author = "Mark Burns"
  e.email = "markthedeveloper@googlemail.com"
  e.ignore_pattern = ["tmp/*",".git/*"]
  e.development_dependencies = ['active_support']
end


MetricFu::Configuration.run do |config|
  #define which metrics you want to use
  config.metrics  = [:churn, :saikuro, :stats, :flog, :flay, :reek, :roodi, :rcov]
  config.graphs   = [:flog, :flay, :reek, :roodi, :rcov]
  config.flay     = { :dirs_to_flay => ['lib'],
    :minimum_score => 100  } 
  config.flog     = { :dirs_to_flog => [ 'lib']  }
  config.reek     = { :dirs_to_reek => ['lib']  }
  config.roodi    = { :dirs_to_roodi => ['lib'] }
  config.saikuro  = { :output_directory => 'scratch_directory/saikuro', 
    :input_directory => ['lib'],
    :cyclo => "",
    :filter_cyclo => "0",
    :warn_cyclo => "5",
    :error_cyclo => "7",
    :formater => "text"} #this needs to be set to "text"
  config.churn    = { :start_date => "1 year ago", :minimum_churn_count => 10}
  config.rcov     = { :environment => 'test',
    :test_files => ['spec/**/*_spec.rb'],
    :rcov_opts => ["--sort coverage", 
                                           "--no-html", 
                                           "--text-coverage",
                                           "--no-color",
                                           "--profile",
                                           "--rails",
                                           "--exclude /gems/,/Library/,spec"]}
  config.graph_engine = :bluff
end

