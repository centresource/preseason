class Preseason::Preseason::Recipe::Production < Preseason::Preseason::Recipe
  PRODUCTION = 'config/environments/production.rb'

  def prepare
    enable_lograge unless config.heroku.use?
    configure_heroku_rails_deflate
    add_precompile_assets
  end

  private
  def enable_lograge
    insert_into_file PRODUCTION, "\n  config.lograge.enabled = true\n", :before => /^end$/
  end

  def configure_heroku_rails_deflate
    gsub_file PRODUCTION, 'config.serve_static_assets = false', 'config.serve_static_assets = true'
  end

  def add_precompile_assets
    insert_into_file PRODUCTION, precompile_array, :before => /^end$/
  end

  def precompile_array
    str = <<-TXT

  config.assets.precompile += %w(
    screen.css
    ie8.js
    #{'active_admin.js' if config.authentication.active_admin?}
    #{'active_admin.css' if config.authentication.active_admin?}
  )
    TXT

    str.gsub /^\s{4}\n/, ''
  end
end
