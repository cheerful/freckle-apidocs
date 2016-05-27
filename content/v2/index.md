---
layout: v2
title: Freckle API v2
---

Welcome to the Freckle Developer Documentation!

* TOC
{:toc}

## Overview

Freckle provides a secure Restful JSON API over HTTPS; with authentification either via OAuth or, for non-user-facing integrations, generated tokens.

There's many public and internal apps using the Freckle API, among them web applications like [Beanstalk](http://beanstalkapp.com), [Github](http://github.com), and [Planscope](http://planscope.io); native mobile and desktop applications like [Punch](http://punch.fousa.be). Plus, many customers have created internal applications that integrate Freckle with their own custom software and services, such as [Pecas](http://ombulabs.github.io/pecas/). [You can even make a giant LED display for your timer!](https://twitter.com/fixingyourvideo/status/718963570164297730)

Be creative! If you want to let us know about how you're using the Freckle API, please [email](mailto:support@letsfreckle.com) or [tweet](http://twitter.com/letsfreckle) us!

Freckle's API docs are on Github: if you find an error or omission
in the API documentation, you can help fix it quickly by [forking the Freckle API docs](https://github.com/cheerful/freckle-apidocs) and submitting a pull request.

## Not a developer?

If you're not a developer, or just want to quickly connect Freckle to other
internet-based apps your use, consider using [Zapier](https://zapier.com/zapbook/freckle/).

Freckle is one of 500+ services supported by Zapier, which allows drag-and-drop integration and complex workflows with other internet-based software. For example, you could alert your Slack chat room that an invoice has been paid, or send new entries directly to a Google Doc!

## Freckle API Libraries

There are several 3rd-party open source libraries for popular languages
available:

* Python: [bitmazk/python-freckle-client](https://github.com/bitmazk/python-freckle-client)
* Ruby: [timcraft/freckles](https://github.com/timcraft/freckles)
* Opauth (PHP OAuth library) strategy: [t1mmen/opauth-freckle](https://github.com/t1mmen/opauth-freckle)

Additionally, the command-line tool [Pippi](https://github.com/sirkitree/pippi) can log time and access other API functionality, which is great if you want to use the Freckle API from a shell script.

<p class="note">
These are 3rd-party libraries and Freckle can't provide support for them.
Please contact the library authors directly if you need help with these.
</p>

## Naming client applications

If you plan to release a public client app for Freckle (such as a native mobile app, regardless if it’s paid-for or free) you’re welcome to do so, and we're happy to help!

Please note that Freckle® is a registered trademark of Slash7 LLC. Do not name apps “Freckle” or “Freckle for <platform>”. Please contact us first with more details about your app if you want to use “Freckle” or the Freckle logo as name or icon of your app.

## API URLs

### API Resources

API Resources are accessed through this base endpoint:

~~~
<%= API_V2_URL %>
~~~

For example, the URL for accessing the timers of a user is:

~~~
<%= API_V2_URL + "/timers" %>
~~~

<p class="note">
This is different than API v1, where the API was accessed through an account-specific endpoint. If you are migrating from API v1, make sure to change the endpoint URL.
</p>


### OAuth

Authenticating through [OAuth](/v2/oauth/) is handled through a different endpoint than accessing API Resources:

~~~
<%= OAUTH2_URL %>
~~~

For example, the URL to redirect users to request access to their Freckle account is:

~~~~
GET <%= OAUTH2_URL %>/oauth/2/authorize
~~~~

## General Schema

The following rules define the general schema of the API:

* Only HTTPS traffic is allowed when accessing the API. *You must use TLSv1.1 or TLSv1.2.* _SSLv3 and TLSv1 is not supported._
* All data is sent and received as JSON, with the exception of [File Uploads](#uploading-files).
* Blank fields are included as `null` in responses.
* Use ISO 8061 for dates and timestamps (`YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` respectively). _For timestamps, Freckle uses UTC internally; for consistency, please be sure to not accidentally use timestamps in your local time zone._

## User Agent (required)

All API Requests must include a valid `User-Agent` header. Requests with no `User-Agent` header will be rejected. We highly recommend to set a name and version, e.g. `MyFreckleBot/1.0`. This will help us help you better in case debugging is required!

### Example:
~~~
User-Agent: MyFreckleBot/1.0
~~~

## Rate Limiting

You can perform up to 2 requests per second from the same IP address. Requests that exceed this limit will at first be slowed down (for up to 5 requests total). If you send more requests than that, remaining requests will be dropped and return an empty `429 Too Many Requests` response.

If you receive a `429` response, make sure to wait a little longer between requests.

<%= headers 429 %>

## Client Errors

There are a few errors that can occur while making API calls. the following are the kinds of errors you may encounter when using the API.

### Invalid JSON

<%= headers 400 %>
<%= json :message => "JSON Parsing Error" %>

### Wrong type of JSON sent

<%= headers 400 %>
<%= json :message => "Body should be JSON Hash" %>

### Fields were not in the correct format

<%= headers 400 %>

### The user does not have the necessary permissions to perform an action

<%= headers 403 %>

### Account does not include this feature

<%= headers 403 %>
<%= json :message => "Account does not include this feature" %>

### Account is currently locked for migration

<%= headers 503 %>
<%= json :message => "Freckle is changing the internal data for your account so you can start using hashtags" %>

### The `errors` array

When validation errors occur, the `errors` array is populated with objects that explain why the request was invalid. Each object has the following fields:

  * **resource**: The type of object the user was trying to affect.

  * **field**: The field where the error occured.

  * **Code**: Why the request was invalid. The standard error codes are:

    * **missing**: the resource does not exist
    * **missing_field**: a required field on the resource has not been set
    * **already_exists**: another resource has the same value as this field.
    * **insufficent_permissions**: the user does not have the necessary permissions to use this field.
    * **Custom errors codes can be defined for resources, and will be documented in the resource's API page.**

## Deleting or Archiving Resources

In certain cases, resources can only be deleted if certain conditions are met. If these resources cannot be deleted, they may be archived instead. An example of this is the Project resource: a project cannot be deleted if it has any entries, invoices, or expenses; but it can be archived. However, if a project does not have any entries, invoices, or expenses; then it cannot be archived (it can only be deleted).

For these resources, we have two separate actions for deleting and archiving. The Delete action is accessible through the `DELETE` HTTP verb, while the archive action is accessible via `PUT archive/`.

### When a resource cannot be deleted

The delete action will only succeed if the resource is able to deleted. If the resource is unable to be deleted, a `400` error will be returned, with an explanation for why the resource cannot be deleted.

This explanation uses a new error code: **dependent**, and the **field** field will indicate which associated resources exist and are preventing this resource from being deleted.

**Note that custom error codes can be defined for a resource's delete action, and will be documented in the resource's API page.**

<%= headers 400 %>
<%= json :delete_error_example %>

### When a resource cannot be archived

The archive action will only succeeed if the resource is able to archived. If the resource is able to be deleted, then it is unable to be archived. If a resource is unable to be archived, a `400` error will be returned, with an explanation for why the resource cannot be archived.

<%= headers 400 %>
<%= json :archive_error_example %>

## Background Processing

In some cases, an API action may need to be processed in the background. In these cases, a `202` response will be returned with a message that the user will be notified via email when the action has completed.

For example, a large tag merge may return the following response:

<%= headers 202 %>
<%= json :message => "The user will be sent an email once this tag merge is complete." %>

## Uploading Files

If an action includes a file as one of the request parameters, then you must send your request parameters as traditional multipart HTTP key/value pairs instead of a JSON object.

Additionally, the `Content-Type` header of the request **must** be set to: `multipart/form-data`. If you don't set the header, the request will not be processed and a `400 Bad Request` error will be returned.

## HTTP Redirection

HTTP Redirection will be used when appropriate, meaning that clients should assume any request may result in a redirection.

Redirect responses will have a `Location` header field which contains the URI of the resource to which the client should repeat the request.

### Permanent Redirection
<%= headers 301, :Location => API_V2_URL + "/new/uri" %>

This and all future requests should be directed to the new URI.

### Temporary Redirection
<%= headers 302, :Location => API_V2_URL + "/new/uri" %>
<%= headers 307, :Location => API_V2_URL + "/new/uri" %>

Repeat the request verbatim to the URI specified in the `Location` header, but clients should still continue to use th original URI in future requests.

## Supported HTTP Verbs

**`HEAD`**
: Can be issued against any `GET` request to return just the HTTP header info.

**`GET`**

**`POST`**

**`PUT`**
: Used for replacing resources or collections and performing actions on a resource.

**`DELETE`**

## Hypermedia

All resources have one or more `*_url` properties linking to other resources or custom actions on this resource. They are meant to provide explicit URLs so clients don't have to generate them. Using these URLs will make API upgrades easier for developers. All URLs follow [RFC 6570 URI templates](http://tools.ietf.org/html/rfc6570).

### Example (Timer Object):

<%= json :timer %>

## Pagination

Responses including multiple items will be paginated to 30 items per page by default. The page can be changed by using the `page` query parameter. Note that the `page` parameter starts with 1.

Some actions can use the `per_page` parameter to return up to 1,000 items per page.

### Link Header

When pagination is used, the `Link` header includes the URLs used in Pagination. Clients should use these links instead of following their own, in case pagination rules change in the future.

~~~
Link: <<%= "#{API_V2_URL}" %>/users/?page=3&per_page=100>; rel="next",
  <<%= "#{API_V2_URL}" %>/users/?page=2&per_page=100>; rel="prev",
  <<%= "#{API_V2_URL}" %>/users/?page=1&per_page=100>; rel="first",
  <<%= "#{API_V2_URL}" %>/users/?page=50&per_page=100>; rel="last"
~~~

The `rel` attribute indicates what the URL links to:

* **next**: shows the URL of the immediate next page of results
* **last**: shows the URL of the last page of results
* **first**: shows the URL of the first page of results
* **prev**: shows the URL of the immediate previous page of results

<script>
  window.showMessageBox = function(){
    document.getElementById('help_tab').click();
    document.getElementById('help_message_button').click();
  }
</script>
