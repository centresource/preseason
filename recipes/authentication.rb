# authlogic/devise
if @template_options[:authlogic]
  generate 'model user email:string crypted_password:string password_salt:string persistence_token:string perishable_token:string current_login_at:datetime last_login_at:datetime last_request_at:datetime login_count:integer last_login_ip:string current_login_ip:string'

  create_file 'app/models/user_session.rb', load_template('app/models/user_session.rb', 'authlogic')

  insert_into_file 'app/models/user.rb', :before => 'end' do
    load_template 'app/models/user.rb', 'authlogic'
  end

  insert_into_file 'config/routes.rb', :before => 'end' do
    load_template 'config/routes.rb', 'routes'
  end

  insert_into_file 'app/controller/application_controller.rb', :after => 'protect_from_forgery' do
    load_template 'app/controller/application_controller.rb', 'authlogic'
  end

  create_file 'app/controllers/user_session_controller.rb', load_template('app/controllers/user_session_controller.rb', 'authlogic')

elsif @template_options[:devise]
  generate 'devise:install' unless @template_options[:active_admin]
  generate 'devise', 'user'
end
