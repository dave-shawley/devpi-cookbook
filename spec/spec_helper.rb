# This option prevents SafeYAML from complaining in `load`.
SafeYAML::OPTIONS[:default_mode] = :safe

# This is a workaround to https://github.com/dtao/safe_yaml/issues/10
SafeYAML::OPTIONS[:deserialize_symbols] = true

# ChefSpec sets up the Chef cookbook_path so that it includes the
# vendor/cookbooks directory.  We need to tell Berkshelf to install
# our dependencies there.
begin
  require 'berkshelf'
  berks = ::Berkshelf::Berksfile.from_file 'Berksfile'
  FileUtils.rm_rf 'vendor/cookbooks'
  berks.install :path => 'vendor/cookbooks'
rescue LoadError
end

require File.expand_path('../helpers/chefspec', __FILE__)
