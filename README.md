#Freckle API v2 Documentation

This is the Documentation for version 2 of the Freckle API. Contributions are welcome, so please fork this repo and submit a [pull request](http://help.github.com/send-pull-requests/) with your changes!

## Overview

This site is built with [nanoc](http://nanoc.ws/).

## Setup

You can install all the necessary gems by running

~~~ sh
bundle install
~~~

You'll also want to setup [Pow](http://pow.cx/):

~~~ sh
# while in repo's root dir:
ln -s `pwd` ~/.pow/freckle-apidocs
open http://freckle-apidocs.dev
~~~

## Building The site

The preferred method of building the site is to use Guard, since it will handle compilation and hooks into livereload. However, you can also build the documentation straight from nanoc.

Regardless of how you build it, you can access it from: [http://freckle-apidocs.dev]

### With Guard

When you run Guard, the site is automatically compiled (and recompiled as you update files), and if you use the [Livereload Browser Extension](http://feedback.livereload.com/knowledgebase/articles/86242-how-do-i-install-and-use-the-browser-extensions-) the page will be updated for you automatically.

Just run:

~~~ sh
guard
~~~

and get to writing!

### Without Guard

Alternatively, you can just compile the site in nanoc without having to worry about monitoring the files or messing with Livereload:

~~~ sh
nanoc
~~~

## Building JSON objects

Instead of writing JSON objects by hand, we create Ruby hashes and use the `to_json` method to generate the necessary JSON.

Our objects are stored in `lib/resources/resources.rb`, and we use special helper methods to retrieve the object and generate it as JSON:

~~~~ erb
<%= json :user %>
<%= json_array :user %>
~~~~

The helper methods are located in `lib/resources/helpers.rb` (if you're curious about how they work).

## Setting Headers

We also use a helper method to specify the HTTP headers for our responses. This method allows you:

* set the HTTP status code
* include pagination as part of the header and specify the name used for pagination
* include any other HTTP headers as a key-value pair.


~~~~ erb
<%= headers 200, :pagination => true, :pagination_resource => "invoices" %>
~~~~

## Testing

You can test the site for bad links and other basic HTML no-nos by running:

~~~sh
rake test
~~~

## Publishing

To publish the site, run:

~~~sh
rake publish
~~~

This will grab the latest commit from the specified branch (defaults to `alpha`), compiles the site, and pushes the contents of `public/` to the `gh-pages` branch.

## Relevant Libraries:

* [nanoc](http://nanoc.ws/)
* [pow](http://pow.cx/)
* [livereload](http://help.livereload.com/kb/general-use/browser-extensions)
* [pygments.rb](https://github.com/tmm1/pygments.rb#readme)
* [guard](https://github.com/guard/guard#readme)
