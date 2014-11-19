require 'capybara'
include Capybara::DSL
require 'coveralls'
Coveralls.wear!

Capybara.default_driver = :selenium

def app
   Sinatra::Application
end

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
   config .run_all_when_everything_filtered = true
   config.filter_run :focus
   config.order = :random
   
=begin
   config.disable_monkey_patching!
   
   config.warnings = true
   
   if config.file_to_run.one?
      config.default_formatter = 'doc'
   end
   
   config.profile_examples = 10
   
   
   Kernel.srand config.seed
=end
end