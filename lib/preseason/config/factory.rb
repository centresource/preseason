module Preseason
  class Preseason
    module Config
      class Factory
        include Config

        attr_accessor :library

        def ask_user
          if yes? "Will you be using Factory Girl? [y/n]"
            self.library = :factory_girl
          elsif yes? "Ok then, how about Object Daddy? [y/n]"
            self.library = :object_daddy
            say 'Hello, Jeremy.'
          end
        end

        def factory_girl?
          library == :factory_girl
        end

        def jeremy?
          library == :object_daddy
        end
      end
    end
  end
end
