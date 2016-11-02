---
layout: default
title: OAuth
---

<div class="note warning sticky">
  <h2>Almost finished!</h2>
  <p>This authentication method is almost finished, but the following sections will return a 404 error:</p>
  <ul>
    <li><a href="#non-web-application-flow">Non-Web Application Flow</a></li>
    <li><a href="#oauth-application-api">OAuth Application API</a></li>
  </ul>
</div>

* TOC
{:toc}

OAuth2 is a protocol that lets external apps request authorization to the private details in a user’s Freckle account without requiring their password. Freckle supports access to API resources using OAuth because tokens can be easily generated as part of a 3rd party integration and revoked by users at any time.

Before you can start developing with the Freckle API, you must first register your application. When you register, you will be given a unique Client ID and Secret. Your Client Secret should not be shared.

There are two supported ways to generate an access token for a specific user from your application: One designed specifically for use by Web Applications, and another that allows other types of applications to list, create, and confirm their Authorization Token for a user.

Since OAuth2 is a complicated authentication protocol, you may want to use an [existing library](http://oauth.net/2/) to generate and refresh access tokens.

All OAuth2 authorization requests are made through a single endpoint

~~~
<%= OAUTH2_URL %>
~~~

## Web Application Flow

Below are the steps required to generate an access token for a Freckle user through an initial `GET` request to Freckle and a corresponding redirect back to your application.

### 1. Redirect users to request Freckle access

~~~~
GET <%= OAUTH2_URL %>/oauth/2/authorize
~~~~

#### Parameters:

client_id
: *Required* **string**
: The client ID you received from Freckle when you registered
: Example: `client_id=abcdefghi1234`

response_type
: *Required* **string**
: Must be set to `code`. This is usually handled by an OAuth2 client library

state
: *Optional* **string**
: An unguessable random string, which is used to protect against cross-site request forgery attacks.

redirect_uri
: *Optional* **string**
: The URL pointing to your application where users will be redirected to after they have authorized your application to use their Freckle data. If no `redirect_uri` is included in the request, Freckle will redirect users to the callback URL configured in the OAuth2 application settings.

  #### Rules:

  If a `redirect_uri` is included in the request, the redirect URL's host and port must exactly match the configured callback URL and the redirect URL path must reference a subdirectory of the callback URL configured in the OAuth2 application settings.

  #### Examples:

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

When the user has authorized your application, Freckle will redirect back to your application (either to the URL configured in the OAuth2 application settings, or the url specified in `redirect_uri`). The redirection will include the following query parameters:

code
: **string**
: A temporary code that you will send back to Freckle to get the access token. This code confirms that the user authorized your application to use their Freckle data, and that you received the request. This temporary code expires shortly after it's issued, so be sure to use it quickly!

state
: **string**
: If you provided a state in your [initial request](#redirect-users-to-request-freckle-access) it will be returned back to you. Reject the redirect if this parameter does not match what you previously sent.

#### Errors:

If the user denied access or there was a problem with the API request, the redirect will include the following query parameters:

error
: **string**
: `invalid_request`: The request was not properly formed.
: `unauthorized_client`: This client is not authorized to request access tokens using this method.
: `access_denied`: The user denied the request to allow this client to access their data.
: `unsupported_response_type`: The server does not support this method of obtaining an authorization code.
: `server_error`: The server encountered an unexpected error and was unable to fulfill the request.
: `temporarily_unavailable`: The server is currently unable to handle the request.

error_description
: **string**
: A short explanation of the error

### 3. POST to Freckle to get the access token.

After you have received the temporary code, you will need to `POST` to Freckle to exchange this temporary code for an access token

~~~
POST <%= OAUTH2_URL %>/oauth/2/access_token
~~~

#### Parameters:

client_id
: *Required* **string**
: The client ID you received from Freckle when you registered your application.

client_secret
: *Required* **string**
: the client secret you received from Freckle when you registered your application.

code
: *Required* **string**
: the code you received as a response in [step 2](#freckle-redirects-back-to-your-site-with-two-parameters).

grant_type
: *Required* **string**
: Must be set to `authorization_code`. This is usually handled by an OAuth2 client library.

redirect_uri
: *Required if provided in [step 1](#redirect-users-to-request-freckle-access)* **string**
: The URL pointing to your application where users will be redirected to after they have authorized your application to use their Freckle data. This must exactly match the value given in [step 1](#redirect-users-to-request-freckle-access).

#### Reponse

The response will include the following values:

access_token
: **string**
: The token you will use to access the API on behalf of a user.

refresh_token
: **string**
: The token you will use to refresh the API access token when it expired.

expires_in
: **integer**
: The number of seconds until the current `access_token` expires.

token_type
: **string**
: The type of access that has been sent to your application. The default value is `bearer`.

By default, the response will have the following format:

~~~~
access_token=abcedfghijk1234567890&expires_in=12345678&refresh_token=poiuytrew098765&scope=&token_type=bearer
~~~~

However, by modifying your request's `Accept` header, you can receive the response in different formats:

~~~~
Accept: application/json
~~~~
<%= json :oauth_access_token %>

#### Errors

If there was an error getting the access token, the response will be a JSON hash that explains the error:

<%= headers 400 %>
<%= json :oauth_access_token_error_example %>

The possible errors are:

* `invalid_request`: The request was not properly formed.
* `invalid_client`: The client provided is invalid.
* `invalid_grant`: The provided authorization grant or refresh token is invalid.
* `unauthorized_client`: The client cannot use this grant type.
* `unsupported_grant_type`: This grant type is not supported by the authorization server.

### 4. Use the access token to make API requests on behalf of the user

Now that you have an access token for the user, you can use it to make API requests on their behalf. Please review the [API basics section on how to include the access token in your requests](/v2/authentication).

### 5. Refresh the expired access token

When the access token expires, a `401` error is returned for any associated API requests:

<%= headers 401 %>

Once an access token has expired, you will need to use the `refresh_token` to request a new `access_token`.

~~~
POST <%= OAUTH2_URL %>/oauth/2/access_token
~~~

#### Parameters

client_id
: *Required* **string**
: The client ID you received from Freckle when you registered your application.

client_secret
: *Required* **string**
: the client secret you received from Freckle when you registered your application.

refresh_token
: *Required* **string**
: The refresh token you were given to refresh the API access token when it expired.

grant_type
: *Required* **string**
: The value must be set to `refresh_token`. This is usually handled by an OAuth2 client library.

#### Response

The response will include the following values:

access_token
: **string**
: The new token you will use to access the API on behalf of a user.

refresh_token
: **string**
: The token you will use to refresh the API access token when it expired.

expires_in
: **integer**
: The number of seconds until the new `access_token` expires.

token_type
: **string**
: The type of access that has been sent to your application. The default value is `bearer`.

By default, the response will have the following format:

~~~~
access_token=abcedfghijk1234567890&expires_in=12345678&refresh_token=poiuytrew098765&scope=&token_type=bearer
~~~~

However, by modifying your request's `Accept` header, you can receive the response in different formats:

~~~~
Accept: application/json
~~~~
<%= json :oauth_access_token %>

## Non-Web Application Flow

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this feature might work. Attempting to call any actions will return a 404 error.</p>
</div>

If your application is not a Web-app, you will need to use the OAuth Authorizations API to [generate a new access token](#oauth-authorizations-api) for the user. Note that the OAuth Authorization API is only available via [Basic Authentication](/v2/authentication)


### OAuth Authorizations API

This API allows users to manage their tokens, and is only accessible via [Basic Authentication](/v2/authentication).

Access Tokens are not shared across accounts. When using the OAuth Authorizations API, you will need to specify which account you are accessing. This is done by including the desired account's subdomain as part of the request URL.

The process for selecting which account to access should be:

1. Present the user with a list of all the subdomains (with the corresponding avatar) they are associated with.
2. User selects which account they want to access
3. Use the user-selected subdomain to access the OAuth Authorizations API

### List all the subdomains associated with this user

In order to use the OAuth Authorizations API, you will need to specify which subdomain the user wants to authenticate with. This method returns a list of all the subdomains associated with the user, along with URLs to their respective avatars.

~~~
GET <%= OAUTH2_URL %>/subdomains
~~~

#### Response

<%= headers 200 %>
<%= json_array :subdomain %>

### List all authorizations

~~~
GET <%= OAUTH2_URL %>/authorizations/:subdomain
~~~

#### Response

<%= headers 200 %>
<%= json_array :oauth_authorization_token %>

#### Response if the user is not associated with the subdomain provided

<%= headers 404 %>

### Get a single Authorization

~~~
GET <%= OAUTH2_URL %>/authorizations/:subdomain/:id
~~~

#### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

### Create a new Authorization Token

When you are not building a Web Application, it might be easier to generate a token using a single POST request.

~~~~
POST <%= OAUTH2_URL %>/authorizations/:subdomain
~~~~


#### Inputs

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

#### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

#### Response if the user is not associated with the subdomain provided

<%= headers 404 %>

### Get-or-create an authorization for a specific app

This method checks for an authorization for the specified OAuth application. If the authorization does not exist for this user, it is automatically created.


~~~
PUT <%= OAUTH2_URL %>/authorizations/:subdomain/clients/:client_id
~~~

#### Inputs

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


### Response if a new authorization is created
<%= headers 201 %>
<%= json :oauth_authorization_token %>


### Response if an authorization already exists
<%= headers 200 %>
<%= json :oauth_authorization_token %>

### Response if the user is not associated with the subdomain provided

<%= headers 404 %>

### Update an existing Authorization

~~~
PUT <%= OAUTH2_URL %>/authroizations/:subdomain/:id
~~~

#### Parameters:

note
: *Optional* **string**
: a note to remind users why the OAuth token was generated

note_url
: *Optional* **string**
: a URL to remind users what app the OAuth token was generated for.

add_scopes
: *Optional* **array of strings**
: The list of scopes to add to this authorization. Adding new scopes allows your application to access additional information from the user's Freckle account. Non-existent scopes, or scopes already applied for this authorization will be ignored.

remove_scopes
: *Optional* **array of strings**
: The list of scopes to remove from this authorization. Removing scopes prevents your application from accessing specific information from the user's Freckle account. Scopes that are not currently applied for this authorization will be ignored.

#### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

#### Response if the user is not associated with the subdomain provided

<%= headers 404 %>

###Delete an Authorization

~~~
DELETE <%= OAUTH2_URL %>/authorizations/:subdomain/:id
~~~

#### Response

<%= headers 204 %>

## OAuth Application API

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this feature might work. Attempting to call any actions will return a 404 error.</p>
</div>

These methods are provided to allow your application to confirm a token's validity and revoke tokens as necessary. They are only accessible by using Basic Authentication as follows:

Username
: Your application's `client_id`

Password
: Your application's `client_secret`

### Check an Authorization

This method allows you to confirm a token's validity. The owner must use Basic Authentication when calling this method, where the username is the `client_id` of the application and the password is its `client_secret`

~~~
GET <%= OAUTH2_URL %>/applications/:client_id/tokens/:access_token
~~~

#### Response if the token does not exist
<%= headers 404 %>

#### Response:

<%= headers 200 %>
<%= json :oauth_authorization_token %>

### Revoke all Authorizations for an application

The owner of an OAuth application can revoke every token that has been created for this authorization. The owner must use Basic Authentication when calling this method, where the username is the `client_id` of the application and the password is its `client_secret`

~~~
DELETE <%= OAUTH2_URL %>/applications/:client_id/tokens
~~~

####Response
<%= headers 204 %>

### Revoke a single authorization for an application

The owner of an OAuth application can also revoke a single token that has been created for this authorization. The owner must use Basic Authentication when calling this method, where the username is the `client_id` of the application and the password is its `client_secret`

~~~
DELETE <%= OAUTH2_URL %>/applications/:client_id/tokens/:access_token
~~~


#### Response

<%= headers 204 %>