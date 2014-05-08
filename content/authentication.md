---
layout: default
title: Authentication
---

<div class="note">
<h2>We're currently Alpha Testing Version 2 of the Freckle API!</h2>
<p>This means that the API will grow and its functionality may change at any time.</p>
</div>

## Using Personal Access Tokens

[Personal Access Tokens](http://help.letsfreckle.com/import-export-api/api) allow users to issue individual tokens for apps and revoke them at will—be sure to handle authentication errors in your application. Treat Personal Access Tokens like passwords!

The token has to be sent for each request your application makes to the Freckle API.

There are two ways to send the token—examples are given using the cURL command line tool:

As *query parameter* named `token`:


<pre class="terminal">
curl -v <%= API_V2_URL %>/timers.json?token=eeee4gqoj2814c45h02ilr9z2e6wkkb$iytjzqvf4u2xxljmvu4haua92jbhf8p
</pre>


As *HTTP header* `X-FreckleToken`:

<pre class="terminal">
curl -v -H "X-FreckleToken:eeee4gqoj2814c45h02ilr9z2e6wkkb$iytjzqvf4u2xxljmvu4haua92jbhf8p" <%= API_V2_URL %>/timers.json
</pre>