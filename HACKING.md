# DEVELOPMENT SETUP

First things first, lets get your Chef development environment
bootstrapped.  A lot has changed since I started this effort.  The most
notable one is that the Chef DK appeared.  Part of developing a Chef
cookbook used to be making sure that you had a solid Ruby development
environment set up using either _rvm_ or _rbenv_, _bundler_, and all
of the other tools.  Now it is much simpler, just install [ChefDK] and
be done with it.

[ChefDK]: https://downloads.getchef.com/chef-dk/

## VERIFYING YOUR ENVIRONMENT

Now you should be set up for development.  Give it a try by running the
style checks.

    prompt% foodcritic
    prompt% knife cookbook test --cookbook-path .. devpi
    checking devpi
    Running syntax check on devpi
    Validating ruby files
    Validating templates
    prompt% rubocop

Now let's make sure that you have test kitchen working by converging
one of the kitchen targets.

    prompt% kitchen converge supervisor-ubuntu
    -----> Starting Kitchen (v1.2.1)
    -----> Creating <supervisor-ubuntu-1404>...
           Bringing machine 'default' up with 'virtualbox' provider...
           ==> default: Importing base box 'opscode-ubuntu-14.04'...
           ==> default: Matching MAC address for NAT networking...
           ==> default: Setting the name of the VM: supervisor-ubuntu-1404_default_1417006611040_81105
           ==> default: Fixed port collision for 22 => 2222. Now on port 2200.
           ==> default: Clearing any previously set network interfaces...
           ==> default: Preparing network interfaces based on configuration...
               default: Adapter 1: nat
           ==> default: Forwarding ports...
               default: 22 => 2200 (adapter 1)
           ==> default: Booting VM...
           ==> default: Waiting for machine to boot. This may take a few minutes...
               default: SSH address: 127.0.0.1:2200
               default: SSH username: vagrant
               default: SSH auth method: private key
               default: Warning: Connection timeout. Retrying...
           ==> default: Machine booted and ready!
           ==> default: Checking for guest additions in VM...
           ==> default: Setting hostname...
           ==> default: Machine not provisioning because `--no-provision` is specified.
           Vagrant instance <supervisor-ubuntu-1404> created.
           Finished creating <supervisor-ubuntu-1404> (0m40.57s).
    -----> Converging <supervisor-ubuntu-1404>...
           Preparing files for transfer
           Resolving cookbook dependencies with Berkshelf 3.2.1...
           Removing non-cookbook files before transfer
    -----> Installing Chef Omnibus (true)
           downloading https://www.getchef.com/chef/install.sh
             to file /tmp/install.sh
    
           trying wget...
           
           <<< lots of output here >>>

    [2014-11-26T12:59:33+00:00] INFO: Chef Run complete in 102.871373345 seconds
    
    Running handlers:
    [2014-11-26T12:59:33+00:00] INFO: Running report handlers
    Running handlers complete
    [2014-11-26T12:59:33+00:00] INFO: Report handlers complete
    Chef Client finished, 46/55 resources updated in 108.958860764 seconds
           Finished converging <supervisor-ubuntu-1404> (2m16.64s).
    -----> Kitchen is finished. (2m57.84s)

If you get this far, then you are good to go.

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
executed by the [Bats] framework.

This sounds like a good bit of work and it is.  Luckily, [Fletcher
Nichol] came up with [test-kitchen] which automates running
integration tests across one or more vagrant images.  You can run the
integration tests with the **kitchen test** command.

[Bats]: https://github.com/sstephenson/bats
[Fletcher Nichol]: https://github.com/fnichol
[test-kitchen]: https://github.com/test-kitchen/test-kitchen

# DEVELOPMENT PROCESS

The development process that I use with this project is pretty simple.

1. Create a feature branch off of `master` for the new feature.
2. Update the README to describe the new recipe or changes to the existing
   recipe.  If there are any obvious attributes, document them now.
3. Write integration tests that express the default behavior of the feature.
4. Implement as much of the recipe as is necessary to meet the requirements
   of the integration test.
