require 'find'

class Preseason::Recipe::Playbook < Preseason::Recipe
  def prepare
    download_playbook_repo
    copy_playbook_assets
    clean_playbook_assets
    add_normalize_import
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
    version = '1.1.3.1'
    get "https://github.com/centresource/playbook/archive/v#{version}.tar.gz", '/tmp/playbook.tar.gz'
    remove_dir "/tmp/playbook-#{version}" if Dir.exist? "/tmp/playbook-#{version}"
    remove_dir '/tmp/playbook-css' if Dir.exist? '/tmp/playbook-css'
    `tar -zxvf /tmp/playbook.tar.gz -C /tmp 2> /dev/null`
    `mv /tmp/playbook-#{version}/styles /tmp/playbook-css`
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

  def add_normalize_import
    insert_into_file 'app/assets/stylesheets/screen.scss', "@import \"normalize-rails/normalize\";\n", :before => '@import "bourbon";'
  end

  def integrate_playbook
    mirror_file 'app/views/layouts/application.html.erb'
    gsub_file 'app/views/layouts/application.html.erb', /Preseason by Centresource/, app_name
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
