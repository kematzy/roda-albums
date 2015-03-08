require 'rubygems'
# require 'capybara'
# require 'capybara/dsl'
# require 'capybara/rspec'
# require 'capybara/rspec/matchers'
require 'rack/test'
ENV['RACK_ENV'] = 'test'

require 'fixtures/app'

# db_name = DB.get{current_database{}}
# raise "Doesn't look like a test database (#{db_name}), not running tests" unless db_name =~ /test\z/


# Capybara.app = MyApp.app
#
# require 'rspec_sequel_matchers'
# require 'rspec-html-matchers'
# require 'rspec/collection_matchers'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  # config.include Capybara::DSL
  # config.include Capybara::RSpecMatchers
  # config.include RspecSequel::Matchers
  # # config.include RSpec::HtmlMatchers
  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!
  # ... other config ...  
end


describe TestApp do
  include Rack::Test::Methods
  
  def app
    TestApp
  end
  
  context 'plugin :roda_albums' do
    
    context 'defaults' do
      
      context 'r.roda_albums => /albums' do
        
        context 'GET /albums ' do
          
          before { get '/albums' }
          
          it 'should return status = 200' do
            expect(last_response.status).to eq(200)
          end
          
          it 'should return the correct body' do
            expect(last_response.body).to eq('GET /albums when path is: [/albums]')
          end
          
        end
        
        context 'POST /albums' do
          before { post '/albums' }
          
          it 'should return status = 200' do
            expect(last_response.status).to eq(200)
          end
          
          it 'should return the correct body' do
            expect(last_response.body).to eq('POST /albums when path is: [/albums]')
          end
          
        end
        
      end
      
      context 'nested' do
        
        context 'r.roda_albums => /nested/albums' do
          
          context 'GET /nested/albums ' do
            before { get '/nested/albums' }
            
            it 'should return status = 200' do
              expect(last_response.status).to eq(200)
            end
          
            it 'should return the correct body' do
              expect(last_response.body).to eq('GET /albums when path is: [/nested/albums]')
            end
            
          end
          
          context 'POST /nested/albums' do
            before { post '/nested/albums' }
            
            it 'should return status = 200' do
              expect(last_response.status).to eq(200)
            end
            
            it 'should return the correct body' do
              expect(last_response.body).to eq('POST /albums when path is: [/nested/albums]')
            end
            
          end
          
        end
        
      end #/ nested
      
    end #/ defaults
    
    
    context 'custom' do
      
      context "r.roda_albums :path_root => '/custom/path'" do
      
        context 'GET /custom/path' do
          before { get '/custom/path' }
          
          it 'should return status = 200' do
            expect(last_response.status).to eq(200)
          end
          
          it 'should return the correct body' do
            expect(last_response.body).to eq('GET /custom/path when path is: [/custom/path]')
          end
          
        end
      
        context 'POST /custom/path' do
          before { post '/custom/path' }
          
          it 'should return status = 200' do
            expect(last_response.status).to eq(200)
          end
          
          it 'should return the correct body' do
            expect(last_response.body).to eq('POST /custom/path when path is: [/custom/path]')
          end
          
        end
      
      end
      
      context 'nested' do
        
        context "r.roda_albums :path_root => '/custom/path'" do
      
          context 'GET /nested/custom/path ' do
            
            before { get '/nested/custom/path' }
          
            it 'should return status = 200' do
              expect(last_response.status).to eq(200)
            end
          
            it 'should return the correct body' do
              expect(last_response.body).to eq('GET /custom/path when path is: [/nested/custom/path]')
            end
            
          end #/ GET
          
          context 'POST /nested/custom/path' do
            before { post '/nested/custom/path' }
            
            it 'should return status = 200' do
              expect(last_response.status).to eq(200)
            end
            
            it 'should return the correct body' do
              expect(last_response.body).to eq('POST /custom/path when path is: [/nested/custom/path]')
            end
            
          end #/ POST
          
        end 
        
      end #/ nested
      
    end #/ custom
    
  end #/ :roda_albums
  
end