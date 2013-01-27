# whiskey disk
create_file 'config/deploy.yml', <<-WHISKEY_DISK
  staging:
    domain: "deployment_user@staging.mydomain.com"
    deploy_to: "/path/to/where/i/deploy/staging.mydomain.com"
    repository: "https://github.com/username/project.git"
    branch: "staging"
    rake_env:
      RAILS_ENV: 'production'
WHISKEY_DISK