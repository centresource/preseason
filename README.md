# Preseason
A Centresource Interactive Agency open internal project for generating new Rails applications.

### Why
We start new Ruby on Rails projects frequently. In doing so, we end up
repeating many of the same steps. As Rubyists, we are always looking for
ways to DRY things up. This project is intended to serve as a launching
pad for new Rails applications. Perhaps most importantly, it is **NOT** supposed to cover everything that every Rails app will ever need, but to be a good starting place.

### How
N.B. This project assumes you have a development environment setup that is capable of installing Rails projects. If not, start with the [Rails Guides](http://guides.rubyonrails.org/getting_started.html "Rails Guides"). You must also have the rvm gem installed. It also assumes that you are using SSH if you plan to make your project a Github repo.

0. Install the `rvm` gem if you don't already have it installed

        `gem install rvm`

1. Install the preseason gem into your global gemset:

        `gem install preseason`

2. Make sure your db is running (postgres/mysql/etc)

3. Install a new Rails application with:

        `preseason <name_of_your_project>`

3. Follow the prompts to choose your database, etc.

4. Make a mistake? Just `rm -rf` your application's directory and repeat steps 1-4.

5. `cd` into your application directory

6. Make magic happen and dreams come true.

####Note About ERB Templates
If you need to write a template that executes ERB in the context of the running script and also outputs ERB for the purposes of the generated application code, be sure to escape your application-bound ERB as `<%%>`

### What
#### Preseason does the following:

+ asks for your db of preference
+ asks for your preferences on a few gems
+ creates an RVM gemset for your project and switches to that gemset
+ creates a new config/database.yml file with info from your db of choice
+ adds the database.yml to .gitignore and creates a database.yml.dist as a placeholder
+ adds .ruby-version, .ruby-gemset, swp files, public/assets, s3 files, etc to .gitignore
+ cleans up the Gemfile (removes comments and empty lines)
+ enables lograge for production (for non-Heroku apps)
+ installs gems via bundler
+ creates a database
+ cleans up routes.rb
+ sets up flash messages in the application layout
+ sets config.assets.initialize_on_precompile to false
+ sets config.autoload_paths += %W(\#{config.root}/lib)
+ sets up a template for using whenever for cronjobs (for non-Heroku apps)
+ installs rspec
  * You will see a message about spring stopping. This is to allow the
    `rspec:install` generator to run.
+ installs and sets up bourbon and neat
+ creates a template for your whiskey_disk deploy in config/deploy.yml (for non-Heroku apps)
+ creates Procfile for foreman
+ starts guard
+ creates a new spec_helper with spork and simplecov
+ removes the test unit directory, the smoke test page, and the Rails logo.
+ migrates the db and recreates the test db from the DEV's schema
+ initializes a git repository, makes an "initial commit", and checks out a 'develop' branch
+ sets up Heroku (optionally)

#### Preseason offers use of the following technologies:

+  Either postgresql, mysql2, or sqlite3
+  [factory_girl](https://github.com/thoughtbot/factory_girl)
+  [authlogic](https://github.com/binarylogic/authlogic), [devise](https://github.com/plataformatec/devise), or [activeadmin](http://www.activeadmin.info/) (with devise)
+  [rvm](https://rvm.io/)
+  [whiskey_disk](https://github.com/flogic/whiskey_disk) (for embarrassingly fast deployments)
+  [lograge](https://github.com/roidrage/lograge)
+  [whenever](https://github.com/javan/whenever)
+  [foreman](https://github.com/ddollar/foreman)
+  [guard](https://github.com/guard/guard)
+  [spork](https://github.com/sporkrb/spork)
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
+  [bitters](http://bitters.bourbon.io)

### Who

Preseason is a project by the development team at the [Centresource Interactive Agency](http://www.centresource.com) in Nashville, TN. The main push for this project is from [Cade Truitt](https://github.com/cade), [Travis Roberts](https://github.com/travisr), [Jeremy Holland](https://github.com/awebneck), [Adam Scott](https://github.com/ascot21), [Rian Rainey](https://github.com/rianrainey), and [Max Beizer](https://github.com/maxbeizer)

## License
Preseason is Copyright © 2015 Centresource. It is free software, and may be redistributed under the terms specified in the [LICENSE](https://github.com/centresource/preseason/blob/master/LICENSE) file.
