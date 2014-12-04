name 'devpi'
maintainer 'Dave Shawley'
maintainer_email 'daveshawley@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures a devpi server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.0'

depends 'nginx'
depends 'python'
%w(ubuntu centos).each do |platform|
  supports platform
end

recipe 'devpi::server', 'Installs the devpi-server package.'
recipe 'devpi::nginx', 'Configure nginx as an HTTP front-end.'
recipe 'devpi::client', 'Install the devpi-client package.'
