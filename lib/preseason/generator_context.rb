module Preseason
  class Preseason
    module GeneratorContext
      class << self
        attr_reader :context

        def context=(context)
          # squashes `rails new` attempt to run bundle install since we run it ourselves and the timing of `rails new` obscures our custom post_install messages
          context.define_singleton_method(:run_bundle, -> {})
          @context = context
        end
      end

      def method_missing(meth, *args, &blk)
        GeneratorContext.context.send meth, *args, &blk
      end
    end
  end
end
