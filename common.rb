require File.join(File.dirname(__FILE__), 'core_extensions.rb')

# create/use gemset
require 'rvm'
run "rvm gemset create #{app_name}"
RVM.gemset_use! "#{app_name}" # `run "rvm gemset use #{app_name}"` doesn't work -- rvm still uses the terminal's current gemset
create_file '.ruby-version', "#{RUBY_VERSION}\n"
create_file '.ruby-gemset', "#{app_name}\n"

load_options

#loop through the recipes and apply each one
required_recipes = %w(
  database
  gitignore
  gemfile
  chosen
  production
  bundle
  routes
  flash_messages
  application
  schedule
  rspec
  whiskey_disk
  foreman
  active_admin
  authentication
  custom_error_pages
  guard
  spork_rspec
  playbook
  git
  heroku
)
required_recipes.each { |required_recipe| apply recipe(required_recipe) }

# semi-hack to make sure our post install messages are output last
run_bundle
def run_bundle ; end

# spit out post install messages
@template_options[:readme].each do |msg|
  say "#{option_color}"
  readme File.join(File.dirname(__FILE__), msg)
  say "#{no_color}"
end
