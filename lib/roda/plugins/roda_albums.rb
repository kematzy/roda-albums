class Roda
  module RodaPlugins
    
    #   plugin :roda_albums
    module RodaAlbums
      
      def self.load_dependencies(app, opts={})
        app.plugin :render
      end
      
      # def self.configure(app, opts={}, &block)
      #   # <snip>
      # end
      
      module RequestMethods
        
        #   routes do |r|
        #     
        #     # with default route
        #     r.roda_albums
        #     
        #     # with custom route
        #     r.roda_albums  :path_root => '/custom/path'
        #     
        #   end
        def roda_albums(opts={}, &block)
          o = { :path_root => '/albums'}.merge(opts)
          
          # NOTE! strip leading slash from path
          on(o[:path_root].gsub(/^\//,'')) do
            get  do
              "GET #{o[:path_root]} when path is: [#{path}] self = [#{self.class}]"
              # roda_class.render('index')
            end
            
            post  do
              "POST #{o[:path_root]} when path is: [#{path}]"
            end
          end
          
        end #/def roda_albums()
      end #/module RequestMethods
    end #/module RodaAlbums
    
    register_plugin(:roda_albums, RodaAlbums)
  end #/module RodaPlugins
end #/class Roda