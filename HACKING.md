# DEVELOPMENT SETUP

First things first, lets get your ruby environment bootstrapped.  If you
don't have a *good* ruby development environment set up, then download
and install [rvm][1.1] or [rbenv][1.2].  After that, we can set up things
the way that they should be set up.

    prompt% gem install bundler --no-rdoc --no-ri
    Fetching: bundler-1.3.5.gem (100%)
    Successfully installed bundler-1.3.5
    1 gem installed
    prompt% bundle install --quiet  # this can take a few minutes

## VERIFYING YOUR ENVIRONMENT

Now you should be set up for development.  Give it a try by running the
style checks.

    prompt% rake lint
    Running foodcritic check on devpi
    bundle exec knife cookbook test --cookbook-path .. devpi
    checking devpi
    Running syntax check on devpi
    Validating ruby files
    Validating templates

Now let's run a simple "do nothing" integration test using [test-
kitchen][1.4].  It will spin up a virtual machine using [vagrant][1.5],
install Chef, install our cookbook, and run a suite of integration tests.

    prompt% rake integration-test
    Running foodcritic check on devpi
    kitchen test
    -----> Starting Kitchen (v1.0.0.beta.3)
    -----> Cleaning up any prior instances of <default-ubuntu-precise>
    -----> Destroying <default-ubuntu-precise>
           [kitchen::driver::vagrant command] BEGIN (vagrant destroy -f)
           [default] Destroying VM and associated drives...
           [kitchen::driver::vagrant command] END (0m4.72s)
    ... output omitted ...
    Installed Bats to /opt/busser/vendor/bats/bin/bats
          remove  /tmp/bats20131019-1302-1p20tfr
           Finished setting up <default-ubuntu-precise> (0m14.65s).
    -----> Verifying <default-ubuntu-precise>
           Suite path directory /opt/busser/suites does not exist, skipping.
    Uploading /opt/busser/suites/bats/my_test.bats (mode=0644)
    -----> Running bats test suite
    1..1
    ok 1 /etc/passwd exists
           Finished verifying <default-ubuntu-precise> (0m0.88s).
    -----> Destroying <default-ubuntu-precise>
           [kitchen::driver::vagrant command] BEGIN (vagrant destroy -f)
           [default] Forcing shutdown of VM...
           [default] Destroying VM and associated drives...
           [kitchen::driver::vagrant command] END (0m4.92s)
           Vagrant instance <default-ubuntu-precise> destroyed.
           Finished destroying <default-ubuntu-precise> (0m5.45s).
           Finished testing <default-ubuntu-precise> (1m23.10s).
    -----> Kitchen is finished. (1m23.37s)

In about a minute or so *test-kitchen* spun up a VM, installed our cookbook
along with its dependencies, and ran a very simple integration test for us.

[1.1]: http://rvm.io/
[1.2]: http://rbenv.org/
[1.3]: https://github.com/jf/rbenv-gemset/
[1.4]: https://github.com/opscode/test-kitchen/
[1.5]: http://vagrantup.com/


# TOOL CHAIN

One thing that the Ruby community has a wealth of is tools and utilities.
This project uses the following tools, not because they are the *best* but
simply because they are the ones that I happened to pick up along the way.

* [rake][2.1] is used for general task automation
* [foodcritic][2.2] is used for Chef cookbook best practice testing
* [test-kitchen][1.4] runs my integration tests
* [berkshelf][2.4] manages my cookbook dependencies
* [tailor][2.5] is used for Ruby style checks

[2.1]: http://rake.rubyforge.org/
[2.2]: http://acrmp.github.io/foodcritic/
[2.3]: http://rspec.info/
[2.4]: http://berkshelf.com/
[2.5]: http://github.com/turboladen/tailor/


# TESTING DURING DEVELOPMENT

You should be running tests regularly while you are developing.  Chef
recipes are a little different than "normal" code when it comes to testing.
There isn't a lot out there in terms of best practices so I took what I
found and put together my own process.

## Integration Tests

Integration tests bring up a machine image using Vagrant, provisions it
using Chef solo, and then executes a series of tests that verify that
the instance is working.  The run list for the node contains whatever is
necessary for a real node.  In this case, it will only be the *devpi*
recipe.  The integration tests are written using Bash shell commands as
executed by the [Bats][3.1] framework.

This sounds like a good bit of work and it is.  Luckily, [Fletcher
Nichol][3.2] came up with [test-kitchen][1.4] which automates running
integration tests across one or more vagrant images.  You can run the
integration tests with the **kitchen test** command.


# DEVELOPMENT PROCESS

The development process that I use with this project is pretty simple.

1. Create a feature branch off of `development` for the new feature.
2. Update the README to describe the new recipe or changes to the existing
   recipe.  If there are any obvious attributes, document them now.
3. Write integration tests that express the default behavior of the feature.
4. Implement as much of the recipe as is necessary to meet the requirements
   of the integration test.
5. Add attributes to make the new recipe configurable and add unit tests
   that verify the behavior of changing the attributes.

