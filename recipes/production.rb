# enable lograge for production
insert_into_file 'config/environments/production.rb', "\n  config.lograge.enabled = true\n", :before => /^end$/

# change setting for heroku_rails_deflate gem
gsub_file 'config/environments/production.rb', 'config.serve_static_assets = false', 'config.serve_static_assets = true'