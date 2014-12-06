# devpi CHANGELOG

This file is used to list changes made in each version of the devpi cookbook.

## 2.0.0
- Fully embrace ChefDK for development.
- Switch attribute access from symbols to strings.
- Remove runit and supervisor recipes.
- Add `devpi_server` and `devpi_nginx_site` LWRPs.
- Removed nginx site template in lieu of letting the *devpi-server* utility
  generate one for us.  That is precisely what the `devpi_nginx_site` LWRP
  does.
- Remove log directory management.  The generated nginx configuration does
  not provide a means to configure this.

## 1.1.0 (Never Released)
- Add the *client* recipe that installs the `devpi` command line utility.
- Upgrade testing frameworks - ChefSpec 3.0, Test Kitchen 1.0.0.
- [devpi-cookbook#2](https://github.com/dave-shawley/devpi-cookbook/issues/2):
  Make the nginx log directory configurable via an attribute.

## 1.0.4 - 5-Jan-2014
- Copyright updated to include 2014.

## 1.0.3 - 4-Jan-2014
- The default nginx configuration limits the size of a POST/PUT request
  to 1MB which is inconveniently small.  This release makes the max upload
  size unlimited by setting `client_max_body_size` to zero.

## 1.0.2 - 30-Dec-2013
- [devpi-cookbook#2](https://github.com/dave-shawley/devpi-cookbook/issues/2):
  The *nginx* recipe was not creating the nginx log directory.
- The nginx service is not necessarily started when it is installed.  The
  recipe is required to explicitly start it.

## 1.0.1 - 24-Nov-2013
- [devpi-cookbook#1](https://github.com/dave-shawley/devpi-cookbook/pull/1):
  Renamed two Chef resources.  Resource names should consistently use
  "devpi-server" instead of "devpi server".

## 1.0.0 - 23-Nov-2013
- Add the *runit* recipe that manages the server daemon using the runit
  package.
- Add the *nginx* recipe which installs an nginx site to front end the running
  daemon.
- Change daemonizing recipes to include *server* by default.

## 0.2.0 - 14-Nov-2013
Create the *supervisor* recipe that manages the server daemon using the
supervisord package.

## 0.1.0 - 14-Nov-2013
Initial release of the devpi cookbook.  The *server* recipe will create
a python virtual environment and install the devpi-server into it.  You
are responsible for setting up a daemon process at this point.
