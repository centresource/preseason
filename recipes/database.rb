# create db files
remove_file 'config/database.yml'

if @template_options[:db_choice] == 'sqlite'
  create_file 'config/database.yml', <<-DB
  development:
    adapter: sqlite3
    database: db/development.sqlite3
    pool: 5
    timeout: 5000

  test:
    adapter: sqlite3
    database: db/test.sqlite3
    pool: 5
    timeout: 5000

  production:
    adapter: sqlite3
    database: db/production.sqlite3
    pool: 5
    timeout: 5000
  DB
else
  create_file 'config/database.yml', <<-DB
  development:
    adapter: #{@template_options[:db_adapters][@template_options[:db_choice]]}
    database: #{app_name}_development
    username:
    password:

  test:
    adapter: #{@template_options[:db_adapters][@template_options[:db_choice]]}
    database: #{app_name}_test
    username:
    password:

  production:
    adapter: #{@template_options[:db_adapters][@template_options[:db_choice]]}
    database: #{app_name}_production
    username:
    password:
  DB

  copy_file "#{destination_root}/config/database.yml", 'config/database.yml.dist'
  username = (`whoami`).chomp if @template_options[:username].blank?
  gsub_file 'config/database.yml', 'username:', "username: #{@template_options[:username]}"
  gsub_file 'config/database.yml', 'password:', "password: #{@template_options[:password]}"
  append_to_file '.gitignore', 'config/database.yml'
end