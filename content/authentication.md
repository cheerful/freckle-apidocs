---
layout: default
title: Authentication
---

* TOC
{:toc}

The Freckle API provides multiple different ways to handle authentication in your application, each one suited for a particular type of application. It's important to pick the right authentication method for your application, so we've created the guide below to help you choose the right one:

## Which Authentication method do I choose?

[OAuth](oauth) (**Strongly recommended**)
: My application will be running in a production environment, is not a script, or I am concerned about security.

[Basic Authentication using User's credentials](#via-username-and-password)
: I'm writing a script whichs asks the user to authenticate each time, or I can store the user's authentication information.

[Basic Authentication using OAuth Tokens](#via-oauth-tokens)
: My tools only allow me to use Basic Authentication, but I want to use OAuth for it's security features.

## Basic Authentication

The API supports Basic Authentication as defined in [RFC2617](http://www.ietf.org/rfc/rfc2617.txt). There are two ways to use Basic Authentication: using the user's credentials or using an OAuth token.

### Via Username and Password

To use Basic Authentication with the Freckle API, simply send the email and password associated with the user.

For example, if you're accessing the API via [cURL](http://curl.haxx.se/), the following command would authenticate with `john@test.com` as the email. (cURL will prompt you to enter the password).

<pre class='terminal'>
curl -u john@test.com https://apitest.letsfreckle.com/api/v2/entries
</pre>

### Via OAuth Tokens

Alternatively, you can authenticate using [personal access tokens](http://help.letsfreckle.com/import-export-api/api) or OAuth tokens. This approach is useful if your tools only support Basic Authentication but you want to take advantage of the security benefits provided by OAuth access tokens.

To do so, provide the token as the username and provide a blank password or a password of `x-oauth-basic`. For example:

<pre class='terminal'>
curl -u abcdefghijklmnop1234567890:x-oauth-basic https://apitest.letsfreckle.com/api/v2/entries
</pre>