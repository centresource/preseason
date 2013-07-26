class Preseason
  module Config
    class Factory
      include Config
  
      attr_accessor :factory
  
      def ask_user
        if yes? "Will you be using Factory Girl? [y/n]"
          self.factory = :factory_girl
        elsif yes? "Ok then, how about Object Daddy? [y/n]"
          self.factory = :object_daddy
          say 'Hello, Jeremy.'
        end
      end
  
      def factory_girl?
        factory == :factory_girl
      end
  
      def jeremy?
        factory == :object_daddy
      end
    end
  end
end
