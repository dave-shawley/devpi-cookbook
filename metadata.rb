name             'devpi'
maintainer       'Dave Shawley'
maintainer_email 'daveshawley@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures a devpi server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'python'
['ubuntu', 'centos'].each do |platform|
  supports platform
end

recipe 'devpi::server', 'Installs the devpi-server package.'
