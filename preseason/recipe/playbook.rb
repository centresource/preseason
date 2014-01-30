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
    [/^\./, /^(?:readme.md|application\.coffee|syntax\.scss)$/]
  end

  def download_playbook_repo
    get 'https://api.github.com/repos/centresource/generator-playbook/tarball', '/tmp/playbook.tar.gz'
    remove_dir '/tmp/centresource-generator-playbook*' if Dir.exist? '/tmp/centresource-generator-playbook*'
    remove_dir '/tmp/playbook-css' if Dir.exist? '/tmp/playbook-css'
    `tar -zxvf /tmp/playbook.tar.gz -C /tmp 2> /dev/null`
    `mv /tmp/centresource-generator-playbook*/app/templates/app/assets/_scss /tmp/playbook-css`
  end

  def copy_playbook_assets
    Find.find('/tmp/playbook-css/') do |path|
      if exclude_rules.none? { |regex| regex =~ File.basename(path) }
        style_path = path.gsub('/tmp/playbook-css/', 'app/assets/stylesheets/')
        if File.directory? path
          FileUtils.makedirs style_path
        else
          copy_file path, style_path
        end
      else
        Find.prune
      end
    end
  end

  def clean_playbook_assets
    gsub_file 'app/assets/stylesheets/screen.scss', 'bourbon/app/assets/stylesheets/bourbon', 'bourbon'
    gsub_file 'app/assets/stylesheets/screen.scss', 'neat/app/assets/stylesheets/neat-helpers', 'neat-helpers'
    gsub_file 'app/assets/stylesheets/screen.scss', 'neat/app/assets/stylesheets/neat', 'neat'
  end

  def integrate_playbook
    mirror_file 'app/views/layouts/application.html.erb'
  end

  def remove_unwanted_files
    remove_file 'app/assets/stylesheets/application.css'
    remove_file 'public/index.html'
    remove_file 'app/assets/images/rails.png'
    remove_dir '/tmp/centresource-generator-playbook*'
    remove_dir '/tmp/playbook-css'
    remove_file '/tmp/playbook.tar.gz'
  end
end
