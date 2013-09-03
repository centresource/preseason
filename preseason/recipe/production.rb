class Preseason::Recipe::Production < Preseason::Recipe
  def prepare
    enable_lograge unless config.heroku.use?
    configure_heroku_rails_deflate
  end
  
  private
  def enable_lograge
    insert_into_file 'config/environments/production.rb', "\n  config.lograge.enabled = true\n", :before => /^end$/
  end
  
  def configure_heroku_rails_deflate
    gsub_file 'config/environments/production.rb', 'config.serve_static_assets = false', 'config.serve_static_assets = true'
  end
end
