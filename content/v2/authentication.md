---
layout: v2
title: Authentication
---

* TOC
{:toc}

## Using Personal Access Tokens

[Personal Access Tokens](http://help.letsfreckle.com/import-export-api/api) allow users to issue individual tokens for apps and revoke them at will—be sure to handle authentication errors in your application. Treat Personal Access Tokens like passwords!

The token has to be sent for each request your application makes to the Freckle API.

There are two ways to send the token—examples are given using the cURL command line tool:

As *query parameter* named `token`:


<pre class="terminal">
curl -v <%= API_V2_URL %>/timers?token=<%= API_V2_EXAMPLE_PERSONAL_ACCESS_TOKEN %>
</pre>


As *HTTP header* `X-FreckleToken`:

<pre class="terminal">
curl -v -H "X-FreckleToken:<%= API_V2_EXAMPLE_PERSONAL_ACCESS_TOKEN %>" <%= API_V2_URL %>/timers
</pre>