class Preseason::Recipe::CustomErrorPages < Preseason::Recipe
  def prepare
    handle_errors_in_app
    create_errors_controller
    create_views
    remove_default_error_pages
  end
  
  private
  def handle_errors_in_app
    insert_into_file 'config/application.rb', "\n\n    config.exceptions_app = self.routes", :after => /config.active_record.whitelist_attributes = true$/
    insert 'config/routes.rb', :before => /^end$/
  end
  
  def create_errors_controller
    generate 'controller errors --no-helper --no-assets'
  end
  
  def create_views
    mirror_file 'app/views/errors/application_error.html.erb'
    mirror_file 'app/views/errors/not_found.html.erb'
    mirror_file 'app/views/errors/unprocessable_entity.html.erb'
  end
  
  def remove_default_error_pages
    remove_file 'public/404.html'
    remove_file 'public/422.html'
    remove_file 'public/500.html'
  end
end
