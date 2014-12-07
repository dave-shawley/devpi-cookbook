# devpi Cookbook

This cookbook installs and configures a devpi server.  [Devpi server]
is a PyPI-compatible Python Index server that acts as both a freestanding
Python Index as well as a pull-through cache of the official Python Package
Index.

[devpi server]: http://doc.devpi.net/latest/

## Requirements

* **Python Versions**: Python 2.6 amd 2.7
* **Operating Systems**: Debian/Ubuntu, Enterprise Linux/CentOS

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <th><tt>['devpiserver']['admin_group']</tt></th>
    <td>String</td>
    <td>This group can administer the devpi server.  This group
        will be created if it does not exist.</td>
    <td>devpi</td>
  </tr>
  <tr>
    <th><tt>['devpiserver']['server_root']</tt></th>
    <td>String</td>
    <td>Store server data in this directory.  This directory will be
        created if it does not exist.</td>
    <td>/opt/devpi-server/data</td>
  </tr>
  <tr>
    <th><tt>['devpiserver']['server_port']</tt></th>
    <td>Integer</td>
    <td>Port number that the server will listen on.</td>
    <td>3141</td>
  </tr>
  <tr>
    <th><tt>['devpiserver']['daemon_user']</tt></th>
    <td>String</td>
    <td>Expect the daemon to run as this user.  This user will be
        created if it does not exist.</td>
    <td>devpi</td>
  </tr>
  <tr>
    <th><tt>['devpiserver']['version']</tt></th>
    <td>String or <tt>nil</tt></td>
    <td>Install this version of the devpi-server package.
        Set this attribute to <tt>nil</tt> to install the latest
        version.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <th><tt>['devpiserver']['virtualenv']</tt></th>
    <td>Path</td>
    <td>Install Python virtual environment here</td>
    <td>/opt/devpi-server</td>
  </tr>
</table>

## Usage

Add the **devpi::server** recipe to your `run_list` to install [devpi server]
into a Python virtual environment created just for it.  The **devpi::nginx**
recipe creates an nginx site configured to expose the server on port 80.

The **devpi::client** recipe installs the `devpi` command line client into
a virtual directory.  The **devpi::server** recipe does not install the
command line client so you have to apply this recipe if you want the client
installed alongside the server.

### devpi::server
Include this recipe in the `run_list` to install the devpi server.  It
will also create the daemon user and administrative group if necessary.

### devpi::nginx
Include this recipe to expose the devpi-server using [nginx] as a
front-end server.

### devpi::client
Include this recipe to install the devpi command-line client.  This will
create a workstation from which you can manage a devpi-server installation.

[nginx]: http://nginx.org/

### devpi_server
This resource defines a complete installation of the [devpi server].  It will
create the Python virtual environment, install the packages/users/groups
needed to run the server, and even generate an nginx site definition for you.

#### Syntax
The simplest usage of the **devpi_server** resource is a single line that
identifies where the server instance should be installed into:

    devpi_server '/opt/devpi'

If you want to control more aspects of the installed server, you do so
using the normal syntax:

    devpi_server '/opt/devpi' do
      admin_group 'admins'
      port 6543
      nginx_site 'devpi'
    end

#### Actions
<table>
  <tr><th>Action</th><th>Description</th></tr>
  <tr>
    <td><tt>:create</tt></td>
    <td>Default. Installs a new devpi server instance into the named
      directory.</td>
  </tr>
  <tr>
    <td><tt>:delete</tt></td>
    <td>Removes an existing server instance.</td>
  </tr>
</table>

