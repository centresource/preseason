recipe_root = "#{template_path}/custom_error_pages"

insert_into_file 'config/application.rb', "\n\n    config.exceptions_app = self.routes", :after => /config.active_record.whitelist_attributes = true$/

with 'config/routes.rb' do |path|
  insert_into_file path, File.read("#{recipe_root}/#{path}"), :before => /^end$/
end

generate 'controller errors --no-helper --no-assets'

mirror_file 'app/views/errors/application_error.html.erb', recipe_root
mirror_file 'app/views/errors/not_found.html.erb', recipe_root
mirror_file 'app/views/errors/unprocessable_entity.html.erb', recipe_root

remove_file 'public/404.html'
remove_file 'public/422.html'
remove_file 'public/500.html'
