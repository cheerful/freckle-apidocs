Freckle API docs
===========================

This site is built with [Jekyll][]. This specific implementation is based
on the ZeptoJS documentation site.

The site can be built with:

~~~ sh
$ jekyll
$ open public/index.html
~~~

Faster building & rebuilding
----------------------------

The `jekyll` command to rebuild the site can be slow because of syntax
highlighting with [Albino][]. There is an executable which uses a fork of Jekyll
that uses [Pygments.rb][] and is thus faster:

~~~ sh
# check if you have necessary gems installed
$ script/doctor

# faster rebuild!
$ script/jekyll [<file>, [<file2>, ...]]
~~~

For quicker rebuilding of the site, you can start up [Guard][]:

~~~ sh
$ script/doctor    # check dependencies
$ script/guard     # live rebuilding of the site!
~~~

Guard will use Jekyll to rebuild parts of the site as individual files change.

Because the site is rendered to "public/" directory, [Pow][] can be configured
to serve it:

~~~ sh
# while in repo's root dir:
$ ln -s `pwd` ~/.pow/freckle-apidocs
$ open http://freckle-apidocs.dev
~~~

  [jekyll]: http://jekyllrb.com/
  [pow]: http://pow.cx/
  [lr]: http://help.livereload.com/kb/general-use/browser-extensions
  [albino]: https://github.com/github/albino#readme
  [pygments.rb]: https://github.com/tmm1/pygments.rb#readme
  [guard]: https://github.com/guard/guard#readme
