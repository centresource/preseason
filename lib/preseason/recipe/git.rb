class Preseason::Recipe::Git < Preseason::Recipe
  attr_reader :repo_name, :github_username, :public_repo

  def prepare
    remove_file 'README.rdoc'
    create_file 'README.md', parse_template('readme/README.md.erb')

    run 'rake db:migrate'
    run 'git init'
    run 'git add .'
    run 'git commit -m "Initial commit"'

    publish_to_github if github?
  end

  private
  def publish_to_github
    ask_repo_details
    ask_repo_owner if repo_organization?

    run "curl -u '#{github_username}' #{github_url} -d '#{curl_params}' > /dev/null"
    run "git remote add origin git@github.com:#{repo_owner}/#{repo_name}.git"

    run 'git push -u origin master'
    run 'git checkout -b staging'
    run 'git push -u origin staging'
  end

  def github?
    yes?("Do you want to create a Github repo? [y/n]")
  end

  def ask_repo_details
    @repo_name = ask "What do you want to name the Github repo?"
    @github_username = ask "What is your Github username?"
    @public_repo = yes? "Is this a public repo? [y/n]"
  end

  def ask_repo_owner
    @repo_owner = ask "What is the org's name?"
  end

  def repo_owner
    @repo_owner || github_username
  end

  def repo_organization?
    @repo_organization ||= yes? "Does this repo belong to an organization? [y/n]"
  end

  def github_url
    if repo_organization?
      "https://api.github.com/orgs/#{repo_owner}/repos"
    else
      "https://api.github.com/user/repos"
    end
  end

  def curl_params
    %Q[{"name":"#{repo_name}","public":"#{public_repo}"}]
  end
end
