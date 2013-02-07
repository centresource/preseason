# Centresource Rails Templates
## a centresource interactive agency open internal project

### Why
We start new Ruby on Rails projects frequently. In doing so, we end up
repeating many of the same steps. As Rubyists, we are always looking for
ways to DRY things up. This project is intended to serve as a starting
place for new Rails applications. Perhaps most importantly, it is
**NOT** supposed to cover everything that every Rails
app will ever need, but to be a good starting place.


### How
N.B. This project assumes you have a development environment setup that
is capable of installing Rails projects. If not, start with the [Rails
Guides](http://guides.rubyonrails.org/getting_started.html "Rails Guides").

1. Clone the csrailstemplates repo to the directory where your new app
   will begin:
        ```git clone git@github.com:centresource/csrailstemplates.git```

2. Install a new Rails applicaiton with the following flag as shown:
        ```rails new YourAppName -m csrailstemplates/common.rb```

3. Follow the prompts to choose your database, etc.

4. Make a mistake? Just ```rm -rf``` your application's directory and
   repeat steps 1-3.

5. ```cd``` into your application directory

6. Make magic happen and dreams come true.

####Note About ERB Templates
When adding a 'template' and you want the included erb to be parsed at runtime and not when this script runs, you must begin your erb tag with `<&&` instead of `<%`.  See `templates/flash/app/views/shared/_flash.html.erb` for an example.

### What
#### Centresource Rails Templates does the following:

+ asks for your db of preference
+ asks for your preferences on a few gems
+ creates an RVM gemset for your project and switches to that gemset
+ creates a new config/database.yml file with info from your db of
choice
+ adds the database.yml to .gitignore and creates a database.yml.dist as
a placeholder
+ adds .rvmrc, swp files, public/assets, s3 files, etc to .gitignore
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



#### Centresource Rails Templates offers use of the following technologies:

+  Either postgresql, mysql2, or sqlite3
+  Factory Girl or Object Daddy (for our friend, Jeremy)
+  Authlogic
+  Activeadmin or plain Devise
+  RVM
+  whiskey_disk (for embarasssingly fast deployments)
+  lograge
+  whenever (:require => false)
+  foreman
+  guard
+  spork
+  rb-fsevent (:require => false)
+  growl
+  better_errors
+  binding\_of\_collar
+  pry
+  awesome_print
+  quiet_assets
+  heroku
+  rspec
+  database_cleaner
+  shoulda-matchers
+  capybara-webkit
+  launchy
+  fuubar
+  simplecov
+  bourbon
+  neat


### Who

Centresource Rails Templates is a project by the development team at the
[Centresource Interactive Agency](http://www.centresource.com/
"Centresource.com") in Nashville, TN. The main push for this
project is from [Cade Truitt](https://github.com/cade), [Travis
Roberts](https://github.com/travisr), [Jeremy
Holland](https://github.com/awebneck) and [Adam Scott] (https://github.com/ascot21). This README was created by [Max
Beizer](https://github.com/maxbeizer). All rights reserved.

##ToDos
* integration spec setup?
* password reset/recover in controller for Authlogic
* Authlogic user factory
* add chosen.js for active admin (possibly for everything?)
* add active admin precompile asset list to production.rb
* ask/setup heroku?
