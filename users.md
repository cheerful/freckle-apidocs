---
layout: default
title: Users
---

Jump to: [List](#list) | 
[Create](#create) | [Show](#read) | [Update](#update) | [Delete](#delete) | 
[Get avatar](#avatar) | [Get authentication token](#token)

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
      "first_name": "Lets"
    }
},
{% endhighlight %}

Try with <a href="http://hurl.it/hurls/65445f00cf62621462e47c2819c81d45200ed685/aa956b48bb5399379b37f3003907a03d32831a51"><img src="hurl.png" width="35"></a>.
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
  </user>
  <!-- ...more users... -->
</users>
{% endhighlight %}

Try with <a href="http://hurl.it/hurls/f2ccff7df61041ec4baf4cfc0eebf9dec1ea978c/fc5198d19edc68ac54a5f81eea9cf703c1fc19e6"><img src="hurl.png" width="35"></a>.
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
    "first_name": "Lets"
  }
}
{% endhighlight %}

Try with <a href="http://hurl.it/hurls/0698e4a92c826fb31533ce8ed13e6aa45d4c529b/8ecc28d1274ba300523cbd933142af7bff11479f"><img src="hurl.png" width="35"></a>.
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
</user>
{% endhighlight %}

Try with <a href="http://hurl.it/hurls/c684a50cfdc4875c2f997c42b9f71d1bfeab11ac/d5bd7af6123e4214688becf22fcd8ba4234788c1"><img src="hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and a users in the response body.

**`401 Unauthorized`** is returned if there's no user with the given ID.
(This will be changed to `404 Not Found` in a future version of the API).

### Roles

A freelancer can only see details about him- or herself.
Other roles have access to all users in the account.

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

Try with <a href="http://hurl.it/hurls/2173dd3bcb51045a43588f0d2ad8ea945fae188a/8c98e3a2fd0dff5a6e3c64a2c36d7b12fedbae60"><img src="hurl.png" width="35"></a>.
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

Try with <a href="http://hurl.it/hurls/94b3590ba30ea64bbb4dcc9cc44b308c7ec35acc/0ba0c549cf2dfb6a15a42bf7ef20a77b1c61848f"><img src="hurl.png" width="35"></a>.
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

Only the account owner can use this API method.

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