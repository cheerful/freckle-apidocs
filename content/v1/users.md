---
layout: v1
title: Users
description: Manage Freckle users with the Freckle Time Tracking RESTful API.
---

* TOC
{:toc}

## List users

    GET /api/users

Return a list of all active users in the account (doesn't return any deactivated users).

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users.json
<%= code_block_end_tag %>

Response:
<%= code_block_start_tag("javascript") %>
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
<%= code_block_end_tag %>

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/274cffe2634174d4be8aedc1ede1b7aa8b1152e1/3effedf1507d0e1f33e601216e60ef059291dabe"><img src="/assets/hurl.png" width="35"></a>.
</div>
<div class="tab xml">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users.xml
<%= code_block_end_tag %>

Response:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;users</span> <span class="na">type=</span><span class="s">&quot;array&quot;</span><span class="nt">&gt;</span>
  <span class="nt">&lt;user&gt;</span>
    <span class="nt">&lt;email&gt;</span>apitestadmin@letsfreckle.com<span class="nt">&lt;/email&gt;</span>
    <span class="nt">&lt;first-name&gt;</span>Lets<span class="nt">&lt;/first-name&gt;</span>
    <span class="nt">&lt;id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>5538<span class="nt">&lt;/id&gt;</span>
    <span class="nt">&lt;last-name&gt;</span>Freckle<span class="nt">&lt;/last-name&gt;</span>
    <span class="nt">&lt;login&gt;</span>admin<span class="nt">&lt;/login&gt;</span>
    <span class="nt">&lt;time-format&gt;</span>fraction<span class="nt">&lt;/time-format&gt;</span>
    <span class="nt">&lt;week-start</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/week-start&gt;</span>
    <span class="nt">&lt;permissions&gt;</span>integration, time, invoicing, reports, tags,
      expenses, projects, team, people, account, billing, import<span class="nt">&lt;/permissions&gt;</span>
    <span class="nt">&lt;hashtags</span> <span class="na">type=</span><span class="s">&quot;boolean&quot;</span><span class="nt">&gt;</span>true<span class="nt">&lt;/hashtags&gt;</span>
  <span class="nt">&lt;/user&gt;</span>
  <span class="c">&lt;!-- ...more users... --&gt;</span>
<span class="nt">&lt;/users&gt;</span>
</code></pre>
</div>


Try with <a href="http://apitest.developer.letsfreckle.com/hurls/3d18d9ab851f3f7a5b97a92a22d9a07901afae4f/5774bcd466bb2529d08ab4f4bd69b81233d73ee1"><img src="/assets/hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and an array of users in the response body.

### Roles

All roles except the freelancer role can access this resource.

## Show user

    GET /api/users/<id>

Returns details about a specific user. This method works with active and deactivated users.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538.json
<%= code_block_end_tag %>

Response:
<%= code_block_start_tag("javascript") %>
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
<%= code_block_end_tag %>

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/406175f1eb7a4e07c9b8f284217c084b23e7cb20/9cdff37a372430b3721f557537ce5595c828bb5a"><img src="/assets/hurl.png" width="35"></a>.
</div>
<div class="tab xml">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538.xml
<%= code_block_end_tag %>

Response:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;user&gt;</span>
  <span class="nt">&lt;email&gt;</span>apitestadmin@letsfreckle.com<span class="nt">&lt;/email&gt;</span>
  <span class="nt">&lt;first-name&gt;</span>Lets<span class="nt">&lt;/first-name&gt;</span>
  <span class="nt">&lt;id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>5538<span class="nt">&lt;/id&gt;</span>
  <span class="nt">&lt;last-name&gt;</span>Freckle<span class="nt">&lt;/last-name&gt;</span>
  <span class="nt">&lt;time-format&gt;</span>fraction<span class="nt">&lt;/time-format&gt;</span>
  <span class="nt">&lt;week-start</span> <span class="na">nil=</span><span class="s">&quot;true&quot;</span><span class="nt">&gt;&lt;/week-start&gt;</span>
  <span class="nt">&lt;permissions&gt;</span>integration, time, invoicing, reports, tags, 
    expenses, projects, team, people, account, billing, import<span class="nt">&lt;/permissions&gt;</span>
  <span class="nt">&lt;hashtags</span> <span class="na">type=</span><span class="s">&quot;boolean&quot;</span><span class="nt">&gt;</span>true<span class="nt">&lt;/hashtags&gt;</span>
<span class="nt">&lt;/user&gt;</span>
</code></pre>
</div>


Try with <a href="http://apitest.developer.letsfreckle.com/hurls/9e4b54872c4c0ccc8f2d87a304e15bb918b6e1e5/859678e18961ddc7a59b5931ffc1070476c66541"><img src="/assets/hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and a users in the response body.

**`401 Unauthorized`** is returned if there's no user with the given ID.
(This will be changed to `404 Not Found` in a future version of the API).

### Roles

A freelancer can only see details about him- or herself.
Other roles have access to all users in the account.

## Get current user

    GET /api/users/self

Returns details about the currently logged in user. 
This method is otherwise identical with `GET /api/users/<id>`.

Try on <a href="http://apitest.developer.letsfreckle.com/hurls/2ada287ae61ad278c44fdf081db506e88deb22b2/17b262450ddfd8195aa4f3e77626dfa115988ced"><img src="/assets/hurl.png" width="35"></a>.

## Get a user's avatar

    GET /api/users/<id>/avatar

Returns URLs to a user's avatar & thumbnail. If you build a client application,
we strongly suggest caching these images.

<div class="tabs">
<div class="selector">
  <div class="json active">JSON</div>
  <div class="xml">XML</div>
</div>
<div class="tab json active">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538/avatar.json
<%= code_block_end_tag %>

Response:

<%= code_block_start_tag("javascript") %>
{
  "thumbnail": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg",
  "id": 5538,
  "avatar": "http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg"
}
<%= code_block_end_tag %>

If the user has no current avatar, the `thumbnail` and `avatar` tag attributes are set to empty strings.

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/fa45bad8cdbcf57ee5d39f2086d74360d6d2ffd8/73f2a3532443e9f206f4809c656ecb5a84178c42"><img src="/assets/hurl.png" width="35"></a>.
</div>
<div class="tab xml">
<%= code_block_start_tag_custom_language("sh") %>
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/users/5538/avatar.xml
<%= code_block_end_tag %>

Response:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;user&gt;</span>
  <span class="nt">&lt;thumbnail&gt;</span>http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar_profile.jpg<span class="nt">&lt;/thumbnail&gt;</span>
  <span class="nt">&lt;avatar&gt;</span>http://apitest.letsfreckle.com/images/avatars/0000/0001/avatar.jpg<span class="nt">&lt;/avatar&gt;</span>
  <span class="nt">&lt;id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>5538<span class="nt">&lt;/id&gt;</span>
<span class="nt">&lt;/user&gt;</span>
</code></pre>
</div>

If the user has no current avatar, the `thumbnail` and `avatar` tags will be empty:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;user&gt;</span>
  <span class="nt">&lt;thumbnail&gt;&lt;/thumbnail&gt;</span>
  <span class="nt">&lt;avatar&gt;&lt;/avatar&gt;</span>
  <span class="nt">&lt;id</span> <span class="na">type=</span><span class="s">&quot;integer&quot;</span><span class="nt">&gt;</span>5538<span class="nt">&lt;/id&gt;</span>
<span class="nt">&lt;/user&gt;</span>
</code></pre>
</div>

Try with <a href="http://apitest.developer.letsfreckle.com/hurls/fc7ae5b212e6271a6a92c64a605d748b4b04f692/a23d67c210866dbe9dc9dfa96593c58532253b82"><img src="/assets/hurl.png" width="35"></a>.
</div>
</div>

### Response codes

Returns **`200 OK`** and the avatar URLs in the response body.

**`401 Unauthorized`** is returned if there's no user with the given ID.
(This will be changed to `404 Not Found` in a future version of the API).

### Roles

The freelancer can only see the avatar for him- or herself. 
Other roles have access to all users in the account.


## Get authentication token

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
<%= code_block_start_tag_custom_language("sh") %>
$ curl https://test:testtest@apitest.letsfreckle.com/api/user/api_auth_token.json
<%= code_block_end_tag %>

Note that no API token is given, instead HTTP Basic Auth is used.

Response:

<%= code_block_start_tag("javascript") %>
{
  "user": {
    "api_auth_token": "lx3gi6pxdjtjn57afp8c2bv1me7g89j"
  }
}
<%= code_block_end_tag %>
</div>
<div class="tab xml">
<%= code_block_start_tag_custom_language("sh") %>
$ curl https://test:testtest@apitest.letsfreckle.com/api/user/api_auth_token.xml
<%= code_block_end_tag %>

Note that no API token is given, instead HTTP Basic Auth is used.

Response:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;user&gt;</span>
  <span class="nt">&lt;api-auth-token&gt;</span>lx3gi6pxdjtjn57afp8c2bv1me7g89j<span class="nt">&lt;/api-auth-token&gt;</span>
<span class="nt">&lt;/user&gt;</span>
</code></pre>
</div>


</div>
</div>

### Response codes

If the HTTP Basic Auth email and password are correct, returns 
**`200 OK`** and the token information in the response body.

**`401 Unauthorized`** is returned if authentication with
email and password.

### Roles

Anyone can retrieve their authentication token using this resource.

## Create user

    POST /api/users

You can create new users, as long as your account limits are not reached.
This method, as well as the update and delete methods, are intended to make
it easier to synchronize users with your own systems. Note that you can't set
or change passwords.

Only the `first_name`, `last_name` and `email` fields can be set.

Creating a user immediately sends them an invite email to the Freckle account.

Request example, expects a `users.xml` file in the current directory:

<%= code_block_start_tag_custom_language("sh") %>
$ curl -d @data/users.xml -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j https://somaccount.letsfreckle.com/api/users.xml
<%= code_block_end_tag %>

Sample post body:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;user&gt;</span>
  <span class="nt">&lt;email&gt;</span>foobar@letsfreckle.com<span class="nt">&lt;/user&gt;</span>
  <span class="nt">&lt;first_name&gt;</span>foo<span class="nt">&lt;/first_name&gt;</span>
  <span class="nt">&lt;last_name&gt;</span>bar<span class="nt">&lt;/last_name&gt;</span>
<span class="nt">&lt;/user&gt;</span>
</code></pre>
</div>

### Response codes

**`201 Created`** means that the user was successfully created. 
The `Location` header in the HTTP response contains the path to this 
new user (in the API). This path contains the user ID if the newly
created user.

### Roles

Only administrators and the account owner can use this API method.

## Update user

    PUT /api/users/<id>

The method updates a user's name and email address.

Request example, expects a `users.xml` file in the current directory:

<%= code_block_start_tag_custom_language("sh") %>
$ curl -d @user.xml -X PUT -H "Content-type: text/xml" -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://somaccount.letsfreckle.com/api/user/ID.xml
<%= code_block_end_tag %>

Request body example:

<div class="highlight"><pre><code class="xml"><span class="cp">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;</span>
<span class="nt">&lt;user&gt;</span>
  <span class="nt">&lt;email&gt;</span>foobar@letsfreckle.com<span class="nt">&lt;/user&gt;</span>
  <span class="nt">&lt;first_name&gt;</span>foo<span class="nt">&lt;/first_name&gt;</span>
  <span class="nt">&lt;last_name&gt;</span>bar<span class="nt">&lt;/last_name&gt;</span>
<span class="nt">&lt;/user&gt;</span>
</code></pre>
</div>

### Response codes

**`200 OK`** is returned if the user was successfully updated.

**`422 Unprocessable Entity`** is returned in case the API user
is not authorized to manage users in the account or if the given
data was invalid (for example, email address is a invalid format).

### Roles

Only administrators and the account owner can use this API method.

## Delete user

    DELETE /api/users/<id>

Deactivates a user.

Users are never actually deleted, just deactivated.
Currently, reactivation of a user is only available
on the team page in the Freckle interface.

<%= code_block_start_tag_custom_language("sh") %>
$ curl -X DELETE -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/user/12345678.xml
<%= code_block_end_tag %>

### Response codes

**`200 OK`** is returned when the user was successfully deactivated.

**`422 Unprocessable Entity`** is returned in case the API user is not the
account owner or the account owner is trying to delete him- or herself.

### Roles

Only the account owner can use this API method.
The account owner can't delete him- or herself.