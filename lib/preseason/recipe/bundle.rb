class Preseason::Recipe::Bundle < Preseason::Recipe
  def prepare
    run 'bundle install'
    run 'rake db:create'
  end
end
