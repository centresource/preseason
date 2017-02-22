class Preseason::Recipe::Bourbon < Preseason::Recipe
  def prepare
    configure_bourbon
    add_neat
    install_bitters
  end

  def configure_bourbon
    run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss'
    gsub_file 'app/assets/stylesheets/application.scss', '*= require_tree .', ''
    append_to_file 'app/assets/stylesheets/application.scss', "@import 'bourbon';\n"
  end

  def add_neat
    insert_into_file 'app/assets/stylesheets/application.scss', after: "@import 'bourbon';\n" do
      "@import 'neat';\n"
    end
  end

  def install_bitters
    inside 'app/assets/stylesheets' do
      run 'bundle exec bitters install'
    end
  end


end
