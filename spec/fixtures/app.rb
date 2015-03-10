require 'roda'
require 'rack/protection'
# require 'tilt/erubis'
# require 'tilt/sass'

require ::File.expand_path('../../../lib/roda/plugins/roda_albums',  __FILE__)

class TestApp < Roda
  #
  plugin :environments
  
  if production?
    use Rack::Session::Cookie, secret: '166C1EC0-36FF-4A26-BA8A-09B1B7B757AB', key: '_testapp_session'
    use Rack::Static, urls: %w(/images /fonts /photos /favicon.ico), root: 'public'
    use Rack::Protection
    plugin :csrf
  end
  
  plugin :roda_albums
  
  
  # handle not found pages
  plugin :not_found do
    "ERROR 404: page not found"
  end
  plugin :error_handler  
  plugin :all_verbs
  plugin :render, :views => 'spec/fixtures/views'
  
  # plugin :view_subdirs
  # plugin :h
  # plugin :padrino_render, cache: (ENV['RACK_ENV'] != 'development') #, escape: true
  # plugin :json, :classes => [ Array, Hash, Sequel::Model ]
  
  # plugin :assets,
  #   :css => %w[bootstrap.min.css font-awesome.min.css app.scss],
  #   :js => {
  #       # :top => %w[angular.min.js ui-bootstrap-tpls-0.12.1.min.js ui-bootstrap-0.12.1.min.js],
  #       :bottom => %w[jquery-2.1.3.min.js bootstrap.min.js app.js]
  #   },
  #   :css_opts => { :style => :compact, :cache => true },
  #   :compiled_js_dir => 'js',
  #   :compiled_css_dir => 'css'
  #   # :compiled_path => nil,
  #   # :compiled  => true,
  #   # :precompiled=>'compiled_assets.json',
  #
  # compile_assets
  
  route do |r|
    
    r.root do
      render('root')
    end
    
    # test defaults  => GET /albums
    r.roda_albums
    
    # test custom route  => GET /custom/path
    r.roda_albums :path_root => '/custom/path'
    
    r.on 'nested' do
      # test nested defaults => GET /nested/albums
      r.roda_albums 
      
      # test nested custom route  => GET /nested/custom/path
      r.roda_albums :path_root => '/custom/path'
    end
    
  end #/r
  
end #/TestApp