#### Attributes
<table>
  <tr><th>Attribute</th><th>Description</th></tr>
  <tr>
    <td><tt>directory</tt></td>
    <td>Install the devpi server into this directory.  This will
      be used as the root of the Python virtual environment created
      for the server.  If a virtual environment already exists, then
      it will be used as-is.  <b>This is the name attribute for this
      resource.</b></td>
  </tr>
  <tr>
    <td><tt>daemon_user</tt></td>
    <td>The user that will run the daemon.  This is used to set the
      appropriate permissions on the data directories.  The default
      value for this attribute is <i>devpi</i>.</td>
  </tr>
  <tr>
    <td><tt>admin_group</tt></td>
    <td>The user group responsible for managing the devpi server.  This
      is used to set the appropriate permissions on the devpi related
      directories.  The default value for this attribute is also
      <i>devpi</i>.</td>
  </tr>
  <tr>
    <td><tt>port</tt></td>
    <td>The port that the devpi server instance will listen on.  The
      default value for this attribute is <i>3141</i>.</td>
  </tr>
  <tr>
    <td><tt>data_directory</tt></td>
    <td>The directory used by the server to store the repository data.
      The default value for this attribute is a sub-directory of
      the server root named <i>data</i>.</td>
  </tr>
  <tr>
    <td><tt>nginx_site</tt></td>
    <td>If this attribute is set, then a new nginx site is created
      with the specified name.  It will be configured as a front-end
      for the installed server.</td>
  </tr>
  <tr>
    <td><tt>version</tt></td>
    <td>If this attribute is set, then this version of the devpi
      package will be installed.  If this is omitted or set to
      <tt>nil</tt>, then the most recent package will be installed.</td>
  </tr>
</table>

### devpi\_nginx_site
This resource uses the `devpi-server` command to generate an nginx site for
the server and optionally enable it.

#### Syntax
The root directory of the server installation is the only required parameter.

    devpi_nginx_site 'devpi' do
      directory '/opt/devpi'
    end

This will create and enable an nginx site named *devpi* for the server that
is installed in the */opt/devpi* virtual environment.

#### Actions
<table>
  <tr><th>Action</th><th>Description</th></tr>
  <tr>
    <td><tt>:create</tt></td>
    <td>Generate and optionally install the nginx configuration.</td>
  </tr>
</table>

#### Attributes
<table>
  <tr><th>Attribute</th><th>Description</th></tr>
  <tr>
    <td><tt>directory</tt></td>
    <td>Generate the site for the devpi server installed in this
      directory.</td>
  </tr>
  <tr>
    <td><tt>daemon_user</tt></td>
    <td>The user that will run the daemon.  The default value for this
      attribute is <i>devpi</i>.</td>
  </tr>
  <tr>
    <td><tt>admin_group</tt></td>
    <td>The user group responsible for managing the devpi server.
      The default value for this attribute is <i>devpi</i>.</td>
  </tr>
  <tr>
    <td><tt>port</tt></td>
    <td>The port that the devpi server listens on.  The
      default value for this attribute is <i>3141</i>.</td>
  </tr>
  <tr>
    <td><tt>data_directory</tt></td>
    <td>The directory used by the server to store the repository data.
      The default value for this attribute is a sub-directory of
      the server root named <i>data</i>.</td>
  </tr>
  <tr>
    <td><tt>enable</tt></td>
    <td>Boolean flag that controls whether the site is enabled or not.
      By default, the site will be enabled.</td>
  </tr>
</table>

### Vagrantfile
Though not a usage of the cookbook per-se, the *Vagrantfile* can be used
to start a stand-alone devpi-server instance.  **vagrant up** will start
the server and make it available at <http://172.16.0.11/>.

## Contributing

1. Fork the repository on Github
2. Create a new branch from `master` to hold your changes.
3. Create the test kitchen environment by running `kitchen converge` on
   whichever suite you are targeting.  Then run `kitchen verify` on the
   suite to make sure that the tests pass.
4. Edit *README.md* to describe your feature.
5. Write integration tests that verify your feature, run them with
   `kitchen verify` -- **they should fail**
6. Implement your feature in its default configuration.  You should not
   modify anything outside if the recipe at this point.  Keep iterating
   until the integration tests pass.
7. Run the static analysis tasks, `rubocop` and `foodcritic`, periodically.
   Fix any problems that they uncover.
8. Update *README.md* to mention any new attributes and add yourself to
   the **AUTHORS** list.
9. Issue a pull-request on Github.

*HACKING.md* contains additional details about developing in this cookbook.

## License and Authors

### Cookbook Authors:

* Dave Shawley

### License:

Copyright (C) 2013-2014 Dave Shawley

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
