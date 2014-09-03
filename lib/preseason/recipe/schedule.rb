class Preseason::Recipe::Schedule < Preseason::Recipe
  def prepare
    mirror_file 'config/schedule.rb'
  end
end
