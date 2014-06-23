---
layout: default
title: Basics
---

* TOC
{:toc}

<div class="note">
<h2>We're currently Alpha Testing Version 2 of the Freckle API!</h2>
<p>This means that the API will grow and its functionality may change at any time.</p>
</div>

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

# Naming client applications

If you plan to release a public client app for Freckle (such as a native mobile app, regardless if it’s paid-for or free) you’re welcome to do so. Do not name apps “Freckle” or “Freckle for <platform>”. Please contact us first with more details about your app if you want to use “Freckle” or the Freckle logo as name or icon of your app!

# API URL

The API is accessed through a single endpoint:

~~~
<%=  API_V2_DOMAIN %>
~~~

For example: if we wanted to access a user's timers, the URL would be:

~~~
<%= API_V2_DOMAIN + "/timers" %>
~~~

# Schema

The following rules define the general schema of the API:

* Only HTTPS traffic is allowed when accessing the API.
* All data is sent and received as JSON, with the exception of [File Uploads](#uploading-files).
* Blank fields are included as `null` in responses.
* The ISO 8061 Date and Timestamp formats are used across the application (`YYYY-MM-DD` and `YYYY-MM-DDTHH:MM:SSZ` respectively).

# A User Agent is Required

All API Requests must include a valid `User-Agent` header. Requests with no `User-Agent` header will be rejected. We recommend two options:

* Your Freckle account subdomain
* The name of the application

## Example:
~~~
User-Agent: My-Freckle-App
~~~

# Client Errors

There are a few errors that can occur while making API calls. the following are the kinds of errors you may encounter when using the API.

## Invalid JSON

<%= headers 400 %>
<%= json :message => "JSON Parsing Error" %>

## Wrong type of JSON sent

<%= headers 400 %>
<%= json :message => "Body should be JSON Hash" %>

## Fields were not in the correct format

<%= headers 400 %>

## The user does not have the necessary permissions to perform an action

<%= headers 403 %>

## Account is currently locked for migration

<%= headers 503 %>
<%= json :message => "Freckle is changing the internal data for your account so you can start using hashtags" %>

# Uploading Files

If an action includes a file as one of the request parameters (such as when creating an import), then you must send your request parameters as traditional multipart HTTP key/value pairs instead of as a JSON object.

Additionally, the `Content-Type` header of the request **must** be set to: `multipart/form-data`, otherwise the request will not be processed and a `400 Bad Request` error will be returned.

# HTTP Redirection

HTTP Redirection will be used when appropriate, meaning that clients should assume any request may result in a redirection.

Redirect responses will have a `Location` header field which contains the URI of the resource to which the client should repeat the requests.

### Permanent Redirection
<%= headers 301, :Location => API_V2_URL + "/new/url" %>

This and all future requests should be directed to the new URI

### Temporary Redirection
<%= headers 302, :Location => API_V2_URL + "/new/url" %>
<%= headers 307, :Location => API_V2_URL + "/new/url" %>

Repeat the request verbatim to the URI specified in the `Location` header, but clients should still continue to use th original URI in future requests

# Supported HTTP Verbs:

**`HEAD`**
: Can be issued against any `GET` request to return just the HTTP header info

**`GET`**

**`POST`**

**`PUT`**
: Used for replacing resources or collections and performing actions on a resource.

**`DELETE`**

# Authentication

##Supported methods:

* Personal Access Tokens

# Hypermedia

All resources have one or more `*_url` properties linking to other resources or custom actions on this resource. They are meant to provide explicit URLs so clients don't have to generate them. Using these URLs will make API upgrades easier for developers. All URLs follow [RFC 6570 URI templates](http://tools.ietf.org/html/rfc6570).

## Example (Timer Object):

<%= json :timer %>