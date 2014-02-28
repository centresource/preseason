class Preseason::Recipe::IE8 < Preseason::Recipe
  def prepare
    return unless config.ie8.enabled?

    copy_js
    insert_into_layout
  end

  private

  def copy_js
    mirror_file 'app/assets/javascripts/ie8.coffee'
  end

  def insert_into_layout
    insert_into_file 'app/views/layouts/application.html.erb', "\n\n    <!--[if IE 8]>\n      <%= javascript_include_tag 'ie8' %>\n    <![endif]-->", :after => /^    \<\%\= yield \%\>$/
  end
end
