class Preseason::Preseason::Recipe::Schedule < Preseason::Preseason::Recipe
  def prepare
    mirror_file 'config/schedule.rb'
  end
end
