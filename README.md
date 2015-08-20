# Sky Bill Proxy

## Overview

The application is made up of a REST proxy written in Ruby using the sinatra framework, and a webpage constructed using HTML, CSS, 
JavaScript, jQuery and mustache.

The simple proxy makes a REST call to a service providing the customers billing information in JSON format.  This is checked and then
returned to the calling webpage.

There are several pros and cons with this appraoch:

### Pros

* The proxy server need not render any content, this means that the HTML etc can be served by a web server and cached as it doesn't change
* The CPU load on the server is relatively small and the rendering effort is carried out on the client
* With a suitable JavaScript framework, e.g. Bootstrap, a page can be designed that is responsive and re-sizes to any device

### Cons

* The proxy is I/O bound and each connection waits until the REST call to the bill server is complete

## Configuration



### Environment

There are several environment variables that the application makes use of.  More can be added by including those in the configuration file.
Only the RACK_ENV environment variable is mandatory in the sense that it is always present for any RACK application.


#### RACK_ENV

This is a standard variable used to communicate the environment in which a RACK application is running.  The values this variable can take the following values

* development
* test
* production

For normal development work locally the value of this variable is obviously "development".  When running tests however it has been set to "test" in the Rakefile to force that configuration.

When running under heroku the value "production" is set.


## Running

### Check out the code

```
git clone https://github.com/fionahiklas/skybill-sinatra.git
```


### Install Gems

Run the following

```
gem install bundler --user-install
export PATH=~/.gem/ruby/2.0.0/bin:$PATH

cd <base of cloned code>

bundle install --path ~/.gem
```

### Start using rack

Run the following command to start the server

```
rackup
```

You can then access the index page at the following URL

```
http://localhost:9292/html/index.html
```


## Tests

### Ruby

The ruby tests make use of rack-test and test/unit, they can be executed with the following command

```
rake test
```


### QUnit

The [Qunit](http://qunitjs.com/) tests for the front-end can be executed by loading each html page under the test/qunit directory into a web browser of your choice (I used firefox).
