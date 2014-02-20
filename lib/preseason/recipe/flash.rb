class Preseason::Recipe::Flash < Preseason::Recipe
  def prepare
    empty_directory 'app/views/shared'
    mirror_file 'app/views/shared/_flash.html.erb'
  end
end
