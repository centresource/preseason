# Preseason
A Centresource Interactive Agency open internal project for generating new Rails applications.

### Why
We start new Ruby on Rails projects frequently. In doing so, we end up repeating many of the same steps. As Rubyists, we are always looking for ways to DRY things up. This project is intended to serve as a starting place for new Rails applications. Perhaps most importantly, it is **NOT** supposed to cover everything that every Rails app will ever need, but to be a good starting place.


### How
N.B. This project assumes you have a development environment setup that is capable of installing Rails projects. If not, start with the [Rails Guides](http://guides.rubyonrails.org/getting_started.html "Rails Guides"). You must also have the rvm gem installed. It also assumes that you are using SSH if you plan to make your project a Github repo.

0. ```gem install rvm``` if you don't already have the rvm gem installed

1. Clone the Preseason repo to the directory where your new app
   will begin:
        ```git clone git@github.com:centresource/preseason.git```

2. Make sure your db is running (postgres/mysql/etc)

3. Install a new Rails applicaiton with the following flag as shown:
        ```rails new [YourAppName] -m preseason/play.rb```

3. Follow the prompts to choose your database, etc.

4. Make a mistake? Just ```rm -rf``` your application's directory and
   repeat steps 1-3.

5. ```cd``` into your application directory

6. Make magic happen and dreams come true.

####Note About ERB Templates
If you need to write a template that executes ERB in the context of the running script and also outputs ERB for the purposes of the generated application code, be sure to escape your application-bound ERB as `<%%>`

### What
#### Preseason does the following:

+ asks for your db of preference
+ asks for your preferences on a few gems
+ creates an RVM gemset for your project and switches to that gemset
+ creates a new config/database.yml file with info from your db of
choice
+ adds the database.yml to .gitignore and creates a database.yml.dist as
a placeholder
+ adds .ruby-version, .ruby-gemset, swp files, public/assets, s3 files, etc to .gitignore
+ cleans up the Gemfile (removes comments and empty lines)
+ enables lograge for production
+ installs gems via bundler
+ creates a database
+ cleans up routes.rb
+ sets up flash messages in the application layout
+ sets config.assets.initialize_on_precompile to false
+ sets config.autoload_paths += %W(\#{config.root}/lib)
+ sets up a template for using whenever for cronjobs
+ installs rspec
+ installs and sets up bourbon and neat
+ creates a template for your whiskey_disk deploy in config/deploy.yml
+ creates Procfile for foreman
+ starts guard
+ creates a new spec_helper with spork and simplecov
+ removes the test unit directory, the smoke test page, and the Rails
logo.
+ migrates the db and recreates the test db from the DEV's schema
+ initializes a git repository, makes an "initial commit", and checks
out a 'develop' branch
+ setup Heroku



#### Preseason offers use of the following technologies:

+  Either postgresql, mysql2, or sqlite3
+  [factory_girl](https://github.com/thoughtbot/factory_girl) or [object_daddy](https://github.com/flogic/object_daddy) (for our friend, [Jeremy](https://github.com/awebneck))
+  [authlogic](https://github.com/binarylogic/authlogic), [devise](https://github.com/plataformatec/devise), or [activeadmin](http://www.activeadmin.info/) (with devise)
+  [rvm](https://rvm.io/)
+  [whiskey_disk](https://github.com/flogic/whiskey_disk) (for embarrassingly fast deployments)
+  [lograge](https://github.com/roidrage/lograge)
+  [whenever](https://github.com/javan/whenever)
+  [foreman](https://github.com/ddollar/foreman)
+  [guard](https://github.com/guard/guard)
+  [spork](https://github.com/sporkrb/spork)
+  [better_errors](https://github.com/charliesome/better_errors)
+  [pry](http://pryrepl.org/)
+  [awesome_print](https://github.com/michaeldv/awesome_print)
+  [quiet_assets](https://github.com/evrone/quiet_assets)
+  [rspec](http://rspec.info/)
+  [database_cleaner](https://github.com/bmabey/database_cleaner)
+  [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
+  [capybara-webkit](https://github.com/thoughtbot/capybara-webkit)
+  [launchy](https://github.com/copiousfreetime/launchy)
+  [fuubar](https://github.com/jeffkreeftmeijer/fuubar)
+  [simplecov](https://github.com/colszowka/simplecov)
+  [bourbon](http://bourbon.io/)
+  [neat](http://neat.bourbon.io/)


### Who

Preseason is a project by the development team at the [Centresource Interactive Agency](http://www.centresource.com) in Nashville, TN. The main push for this project is from [Cade Truitt](https://github.com/cade), [Travis Roberts](https://github.com/travisr), [Jeremy Holland](https://github.com/awebneck), [Adam Scott](https://github.com/ascot21) and [Max Beizer](https://github.com/maxbeizer)

### ToDos
* integration spec setup?
* add active admin precompile asset list to production.rb
* add logic to setup activeadmin for authlogic and allow choice between
  devise and authlogic rather than y/n for authlogic

## Contributing
1. fork the repo

2. exhibit your brilliance

3. push to your fork

4. submit a pull request


## Troubleshooting
* If you don't have QT libraries installed, you may get this error when installing Capybara
   * `Command 'qmake -spec macx-g++' not available`
      * Just run `brew install qt`. [Learn more](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)

## License
preseason is Copyright © 2012-2013 Centresource. It is free software, and may be redistributed under the terms specified in the [LICENSE](https://github.com/centresource/preseason/blob/master/LICENSE) file.
