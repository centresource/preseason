class Preseason
  module Config
    class Heroku
      include Config

      attr_accessor :use

      def ask_user
        self.use = yes? "Will this app be deployed to Heroku? [y/n]"
      end

      def use?
        use
      end
    end
  end
end
