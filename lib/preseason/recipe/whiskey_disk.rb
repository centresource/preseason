class Preseason::Preseason::Recipe::WhiskeyDisk < Preseason::Preseason::Recipe
  def prepare
    mirror_file 'config/deploy.yml' unless config.heroku.use?
  end
end
