## TODO:
# integration spec setup?
# password reset/recover in controller for Authlogic
# Authlogic user factory
# add chosen.js for active admin (possibly for everything?)
# add active admin precompile asset list to production.rb
# setup README based on gems?
# setup github remote?
# ask/setup heroku?

db_adapters = {'postgres' => 'postgresql', 'mysql' => 'mysql2', 'sqlite' => 'sqlite3'}
db_gems = {'postgres' => 'pg', 'mysql' => 'mysql2', 'sqlite' => 'sqlite3'}
db_choice = ask("What db will you be using?", :limited_to => ['postgres', 'mysql', 'sqlite'])

unless db_choice == 'sqlite'
  username = ask "What is your #{db_choice} database username?"
  password = ask "What is your #{db_choice} database password? (leave blank for none)"
end

if yes? 'Will you be using Factory Girl? [y/n]'
  factory_girl = true
elsif yes? 'Ok then, how about Object Daddy? [y/n]'
  object_daddy = true
  say 'Hello, Jeremy.'
end

if yes? 'Will you be using Authlogic? [y/n]'
  authlogic = true
elsif yes? 'Will you be using ActiveAdmin? [y/n]'
  active_admin = true
  devise = true
elsif yes? 'Ok then, how about Devise? [y/n]'
  devise = true
end

# create/use gemset
require 'rvm'
run "rvm gemset create #{app_name}"
RVM.gemset_use! app_name # `run "rvm gemset use #{app_name}"` doesn't work -- rvm still uses the terminal's current gemset
create_file '.rvmrc', "rvm gemset use #{app_name}"
run 'rvm rvmrc trust'

# create db files
remove_file 'config/database.yml'

if db_choice == 'sqlite'
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
    adapter: #{db_adapters[db_choice]}
    database: #{app_name}_development
    username:
    password:

  test:
    adapter: #{db_adapters[db_choice]}
    database: #{app_name}_test
    username:
    password:

  production:
    adapter: #{db_adapters[db_choice]}
    database: #{app_name}_production
    username:
    password:
  DB

  copy_file "#{destination_root}/config/database.yml", 'config/database.yml.dist'
  username = (`whoami`).chomp if username.blank?
  gsub_file 'config/database.yml', 'username:', "username: #{username}"
  gsub_file 'config/database.yml', 'password:', "password: #{password}"
  append_to_file '.gitignore', 'config/database.yml'
end

append_to_file '.gitignore' do
  %w(
    .rvmrc
    coverage
    .DS_Store
    *.swp
    erd.pdf
    .powrc
    public/assets
    config/aws_s3.yml
    config/sunspot.yml
    solr/data
    *.pid
    dump.rdb
  ).join("\n")
end

# remove all commented lines from Gemfile
gsub_file 'Gemfile', /^\s*#\s*.*$/, ''

# remove unwanted gems (replacing jquery-rails later to move it to top of Gemfile)
gems_to_remove = %w(jquery-rails)
gems_to_remove.push('sqlite3') unless db_choice == 'sqlite'
gsub_file 'Gemfile', /^\s*gem '(#{Regexp.union(gems_to_remove)})'.*$/, ''

# remove empty lines from Gemfile
gsub_file 'Gemfile', /^\n/, ''

# add db-specific gem
insert_into_file 'Gemfile', :after => /gem 'rails'.*\n/ do
  "gem '#{db_gems[db_choice]}'\n"
end unless db_choice == 'sqlite'

# add environment-wide gems to top of Gemfile
insert_into_file 'Gemfile', :after => /gem '#{db_gems[db_choice]}'.*\n/ do
  %w(
    whiskey_disk
    jquery-rails
    lograge
  ).map { |gem_name| "gem '#{gem_name}'" }.join("\n") << "\n\n"
end

# add custom case, with require
insert_into_file 'Gemfile', :after => /gem 'lograge'\n/ do
  "gem 'whenever', :require => false\n"
end

gem_group :development do
  gem 'foreman'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'rb-fsevent', :require => false
  gem 'growl'
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem_group :development, :test do
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'awesome_print'
  gem 'quiet_assets'
  gem 'heroku'
  gem 'rspec-rails'
end

gem_group :test do
  gem 'spork-rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'fuubar'
  gem 'simplecov'
end

if factory_girl
  insert_into_file 'Gemfile', :after => "group :development, :test do\n" do
    "  gem 'factory_girl_rails'\n"
  end
elsif object_daddy
  plugin 'object_daddy', :git => "git://github.com/awebneck/object_daddy.git"
end

if active_admin
  insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
    "gem 'activeadmin'\n"
  end
  insert_into_file 'config/environments/development.rb', "\n  config.action_mailer.default_url_options = { :host => 'localhost:3000' }\n", :before => /^end$/
end

if authlogic
  insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
    "gem 'authlogic'\n"
  end
elsif devise
  insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
    "gem 'devise'\n"
  end
end

# enable lograge for production
insert_into_file 'config/environments/production.rb', "\n  config.lograge.enabled = true\n", :before => /^end$/

run 'bundle install'
run 'rake db:create'

# remove comments/empty lines from routes.rb
gsub_file 'config/routes.rb', /^\s*#\s*.*$/, ''
gsub_file 'config/routes.rb', /^\n/, ''
insert_into_file 'config/routes.rb', "  root :to => 'home#index'\n", :before => /^end$/

# set up flash messages
empty_directory 'app/views/shared'
create_file 'app/views/shared/_flash.html.erb', <<-FLASH
<% flash().each do |key, msg| %>
  <div class="alert alert-<%= key %> fade in">
    <%= link_to '&times;'.html_safe, '#', :class => 'close', 'data-dismiss' => 'alert' %>
    <%= msg %>
  </div>
