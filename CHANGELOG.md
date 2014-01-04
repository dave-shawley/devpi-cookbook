devpi CHANGELOG
===============

This file is used to list changes made in each version of the devpi cookbook.

1.0.3
-----
- The default nginx configuration limits the size of a POST/PUT request
  to 1MB which is inconveniently small.  This release makes the max upload
  size unlimited by setting `client_max_body_size` to zero.

1.0.2
-----
- [devpi-cookbook#2](https://github.com/dave-shawley/devpi-cookbook/pull/2):
  The *nginx* recipe was not creating the nginx log directory.
- The nginx service is not necessarily started when it is installed.  The
  recipe is required to explicitly start it.

1.0.1
-----
- [devpi-cookbook#1](https://github.com/dave-shawley/devpi-cookbook/pull/1):
  Renamed two Chef resources.  Resource names should consistently use
  "devpi-server" instead of "devpi server".

1.0.0
-----
- Add the *runit* recipe that manages the server daemon using the runit
  package.
- Add the *nginx* recipe which installs an nginx site to front end the running
  daemon.
- Change daemonizing recipes to include *server* by default.

0.2.0
-----
Create the *supervisor* recipe that manages the server daemon using the
supervisord package.

0.1.0
-----
Initial release of the devpi cookbook.  The *server* recipe will create
a python virtual environment and install the devpi-server into it.  You
are responsible for setting up a daemon process at this point.