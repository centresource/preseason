copy_file "#{destination_root}/config/database.yml", 'config/database.yml.dist'
create_file '.rvmrc', "rvm gemset use #{app_name}"
append_to_file '.gitignore', ".rvmrc"
append_to_file '.gitignore', "\nconfig/database.yml"

gem 'authlogic'
gem 'formtastic'
gem 'rspec-rails', :group => [:development, :test]
gem 'passenger', :group => [:development, :test]
gem 'pry', :group => [:development, :test]
gem 'jasmine', '>=1.1.0.rc3', :group => [:development, :test]
gem 'spork', '>=0.9.0.rc2', :group => [:development, :test]
gem 'shoulda-matchers', :group => [:development, :test]
gem 'capybara', :group => [:development, :test]
gem 'awesome_print', :group => [:development, :test]
gem 'map_by_method', :group => [:development, :test]

run 'bundle install'

plugin 'object_daddy', :git => "git://github.com/awebneck/object_daddy.git"
plugin 'enum_simulator', :git => "git://github.com/centresource/enum_simulator.git"
generate 'rspec:install'
generate 'jasmine:install'
generate 'formtastic:install'
generate 'model user email:string crypted_password:string password_salt:string persistence_token:string perishable_token:string current_login_at:datetime last_login_at:datetime last_request_at:datetime login_count:integer last_login_ip:string current_login_ip:string'
generate 'authlogic:session user_session'

run 'git init'
run 'git add .'
run 'git commit -m "Initial commit"'
run 'git checkout -b develop'
