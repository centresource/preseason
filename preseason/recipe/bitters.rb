class Preseason::Recipe::Bitters < Preseason::Recipe
  def prepare
    install_bitters
    cleanup_bitters
    rename_assets
  end

  private

  def install_bitters
    inside 'app/assets/stylesheets' do
      run 'bitters install'
      run 'cp -R bitters/* base/'
      run 'cat base/mixins/imports.scss >> base/mixins/_base.scss'
    end
  end

  def cleanup_bitters
    remove_dir 'app/assets/stylesheets/bitters'
    remove_file 'app/assets/stylesheets/base/_bitters.scss'
    remove_file 'app/assets/stylesheets/base/mixins/imports.scss'
    create_file 'app/assets/stylesheets/modules/.gitkeep'
    create_file 'app/assets/stylesheets/pages/.gitkeep'
  end

  def rename_assets
    Dir.glob("app/assets/stylesheets/**/*.scss").each do |path|
      unless path.end_with?('.css.scss')
        new_path = path.gsub('.scss', '.css.scss')
        run("mv #{path} #{new_path}")
      end
    end
  end
end
