class Preseason
  module Config
    class Factory
      include Config

      attr_accessor :library

      def ask_user
        if yes? "Will you be using Factory Girl? [y/n]"
          self.library = :factory_girl
        end
      end

      def factory_girl?
        library == :factory_girl
      end
    end
  end
end
