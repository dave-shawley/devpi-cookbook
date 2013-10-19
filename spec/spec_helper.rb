# This option prevents SafeYAML from complaining in `load`.
SafeYAML::OPTIONS[:default_mode] = :safe

# This is a workaround to https://github.com/dtao/safe_yaml/issues/10
SafeYAML::OPTIONS[:deserialize_symbols] = true

begin
  require 'berkshelf'

  berks = ::Berkshelf::Berksfile.from_file 'Berksfile'
  FileUtils.rm_rf 'vendor/cookbooks'
  berks.install :path => 'vendor/cookbooks'
rescue LoadError
end
