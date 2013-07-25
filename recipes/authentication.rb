# authlogic/devise
if @template_options[:authlogic]
  recipe_root = "#{template_path}/authlogic"
  
  # model - if you edit this, mirror your changes in the user_factory
  generate 'model user first_name:string last_name:string email:string crypted_password:string password_salt:string persistence_token:string perishable_token:string'
  
  with 'app/models/user.rb' do |path|
    insert_into_file path, File.read("#{recipe_root}/#{path}"), :before => 'end'
  end
  mirror_file 'app/models/user_session.rb', recipe_root

  # factory
  mirror_file 'spec/factories/users.rb', recipe_root

  # routes
  with 'config/routes.rb' do |path|
    insert_into_file path, File.read("#{recipe_root}/#{path}"), :before => 'end'
  end

  # controllers
  mirror_file 'app/controllers/user_session_controller.rb', recipe_root

  with 'app/controllers/application_controller.rb' do |path|
    insert_into_file path, File.read("#{recipe_root}/#{path}"), :after => 'protect_from_forgery'
  end

  # views
  %w(new forgot_password acquire_password).each do |file_name|
    mirror_file "app/views/user_session/#{file_name}.html.erb", recipe_root
  end

  # mailer (for password reset)
  generate 'mailer SiteMailer'

  with 'app/mailers/site_mailer.rb' do |path|
    insert_into_file path, File.read("#{recipe_root}/#{path}"), :before => 'end'
  end

  mirror_file 'app/views/site_mailer/password_reset_instructions.html.erb', recipe_root

  @template_options[:readme] << 'templates/authlogic/POST_INSTALL'

elsif @template_options[:devise]
  generate 'devise:install' unless @template_options[:active_admin]
  generate 'devise', 'user'
end
