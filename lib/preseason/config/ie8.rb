class Preseason
  module Config
    class IE8
      include Config

      attr_accessor :enabled

      def ask_user
        self.enabled = yes? "Will this app need to support Internet Explorer 8 (install selectivizr.js and respond.js)? [y/n]"
      end

      def enabled?
        enabled
      end
    end
  end
end
