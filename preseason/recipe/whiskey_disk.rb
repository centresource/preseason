class Preseason::Recipe::WhiskeyDisk < Preseason::Recipe
  def prepare
    mirror_file 'config/deploy.yml'
  end
end
