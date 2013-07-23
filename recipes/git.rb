# create a local repo and then a remote repo in the Centresource org
# create master and develop remote branches
run 'git init'
remove_file 'README.rdoc'
create_file 'README.md', load_template('README.md.erb', 'readme')
run 'git add .'
run 'git commit -m "Initial commit"'

if yes?("#{ask_color}Do you want to create a Github repo? #{option_color}[y/n]#{no_color}")
  repo_name = ask("#{ask_color}What do you want to name the Github repo?#{no_color}")
  github_username = ask("#{ask_color}What is your Github username?#{no_color}")
  if yes?("#{ask_color}Is this a public repo? #{option_color}[y/n]#{no_color}")
    public_repo_answer = true
  else
    public_repo_answer = false
  end
  if yes?("#{ask_color}Does this repo belong to an organization? #{option_color}[y/n]#{no_color}")
    org_name = ask("#{ask_color}What is the org's name?#{no_color}")
    run <<-RUBY
    curl -u '#{github_username}' https://api.github.com/orgs/#{org_name}/repos -d '{"name":"#{repo_name}",
                                                                        "public":"#{public_repo_answer}"}' > /dev/null
    RUBY
    run "git remote add origin git@github.com:#{org_name}/#{repo_name}.git"
  else
    run <<-RUBY
    curl -u '#{github_username}' https://api.github.com/user/repos -d '{"name":"#{repo_name}",
                                                                        "public":"#{public_repo_answer}"}' > /dev/null
    RUBY
    run "git remote add origin git@github.com:#{github_username}/#{repo_name}.git"
  end
  run 'git push -u origin master'
  run 'git checkout -b staging'
  run 'git push -u origin staging'
end
