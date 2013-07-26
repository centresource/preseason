require File.expand_path(File.join(File.dirname(__FILE__), 'preseason'))
require File.expand_path(File.join(File.dirname(__FILE__), 'preseason/generator_context'))

Preseason::GeneratorContext.context = self
Preseason.new.game_on!
