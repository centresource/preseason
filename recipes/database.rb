# create db files
remove_file 'config/database.yml'

if @template_options[:db_choice] == 'sqlite'
  create_file 'config/database.yml', load_template('config/database.yml','sqlite')
else
  create_file 'config/database.yml', load_template('config/database.yml.erb','no-sqlite')

  copy_file "#{destination_root}/config/database.yml", 'config/database.yml.dist'
  username = (`whoami`).chomp if @template_options[:username].blank?
  gsub_file 'config/database.yml', 'username:', "username: #{@template_options[:username]}"
  gsub_file 'config/database.yml', 'password:', "password: #{@template_options[:password]}"
  append_to_file '.gitignore', 'config/database.yml'
end