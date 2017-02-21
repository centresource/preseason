class Preseason::Recipe::Bitters < Preseason::Recipe
  def prepare
    install_bitters
  end

  private

  def install_bitters
    inside 'app/assets/stylesheets' do
      run 'bitters install'
      run 'cp -R bitters/* base/'
      run 'cat base/mixins/imports.scss >> base/mixins/_base.scss'
    end
  end
end
