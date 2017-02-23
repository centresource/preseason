class Preseason
  module Config
    class Templating
      include Config

      attr_accessor :library

      def ask_user
        if yes? "Would you like to use Slim templating language? [y/n]"
          self.library = :slim
        elsif yes? "Would you like to use HAML instead? [y/n]"
          self.library = :haml
        end
      end

      def slim?
        library == :slim
      end

      def haml?
        library == :haml
      end
    end
  end
end
