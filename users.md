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
(This will be changed to a `404 Not Found` in a future version of the API).

### Roles

A freelancer can only see details about him or herself.
Other roles have access to all users in the account.

Receive a user's avatar
----------

Returns path to user avatar & thumbnail.

GET `/api/users/<id>/avatar.xml`

Sample request:

    curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538/avatar.xml

Sample XML response:

    <?xml version="1.0" encoding="UTF-8"?>
    <user>
      <avatar>http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg</avatar>
      <thumbnail>http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg</thumbnail>
      <id type="integer">5538</id>
    </user>

### Response codes

* 401 Unauthorized

  The user is not authorized to access this information or the authentication token is not valid.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

### Roles

The freelancer can only see details about herself. Other roles have access to all users in the account.

Receive a user's authentication token
-------------------------------------

The authentication token can be retrieved through the `api_auth_token` resource. 3rd party applications may prefer to ask its users for their login credentials instead of the authentication token because they're easier to remember.

Note that this part of the API uses HTTP Basic Authentication instead of token authentication.

GET `/api/user/api_auth_token.xml`

    curl https://test:testtest@apitest.letsfreckle.com/api/user/api_auth_token.xml

Sample response:

    <?xml version="1.0" encoding="UTF-8"?>
    <user>
      <api-auth-token>lx3gi6pxdjtjn57afp8c2bv1me7g89j</api-auth-token>
    </user>

### Response codes

* 401 Unauthorized

  The supplied credentials are incorrect and should probably be re-requested from the user.

* 500 Internal Server Error

  An error occurred. The API call was not processed correctly and should be retried later.

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
