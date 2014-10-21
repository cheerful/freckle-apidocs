---
layout: default
title: Current User
---

<div class="note warning sticky">
  <h2>Not implemented yet!</h2>
  <p>This is just a sneak peek into how this resource might work. Attempting to call any actions will return a 404 error.</p>
</div>

* TOC
{:toc}

## Get the Current User

~~~
GET /current_user/
~~~

### Response

<%= headers 200 %>
<%= json :current_user %>

## Get the Current User's Entries

~~~
GET /current_user/entries
~~~

### Parameters

You can use the parameters specified in the [Entry API's List Action](/entries/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "current_user/entries" %>
<%= json :entry %>

## Get the Current User's Expenses

~~~
GET /current_user/expenses
~~~

### Parameters

You can use the parameters specified in the [Expense API's List Action](/expenses/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "current_user/expenses" %>
<%= json :expense %>

## Get the Projects the Current User has logged entries or expenses for

~~~
GET /current_user/projects
~~~

### Parameters

You can use the parameters specified in the [Project API's List Action](/projects/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "current_user/participating_projects" %>
<%= json :project %>

## Edit the Current User

~~~
PUT /current_user
~~~

### Inputs

email
: *Optional* **string**: the email address of the user.

first name
: *Optional* **string**: the first name of the user

last name
: *Optional* **string**: the last name of the user

time_format
: *Optional* **string**: How time should be formatted. Accepted values are:

    * fraction
    * hours_minutes

week_start
: *Optional* **string**: when the week starts for the current user. Accepted Values are:

    * sunday
    * monday

send_personal_weekly_report_email
: *Optional* **boolean**: indicates whether a personal weekly report email should be sent.

send_team_weekly_report_email
: *Optional* **boolean**: indicates whether a team weekly report should be sent. If the current user is not an admin, this field will be ignored.

### Response

<%= headers 200 %>
<%= json :current_user %>

## Replace Avatar with uploaded image

Replace the Current User's avatar with the uploaded image. The maximum filesize for the uploaded image is 2MB.

~~~
PUT /current_user/upload_picture
~~~

### An Important Note about Uploading Files
In order to upload a new avatar, you must send the request parameters as traditional HTTP key/value pairs and set the `Content-Type` header to `application/x-ww-form-urlencoded`. For more details, please review the API Basics section on [Uploading Files](/#uploading-files)

### Input

file
: *Required* **file**: an HTTP file object containing the picure

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **invalid_image**: The uploaded file is not a valid image
* **too_large**: The uploaded file is too large

## Replace Avatar with an image URL

Replace the Current User's avatar with the image specified by the URL provided. The maximum filesize for the image specified by the URL is 2MB.

~~~
PUT /current_user/picture_url
~~~

### Input

url
: *Required* **string**: the URL where the image is located.

### Response

<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes can be returned for this action:

* **invalid_image**: The URL provided does not point to an image.
* **invalid_url**: The URL provided is invalid.
* **could_not_reach_url**: we were unable to complete the request using the URL provided.
* **too_large**: The image is too large.

## Replace Avatar with a Twitter Account's Profile Image

Replace the Current User's avatar with the profile image of a Twitter Account. Note that the Twitter account must be public in order to use its profile image.

~~~
PUT /current_user/twitter_picture
~~~

### Input

twitter_handle
: *Required* **string**: the Twitter handle you want to use (@-symbol optional)

### Response
<%= headers 204 %>

### Custom Error Codes

The following Custom Error codes could be returned for this action:

* **invalid_twitter_handle**: The Twitter account provided could not be found, or is not public
* **unable_to_reach_twitter**: We were unable to reach Twitter

## Use Gravatar for Picture

Replace the Current User's avatar with the default image from their [Gravatar](http://en.gravatar.com/) account. The Current User's email address is used to retrieve the Gravatar Profile. The maximum filesize for the image specified in their Gravatar Profile is 2MB.

~~~
PUT /current_user/use_gravatar
~~~

### Response

<%= headers 204 %>

## Custom Error Codes

The following Custom Error codes can be returned for this action:

* **invalid_gravatar_profile**: The email address does not have a Gravatar Profile associated with it, or is not accessible.
* **unable_to_reach_gravatar**: We were unable to reach Gravatar.

## Remove Picture

Remove the Current User's avatar and replace it with a generic Freckle Avatar.

~~~
DELETE /current_user/picture
~~~

### Response

<%= headers 204 %>


