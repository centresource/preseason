require 'find'

# TODO
# - Include correct directories/files: app/templates/app/asets/*
# - Exclude correct files
# - Rename `.scss` files to `.css.scss`
# - Add gem dependecies: Bourbon, Neat, Normalize

class Preseason::Recipe::Playbook < Preseason::Recipe
  def prepare
    download_playbook_repo
    copy_playbook_assets
    clean_playbook_assets
    integrate_playbook
    remove_unwanted_files
  end

  private
  def exclude_rules
    # exclude:
    # => files and directories beginning with "."
    # => "README.md" files
    # => "application.coffee" file
    [/^\./, /^(?:README.md|application\.coffee)$/]
  end

  def download_playbook_repo
    get 'https://api.github.com/repos/centresource/playbook/tarball', '/tmp/playbook.tar.gz'
    remove_dir '/tmp/playbook' if Dir.exist? '/tmp/playbook'
    empty_directory '/tmp/playbook'
    `tar -zxvf /tmp/playbook.tar.gz -C /tmp/playbook 2> /dev/null`
    `mv /tmp/playbook/* /tmp/playbook/files`
  end

  def copy_playbook_assets
    Dir.glob('/tmp/playbook/files/app/assets/{stylesheets,javascripts}').each do |dir_path|
      Find.find(dir_path) do |path|
        if exclude_rules.none? { |regex| regex =~ File.basename(path) }
          if File.directory? path
            FileUtils.makedirs path[/(?:app).*/]
          else
            copy_file path, path[/(?:app).*/]
          end
        else
          Find.prune
        end
      end
    end

    # get vendor assets
    copy_file '/tmp/playbook/files/vendor/assets/stylesheets/normalize.css', 'vendor/assets/stylesheets/normalize.css'
    copy_file '/tmp/playbook/files/vendor/assets/javascripts/selectivizr.js', 'vendor/assets/javascripts/selectivizr.js'
    copy_file '/tmp/playbook/files/vendor/assets/javascripts/respond.js', 'vendor/assets/javascripts/respond.js'
  end

  def clean_playbook_assets
    gsub_file 'app/assets/stylesheets/screen.scss', 'bourbon/bourbon', 'bourbon'
    gsub_file 'app/assets/stylesheets/screen.scss', 'neat/neat', 'neat'
    gsub_file 'app/assets/stylesheets/base/_variables.scss', 'neat/neat-helpers', 'neat-helpers'
  end

  def integrate_playbook
    mirror_file 'app/views/layouts/application.html.erb'
  end

  def remove_unwanted_files
    remove_file 'app/assets/stylesheets/application.css'
    remove_file 'public/index.html'
    remove_file 'app/assets/images/rails.png'
    remove_dir '/tmp/playbook'
    remove_file '/tmp/playbook.tar.gz'
  end
end
