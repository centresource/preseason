class Preseason::Recipe::ZeusRspec < Preseason::Recipe
  def prepare
    configure_zeus
    create_spec_helper
  end

  def configure_zeus
    run 'bundle exec zeus init'

    insert_into_file 'custom_plan.rb', after: "class CustomPlan < Zeus::Rails\n" do
      parse_template('zeus/custom_plan.erb')
    end
  end

  def create_spec_helper
    remove_file 'spec/spec_helper.rb'
    create_file 'spec/spec_helper.rb', parse_template('spec/spec_helper.erb')
    remove_file 'test'
  end
end
