---
layout: default
title: Current User
---

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

## Get the Projects the Current User is Participating In

~~~
GET /current_user/participating_projects
~~~

### Parameters

You can use the parameters specified in the [Project API's List Action](/projects/index.html#list) to further limit the results

### Response

<%= headers 200, :pagination => true, :pagination_resource => "current_user/participating_projects" %>
<%= json :project %>

## Edit the Current User

~~~
PATCH /current_user
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
: *Optional* **boolean**: indicates whether a team weekly report should be sent.

### Response

<%= headers 200 %>
<%= json :current_user %>

## Uploading a new Picture

~~~
PUT /current_user/upload_picture
~~~

### An Important Note about Uploading Files
In order to upload a new picture, you must send the request parameters as traditional HTTP key/value pairs and set the `Content-Type` header to `application/x-ww-form-urlencoded`. For more details, please review the API Basics section on [Uploading Files](/#uploading-files)

### Input

file
: *Required* **file**: an HTTP file object containing the picure

### Response

<%= headers 204 %>

## Use a URL for the Picture

~~~
PUT /current_user/picture_url
~~~

### Input

url
: *Required* **string**: the URL where the image is located

### Response

<%= headers 204 %>

## Use your Twitter Profile Picture for the Picture

~~~
PUT /current_user/twitter_picture
~~~

### Input

twitter_handle
: *Required* **string**: the Twitter handle you want to use (@-symbol optional)

### Response
<%= headers 204 %>

## Use Gravatar for Picture

~~~
PUT /current_user/use_gravatar
~~~

### Response

<%= headers 204 %>

## Remove Picture

~~~
DELETE /current_user/picture
~~~

### Response

<%= headers 204 %>



