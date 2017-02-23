class Preseason
  module Config
    class Bourbon
      include Config

      attr_accessor :library

      def ask_user
        if yes? "Would you like to use Bourbon and Neat? [y/n]"
          self.library = :bourbon
        end
      end

      def bourbon?
        library == :bourbon
      end
    end
  end
end
