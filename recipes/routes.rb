# remove comments/empty lines from routes.rb
gsub_file 'config/routes.rb', /^\s*#\s*.*$/, ''
gsub_file 'config/routes.rb', /^\n/, ''
insert_into_file 'config/routes.rb', "  root :to => 'home#index'\n", :before => /^end$/