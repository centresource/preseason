class Preseason::Recipe::Bourbon < Preseason::Recipe
  def prepare
    configure_bourbon
    add_neat
  end

  def configure_bourbon
    remove_file 'app/assets/stylesheets/application.css'
    create_file 'app/assets/stylesheets/application.scss'
    append_to_file 'app/assets/stylesheets/application.scss', "@import 'bourbon';\n"
  end

  def add_neat
    insert_into_file 'app/assets/stylesheets/application.scss', after: "@import 'bourbon';\n" do
      "@import 'neat';\n"
    end
  end
end
