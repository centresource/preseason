if @template_options[:db_choice] == 'postgres'
  if yes? 'Do you want to setup Heroku? [y/n]'
    #precompile assets
    run "rake assets:precompile"

    #login and create the app on heroku
    run "heroku login"
    run "heroku create #{app_name}"

    #setup pgbackups
    run "heroku addons:add pgbackups"

    #push to heroku
    run "git push heroku master"
  end
end
