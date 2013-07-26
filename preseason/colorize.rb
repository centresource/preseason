class Preseason
  module Colorize
    include Preseason::GeneratorContext
    
    # override method from Thor::Shell::Basic
    def ask(statement, *args)
      statement = colorize(statement)
      super
    end
  
    # override method from Thor::Shell::Basic
    def yes?(statement, color = nil)
      statement = colorize(statement)
      super
    end
  
    # override method from Rails::Generators::Actions
    def readme(path)
      begin
        say "#{option_color}"
        super
      ensure
        say "#{no_color}"
      end
    end
  
    private
    def colorize(statement)
      statement.insert 0, ask_color
      statement.insert option_index(statement), option_color if option_index(statement)
      statement.insert aside_index(statement) || -1, no_color
    
      statement
    end
    
    def option_index(statement)
      index = statement.rindex '['
      index if index && index > ask_color.size
    end
    
    def aside_index(statement)
      statement.rindex '('
    end
  
    def ask_color
      "\033[35m" # magenta
    end

    def option_color
      "\033[33m" # yellow
    end

    def no_color
      "\033[0m" # reset
    end
  end
end