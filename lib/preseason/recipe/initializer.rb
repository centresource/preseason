class Preseason::Recipe::Initializer < Preseason::Recipe
  def prepare
    initialize_assets
  end

  private
  def initialize_assets
    old_line = '# Rails.application.config.assets.precompile += %w( search.js )'
    new_line = 'Rails.application.config.assets.precompile += %w( screen.css )'
    gsub_file 'config/initializers/assets.rb', old_line, new_line
  end
end
