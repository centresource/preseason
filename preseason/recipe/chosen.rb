class Preseason::Recipe::Chosen < Preseason::Recipe
  def prepare
    append_to_file 'app/assets/javascripts/application.js', '//= require chosen-jquery'
  end
end