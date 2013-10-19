begin
  require 'berkshelf'

  berks = ::Berkshelf::Berksfile.from_file 'Berksfile'
  FileUtils.rm_rf 'vendor/cookbooks'
  berks.install :path => 'vendor/cookbooks'
rescue LoadError
end
