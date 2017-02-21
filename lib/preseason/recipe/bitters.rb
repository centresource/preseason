class Preseason::Recipe::Bitters < Preseason::Recipe
  def prepare
    inside 'app/assets/stylesheets' do
      run 'bundle exec bitters install'
    end
  end
end
