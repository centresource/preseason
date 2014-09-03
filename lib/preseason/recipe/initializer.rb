class Preseason::Recipe::Initializer < Preseason::Recipe
  attr_accessor :assets

  def prepare
    precompile_assets
    initialize_assets
  end

  private
  def precompile_assets
    @assets = %w(screen.css)
    @assets << 'ie8.js' if config.ie8.enabled?
  end

  def initialize_assets
    old_line = '# Rails.application.config.assets.precompile += %w( search.js )'
    new_line = "Rails.application.config.assets.precompile += #{@assets}"
    gsub_file 'config/initializers/assets.rb', old_line, new_line
  end
end
