# OAuth

## Web Application Flow from 3rd party services:

### 1. Redirect users to request Freckle access

#### Parameters:

client_id
: *Required* **string**: the client ID you received from GitHub when you registered

redirect_uri
: *Optional* **string**: a URL in your app where users will be sent after authorization.

  ####Rules:

  If `redirect_uri` is not included in the request, Freckle will redirect users to the callback URL configured in the OAuth application settings.

  If `redirect_uri` is included in the request, the redirect URL's host and port must exactly match the callback URL and the redirect URL path must reference a subdirectory of the callback URL configured in the OAuth application settings.

  ####Examples:

  ~~~
  DEFINED CALLBACK: http://example.com/path

  GOOD: https://example.com/path
  GOOD: http://example.com/path/subdir/other

  BAD:  http://example.com/bar
  BAD:  http://example.com/
  BAD:  http://example.com:8080/path
  BAD:  http://oauth.example.com:8080/path
  BAD:  http://example.org
  ~~~

scope
: *Optional* **string**: Comma separated list of scopes, which specify the  type of access your application needs.

state
: *Optional* **string**: unguessable random string, used to protect against cross-site request forgery attacks.

### 2. Freckle redirects back to your site with two parameters:

code
: **string**: temporary code as part of the acceptance

state
: **string** if you provided a state in your initial request (step 1), then it will be returned back to you. If this parameter does not match what you previously sent, then reject the request.

### 3. POST to Freckle to get the access token.

#### Parameters:

client_id
: *Required* **string**: The client ID you received from Freckle when you registered your application.

redirect_uri
: *Optional* **string**: The URI to redirect back to.

client_secret
: *Required* **string**: the client secret you received from Freckle when you registered your application

code
: *Required* **string: the code you received as a response in step 2.

###Reponse

This post will return two values:

* **access_token**: the token you should save to access the API with
* **token_type**

# OAuth Authorizations API

In order to allow non-webapp clients authenticate with our application, we provide an API for users to manage their own tokens. Note that your application can only access tokens generated for your application, and the API is only accessible through basic Authentication.

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

When you're not building a webapp, it might be easier to create a token using basic authentication. In order for this to be successful, you must provide the client ID and secret generated in the OAuth application settings.

### Inputs

client_id
: *Required* **string**: the client key generated for your application.

client_secret(required), string: teh client secret generated for your 

scopes
:*Optional* **array of strings**: a list of scopes that this authorization requires

note
: *Optional* **string**: a note to remind users why the OAuth token was generated

note_url
: *Optional* **string**: a URL to remind users what app the OAuth token was generated for.

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

## Update an existing Authorization

~~~
PATCH /authroizations/:id
~~~

### Parameters:

note
: *Optional* **string**: a note to remind users why the OAuth token was generated

note_url
: *Optional* **string**: a URL to remind users what app the OAuth token was generated for.


### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>


## Add scopes to an Authorization

~~~
POST /authroizations/:id/scopes
~~~

### Input

scopes
: *Required* **array of strings**: the scopes to add to this authorization

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

## Remove scopes from an Authorization

~~~
PUT /authroizations/:id/scopes
~~~

### Input

scopes
: *Required* **array of strings**: the scopes to remove from this authorization

### Response

<%= headers 200 %>
<%= json :oauth_authorization_token %>

## Remove all Projects from a Project Group

~~~
DELETE /imports/:id/scopes/
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

~~~
GET /applications/:client_id/tokens/:access_token
~~~

A special method can be used to check the validity of a token. In order to use this method, you must use Basic Authentication as follows:

Username
: Your application's `client_id`

Password
: Your application's `client_secret`

## Response if the token does not exist
<%= headers 404 %>

##Response:

<%= headers 200 %>
<%= json :oauth_authorization_token %>
