if @template_options[:heroku]
  if yes?("#{ask_color}Do you want to setup Heroku? #{option_color}[y/n]#{no_color}")
    #login and create the app on heroku
    run "heroku auth:login"
    run "heroku apps:create #{app_name}"

    #setup pgbackups
    run "heroku addons:add pgbackups"

    #push to heroku
    run "git push heroku master -u"
  end
end
