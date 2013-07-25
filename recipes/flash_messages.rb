# set up flash messages
empty_directory 'app/views/shared'
mirror_file 'app/views/shared/_flash.html.erb', "#{template_path}/default"
