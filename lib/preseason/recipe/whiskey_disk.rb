class Preseason::Recipe::WhiskeyDisk < Preseason::Recipe
  def prepare
    mirror_file 'config/deploy.yml' if config.whiskey_disk.use?
  end
end
