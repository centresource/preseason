module Rails
  module Generators
    module Actions

      require 'erb'

      attr_reader :template_options

      def ask_color
        "\033[35m" # magenta
      end

      def option_color
        "\033[33m" # yellow
      end

      def no_color
        "\033[0m" # reset
      end

      def load_options
        @template_options ||= {}
        @template_options[:db_adapters] = {'postgres' => 'postgresql', 'mysql' => 'mysql2', 'sqlite' => 'sqlite3'}
        @template_options[:db_gems] = {'postgres' => 'pg', 'mysql' => 'mysql2', 'sqlite' => 'sqlite3'}
        @template_options[:db_choice] = ask "#{ask_color}What db will you be using?#{no_color}", :limited_to => ['postgres', 'mysql', 'sqlite']

        unless @template_options[:db_choice] == 'sqlite'
          @template_options[:username] = ask "#{ask_color}What is your #{@template_options[:db_choice]} database username?#{no_color} (leave blank for `whoami`)"
          @template_options[:username] = (`whoami`).chomp if @template_options[:username].blank?
          @template_options[:password] = ask "#{ask_color}What is your #{@template_options[:db_choice]} database password?#{no_color} (leave blank for none)"
        end

        if yes? "#{ask_color}Will you be using Factory Girl? #{option_color}[y/n]#{no_color}"
          @template_options[:factory_girl] = true
        elsif yes? "#{ask_color}Ok then, how about Object Daddy? #{option_color}[y/n]#{no_color}"
          @template_options[:object_daddy] = true
          say 'Hello, Jeremy.'
        end

        if yes? "#{ask_color}Will you be using Authlogic? #{option_color}[y/n]#{no_color}"
          @template_options[:authlogic] = true
        elsif yes? "#{ask_color}Will you be using ActiveAdmin? #{option_color}[y/n]#{no_color}"
          @template_options[:active_admin] = true
          @template_options[:devise] = true
        elsif yes? "#{ask_color}Ok then, how about Devise? #{option_color}[y/n]#{no_color}"
          @template_options[:devise] = true
        end

        # will they be hosting the app on Heroku?
        if @template_options[:db_choice] == 'postgres' && yes?("#{ask_color}Will this app be deployed to Heroku? #{option_color}[y/n]#{no_color}")
          @template_options[:heroku] = true
        end

        @template_options[:readme] = []
      end

      def recipe(name)
        File.join File.dirname(__FILE__), 'recipes', "#{name}.rb"
      end

      def load_template(name, group)
        path = File.expand_path name, template_path(group)
        content = ERB.new(File.read path)
        content.result(binding)
      end

      def template_path(name)
        File.join(File.dirname(__FILE__), 'templates', name)
      end
    end
  end
end
