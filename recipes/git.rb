# create a local repo and then a remote repo in the Centresource org
# create master and develop remote branches
remove_file 'README.rdoc'
create_file 'README.md', parse_template('readme/README.md.erb')

run 'rake db:migrate db:test:clone'
run 'git init'
run 'git add .'
run 'git commit -m "Initial commit"'

if yes?("#{ask_color}Do you want to create a Github repo? #{option_color}[y/n]#{no_color}")
  repo_name = ask("#{ask_color}What do you want to name the Github repo?#{no_color}")
  github_username = ask("#{ask_color}What is your Github username?#{no_color}")
  public_repo_answer = yes?("#{ask_color}Is this a public repo? #{option_color}[y/n]#{no_color}")
  curl_params = %Q[{"name":"#{repo_name}","public":"#{public_repo_answer}"}]
  if yes?("#{ask_color}Does this repo belong to an organization? #{option_color}[y/n]#{no_color}")
    repo_owner = ask("#{ask_color}What is the org's name?#{no_color}")
    github_url = "https://api.github.com/orgs/#{repo_owner}/repos"
  else
    repo_owner = github_username
    github_url = "https://api.github.com/user/repos"
  end
  run "curl -u '#{github_username}' #{github_url} -d '#{curl_params}' > /dev/null"
  run "git remote add origin git@github.com:#{repo_owner}/#{repo_name}.git"

  run 'git push -u origin master'
  run 'git checkout -b staging'
  run 'git push -u origin staging'
end
