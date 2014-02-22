class Preseason::Preseason::Recipe::Database < Preseason::Preseason::Recipe
  def recipe_root
    # this is only used in the sqlite context
    "#{template_path}/sqlite"
  end

  def prepare
    config.database.sqlite? ? prepare_sqlite : prepare_default
    append_to_file '.gitignore', "\n#{db_yml}"
  end

  private
  def prepare_default
    remove_file db_yml
    create_file "#{db_yml}.dist", parse_template("database/#{db_yml}.dist.erb")
    create_file db_yml, parse_template("database/#{db_yml}.erb")
  end

  def prepare_sqlite
    mirror_file db_yml
    copy_file "#{recipe_root}/#{db_yml}", "#{db_yml}.dist"
    append_to_file '.gitignore', db_yml
  end

  def db_yml
    'config/database.yml'
  end
end
