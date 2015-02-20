class Preseason
  module Config
    class WhiskeyDisk
      include Config

      attr_accessor :use

      def ask_user
        self.use = yes? "Would you like to include whiskey_disk? [y/n]"
      end

      def use?
        use
      end
    end
  end
end
