class Preseason::Recipe::Rspec < Preseason::Recipe
  def prepare
    generate 'rspec:install'
  end
end
