# create a local repo and then a remote repo in the Centresource org
# create master and develop remote branches
run 'git init'
remove_file 'README.rdoc'
create_file 'README.md', 'This Rails app was created with help from [Centresource\'s](http://www.centresource.com/ "Centresource") Trail Mix Project'
run 'git add .'
run 'git commit -m "Initial commit"'

if yes? 'Do you want to create a Github repo? [y/n]'
  repo_name = ask('What do you want to name the Github repo?')
  github_username = ask('What is your Github username?')
  if yes? 'Is this a public repo? [y/n]'
    private_repo_answer = true
  else
    private_repo_answer = false
  end
  if yes? 'Does this repo belong to an organization? [y/n]'
    org_name = ask('What is the org\'s name?')
    run <<-RUBY
    curl -u '#{github_username}' https://api.github.com/orgs/#{org_name}/repos -d '{"name":"#{repo_name}",
                                                                        "public":"#{private_repo_answer}"}' > /dev/null
    RUBY
    run "git remote add origin git@github.com:#{org_name}/#{repo_name}.git"
  else
    run <<-RUBY
    curl -u '#{github_username}' https://api.github.com/user/repos -d '{"name":"#{repo_name}",
                                                                        "public":"#{private_repo_answer}"}' > /dev/null
    RUBY
    run "git remote add origin git@github.com:#{github_username}/#{repo_name}.git"
  end
  run 'git push -u origin master'
  run 'git checkout -b develop'
  run 'git push -u origin develop'
end
