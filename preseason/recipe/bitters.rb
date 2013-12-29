class Preseason::Recipe::Bitters < Preseason::Recipe
	def prepare
		inside 'app/assets/stylesheets/' do
    	run "bitters install" #, :capture => true, :verbose => false
    end
	end
end