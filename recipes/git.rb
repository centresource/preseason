# create a local repo and then a remote repo in the Centresource org
# create master and develop remote branches
run 'git init'
run 'git add .'
run 'git commit -m "Initial commit"'

if yes? 'Do you want to create a Github repo? [y/n]'
  repo_name = ask('What do you want to name the Github repo?')
  github_username = ask('What is your Github username?')
  if yes? 'Is this a private repo? [y/n]'
    private_repo_answer = true
  else
    private_repo_answer = false
  end
  run <<-RUBY
    curl -u '#{github_username}' https://api.github.com/orgs/centresource/repos -d '{"name":"#{repo_name}",
                                                                         "private":"#{private_repo_answer}"}' > /dev/null
  RUBY
  run "git remote add origin git@github.com:centresource/#{repo_name}.git"
  run 'git push -u origin master'
  run 'git checkout -b develop'
  run 'git push -u origin develop'
end
