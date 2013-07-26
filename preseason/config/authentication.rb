class Preseason
  module Config
    class Authentication
      include Config
  
      attr_accessor :authentication
  
      def ask_user
        if yes? "Will you be using Authlogic? [y/n]"
          self.authentication = :authlogic
        elsif yes? "Will you be using ActiveAdmin? [y/n]"
          self.authentication = :active_admin
        elsif yes? "Ok then, how about Devise? [y/n]"
          self.authentication = :devise
        end
      end
  
      def authlogic?
        authentication == :authlogic
      end
  
      def active_admin?
        authentication == :active_admin
      end
  
      def devise?
        authentication == :devise || active_admin?
      end
    end
  end
end
