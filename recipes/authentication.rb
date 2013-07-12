# authlogic/devise
if @template_options[:authlogic]
  # models
  generate 'model user first_name:string last_name:string email:string crypted_password:string password_salt:string persistence_token:string perishable_token:string'

  insert_into_file 'app/models/user.rb', :before => 'end' do
    load_template 'app/models/user.rb', 'authlogic'
  end

  create_file 'app/models/user_session.rb', load_template('app/models/user_session.rb', 'authlogic')

  # routes
  insert_into_file 'config/routes.rb', :before => 'end' do
    load_template 'config/routes.rb', 'routes'
  end

  # controllers
  create_file 'app/controllers/user_session_controller.rb', load_template('app/controllers/user_session_controller.rb', 'authlogic')

  insert_into_file 'app/controllers/application_controller.rb', :after => 'protect_from_forgery' do
    load_template 'app/controllers/application_controller.rb', 'authlogic'
  end

  # views
  create_file 'app/views/user_session/new.html.erb', load_template('app/views/user_session/new.html.erb', 'authlogic')
  create_file 'app/views/user_session/forgot_password.html.erb', load_template('app/views/user_session/forgot_password.html.erb', 'authlogic')
  create_file 'app/views/user_session/acquire_password.html.erb', load_template('app/views/user_session/acquire_password.html.erb', 'authlogic')

  # mailer (for password reset)
  generate 'mailer SiteMailer'

  insert_into_file 'app/mailers/site_mailer.rb', :before => 'end' do
    load_template 'app/mailers/site_mailer.rb', 'authlogic'
  end

  create_file 'app/views/site_mailer/password_reset_instructions.html.erb', load_template('app/views/site_mailer/password_reset_instructions.html.erb', 'authlogic')

  @template_options[:readme] << 'templates/authlogic/POST_INSTALL'

elsif @template_options[:devise]
  generate 'devise:install' unless @template_options[:active_admin]
  generate 'devise', 'user'
end
