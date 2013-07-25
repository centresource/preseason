# create db files
if @template_options[:db_choice] == 'sqlite'
  recipe_root = "#{template_path}/sqlite"
  with 'config/database.yml' do |path|
    mirror_file path, recipe_root
    copy_file "#{recipe_root}/#{path}", "#{path}.dist"
  end
else
  with 'config/database.yml' do |path|
    remove_file path
    create_file "#{path}.dist", parse_template("no-sqlite/#{path}.dist.erb")
    create_file path, parse_template("no-sqlite/#{path}.erb")
  end
end
append_to_file '.gitignore', 'config/database.yml'
