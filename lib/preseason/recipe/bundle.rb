class Preseason::Preseason::Recipe::Bundle < Preseason::Preseason::Recipe
  def prepare
    run 'bundle install'
    run 'rake db:create'
  end
end