<% end %>
FLASH
insert_into_file 'app/views/layouts/application.html.erb', "\n  <%= render 'shared/flash' %>", :after => "<body>\n"

# config/application.rb settings
insert_into_file 'config/application.rb', "\n    config.assets.initialize_on_precompile = false\n", :before => /^  end$/
insert_into_file 'config/application.rb', "    config.autoload_paths += %W(\#{config.root}/lib)", :after => /config.autoload_paths.*\n/

# config/schedule.rb for whenever cron tab
create_file 'config/schedule.rb', <<-CRONTAB
# Use this file to easily define all of your cron jobs.

every :sunday, :at => '4am' do
  rake "log:clear"
end

# Learn more: http://github.com/javan/whenever
CRONTAB

# rspec
generate 'rspec:install'

# whiskey disk
create_file 'config/deploy.yml', <<-WHISKEY_DISK
  staging:
    domain: "deployment_user@staging.mydomain.com"
    deploy_to: "/path/to/where/i/deploy/staging.mydomain.com"
    repository: "https://github.com/username/project.git"
    branch: "staging"
    rake_env:
      RAILS_ENV: 'production'
WHISKEY_DISK

# foreman
create_file 'Procfile', ''

# active admin
generate 'active_admin:install' if active_admin

# authlogic/devise
if authlogic
  generate 'model user email:string crypted_password:string password_salt:string persistence_token:string perishable_token:string current_login_at:datetime last_login_at:datetime last_request_at:datetime login_count:integer last_login_ip:string current_login_ip:string'

  generate 'authlogic:session UserSession'

  insert_into_file 'app/models/user.rb', :before => 'end' do
  <<-AUTHLOGIC

  acts_as_authentic do |c|
    # because RSpec has problems with Authlogic's session maintenance
    # see https://github.com/binarylogic/authlogic/issues/262#issuecomment-1804988
    c.maintain_sessions = false
  end
  AUTHLOGIC
  end

  insert_into_file 'config/routes.rb', :before => 'end' do
  <<-ROUTES

  match '/login',                 :to => 'user_session#new',                      :as => :login,           :via => :get
  match '/login',                 :to => 'user_session#create',                   :as => :login,           :via => :post
  match '/logout',                :to => 'user_session#destroy',                  :as => :logout,          :via => :delete
  match '/forgot_password',       :to => 'user_session#forgot_password',          :as => :forgot_password, :via => :get
  match '/forgot_password',       :to => 'user_session#send_reset_password_link', :as => :forgot_password, :via => :post
  match '/reset_password/:token', :to => 'user_session#acquire_password',         :as => :reset_password,  :via => :get
  match '/reset_password/:token', :to => 'user_session#reset_password',           :as => :reset_password,  :via => :post
  match '/register',              :to => 'users#new',                             :as => :register,        :via => :get
  match '/register',              :to => 'users#create',                          :as => :register,        :via => :post
  ROUTES
  end

  create_file 'app/controllers/user_session_controller.rb', <<-AUTHLOGIC
class UserSessionController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      redirect_to root_url
    else
      flash.now[:error] = 'Username or password are incorrect.'
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_url
  end
end
  AUTHLOGIC
elsif devise
  generate 'devise:install' unless active_admin
  generate 'devise', 'user'
end

# guard
run 'bundle exec guard init'
gsub_file 'Guardfile', ":cucumber_env => { 'RAILS_ENV' => 'test' }, ", ''
gsub_file 'Guardfile', "guard 'rspec' do", "guard 'rspec', :cli => '--drb --format Fuubar --tag focus', :all_after_pass => false, :all_on_start => false do"

# spork/rspec
remove_file 'spec/spec_helper.rb'
create_file 'spec/spec_helper.rb', <<-SPEC
require 'rubygems'
require 'spork'

if(ENV["SIMPLECOV"])
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter "/spec/"
  end
  puts "Running coverage tool\\n"
end

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  #{"require 'rails/application'" if devise}
  #{"Spork.trap_method(Rails::Application::RoutesReloader, :reload!)" if devise}

  #{"require 'authlogic/test_case'" if authlogic}
  #{"include Authlogic::TestCase" if authlogic}

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    Capybara.javascript_driver = :webkit
    config.mock_with :rspec
    config.fixture_path = "\#{::Rails.root}/spec/factories"
    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with :truncation
    end

    config.before(:each) do
      if example.metadata[:use_truncation]
        DatabaseCleaner.strategy = :truncation
      else
        DatabaseCleaner.start
      end
    end

    config.after(:each) do
      DatabaseCleaner.clean
      if example.metadata[:use_truncation]
        DatabaseCleaner.strategy = :transaction
      end
    end
  end

end

Spork.each_run do
  #{"FactoryGirl.reload" if factory_girl}
end
SPEC

remove_file 'test'
remove_file 'public/index.html'
remove_file 'app/assets/images/rails.png'

run 'rake db:migrate db:test:clone'

# create a local repo and then a remote repo in the Centresource org
# create master and develop remote branches
run 'git init'
run 'git add .'
run 'git commit -m "Initial commit"'
repo_name = ask('What do you want to name the Github repo?')
github_username = ask('What is your Github username?')
if yes? 'Is this a private repo? [y/n]'
  private_repo_answer = true
else
  private_repo_answer = false
end
run <<-RUBY
  curl -u '#{github_username}' https://api.github.com/orgs/centresource/repos -d '{"name":"#{repo_name}",
                                                                       "private":"#{private_repo_answer}"}' > /dev/null
RUBY
run "git remote add origin git@github.com:centresource/#{repo_name}.git"
run 'git push -u origin master'
run 'git checkout -b develop'
run 'git push -u origin develop'
