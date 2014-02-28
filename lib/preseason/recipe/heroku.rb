class Preseason::Recipe::Heroku < Preseason::Recipe
  def prepare
    return unless config.heroku.use?

    if yes?("Do you want to setup Heroku? [y/n]")
      run "heroku auth:login"
      run "heroku apps:create #{app_name}"
      run "heroku addons:add pgbackups"
      run "git push heroku master -u"
    end
  end
end
