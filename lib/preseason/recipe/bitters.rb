class Preseason::Recipe::Bitters < Preseason::Recipe
  def prepare
    install_bitters
  end

  def install_bitters
    inside 'app/assets/stylesheets' do
      run 'bundle exec bitters install'
    end

    insert_into_file 'app/assets/stylesheets/application.scss', after: "@import 'neat';\n" do
      "@import 'base/base';\n"
    end
  end
end
