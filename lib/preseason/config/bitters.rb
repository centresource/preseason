class Preseason
  module Config
    class Bitters
      include Config

      attr_accessor :library

      def ask_user
        if yes? "Would you like to use Bourbon's pre-defined styles: Bitters? [y/n]"
          self.library = :bitters
        end
      end

      def bitters?
        library == :bitters
      end
    end
  end
end
