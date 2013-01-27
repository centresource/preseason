# set up flash messages
empty_directory 'app/views/shared'
create_file 'app/views/shared/_flash.html.erb', load_template('app/views/shared/_flash.html.erb','flash')
insert_into_file 'app/views/layouts/application.html.erb', "\n  <%= render 'shared/flash' %>", :after => "<body>\n"
