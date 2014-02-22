class Preseason::Preseason::Recipe::Foreman < Preseason::Preseason::Recipe
  def prepare
    create_file 'Procfile', ''
  end
end
