# spork/rspec
remove_file 'spec/spec_helper.rb'
create_file 'spec/spec_helper.rb', load_template('spec_helper.erb','spec')

remove_file 'test'
remove_file 'public/index.html'
remove_file 'app/assets/images/rails.png'

run 'rake db:migrate db:test:clone'