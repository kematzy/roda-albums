require 'rubygems'
# require 'capybara'
# require 'capybara/dsl'
# require 'capybara/rspec'
# require 'capybara/rspec/matchers'
require 'rack/test'
ENV['RACK_ENV'] = 'test'

require ::File.expand_path('../fixtures/app',  __FILE__)

# db_name = DB.get{current_database{}}
# raise "Doesn't look like a test database (#{db_name}), not running tests" unless db_name =~ /test\z/


# Capybara.app = MyApp.app

# require 'rspec_sequel_matchers'
require 'rspec-html-matchers'
# require 'rspec/collection_matchers'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  # config.include Capybara::DSL
  # config.include Capybara::RSpecMatchers
  # config.include RspecSequel::Matchers
  config.include RSpecHtmlMatchers
  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!
  # ... other config ...  
end

