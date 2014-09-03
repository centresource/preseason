class Preseason::Recipe::Bundle < Preseason::Recipe
  def prepare
    run 'bundle install'
    run 'bundle exec spring binstub --all'
    run 'rake db:create'
  end
end
