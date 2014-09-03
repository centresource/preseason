class Preseason::Recipe::Devise < Preseason::Recipe
  def prepare
    return unless config.authentication.devise?

    generate 'devise:install'
    generate 'devise', 'user'
    insert_into_file 'config/environments/development.rb', "\n  config.action_mailer.default_url_options = { :host => 'localhost:3000' }\n", :before => /^end$/
  end
end
