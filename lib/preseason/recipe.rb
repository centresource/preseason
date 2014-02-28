require 'erb'

class Preseason::Recipe
  include Preseason::GeneratorContext
  include Preseason::Colorize

  attr_reader :config

  def initialize(config)
    @config = config
  end

  def recipe_root
    "#{template_path}/#{self.class.name.demodulize.underscore}"
  end

  def post_install_hook
    # implement in child classes
  end

  private
  def mirror_file(path)
    remove_file(path) if File.exist?(path)
    copy_file "#{recipe_root}/#{path}", path
  end

  def parse_template(path)
    ERB.new(File.read(File.join(template_path, path))).result(binding)
  end

  def template_path
    @template_path ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end

  def insert(path, opts = {})
    insert_into_file path, File.read("#{recipe_root}/#{path}"), opts
  end
end
