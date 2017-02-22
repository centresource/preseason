class Preseason::Recipe::Gemfile < Preseason::Recipe
  def prepare
    remove_comments
    remove_unwanted_gems
    remove_empty_lines
    add_ruby_version
    add_database_gem
    add_global_gems
    add_non_heroku_gems
    add_production_gems
    add_development_gems
    add_development_test_gems
    add_test_gems
    add_factory_gem
    add_bitters_gem
    add_active_admin_gem
    add_authentication_gem
    add_modernizr_gem
    add_normalize_gem
    add_ie8_gems
  end

  private
  def remove_comments
    gsub_file 'Gemfile', /^\s*#\s*.*$/, ''
  end

  def remove_unwanted_gems
    gems_to_remove = %w(jquery-rails) # removing jquery-rails now so we can move it to top of Gemfile
    gems_to_remove << 'sqlite3' unless config.database.sqlite?
    gsub_file 'Gemfile', /^\s*gem '(#{Regexp.union(gems_to_remove)})'.*$/, ''
  end

  def remove_empty_lines
    gsub_file 'Gemfile', /^\n/, ''
  end

  def add_ruby_version
    insert_into_file 'Gemfile', "ruby '#{RUBY_VERSION}'\n\n", :after => /source 'https:\/\/rubygems.org'.*\n/
  end

  def add_database_gem
    insert_into_file 'Gemfile', "gem '#{config.database.gem_name}'\n", :after => /gem 'rails'.*\n/ unless config.database.sqlite?
  end

  def add_global_gems
    insert_into_file 'Gemfile', :after => /gem '#{config.database.gem_name}'.*\n/ do
      %w(
        whiskey_disk
        jquery-rails
      ).map { |gem_name| "gem '#{gem_name}'" }.join("\n") << "\n"
    end
  end

  def add_modernizr_gem
    insert_into_file 'Gemfile', "gem 'modernizr-rails'\n", :after => /gem 'uglifier'.*\n/
  end

  def add_normalize_gem
    insert_into_file 'Gemfile', "gem 'normalize-rails'\n", :after => /gem 'modernizr-rails'.*\n/
  end

  def add_ie8_gems
    if config.ie8.enabled?
      insert_into_file 'Gemfile', :after => /gem 'jquery-rails'\n/ do
        "gem 'selectivizr-rails'\ngem 'respond-rails'\n"
      end
    end
  end

  def add_non_heroku_gems
    unless config.heroku.use?
      insert_into_file 'Gemfile', :after => /gem 'jquery-rails'\n/ do
        "gem 'lograge'\ngem 'whenever', :require => false\n"
      end
    end
  end

  def add_production_gems
    if config.heroku.use?
      gem_group :production do
        gem 'heroku_rails_deflate'
      end
    end
  end

  def add_development_gems
    gem_group :development do
      gem 'foreman'
      gem 'guard-bundler'
      gem 'guard-rspec'
      gem 'guard-spork'
      gem 'rb-fsevent', :require => false
    end
  end

  def add_development_test_gems
    gem_group :development, :test do
      gem 'pry-rails'
      gem 'pry-nav'
      gem 'awesome_print'
      gem 'rspec-rails'
    end
  end

  def add_test_gems
    gem_group :test do
      gem 'spork-rails', github: 'sporkrb/spork-rails'
      gem 'database_cleaner'
      gem 'shoulda-matchers'
      gem 'capybara-webkit'
      gem 'launchy'
      gem 'fuubar'
      gem 'simplecov'
    end
  end

  def add_factory_gem
    if config.factory.factory_girl?
      insert_into_file 'Gemfile', :after => "group :development, :test do\n" do
        "  gem 'factory_girl_rails'\n"
      end
    end
  end

  def add_bourbon_gems
    if config.bourbon.bourbon?
      insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
        "gem 'bourbon', '~> 4.2', '>= 4.2.6'\n"
        "gem 'neat', '~> 2.0.0'\n"
        "gem 'bitters', '~> 1.5.0'\n"
      end
    end
  end

  def add_active_admin_gem
    if config.authentication.active_admin?
      insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
        "gem 'activeadmin', :github => 'gregbell/active_admin'\n"
      end
    end
  end

  def add_authentication_gem
    if config.authentication.authlogic?
      insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
        "gem 'authlogic'\n"
      end
    elsif config.authentication.devise?
      insert_into_file 'Gemfile', :after => "gem 'jquery-rails'\n" do
        "gem 'devise'\n"
      end
    end
  end
end
