# config/application.rb settings
insert_into_file 'config/application.rb', "\n    config.assets.initialize_on_precompile = false\n", :before => /^  end$/
insert_into_file 'config/application.rb', "    config.autoload_paths += %W(\#{config.root}/lib)", :after => /config.autoload_paths.*\n/
