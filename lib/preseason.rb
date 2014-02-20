require "preseason/version"
require 'ostruct'
require_relative 'preseason/generator_context'
require_relative 'preseason/colorize'
require_relative 'preseason/config'
require_relative 'preseason/recipe'

module Preseason
  Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/preseason/{recipe,config}/*").each do |path|
    require path
  end

  class Preseason
    include Colorize

    attr_reader :config

    def initialize(context)
      Preseason::GeneratorContext.context = context

      @config = OpenStruct.new(
        :database => Config::Database.new,
        :factory => Config::Factory.new,
        :authentication => Config::Authentication.new,
        :ie8 => Config::IE8.new,
        :heroku => Config::Heroku.new
      )
    end

    def game_on!
      ask_for_config
      prepare_recipes
      display_post_install_messages
    end

    private
    def ask_for_config
      config.database.ask_user
      config.factory.ask_user
      config.authentication.ask_user
      config.heroku.ask_user if config.database.postgres?
      config.ie8.ask_user
    end

    def prepare_recipes
      recipes.each &:prepare
    end

    def display_post_install_messages
      recipes.each do |recipe|
        readme "#{recipe.recipe_root}/#{recipe.post_install_hook}" if recipe.post_install_hook
      end
    end

    def recipes
      @recipes ||= %w(
        Rvm
        Gemfile
        Gitignore
        Database
        Chosen
        Production
        Bundle
        Flash
        Application
        Schedule
        Rspec
        WhiskeyDisk
        Foreman
        Authlogic
        Devise
        ActiveAdmin
        CustomErrorPages
        Guard
        SporkRspec
        Playbook
        IE8
        Bitters
        Routes
        Git
        Heroku
      ).map { |recipe_name| "Preseason::Recipe::#{recipe_name}".constantize.new(config) }
    end
  end
end
