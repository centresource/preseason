## Contributing
1. fork the repo
2. exhibit your brilliance
3. push to your fork
4. submit a pull request

### Developing Locally
1. Fork the repo
2. Clone it to your local machine
3. `gem uninstall preseason` if you have it installed already
  - you may be prompted about removing an executable called preseason. The answer is yes
4. Crack the project open and make magic happen
5. `gem build preseason.gemspec`
  - should you receive an error message about the gem containing itself, try `rm preseason-0.0.1.gem` (or whatever version number we are on and stage that deletion
6. `gem install preseason` in your global gemset
7. In a separate terminal (or just outside the preseason dir), `presason <the name of your test project>`
8. Information on tests coming soon.

## Troubleshooting
* If you don't have QT libraries installed, you may get this error when installing Capybara
   * `Command 'qmake -spec macx-g++' not available`
      * Just run `brew install qt`. [Learn more](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)
* If you get the following error when building the gem, you need to stage the deletion of
`preseason.gem` file by `git stage -u preseason.x.x.x.gem`
```
└[$] gem build preseason.gemspec
WARNING:  See http://guides.rubygems.org/specification-reference/ for help
ERROR:  While executing gem ... (Gem::InvalidSpecificationException)
        from bin/rails:4:in `<main>'
```

### Submitting Bug Reports

If you're nice enough to submit a bug and make Preseason better, please
provide the following information to make resolving the bug easier.

1. Your operating system (and version)
2. Your shell type and version (Bash, Zsh, Bourne, etc)
3. Clear steps to reproduce the bug. What answers did you select during
   the prompts?
4. Any error messages seen in the console
5. A description of what you expected to happen
6. A description of what actually happened
