class Preseason::Recipe::Foreman < Preseason::Recipe
  def prepare
    create_file 'Procfile', ''
  end
end
