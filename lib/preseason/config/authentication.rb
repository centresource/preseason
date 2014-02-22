module Preseason
  class Preseason
    module Config
      class Authentication
        include Config

        attr_accessor :library

        def ask_user
          if yes? "Will you be using Authlogic? [y/n]"
            self.library = :authlogic
          elsif yes? "Will you be using ActiveAdmin? [y/n]"
            self.library = :active_admin
          elsif yes? "Ok then, how about Devise? [y/n]"
            self.library = :devise
          end
        end

        def authlogic?
          library == :authlogic
        end

        def active_admin?
          library == :active_admin
        end

        def devise?
          library == :devise || active_admin?
        end
      end
    end
  end
end
