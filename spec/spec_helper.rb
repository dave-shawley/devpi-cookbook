# Pull in commonly used libraries.
require 'chefspec'
require 'support/matchers.rb'

# Configure SafeYAML so that it doesn't complain so much.
require 'safe_yaml'

# This option prevents SafeYAML from complaining in `load`.
SafeYAML::OPTIONS[:default_mode] = :safe

# This is a workaround to https://github.com/dtao/safe_yaml/issues/10
SafeYAML::OPTIONS[:deserialize_symbols] = true

# ChefSpec sets up the Chef cookbook_path so that it includes the
# vendor/cookbooks directory.  We need to tell Berkshelf to install
# our dependencies there.
require 'berkshelf'
berks = ::Berkshelf::Berksfile.from_file 'Berksfile'
RSpec.configure do |config|
  config.cookbook_path = 'vendor/cookbooks'
  config.platform = 'ubuntu'
  config.version = '12.04'
  config.before(:suite) do
    FileUtils.rm_rf 'vendor/cookbooks'
    berks.install path: 'vendor/cookbooks'
  end
  config.after(:suite) do
    FileUtils.rm_rf 'vendor/cookbooks'
  end
end

# Dump the resources associated with a ChefSpec::Runner.
#
# This is best used in a `subject` block:
#
#     subject {
#       dump_chef_run @chef_run.converge described_recipe
#     }
#
# This will output a list of resources that participated in the run so that
# you can easily see which matchers should have been generated.
#
def dump_chef_run(runner)
  runner.run_context.resource_collection.each do |elm|
    puts "... #{elm.action}_#{elm.resource_name} '#{elm.name}'"
    yield(elm) if block_given?
  end
  runner
end
