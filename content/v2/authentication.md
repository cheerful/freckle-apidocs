---
layout: v2
title: Authentication
---

* TOC
{:toc}

The Freckle API provides multiple different ways to handle authentication in your application, each one suited for a particular type of application. It's important to pick the right authentication method for your application, so we've created the guide below to help you choose the right one:

<p class="note">
The examples below use <a href="http://radek.io/2015/10/20/httpie/">httpie</a>; which returns a pretty-printed and syntax highlighted response, and works on OS X, Linux, and Windows. You should try it out, we really like it!
</p>

## Which type of authentication should I choose?

[OAuth](/v2/oauth) (**Strongly recommended**)
: My application will be running in a production environment, is not a script, or I am concerned about security.

[Personal Access Token](#using-personal-access-tokens)
: My application is a script or for internal use only.

## Which authentication method do I choose?

[Sending HTTP Header or `freckle_token` parameter for Personal Access Token](#using-personal-access-tokens)
: My application uses Personal Access Tokens for authentication

[Sending HTTP Header or `access_token` parameter for OAuth access token](#using-oauth-access-tokens)
: My application uses OAuth access tokens for authentication

[Basic Authentication using OAuth access tokens](#api-access-via-oauth-access-tokens)
: My tools only allow me to use Basic Authentication but I want to take advantage of OAuth's security benefits.

[Basic Authentication using Personal Access Tokens](#api-access-via-personal-access-tokens)
: My tools only allow me to use Basic Authentication and I am using Personal Access Tokens for authentication.

[Basic Authentication to interact with the OAuth Authorizations API](#to-interact-with-the-oauth-authorizations-api)
: I am writing a non-web application that will be using OAuth, and I need to generate an OAuth access token to allow my application to access the API.

## Using Personal Access Tokens

[Personal Access Tokens](http://help.letsfreckle.com/article/103-connecting-to-the-freckle-api) allow users to issue individual tokens for apps and revoke them at will—be sure to handle authentication errors in your application. Treat Personal Access Tokens like passwords!

The token has to be sent for each request your application makes to the Freckle API.

There are two ways to send the token—examples are given using the cURL command line tool:

As a *query parameter* named `freckle_token`:

<pre class="terminal">
http GET <%= API_V2_URL %>/timers freckle_token==<%= API_V2_EXAMPLE_PERSONAL_ACCESS_TOKEN %>
</pre>

As a *HTTP header* named `X-FreckleToken`:

<pre class="terminal">
http GET <%= API_V2_URL %>/timers X-FreckleToken:<%= API_V2_EXAMPLE_PERSONAL_ACCESS_TOKEN %>
</pre>

## Using OAuth access tokens

Once your application has received an OAuth access token, you can begin making API requests. Note that access tokens can be revoked at any time, so be sure to handle authentication errors in your application.

The token has to be sent for each request made to the API.

There are two ways to send the token—examples are given using the cURL command line tool:

As an OAuth2 Token header:

<pre class="terminal">
http GET <%= API_V2_URL %>/timers Authorization:"Bearer YOUR_OAUTH_ACCESS_TOKEN"
</pre>

As a *query parameter* named `access_token`:

<pre class="terminal">
http GET <%= API_V2_URL %>/timers access_token==YOUR_OAUTH_ACCESS_TOKEN
</pre>

## Basic Authentication

The API supports Basic Authentication as defined in [RFC2617](http://www.ietf.org/rfc/rfc2617.txt). There are two ways Basic Authentication can be used:

* to allow API access with an OAuth access token or Personal Access Token
* to interact with the [OAuth Authorizations API](/v2/oauth#oauth-authorizations-api)

### API access via OAuth access tokens

You can authenticate using [OAuth access tokens](/v2/oauth). This approach is useful if your tools only support Basic Authentication but you want to take advantage of the security benefits provided by OAuth Access Tokens.

To do so, provide the access token as the username and provide a blank password or a password of `x-oauth-basic`. For example:

<pre class='terminal'>
http GET <%= API_V2_URL %>/entries -a abcdefghijklmnop1234567890:x-oauth-basic
</pre>

### API access via Personal Access Tokens

You can authenticate using [Personal Access Tokens](http://help.letsfreckle.com/article/103-connecting-to-the-freckle-api). This approach is useful if your tools only support Basic Authentication and you are using Personal Access Tokens for authentication.

To do so, provide the Personal Access Token as the username and provide a blank password or a password of `x-freckle-token`. For example:

<pre class='terminal'>
http GET <%= API_V2_URL %>/entries -a <%= API_V2_EXAMPLE_PERSONAL_ACCESS_TOKEN %>:x-freckle-token
</pre>

### To interact with the OAuth Authorizations API

The [OAuth Authorizations API](/v2/oauth#oauth-authorizations-api) allows users to manage their OAuth access tokens and provides non-web applications a way to generate an OAuth access token for the authenticated user.

To use Basic Authentication to interact with the OAuth Authorizations API, simply send the email and password associated with the user.

For example, if you're accessing the API via [httpie](http://radek.io/2015/10/20/httpie/), the following command would authenticate with `john@test.com` as the email. (httpie will prompt you to enter the password).

<pre class='terminal'>
http GET <%= API_V2_URL %>/subdomains -a john@test.com
</pre>