insert_into_file 'config/application.rb', "\n\n    config.exceptions_app = self.routes", :after => /config.active_record.whitelist_attributes = true$/

insert_into_file 'config/routes.rb', :before => /^end$/ do
  load_template 'config/routes.rb', 'custom_error_pages'
end

generate 'controller errors'

create_file 'app/views/errors/application_error.html.erb', load_template('app/views/errors/application_error.html.erb', 'custom_error_pages')
create_file 'app/views/errors/not_found.html.erb', load_template('app/views/errors/not_found.html.erb', 'custom_error_pages')
create_file 'app/views/errors/unprocessable_entity.html.erb', load_template('app/views/errors/unprocessable_entity.html.erb', 'custom_error_pages')

remove_file 'public/404.html'
remove_file 'public/422.html'
remove_file 'public/500.html'
