---
layout: default
title: Basics
---

# Introduction

Many applications use the Freckle API every day, among them web applications
like [Beanstalk]("http://beanstalkapp.com"), [Github]("http://github.com"), and [Planscope]("http://planscope.io"); native mobile and desktop applications like [Pigment](http://pigmentapp.com) and [Punch](http://punch.fousa.be); as well as many internal applications that our customers write to integrate with other software and services. Be creative! If you want to let us know about how you're using the Freckle API, please [email](mailto:support@letsfreckle.com), [tweet](http://twitter.com/letsfreckle), or [send us a message on Facebook](https://www.facebook.com/FreckleTimeTracking).

Freckle is also one of the many services listed on [Zapier](https://zapier.com/zapbook/freckle/) which allows drag-and-drop integration of Freckle with other internet-based software (for example, you can send new Freckle entries to your Campfire chat room!).

Freckle's API docs are on Github: if you find an error or omission
in the API documentation, you can help fix it quickly by [forking the Freckle API docs](https://github.com/cheerful/freckle-apidocs) and submitting a pull request!

# [Freckle API Libraries](#libraries)

There are several 3rd-party open source libraries for popular languages
available:

* Ruby: [letsfreckle-client](https://github.com/ryanlecompte/letsfreckle-client)
* Python: [ipmb/freckle](https://github.com/ipmb/freckle)
* Node.js: [nodefreckle](https://github.com/tbranyen/nodefreckle)
* Clojure: [clj-freckle](https://github.com/mlehman/clj-freckle)

Additionally, the command-line tool [Pippi](https://github.com/sirkitree/pippi) can log time and access other API functionality, which is great if you want to use the Freckle API from a shell script.

<p class="note">
These are 3rd-party libraries and Freckle can't provide support for them.
Please contact the library authors directly if you need help with these.
</p>

# API URL

The URL used to access the API is based on the subdomain of the account, and follows the format:

~~~
subdomain.letsfreckle.com/api/v2
~~~

For example: if our account subdomain was: `apitest`, the API URL would be:

~~~
apitest.letsfreckle.com/api/v2
~~~

# Schema

The following rules define the general schema of the API:

* Only HTTPS traffic is allowed when accessing the API.
* All data is sent and received as JSON, with the exception of [File Uploads](#file_uploads).
* Blank fields are included as `null` in responses.
* The ISO 8061 Date and Timestamp formats are used across the application (`YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` respectively).

# Client Errors

There are a few errors that can occur while making API calls. the following are the kinds of errors you may encounter when using the API.

## Invalid JSON

<%= headers 400 %>
<%= json :message => "JSON Parsing Error" %>

## Wrong type of JSON sent

<%= headers 400 %>
<%= json :message => "Body should be JSON Hash" %>

## The user does not have the necessary permissions to perform an action

<%= headers 401 %>

## Account is currently locked for migration

<%= headers 503 %>
<%= json :message => "Freckle is changing the internal data for your account so you can start using hashtags" %>

## Fields were invalid

<%= headers 422 %>
<%= json :validation_error_example %>

### The `errors` array

When validation errors occur, the `errors` array is populated with objects that explain why the request was invalid. Each object has the following fields:

  * **resource**: The type of object the user was trying to affect.

  * **field**: The field where the error occured.

  * **Code**: Why the request was invalid. The standard error codes are:

    * **missing**: the resource does not exist
    * **missing_field**: a required field on the resource has not been set
    * **already_exists**: another resource has the same value as this field.
    * **Custom errors codes can be defined for resources, and will be documented in the resource's API page.**

# [Deleting or Archiving Resources](#deleting-or-archiving-resources)

In certain cases, some resources can only be deleted if certain conditions are met. If these resources cannot be deleted, then they may be archived. An example of this is the Project resource: a project cannot be deleted if it has any entries, invoices, or expenses; but it can be archived. However, if a project does not have any entries, invoices, or expenses; then it cannot be archived (it can only be deleted).

For these resources, we have two separate actions for deleting and archiving. The Delete action is accessible through the `DELETE` HTTP verb, while the archive action is accessible via `PUT archive/`.

## When a resource cannot be deleted

The delete action will only succeed if the resource is able to deleted. If the resource is unable to be deleted, a `422` error will be returned, with an explanation for why the resource cannot be deleted.

This explanation uses a new error code: **dependent**, and the **field** field will indicate which associated resources exist and are preventing this resource from being deleted.

**Note that custom error codes can be defined for a resource's delete action, and will be documented in the resource's API page.**

<%= headers 422 %>
<%= json :delete_error_example %>

## When a resource cannot be archived

The archive action will only succeeed if the resource is able to archived. If the resource is able to be deleted, then it is unable to be archived. If a resource is unable to be archived, a `422` error will be returned, with an explanation for why cd ..the resource cannot be archived.

This explanation uses a new error code: **deletable**, and the **field** field will point to the `id` field. This error code indicates that the delete action should be called on this resource.

**Note that custom error codes can be defined for a resource's archive action, and will be documented in the resource's API page.**

<%= headers 422 %>
<%= json :archive_error_example %>

# [Uploading Files](#uploading-files)

If an action includes a file as one of the request parameters (such as when creating an import), then you must send your request parameters as traditional HTTP key/value pairs instead of as a JSON object.

Additionally, the `Content-Type` header of the request **must** be set to: `application/x-ww-form-urlencoded`, otherwise the request will not be processed and a `400 Bad Request` error will be returned.

# HTTP Redirection

HTTP Redirection will be used when appropriate, meaning that clients should assume any request may result in a redirection.

Redirect responses will have a `Location` header field which contains the URI of the resource to which the client should repeat the requests.

### Permanent Redirection
<%= headers 301, :Location => "apitest.letsfreckle.com/api/v2/new/url" %>

This and all future requests should be directed to the new URI

### Temporary Redirection
<%= headers 302, :Location => "apitest.letsfreckle.com/api/v2/new/url" %>
<%= headers 307, :Location => "apitest.letsfreckle.com/api/v2/new/url" %>

Repeat the request verbatim to the URI specified in the `Location` header, but clients should still continue to use th original URI in future requests

# Supported HTTP Verbs:

**`HEAD`**
: Can be issued against any resource to get just the HTTP header info

**`GET`**

**`POST`**

**`PATCH`**
: Used for updating resources with partial data. For instance, an Tag resource has `name`  and `billable` fields. A PATCH request may accept one or more attributes to update the resource. Since PATCH is relatively new and uncommon, resource endpoints also accept POST requests

**`PUT`**
: Used for replacing resources or collections and performing actions on a resource.

**`DELETE`**

# Authentication

##Supported methods:

* OAuth2 Token (sent in Header)
* OAuth2 Token (sent as a parameter)
* OAuth2 Key/Secret

# Hypermedia

All resources have one or more `*_url` properties linking to other resources. They are meant to provide explicit URLs so clients don't have to generate them. Using these URLs will make API upgrades easier for developers. All URLs follow [RFC 6570 URI templates](http://tools.ietf.org/html/rfc6570).

## Example (Tag Object):

<%= json :tag %>

# Pagination

Responses including multiple items will be paginated to 30 items by default. The page can be changed by using the `page` query parameter. Note that the `page` paremter starts with 1.


Some actions can use the `per_page` parameter, which will be documented in the resource's API page.

## Link Header

When pagination is used, the `Link` header includes the URLs used in Pagination. Clients should use these links instead of following their own, in case pagination rules change in the future.

~~~
Link: <https://apitest.letsfreckle.com/api/v2/users/?page=3&per_page=100>; rel="next",
  <https://apitest.letsfreckle.com/api/v2/users/?page=2&per_page=100>; rel="prev",
  <https://apitest.letsfreckle.com/api/v2/users/?page=1&per_page=100>; rel="first",
  <https://apitest.letsfreckle.com/api/v2/users/?page=50&per_page=100>; rel="last"
~~~

the `rel` attribute indicates what the URL links to:

* **next**: shows the URL of the immediate next page of results
* **last**: shows the URL of the last page of results
* **first**: shows the URL of the first page of results
* **prev**: shows the URL of the immediate previous page of results

# User Agent Required

All API Requests must include a valid `User-Agent` header. Requests with no `User-Agent` header will be rejected. We recommend two options:

* Your Freckle account subdomain
* The name of the application

## Example:
~~~
User-Agent: My-Freckle-App
~~~

# Scopes

Scopes specify the type of permissions that an API action accepts and your application needs access to. Scopes do not promise any additional permission beyond what the user already has (so if the user has read-only access to something, a "write" scope will not affect their ability to write)

There are two parameters associated with Scopes:

* **`X-OAuth-Scopes`**: the scopes your token has been authorized to access
* **`X-Accepted-OAuth-Scopes`**: The scopes the current action checks for.

The currently supported scopes are:

* **current_user**: read/write access to profile info only. (includes: **user:email**)
* **project**: read/write access to the projects the user has access to
* **user**: Read/Write info for all the other users in the account
* **entry**: Read/Write access to the current user's time entries
* **tag**: read/write access to the tags in the account
* **import**: read/write access to the imports in the account
* **goal**: read/write access to the goals in the account
* **invoice**: read/write access to the invoices in the account

# [API Test Account](#test)

You can use our API test account for testing your code. The data from this test account will be regularly wiped, so don't rely on your test data being there the next day. Also note that you might not be the only person using this token at a certain time.

Domain: `apitest.letsfreckle.com`
Token: `lx3gi6pxdjtjn57afp8c2bv1me7g89j`

If you do any kind of non-trivial client application or have special needs for API testing, we recommend that you create a Freckle account specifically just for testing your application, so you can be sure your data stays intact while you develop!

Try it now!

~~~
$ curl -H "X-FreckleToken:lx3gi6pxdjtjn57afp8c2bv1me7g89j" https://apitest.letsfreckle.com/api/v2/projects.json
~~~

Instead of using cURL, you can also try it directly in your browser with <a href="http://apitest.developer.letsfreckle.com/hurls/fad3d73a5f2d60de3a41397d330e75856beeaddd/21d1e53251a9bf5941d0bd25aeb7557a3ca52a26"><img src="hurl.png" width="35"></a>.

You should see something like this:

<%= json :project %>

# Acknowledgements

The design of the Freckle API is based on [Github's v3 API](http://developer.github.com/v3). Thanks to them for creating an excellent API design.