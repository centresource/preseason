class Preseason::Preseason::Recipe::Rspec < Preseason::Preseason::Recipe
  def prepare
    generate 'rspec:install'
  end
end
