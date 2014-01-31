class Preseason::Recipe::Bitters < Preseason::Recipe
  def prepare
    install_bitters
    cleanup_bitters
  end

  private

  def install_bitters
    inside 'app/assets/stylesheets' do
      run 'bitters install'
      `cp -R bitters/* base/`
    end
  end

  def cleanup_bitters
    remove_dir 'app/assets/stylesheets/bitters'
    remove_file 'app/assets/stylesheets/base/_bitters.scss'
  end
end
