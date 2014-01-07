class Preseason::Recipe::Bitters < Preseason::Recipe
	def prepare
		inside 'app/assets/stylesheets' do
    	run 'bitters install'
    	inject_into_file 'screen.scss', "@import \"bitters/bitters\";\n", :after => "@import \"bourbon\";\n"
    end
	end
end
