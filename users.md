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

Add user
--------

You can create new users by POSTing to the user resource.

POST `/api/users.xml`

Sample request:

    curl -d @data/users.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" \
      https://somaccount.letsfreckle.com/api/users.xml

Sample POST body:

    <?xml version="1.0" encoding="UTF-8"?>
    <user>
      <email>foo.bar@example.com</user>
      <first_name>foo</first_name>
      <last_name>bar</last_name>
    </user>

In case the user was successfully created, you get a `HTTP 201 Created` back, with the `Location` header containing the URL of the user (e.g. https://someaccount.letsfreckle.com/api/users/123).

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 422 Unprocessable Entity

  An error occurred. Another user with the given email already exists or the account user limit has been reached.

### Roles

Only the account owner can use this resource. The `apitest` account doesn't allow you to create new users for obvious reasons.

Update user
-----------

You can PUT to the user resource to update its attributes.

PUT `/api/users/<id>.xml`

Sample request:

    curl -d @data/user.xml -X PUT -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" \
      https://somaccount.letsfreckle.com/api/user/ID.xml

Sample POST body:

    <?xml version="1.0" encoding="UTF-8"?>
    <user>
      <email>foozinho.barzinho@example.com</user>
      <first_name>foozinho</first_name>
      <last_name>barzinho</last_name>
    </user>

In case the user was successfully updated, you get a `HTTP 200 Ok` back, with the Location header containing the URL of the user (e.g. https://someaccount.letsfreckle.com/api/users/123).

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 422 Unprocessable Entity

  An error occurred. Another user with the given email already exists.

### Roles

Only the account owner can use this resource. The `apitest` account doesn't allow you to create new users for obvious reasons.

Remove user
-----------

Delete this resource to deactivate the user.

Users are never actually removed completely, but just deactivated. Reactivation of a user can only be done through the web the interface.

DELETE `/api/users/<id>.xml`

Sample request:

    curl -d @data/user.xml -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" \
      https://apitest.letsfreckle.com/api/user/ID.xml

In case the user was successfully removed, you get a `HTTP 200 Ok` back.

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 422 Unprocessable Entity

  An error occurred. You are probably trying to remove the account owner or yourself.

### Roles

Only the account owner can use this resource. The `apitest` account doesn't allow you to create new users for obvious reasons.
