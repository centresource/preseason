require 'rvm'

class Preseason::Recipe::Rvm < Preseason::Recipe
  def prepare
    run "rvm gemset create #{app_name}"
    RVM.gemset_use! "#{app_name}" # `run "rvm gemset use #{app_name}"` doesn't work -- rvm still uses the terminal's current gemset
    create_file '.ruby-version', "#{RUBY_VERSION}\n"
    create_file '.ruby-gemset', "#{app_name}\n"
  end
end
