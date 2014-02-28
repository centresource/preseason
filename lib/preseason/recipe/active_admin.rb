class Preseason::Recipe::ActiveAdmin < Preseason::Recipe
  def prepare
    return unless config.authentication.active_admin?

    generate 'active_admin:install'
  end
end
