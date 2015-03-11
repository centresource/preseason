class Preseason::Recipe::Rspec < Preseason::Recipe
  def prepare
    run 'spring stop' # stop spring to allow rspec install, otherwise it hangs
    generate 'rspec:install'
  end
end
