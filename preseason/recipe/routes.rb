class Preseason::Recipe::Routes < Preseason::Recipe
  def prepare
    remove_comments_and_newlines
    add_root_path
    generate_site_controller
  end

  private
  def remove_comments_and_newlines
    gsub_file 'config/routes.rb', /^\s*#\s*.*$/, ''
    gsub_file 'config/routes.rb', /^\n/, ''
  end

  def add_root_path
    insert_into_file 'config/routes.rb', "  root :to => 'site#index'\n", :before => /^end$/
  end

  def generate_site_controller
    generate 'controller site index --no-assets --no-helper'
  end
end
