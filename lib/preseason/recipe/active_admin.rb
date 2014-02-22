class Preseason::Preseason::Recipe::ActiveAdmin < Preseason::Preseason::Recipe
  def prepare
    return unless config.authentication.active_admin?

    generate 'active_admin:install'
  end
end
