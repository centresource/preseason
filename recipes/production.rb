# enable lograge for production
insert_into_file 'config/environments/production.rb', "\n  config.lograge.enabled = true\n", :before => /^end$/
