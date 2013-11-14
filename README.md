devpi Cookbook
==============
This cookbook installs and configures a devpi server.  [Devpi][1] is a
PyPI-compatible Python Index server that acts as both a freestanding
Python Index as well as a pull-through cache of the official Python 
Package Index.

[1]: http://doc.devpi.net/latest/

Requirements
------------
* **Python Versions**: Python 2.6 amd 2.7
* **Operating Systems**: Debian/Ubuntu, Enterprise Linux/CentOS

Attributes
----------

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <th><tt>[:devpiserver][:admin_group]</tt></th>
    <td>String</td>
    <td>This group can administer the devpi server.  This group
        will be created if it does not exist.</td>
    <td>devpi</td>
  </tr>
  <tr>
    <th><tt>[:devpiserver][:server_root]</tt></th>
    <td>String</td>
    <td>Store server data in this directory.  This directory will be
        created if it does not exist.</td>
    <td>/opt/devpi-server/data</td>
  </tr>
  <tr>
    <th><tt>[:devpiserver][:server_port]</tt></th>
    <td>Integer</td>
    <td>Port number that the server will listen on.</td>
    <td>3141</td>
  </tr>
  <tr>
    <th><tt>[:devpiserver][:daemon_user]</tt></th>
    <td>String</td>
    <td>Run the daemon as this user.  This user will be created if
        it does not exist.</td>
    <td>devpi</td>
  </tr>
  <tr>
    <th><tt>[:devpiserver][:version]</tt></th>
    <td>String or <tt>nil</tt></td>
    <td>Install this version of the devpi-server package.
        Set this attribute to <tt>nil</tt> to install the latest
        version.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <th><tt>[:devpiserver][:virtualenv]</tt></th>
    <td>Path</td>
    <td>Install Python virtual environment here</td>
    <td>/opt/devpi-server</td>
  </tr>
</table>

Usage
-----
#### devpi::server
Include this recipe in the `run_list` to install the devpi server.  It
will also create the daemon user and administrative group if necessary.

#### devpi::supervisor
Include this recipe to manage the devpi server using [supervisor][2].
It will install supervisor globally if necessary and add the devpi server
job.  This recipe assumes that the *server* recipe is already present in
the run list.

#### devpi::runit
Include this recipe to manage the devpi server using a [runit][3] script.
It will install runit globally if necessary and configure a devpi server
job.

[2]: http://supervisord.org/
[3]: http://smarden.org/runit/

Contributing
------------

1. Fork the repository on Github
2. Create a feature branch named *"feature/my_feature"* from `development`
3. Edit *README.md* to describe your feature
4. Write integration tests that verify your feature, run them with
   `rake integration-test` -- **they should fail**
5. Implement your feature in its default configuration.  You should not
   modify anything outside if the recipe at this point.  Keep iterating
   until the integration tests pass.
6. Implement unit tests to cover any configuration or platform details.
   Add attributes as needed at this point.  Run unit tests with `rake
   unit-test`.  
7. Run the static analysis tasks using `rake lint`.  Fix any problems that
   they find.
8. Update *README.md* to mention any new attributes and add yourself to
   the **AUTHORS** list.
9. Issue a pull-request on Github.

*HACKING.md* contains additional details about developing in this cookbook.

License and Authors
-------------------
#### Cookbook Authors:

* Dave Shawley

#### License:

Copyright (C) 2013 Dave Shawley

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
