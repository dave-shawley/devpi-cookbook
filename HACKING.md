# DEVELOPMENT SETUP

First things first, lets get your ruby environment bootstrapped.  If you
don't have a *good* ruby development environment set up, then download
and install [rvm][1.1] or [rbenv][1.2].  After that, we can set up things
the way that they should be set up.  The examples in this document use
*rbenv* with the [gemset plug-in][1.3] installed.

    prompt% gem install bundler --no-rdoc --no-ri
    Fetching: bundler-1.3.5.gem (100%)
    Successfully installed bundler-1.3.5
    1 gem installed
    prompt% bundle install --quiet  # this can take a few minutes

## VERIFYING YOUR ENVIRONMENT

Now you should be set up for development.  Give it a try by running the
unit tests.

    prompt% rake unit-test
    /Users/.../bin/ruby -S rspec ./spec/default_spec.rb
    *

    Pending:
      devpi::default should do something
        # Your recipe examples go here.
        # ./spec/default_spec.rb:5

    Finished in 0.00044 seconds
    1 example, 0 failures, 1 pending

If you get this far, then things are going pretty well.  Let's try
running our style checks.

	prompt% rake lint
  Running foodcritic check on devpi
  bundle exec knife cookbook test --cookbook-path .. devpi
  checking devpi
  Running syntax check on devpi
  Validating ruby files
  Validating templates


[1.1]: http://rvm.io/
[1.2]: http://rbenv.org/
[1.3]: https://github.com/jf/rbenv-gemset/


# TOOL CHAIN

One thing that the Ruby community has a wealth of is tools and utilities.
This project uses the following tools, not because they are the *best* but
simply because they are the ones that I happened to pick up along the way.

* [rake][2.1] is used for general task automation
* [foodcritic][2.2] is used for Chef cookbook best practice testing
* [rspec][2.3] runs my unit tests

[2.1]: http://rake.rubyforge.org/
[2.2]: http://acrmp.github.io/foodcritic/
[2.3]: http://rspec.info/
