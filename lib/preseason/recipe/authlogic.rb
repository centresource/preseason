class Preseason::Preseason::Recipe::Authlogic < Preseason::Preseason::Recipe
  def prepare
    return unless config.authentication.authlogic?

    setup_model
    setup_factory
    setup_routes
    setup_controllers
    setup_views
    setup_mailer
  end

  def post_install_hook
    'POST_INSTALL' if config.authentication.authlogic?
  end

  private
  def setup_model
    # if you edit this, mirror your changes in the user_factory
    generate 'model user first_name:string last_name:string email:string crypted_password:string password_salt:string persistence_token:string perishable_token:string'

    insert 'app/models/user.rb', :before => /^end$/
    mirror_file 'app/models/user_session.rb'
  end

  def setup_factory
    mirror_file 'spec/factories/users.rb'
  end

  def setup_routes
    insert 'config/routes.rb', :before => /^end$/
  end

  def setup_controllers
    mirror_file 'app/controllers/user_session_controller.rb'
    insert 'app/controllers/application_controller.rb', :after => 'protect_from_forgery'
  end

  def setup_views
    %w(new forgot_password acquire_password).each do |file_name|
      mirror_file "app/views/user_session/#{file_name}.html.erb"
    end
  end

  def setup_mailer
    generate 'mailer SiteMailer'
    insert 'app/mailers/site_mailer.rb', :before => /^end$/
    mirror_file 'app/views/site_mailer/password_reset_instructions.html.erb'
  end
end
