class Preseason::Recipe::SporkRspec < Preseason::Recipe
  def prepare
    remove_file 'spec/spec_helper.rb'
    create_file 'spec/spec_helper.rb', parse_template('spec/spec_helper.erb')
    remove_file 'test'
  end
end
