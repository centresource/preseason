# remove all commented lines from Gemfile
gsub_file 'Gemfile', /^\s*#\s*.*$/, ''

# remove unwanted gems (replacing jquery-rails later to move it to top of Gemfile)
gems_to_remove = %w(jquery-rails)
gems_to_remove.push('sqlite3') unless @template_options[:db_choice] == 'sqlite'
gsub_file 'Gemfile', /^\s*gem '(#{Regexp.union(gems_to_remove)})'.*$/, ''

# remove empty lines from Gemfile
gsub_file 'Gemfile', /^\n/, ''

# add db-specific gem
insert_into_file 'Gemfile', :after => /gem 'rails'.*\n/ do
  "gem '#{@template_options[:db_gems][@template_options[:db_choice]]}'\n"
end unless @template_options[:db_choice] == 'sqlite'

# add environment-wide gems to top of Gemfile
insert_into_file 'Gemfile', :after => /gem '#{@template_options[:db_gems][@template_options[:db_choice]]}'.*\n/ do
  %w(
    whiskey_disk
    jquery-rails
    bourbon
    neat
    chosen-rails
  ).map { |gem_name| "gem '#{gem_name}'" }.join("\n") << "\n\n"
end

if @template_options[:heroku] == true && no?("Will this app be deployed to Heroku?")
  @template_options[:heroku] = false
  # add custom case, with require
  insert_into_file 'Gemfile', :after => /gem 'chosen-rails'\n/ do
    "gem 'lograge'\n
     gem 'whenever', :require => false\n"
  end
end

gem_group :production do
  gem 'heroku_rails_deflate'
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

if @template_options[:factory_girl]
  insert_into_file 'Gemfile', :after => "group :development, :test do\n" do
    "  gem 'factory_girl_rails'\n"
  end
elsif @template_options[:object_daddy]
  plugin 'object_daddy', :git => "git://github.com/awebneck/object_daddy.git"
end

if @template_options[:active_admin]
  insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
    "gem 'activeadmin'\n"
  end
  insert_into_file 'config/environments/development.rb', "\n  config.action_mailer.default_url_options = { :host => 'localhost:3000' }\n", :before => /^end$/
end

if @template_options[:authlogic]
  insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
    "gem 'authlogic'\n"
  end
elsif @template_options[:devise]
  insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
    "gem 'devise'\n"
  end
end
