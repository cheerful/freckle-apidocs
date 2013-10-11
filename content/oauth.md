---
layout: default
title: OAuth
---

OAuth2 is a protocol that lets external apps request authorization to the private details in a user’s Freckle account without requiring their password. Freckle only supports access to API resources using OAuth because tokens can be limited to specific types of data and can be revoked by users at any time.

Before you can start developing with the Freckle API, you must first register your application. When you register, you will be given a unique Client ID and Secret. Your Client Secret should not be shared.

There are two supported ways to generate an access token for a specific user from your application: One designed specifically for use by Web Applications, and another that allows other types of applications to list, create, and confirm their Authorization Token for a user.

## Web Application Flow

Below are the steps required to generate an access token for a Freckle user through a `GET` request to Freckle and a corresponding redirect back to your application.

### 1. Redirect users to request Freckle access

~~~~
GET /login/oauth/authorize
~~~~

#### Parameters:

client_id
: *Required* **string**
: The client ID you received from Freckle when you registered
: Example: `client_id=abcdefghi1234`

scope
: *Optional* **string** of a comma separated list of [scopes](#scopes)
: The type of access your application needs to the user's Freckle data.
: If no value is provided, then the permissions you chose when you setup your application will be used.
: Example: `scope=current_user,project,entry`

state
: *Optional* **string**
: An unguessable random string, which is used to protect against cross-site request forgery attacks.

redirect_uri
: *Optional* **string**
: The URL pointing to your application where users will be redirected to after they have authorized your application to use their Freckle data.

  ####Rules:

  If `redirect_uri` is not included in the request, Freckle will redirect users to the callback URL configured in the OAuth application settings.

  If `redirect_uri` is included in the request, the redirect URL's host and port must exactly match the configured callback URL and the redirect URL path must reference a subdirectory of the callback URL configured in the OAuth application settings.

  ####Examples:

  ~~~
  CONFIGURED CALLBACK URL: http://example.com/path

  GOOD: https://example.com/path
  GOOD: http://example.com/path/subdir/other

  BAD:  http://example.com/bar
  BAD:  http://example.com/
  BAD:  http://example.com:8080/path
  BAD:  http://oauth.example.com:8080/path
  BAD:  http://example.org
  ~~~

### 2. Freckle redirects back to your site with two parameters:

When the user has authorized your application, Freckle will redirect back to your application (either to the URL configured in the OAuth application settings, or the url specified in `redirect_uri`). The redirection will include the following parameters in the URL:

code
: **string**
: A Temporary code that you will send back to Freckle to get the access token. This code confirms that the user authorized your application to use their Freckle data, and that you received the request.

state
: **string**
: If you provided a state in your [redirect to Freckle](#step-1) then it will be returned back to you. If this parameter does not match what you previously sent, then reject the request.

### 3. POST to Freckle to get the access token.

After you have received the temporary code, you will need to `POST` to Freckle to exchange this temporary code for an access token:

#### Parameters:

client_id
: *Required* **string**
: The client ID you received from Freckle when you registered your application.

client_secret
: *Required* **string**
: the client secret you received from Freckle when you registered your application

code
: *Required* **string**
: the code you received as a response in [step 2](#step-2).

###Reponse

The response will include the following values:

* **access_token**
: The token you will use to access the API on behalf of a user
* **token_type**
: The type of access that has been sent to your application. The default value is "Bearer"
* **scope**
: The permissions that have been provided to your application.

By default, the response will have the following format:

~~~~
access_token=abcedfghijk1234567890&scope=current_user%2Centry&token_type=bearer
~~~~

However, by modifying your request's `Accept` header, you can receive the response in different formats:

~~~~
Accept: application/json
{"access_token":"abcedfghijk1234567890", "scope":"current_user,entry", "token_type":"bearer"}

Accept: application/xml
<OAuth>
  <token_type>bearer</token_type>
  <scope>current_user,entry</scope>
  <access_token>abcedfghijk1234567890</access_token>
</OAuth>
~~~~

### 4. Use the access token to make API requests on behalf of the user

Now that you have an access token for the user, you can use it to make API requests on their behalf. Please review the [API basics section on how to include the access token in your requests](/basics#authorization).

## Non-Web Application Flow

If your application is not a Web-app, you will need to use the OAuth Authorizations API to [generate a new access token](#oauth-authorizations-api) for the user. Note that the OAuth Authorization API is only available via [Basic Authentication](/authentication)


# OAuth Authorizations API

This API allows users to manage their tokens, and is only accessible via [Basic Authentication](authentication).

## List all authorizations

~~~
GET /authorizations
~~~

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

### Get a single Authorization

~~~
GET /authorizations/:id
~~~

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

## Create a new Authorization Token

When you are not building a Web Application, it might be easier to generate a token using a single POST request.

~~~~
POST /authorizations
~~~~


### Inputs

client_id
: *Required* **string**
: the client key generated for your application.

client_secret
: *Required* **string**
: the client secret generated for your application.

scopes
: *Optional* **array of strings**
: The type of access your application needs to the user's Freckle data.
: If no value is provided, then the permissions you chose when you setup your application will be used.

note
: *Optional* **string**
: a note to remind users why the OAuth token was generated

note_url
: *Optional* **string**
: a URL to remind users what app the OAuth token was generated for.

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

## Update an existing Authorization

~~~
PATCH /authroizations/:id
~~~

### Parameters:

note
: *Optional* **string**
: a note to remind users why the OAuth token was generated

note_url
: *Optional* **string**
: a URL to remind users what app the OAuth token was generated for.


### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>


## Add scopes to an Authorization

Adding new scopes allows your application to access additional information from the user's Freckle account. Non-existent scopes, or scopes already applied for this authorization will be ignored.

~~~
POST /authroizations/:id/scopes
~~~

### Input

scopes
: *Required* **array of strings**
: The scopes to add to this authorization

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

## Remove scopes from an Authorization

Removing scopes prevents your application from accessing specific information from the user's Freckle account. Scopes that are not currently applied for this authorization will be ignored.

~~~
PUT /authroizations/:id/scopes
~~~

### Input

scopes
: *Required* **array of strings**
: The scopes to remove from this authorization

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

## Remove all scopes from an Authorization

Removing all scopes prevents your application from accessing the information in a user's Freckle account. This method is useful for "clearing out" all of the current permissions your application has for a user's Freckle account, so that you can load a new set of permissions.

~~~
DELETE /authorizations/:id/scopes/
~~~

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

##Delete an Authorization

~~~
DELETE /authorizations/:id
~~~

### Response

<%= headers 204 %>

## Check an Authorization

This method allows you to confirm a token's validity. In order to use this method, you must use Basic Authentication as follows:

Username
: Your application's `client_id`

Password
: Your application's `client_secret`

~~~
GET /applications/:client_id/tokens/:access_token
~~~

## Response if the token does not exist
<%= headers 404 %>

##Response:

<%= headers 200 %>
<%= json :oauth_authorization_token %>
