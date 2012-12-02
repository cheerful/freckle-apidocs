---
layout: default
title: Basics
---

Freckle's RESTful API enabled your application or script to 
access **entries** (list/search, read, create, update, delete, mass import),
**projects** (list, read, create, update, delete, archive, activate),
**tags** (list) and **users** (list, read, create, update, deactivate, get avatar).

Many applications use the Freckle API every day, among them web applications
like <a href="http://beanstalkapp.com">Beanstalk</a>, 
<a href="http://github.com">GitHub</a> and 
<a href="http://planscope.io">Planscope</a>, 
native mobile and desktop applications
like <a href="http://pigmentapp.com">Pigment</a> 
and <a href="http://punch.fousa.be">Punch</a>
as well as many internal applications that our customers write to integrate 
with other software and services. Be creative!

We plan to extend and adapt the API to allow access to more resources
in the future. If you have any questions or feedback, please don't hesitate
to use the big blue feedback button on the left.

<p class="note">
If you plan to release a public client app for Freckle (such as a native 
mobile app, regardless if it's paid-for or free) you're welcome to do so. 
<i>Do not name apps "Freckle" or "Freckle for &lt;platform&gt;".</i>
Please contact us first with more details about your app if you want to 
use "Freckle" or the Freckle logo as name or icon of your app!
</p>

Freckle API Libraries
---------------------

There are several 3rd-party open source libraries for popular languages
available:

* Ruby: [letsfreckle-client]
* Python: [ipmb/freckle]
* Node.js: [nodefreckle]
* Clojure: [clj-freckle]

Additionally, the command-line tool [Pippi] can log time and access
other API functionality, which is great if you want to use the Freckle API
from a shell script.

<p class="note">
These are 3rd-party libraries and Freckle can't provide support for them.
Please contact the library authors directly if you need help with these.
</p>

URLs
----

Accessing the Freckle API uses the following URL schema:

    https://<subdomain>.letsfreckle.com/api/<resource>

Where **subdomain** is the subdomain of the account you want to access and 
**resource** is the resource (e.g. entries, projects, tags, users and so on).

For example, getting a list of projects from the "apitest" account via JSON would 
result in the URL:

    https://apitest.letsfreckle.com/api/projects.json

Resources are normally accessed via SSL only. Some resources can also be 
accessed through a regular HTTP request.

Authentication
--------------

An *authentication token* is needed for accessing the API. This token authenticates
a specific user of the account and can be found in 
<a href="http://letsfreckle.com/help/#faq_40">"settings & tools > API"</a> 
in the Freckle user interface. Treat authentications tokens like passwords!

A user can reset the API token at any time—be sure to handle authentication errors
in your application.

The token has to be sent for each request your application makes to the Freckle API.

There are two ways to send the token—examples are given using the [cURL] command line tool:

As *query parameter* named `token`:

{% highlight sh %}
curl -v https://apitest.letsfreckle.com/api/projects.json?token=lx3gi6pxdjtjn57afp8c2bv1me7g89j
{% endhighlight %}

As *HTTP header* `X-FreckleToken`:

{% highlight sh %}
curl -v -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects.json
{% endhighlight %}

For better readability of URLs, in this documentation the HTTP header method will be used for
the cURL examples. It's generally also a good idea to use the HTTP header method if you wrap
Freckle API calls in a library or module in your code.

<p class=note>
In order to make it easier for users to authenticate in interactive client applications
such as on mobile devices, the token can be retrieved via the 
<code>/api/user/api_auth_token</code> API method by using HTTP Basic Auth with the
user's email and password. See the Users section for more information.
</p>

Response codes and error handling
---------------------------------

A call to the API can result in one of five different outcomes:

* Everything works fine—a HTTP status code in the 200 range is returned;
  for reads and updates `200 OK` and for newly created resources `201 Created`.

* Authentication fails or the user's role doesn't permit an action: `401 Unauthorized`.
  If your application is an interactive, you likely want to ask the user for
  new security credentials and not use the API again until a new API token is provided.
  Ideally, your interactive app doesn't ever run into the case that a users' role doesn't permit
  an action, but it can happen especially if you cache data and it gets out of sync
  (for example the projects a "freelancer" user has access to). If you run into this
  issue, it's a good idea to invalidate your caches and fetch the data from the API again.
  
* On creating or updating, if required fields are missing, `422 Unprocessable Entity` is returned.

* There was an unhandled exception on the server side: `500 Internal Server Error`:
  This is rare, but can happen in exceptional circumstances. The best thing to do
  is to try the same call later.

* There's a timeout or a network issue and the connection is dropped without response:
  This is rare but it does happen. Try the call again.

Roles
-----

There are currently four user roles in Freckle: `administrator`, `owner`, `member`, and `freelancer`. 

Each Freckle user is assigned to one of these roles. Depending on the role, certain parts of the API
may not be available. For each resource, this documentation explains which roles have access and 
if there are any per-role restrictions (for example, a user with the "freelancer" role doesn't 
have access to all projects).

API Test Account
----------------

You can use our API test account for testing your code. The data from this test account 
will be regularly wiped—don't rely on your test data being there the next day. Also note that you 
might not be the only person using this token at a certain time.

Domain: `apitest.letsfreckle.com`<br>
Token: `lx3gi6pxdjtjn57afp8c2bv1me7g89j`

If you do any kind of non-trivial client application or have special needs for API testing,
we recommend that you create a Freckle account specifically just for testing your application,
so you can be sure your data stays intact while you develop!

Try it now!

{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/projects.json
{% endhighlight %}

Instead of using cURL, you can also try it directly in your browser with <a href="http://hurl.it/hurls/4e6a8b89f7390b9b1408c966306db7301acbb6e4/f77acc2c0c6f7f44d2215025a9beab9191778233"><img src="hurl.png" width="35"></a>.

You should see something like:

{% highlight json %}
[ 
  { 
    "project": {
      "name": "Fixture Company",
      "unbillable_minutes": 120,
      "created_at": "2009-10-16T09:04:50Z",
      "billable": true,
      "budget_minutes": null,
      "minutes": 7560,
      "cached_tags": [ { /*...*/ } ]
    }
    /*...*/
  }
]
{% endhighlight %}

Data Formats
------------

The Freckle API can accept and return data in JSON or XML. 

Because it's awesome, we'll mostly use examples in JSON in this documentation,
however, XML works just as well.

There's no default format—to choose the data format you need to either add
a `.xml` or `.json` extension to URL you are calling, or set the
`Accept` HTTP header to `text/xml` or `application/json`.

Field formats
-------------

Freckle uses the following field formats:

* **IDs** are stored as 4-byte integers (range 1 to 2147483647)
* **Timestamps** are given UTC-based, e.g. `2012-01-09T08:33:29Z`
* **Dates** are given YYYY-MM-DD, e.g. `2011-07-26`

There's limits on the text length of some fields, but, with the exception
of tags which are limited to 30 characters, it's highly unlikely
that you'll hit those.

[letsfreckle-client]: https://github.com/ryanlecompte/letsfreckle-client
[ipmb/freckle]: https://github.com/ipmb/freckle
[nodefreckle]: https://github.com/tbranyen/nodefreckle
[clj-freckle]: https://github.com/mlehman/clj-freckle
[Pippi]: https://npmjs.org/package/pippi
[cURL]: http://curl.haxx.se
