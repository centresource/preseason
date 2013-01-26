# guard
run 'bundle exec guard init'
gsub_file 'Guardfile', ":cucumber_env => { 'RAILS_ENV' => 'test' }, ", ''
gsub_file 'Guardfile', "guard 'rspec' do", "guard 'rspec', :cli => '--drb --format Fuubar --tag focus', :all_after_pass => false, :all_on_start => false do"

