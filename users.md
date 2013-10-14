---
layout: default
title: Users
description: Manage Freckle users with the Freckle Time Tracking RESTful API.
---

Jump to: [List](#list) | 
[Create](#create) | [Show](#read) | [Update](#update) | [Delete](#delete) | 
[Get current user](#self) | [Get avatar](#avatar) | [Get authentication token](#token)

<a id="list"></a>List users
------------------

    GET /api/users

Return a list of all active users in the account (doesn't return any deactivated users).

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users.json
{% endhighlight %}

Response:
{% highlight js %}
[
  {
    "user": {
      "week_start": null,
      "id": 5538,
      "last_name": "Freckle",
      "permissions": "integration, time, invoicing, reports, tags, 
        expenses, projects, team, people, account, billing, import",
      "login": "admin",
      "time_format": "fraction",
      "email": "apitestadmin@letsfreckle.com",
      "first_name": "Lets",
      "hashtags": true,
    }
},
{% endhighlight %}

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/274cffe2634174d4be8aedc1ede1b7aa8b1152e1/3effedf1507d0e1f33e601216e60ef059291dabe"><img src="hurl.png" width="35"></a>.
</div>
<div class="tab xml">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users.xml
{% endhighlight %}

Response:
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<users type="array">
  <user>
    <email>apitestadmin@letsfreckle.com</email>
    <first-name>Lets</first-name>
    <id type="integer">5538</id>
    <last-name>Freckle</last-name>
    <login>admin</login>
    <time-format>fraction</time-format>
    <week-start nil="true"></week-start>
    <permissions>integration, time, invoicing, reports, tags,
      expenses, projects, team, people, account, billing, import</permissions>
    <hashtags type="boolean">true</hashtags>
  </user>
  <!-- ...more users... -->
</users>
{% endhighlight %}

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/3d18d9ab851f3f7a5b97a92a22d9a07901afae4f/5774bcd466bb2529d08ab4f4bd69b81233d73ee1"><img src="hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and an array of users in the response body.

### Roles

All roles except the freelancer role can access this resource.

<a id="read"></a>Show user
----------

    GET /api/users/<id>

Returns details about a specific user. This method works with active and deactivated users.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538.json
{% endhighlight %}

Response:
{% highlight js %}
{
  "user": {
    "week_start": null,
    "id": 5538,
    "last_name": "Freckle",
    "permissions": "integration, time, invoicing, reports, tags,
      expenses, projects, team, people, account, billing, import",
    "time_format": "fraction",
    "email": "apitestadmin@letsfreckle.com",
    "first_name": "Lets",
    "hashtags": true,
  }
}
{% endhighlight %}

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/406175f1eb7a4e07c9b8f284217c084b23e7cb20/9cdff37a372430b3721f557537ce5595c828bb5a"><img src="hurl.png" width="35"></a>.
</div>
<div class="tab xml">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538.xml
{% endhighlight %}

Response:
{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<user>
  <email>apitestadmin@letsfreckle.com</email>
  <first-name>Lets</first-name>
  <id type="integer">5538</id>
  <last-name>Freckle</last-name>
  <time-format>fraction</time-format>
  <week-start nil="true"></week-start>
  <permissions>integration, time, invoicing, reports, tags, 
    expenses, projects, team, people, account, billing, import</permissions>
  <hashtags type="boolean">true</hashtags>
</user>
{% endhighlight %}

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/9e4b54872c4c0ccc8f2d87a304e15bb918b6e1e5/859678e18961ddc7a59b5931ffc1070476c66541"><img src="hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and a users in the response body.

**`401 Unauthorized`** is returned if there's no user with the given ID.
(This will be changed to `404 Not Found` in a future version of the API).

### Roles

A freelancer can only see details about him- or herself.
Other roles have access to all users in the account.

<a id="self"></a>Get current user
----------

    GET /api/users/self

Returns details about the currently logged in user. 
This method is otherwise identical with `GET /api/users/<id>`.

Try on <a href="http://apitest.developer.letsfreckle.com/hurls/2ada287ae61ad278c44fdf081db506e88deb22b2/17b262450ddfd8195aa4f3e77626dfa115988ced"><img src="hurl.png" width="35"></a>.

<a id="avatar"></a>Get a user's avatar
----------

    GET /api/users/<id>/avatar

Returns URLs to a user's avatar & thumbnail. If you build a client application,
we strongly suggest caching these images.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538/avatar.json
{% endhighlight %}

Response:

{% highlight js %}
{
  "thumbnail": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
  "id": 5538,
  "avatar": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
}
{% endhighlight %}

If the user has no current avatar, the `thumbnail` and `avatar` tag attributes are set to empty strings.

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/fa45bad8cdbcf57ee5d39f2086d74360d6d2ffd8/73f2a3532443e9f206f4809c656ecb5a84178c42"><img src="hurl.png" width="35"></a>.
</div>
<div class="tab xml">
{% highlight sh %}
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538/avatar.xml
{% endhighlight %}

Response:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<user>
  <thumbnail>http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg</thumbnail>
  <avatar>http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg</avatar>
  <id type="integer">5538</id>
</user>
{% endhighlight %}

If the user has no current avatar, the `thumbnail` and `avatar` tags will be empty:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<user>
  <thumbnail></thumbnail>
  <avatar></avatar>
  <id type="integer">5538</id>
</user>
{% endhighlight %}

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/fc7ae5b212e6271a6a92c64a605d748b4b04f692/a23d67c210866dbe9dc9dfa96593c58532253b82"><img src="hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and the avatar URLs in the response body.

**`401 Unauthorized`** is returned if there's no user with the given ID.
(This will be changed to `404 Not Found` in a future version of the API).

### Roles

The freelancer can only see the avatar for him- or herself. 
Other roles have access to all users in the account.


<a id="token"></a>Get authentication token
-------------------------------------

    GET /api/user/api_auth_token

The authentication token can be retrieved through the `api_auth_token` resource. 
3rd-party applications may prefer to ask their users for their email and password 
instead of the authentication token because those are easier to remember.

We strongly recommend using this method only for interactive applications.

Note that this part of the API uses HTTP Basic Authentication instead of token 
authentication.

<p class="note">
We plan to support OAuth authentication in a future API version.
</p>

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
{% highlight sh %}
$ curl https://test:testtest@apitest.letsfreckle.com/api/user/api_auth_token.json
{% endhighlight %}

Note that no API token is given, instead HTTP Basic Auth is used.

Response:

{% highlight js %}
{
  "user": {
    "api_auth_token": "lx3gi6pxdjtjn57afp8c2bv1me7g89j"
  }
}
{% endhighlight %}
</div>
<div class="tab xml">
{% highlight sh %}
$ curl https://test:testtest@apitest.letsfreckle.com/api/user/api_auth_token.xml
{% endhighlight %}

Note that no API token is given, instead HTTP Basic Auth is used.

Response:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<user>
  <api-auth-token>lx3gi6pxdjtjn57afp8c2bv1me7g89j</api-auth-token>
</user>
{% endhighlight %}
</div>
</div>

### Response codes

If the HTTP Basic Auth email and password are correct, returns 
**`200 OK`** and the token information in the response body.

**`401 Unauthorized`** is returned if authentication with
email and password.

### Roles

Anyone can retrieve their authentication token using this resource.

<a id="create"></a>Create user
--------

    POST /api/users

You can create new users, as long as your account limits are not reached.
This method, as well as the update and delete methods, are intended to make
it easier to synchronize users with your own systems. Note that you can't set
or change passwords.

Only the `first_name`, `last_name` and `email` fields can be set.

Creating a user immediately sends them an invite email to the Freckle account.

Request example, expects a `users.xml` file in the current directory:

{% highlight sh %}
$ curl -d @data/users.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j https://somaccount.letsfreckle.com/api/users.xml
{% endhighlight %}

Sample post body:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<user>
  <email>foobar@letsfreckle.com</user>
  <first_name>foo</first_name>
  <last_name>bar</last_name>
</user>
{% endhighlight %}

### Response codes

**`201 Created`** means that the user was successfully created. 
The `Location` header in the HTTP response contains the path to this 
new user (in the API). This path contains the user ID if the newly
created user.

### Roles

Only administrators and the account owner can use this API method.

<a id="update"></a>Update user
-----------

    PUT /api/users/<id>

The method updates a user's name and email address.

Request example, expects a `users.xml` file in the current directory:

{% highlight sh %}
$ curl -d @user.xml -X PUT -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://somaccount.letsfreckle.com/api/user/ID.xml
{% endhighlight %}

Request body example:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<user>
  <email>foobar@letsfreckle.com</user>
  <first_name>foo</first_name>
  <last_name>bar</last_name>
</user>
{% endhighlight %}

### Response codes

**`200 OK`** is returned if the user was successfully updated.

**`422 Unprocessable Entity`** is returned in case the API user
is not authorized to manage users in the account or if the given
data was invalid (for example, email address is a invalid format).

### Roles

Only administrators and the account owner can use this API method.

<a id="delete"></a>Delete user
-----------

    DELETE /api/users/<id>

Deactivates a user.

Users are never actually deleted, just deactivated.
Currently, reactivation of a user is only available
on the team page in the Freckle interface.

{% highlight sh %}
$ curl -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/user/12345678.xml
{% endhighlight %}

### Response codes

**`200 OK`** is returned when the user was successfully deactivated.

**`422 Unprocessable Entity`** is returned in case the API user is not the
account owner or the account owner is trying to delete him- or herself.

### Roles

Only the account owner can use this API method.
The account owner can't delete him- or herself.